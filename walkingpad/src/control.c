#include <stdio.h>

#include "declare.h"
#include "image.h"
#include "displaydriver.h"

#include "sensor.h"
#include "beep.h"
#include "run_mode.h"
#include "miwifi.h"
#include "eeprom.h"
#include "key.h"

#include "control.h"

uchar ram_d1;
uchar ram_d2;

@near uint user_time_minute;  //running time count in minute
@near uchar user_time_second; //running time count in sencod
uint user_distance;           //running distance integral,in 0.01km
@near static uint user_distance_saved;
ulong user_calories;
@near uchar start_cnt;
@near bool run_in_prog_mode;
@near user_state_t userstate;

#define STOP_CALC_COUNT 150

/*--------------------*
 |  Private functions
 *--------------------*/

/*--------------------------------------------------------------------------*
 |
 |  time_calculation
 |  Call to calculate the running time
 |
 *--------------------------------------------------------------------------*/
static void time_calculation(void)
{
    if (userstate == USER_STATE_RUN
        && is_new_second()
        && no_current_cnt < STOP_CALC_COUNT)
    {
        user_time_second++;
        if (user_time_second >= 60)
        {
            user_time_second = 0;
            user_time_minute++;
            //the maximum running time is 99minutes 59seconds, time up then go to EOC
            if (user_time_minute >= USER_TIME_MAX)
            {
                beep(BEEP_KEY);
                save_total_distance();
                reset_data();
            }
        }
    }
}

static void prepare_statistic_data(void)
{
    uint temp16;

    if (user_distance > store_point.dist)
    {
        if (!has_wifi_flag(FLAG_WIFI_STORE_POINT) && net_state == NET_STATE_CLOUD && IS_TIME_SET)
        {
            store_point.predist = user_distance - store_point.dist;
            store_point.dist = user_distance;

            store_point.preenergy = user_calories - store_point.energy;
            store_point.energy = user_calories;

            store_point.presteps = user_steps_total - store_point.steps;
            store_point.steps = user_steps_total;

            temp16 = user_time_minute * 60 + user_time_second;
            store_point.pretime = temp16 - store_point.time;
            store_point.time = temp16;

            store_point.presp = machine_speed_target / 3;

            store_point.state = machine_volt_motor;
            store_point.state <<= 8;
            store_point.state |= machine_current_motor;
            if (runmode == RUN_MODE_AUTO)
                store_point.state &= 0xFF7F;
            else
                store_point.state |= 0x0080;

            set_wifi_flag(FLAG_WIFI_STORE_POINT);
        }

        if (user_distance / 100 > store_mp.km)
        {
            temp16 = user_time_minute * 60 + user_time_second;
            store_mp.dur = temp16 - store_mp.time;
            store_mp.time = temp16;
            store_mp.km = user_distance / 100;

            set_wifi_flag(FLAG_WIFI_STORE_MP);
        }
    }
}

static void dist_calculation(void)
{
    static uint user_distance_10m_dist;

    if (userstate == USER_STATE_READY)
    {
        if (user_distance == 0)
        {
            user_distance_10m_dist = 0;
        }
    }
    else if (userstate == USER_STATE_RUN
        && stepdown_flag == STEPDOWN_NONE
        && no_current_cnt < STOP_CALC_COUNT)
    {
        user_steps_total = user_steps_pause + user_steps;
        if (is_new_second())
        {
            user_distance_10m_dist += machine_speed_target;
            if (user_distance_10m_dist > 1080)
            {
                user_distance++; // 10m
                user_distance_10m_dist -= 1080;

                if (user_distance > USER_DISTANCE_MAX)
                {
                    beep(BEEP_KEY);
                    save_total_distance();
                    reset_data();
                }
            }
            user_calories = 1554ul * user_distance / 25ul + user_distance_10m_dist * 259ul / (180ul * 25);

            prepare_statistic_data();
        }
    }
}

/*--------------------------------------------------------------------------*
 |
 |  speed_rpm_convert
 |  call in main loop to convert speed setting to rpm or convert machine rpm to
 |  user speed.
 |   MUST be put after key process for send new user_rpm_target to machine
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
void speed_rpm_convert(void)
{
    uint tempi;
    if (user_speed_target > 100)
    {
        tempi = (user_speed_target - 100);
        tempi *= (SPEED_TARGET_SHI - 100);
        tempi /= (SPEED_TARGET_MAX - 100);
        tempi += 100;
    }
    else
    {
        tempi = user_speed_target;
    }
    //user speed to rpm
    user_rpm_target = tempi * RPM_TARGET_SCALE / 10;
    tempi = (machine_rpm_target * 10 + RPM_TARGET_SCALE / 2) / RPM_TARGET_SCALE;
    machine_speed_target = tempi;
}

void reset_data(void)
{
    user_time_minute = 0;
    user_time_second = 0;

    user_distance = 0;
    user_distance_saved = 0;
    user_calories = 0;

    user_steps_total = 0;
    user_steps_pause = 0;

    goal_status = GOAL_ONGOING;

    // reset statistic data
    store_mp.dur = 0;
    store_mp.time = 0;
    store_mp.km = 0;

    store_point.predist = 0;
    store_point.dist = 0;
    store_point.preenergy = 0;
    store_point.energy = 0;
    store_point.presteps = 0;
    store_point.steps = 0;
    store_point.pretime = 0;
    store_point.time = 0;
    store_point.presp = 0;
}

void save_total_distance(void)
{
    if (user_distance > user_distance_saved)
    {
        user_total_distance += user_distance - user_distance_saved;
        user_distance_saved = user_distance;
        eeprom_write_long(EEPROM_ADDR_TOTAL_DIST, user_total_distance);
    }
}

/*--------------------------------------------------------------------------*
 |
 |  useroperation
 |  Call periodically in main loop
 |
 *--------------------------------------------------------------------------*/
void useroperation(void)
{
    if (runmode == RUN_MODE_AUTO || runmode == RUN_MODE_FIXED || runmode == RUN_MODE_NEW)
    {
        time_calculation();
        dist_calculation();
    }
    // HX711_Weight();
    speed_rpm_convert();
    if (run_in_prog_mode)
    {
        ProgModeKeys();
    }
    else
    {
        UserConsumerKeys();
    }
    UserConsumerOperation();
    UserConsumerDisplay(); /* update display */

    //image function, call periodically
    // DisplayDriverProcessLED(); //20ms
}
