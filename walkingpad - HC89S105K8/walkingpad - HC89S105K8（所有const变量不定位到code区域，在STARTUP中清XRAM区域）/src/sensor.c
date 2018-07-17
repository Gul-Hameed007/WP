#include "sensor.h"
#include "beep.h"
#include "declare.h"
#include <string.h>
#include <stdlib.h>
#include <intrins.h>
/*--------------------------------------------------------------------------*
 |read HX711's AD value 
 |
 *--------------------------------------------------------------------------*/
#define QSIZE 5
#define TENSION_LOW 83500
#define TENSION_HIGH 84000
#define DRIFT_THRESHOLD_LOW 50
#define DRIFT_THRESHOLD_HIGH 2000
#define DRIFT_TENSION_THRESHOLD 4000
#define DISCONNECT_THRESHOLD 3
#define SENSOR__THRESHOLD 2500
#define TIME_1_SECOND 50
#define TIME_2_SECONDS 100
#define TIME_5_SECONDS 250

#define MEDIAN_FILTER

 static ulong array[QSIZE];
 static ulong array2[QSIZE];
 static uchar filter_cnt, filter_cnt2;
 static uchar all_display_on_cnt_old;
 uchar flag_Gsensor_disconnected;

 ulong tension, tension2;
 ulong tension_orig, tension2_orig;
 static ulong tension_ini, tension2_ini;
 long tension_bias, tension2_bias;

 static long tension_old, tension2_old;

 static uchar array_idx;

 static uchar drift_cnt;
 uchar no_current_cnt;
// uchar fold_cnt;

 static uchar disconnect_cnt1, disconnect_cnt2;
// static uchar disconnect_sec1, disconnect_sec2;

// long tension_abs, tension2_abs;
 static ulong drift, drift2;
 static ulong drift_abs, drift2_abs;

 static uchar sensor_release_cnt;
 static uchar sensor_press_cnt;
 bool flag_sensor_may_reverted;
 extern user_state_t userstate;
 ebool flag_may_stuck;

static void adjust_drift(void);
static void do_drift(void);

#define ABSUB(x, y) x > y ? x - y : y - x


//****************************************************
//
//****************************************************
static void Delay__hx711_us(void)
{
    _nop_();
    _nop_();
}

#define READ_HX711(n)         \
    ulong count;              \
    uchar i;                  \
    Delay__hx711_us();        \
    HX711_CK##n = 0;          \
    count = 0;                \
    if (HX711_DT##n == 1)     \
    {                         \
        return U32_MAX;       \
    }                         \
    for (i = 0; i < 24; i++)  \
    {                         \
        HX711_CK##n = 1;      \
        count = count << 1;   \
        Delay__hx711_us();    \
        HX711_CK##n = 0;      \
        if (HX711_DT##n)      \
        {                     \
            count++;          \
        }                     \
    }                         \
    HX711_CK##n = 1;          \
    count = count ^ 0x800000; \
    Delay__hx711_us();        \
    HX711_CK##n = 0;          \
    return count;

static ulong HX711_Read1(void)
{
    READ_HX711(1)
}

static ulong HX711_Read2(void)
{
    READ_HX711(2)
}

#ifdef MEDIAN_FILTER
static ulong get_median(ulong data_array[])
{
    ulong sens_data[QSIZE];
    uchar i, k, m;

    memcpy(sens_data, data_array, sizeof(sens_data));

    for (k = 0; k < QSIZE / 2 + 1; k++)
    {
        for (i = k + 1, m = k; i < QSIZE; i++)
        {
            if (sens_data[m] > sens_data[i])
                m = i;
        }
        if (m != k)
        {
            sens_data[m] ^= sens_data[k];
            sens_data[k] ^= sens_data[m];
            sens_data[m] ^= sens_data[k];
        }
    }
    return sens_data[k - 1];
}
#else
static ulong get_mean(ulong sens_data[])
{
    ulong maximum, minimum, avg;
    uint k;
    maximum = sens_data[0];
    minimum = sens_data[0];
    avg = sens_data[0];
    for (k = 1; k < QSIZE; k++)
    {
        if (maximum < sens_data[k])
        {
            maximum = sens_data[k];
        }
        else if (minimum > sens_data[k])
        {
            minimum = sens_data[k];
        }
        avg += sens_data[k];
    }
    avg -= maximum + minimum;
    avg /= (QSIZE - 2);
    return avg;
}
#endif

void HX711_Weight(void)
{
    ulong hx711_wt1 = HX711_Read1();
    ulong hx711_wt2 = HX711_Read2();
    if (hx711_wt1 == U32_MAX || hx711_wt2 == U32_MAX)
    {
        //beep(BEEP_KEY);
        return;
    }
    hx711_wt1 /= 100;
    hx711_wt2 /= 100;

    array[array_idx] = hx711_wt1;
    array2[array_idx] = hx711_wt2;
    array_idx = (array_idx + 1) % QSIZE;
    filter_cnt++;
    if (filter_cnt >= QSIZE)
    {
        filter_cnt = QSIZE;

        tension_old = tension;
        tension2_old = tension2;

#ifdef MEDIAN_FILTER
        // median filter
        tension = get_median(array);
        tension2 = get_median(array2);
#else
        // mean filter
        tension = get_mean(array);
        tension2 = get_mean(array2);
#endif

        if (waiting_cnt > 0)
        {
            tension_ini += tension;
            tension2_ini += tension2;
            filter_cnt2++;
        }
        else if (waiting_cnt == 0 && all_display_on_cnt_old > 0)
        {
            tension_ini /= filter_cnt2;
            tension2_ini /= filter_cnt2;

            tension_orig = tension_ini;
            tension2_orig = tension2_ini;
        }
        else
        {
            tension_bias = tension - tension_ini;
            tension2_bias = tension2 - tension2_ini;
        }

        all_display_on_cnt_old = waiting_cnt;

        if (waiting == 0 && userstate != USER_STATE_SLEEP) 
        {
            calc_disconnect();
        }
    }
    else
    {
        tension = 0;
        tension2 = 0;
    }

    if (waiting == 0)
    {
        adjust_drift();
    }
}

void calc_disconnect(void) 
{
    if (tension >= TENSION_LOW && tension < TENSION_HIGH &&
        (ABSUB(tension, tension_old)) < DISCONNECT_THRESHOLD &&
        tension_bias >= -2 && tension_bias <= 2
        || tension == 0) 
    {
        INC_UCHAR(disconnect_cnt1);
    } 
    else 
    {
        disconnect_cnt1 = 0;
    }

    if (tension2 >= TENSION_LOW && tension2 < TENSION_HIGH &&
        (ABSUB(tension2, tension2_old)) < DISCONNECT_THRESHOLD &&
        tension2_bias >= -2 && tension2_bias <= 2
        || tension2 == 0) 
    {
        INC_UCHAR(disconnect_cnt2);
    } 
    else 
    {
        disconnect_cnt2 = 0;
    }

    flag_Gsensor_disconnected = 0;
    if (disconnect_cnt1 > TIME_5_SECONDS) 
    {
        flag_Gsensor_disconnected += 1;
    }
    if (disconnect_cnt2 > TIME_5_SECONDS) 
    {
        flag_Gsensor_disconnected += 2;
    }
}

void do_drift(void)
{
    uchar drift_interval;

    drift_abs = ABSUB(tension, tension_old);
    drift2_abs = ABSUB(tension2, tension2_old);

    if (drift_abs < DRIFT_THRESHOLD_LOW && drift2_abs < DRIFT_THRESHOLD_LOW && userstate != USER_STATE_TICK)
    {
        drift_cnt++;
        drift += drift_abs;
        drift2 += drift_abs;
    }
    else
    {
        drift_cnt = 0;
        drift = 0;
        drift2 = 0;
    }

    drift_interval = TIME_2_SECONDS / (1 + machine_speed_target / 20);

    if (drift_cnt > drift_interval && no_current_cnt > TIME_2_SECONDS)
    {
        tension_ini = tension;
        tension2_ini = tension2;
        drift_cnt = 0;
        sensor_press_cnt = 0;
        sensor_release_cnt = 0;
    }
}

void adjust_drift(void)
{
    euint state_sec;
     ebool start_no_tick;

    /* if (no_current_cnt == 0)
    {
        fold_cnt = 0;
    } */

    if (machine_current_motor >= 0 && machine_current_motor < 20 && user_steps_last == user_steps)
    {
        /* if (machine_current_motor < 8 && machine_speed_target > 0)
        {
            INC_UCHAR(fold_cnt);
        }
        else
        {
            fold_cnt = 0;
        } */

        INC_UCHAR(no_current_cnt);
    }
    else
    {
        no_current_cnt = 0;
    }

    if (tension_bias + tension2_bias < -SENSOR__THRESHOLD) // Ư�ƺ�ͻ��
    {
        INC_UCHAR(sensor_release_cnt);
    }
    else
    {
        sensor_release_cnt = 0;
    }

    if (userstate == USER_STATE_READY && state_sec == 0 && flag_sensor_may_reverted == 1)
    {
        if (tension_ini + tension2_ini - tension_orig - tension2_orig > SENSOR__THRESHOLD)
        {
            INC_UCHAR(sensor_press_cnt);
        }
        else
        {
            sensor_press_cnt = 0;
        }

        if (sensor_press_cnt > 10)
        {
            tension_ini = tension_orig;
            tension2_ini = tension2_orig;
            flag_sensor_may_reverted = 0;
            drift_cnt = 0;
            sensor_press_cnt = 0;
        }
    }

    else if (userstate == USER_STATE_STOP)
    {
        if (tension + tension2 - tension_orig - tension2_orig >= 600) // stuck.
        {
            INC_UCHAR(sensor_press_cnt);
        }
        else
        {
            sensor_press_cnt = 0;
        }

        if (sensor_press_cnt > 200 && state_sec > 60 || sensor_release_cnt > 50 || flag_may_stuck)
        {
            do_drift();
        }
    }
    else
    {
        if (sensor_release_cnt < 50 && userstate == USER_STATE_READY && state_sec < 60 && start_no_tick == 1)
            return;

        do_drift();

        if (sensor_release_cnt > 100)
        {
            tension_ini = tension;
            tension2_ini = tension2;
            drift_cnt = 0;
            sensor_press_cnt = 0;
            sensor_release_cnt = 0;
        }
    }
}
