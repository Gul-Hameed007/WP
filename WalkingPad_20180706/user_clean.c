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

/*-------------*
 |  Constants
 *-------------*/
//error definition
#define ERROR_MOSFET 0x0001          //mosfet is shortened
#define ERROR_DCMOTOR_ALARM 0x0002   //ALARM from TD310
#define ERROR_DCMOTOR_CURRENT 0x0004 //dc motor current is too large, taking as shorten
#define ERROR_SPEED_SENSOR 0x0008    //with pwm output, not speed feedback
//#define ERROR_DRIVE_FAIL                              0x0010  //without drive, but has speed signal
#define ERROR_MOTOR_DISCONNECT 0x0010 //without drive, but has speed signal
#define ERROR_COMMUNICATION 0x0080    //communication lost

#define USER_TOTAL_DISTANCE_MAX 999999 // 99999999

//stay at fault state maximum time
#define FAULT_STATE_CNT_MAX 5 //in second
//stay at eoc state maximum time
#define EOC_STATE_CNT_MAX 35        //in second
#define EOC_STATE_CNT_FLASH_BEEP 30 //in second, before this time in EOC,
//'End' flash and beep for alarm
//from standby/idle/pause state to sleep state count maximum time
#define TO_SLEEP_CNT_MAX 600 //in second

#define USER_TIME_MAX 1080      //99                    //99 minutes, in 1minute
#define USER_DISTANCE_MAX 9990  //99.99km,in 0.01km
#define USER_CALORIES_MAX 65535 //999C,in 0.1C
//calories scale
#define USER_CALORIES_100C_SCALE (256045 + 100) //refer to design document for details.
                                                //10 for compensation
//distance scale
#define USER_DISTANCE_10M_SCALE (18000 + 0) //refer to design document for details.

#define GOTO_STATE(s)   \
    do                  \
    {                   \
        userstate = s;  \
        state_sec = 0;  \
        state_tick = 0; \
        start_cnt = 0;  \
    } while (0)

#define SPEED_INC 15



#define CHECK_KEY_ID                          \
    if (key_id == KEY_NONE)                   \
    {                                         \
        if ((key_id = rcCheck()) != KEY_NONE) \
            key_id_done = 0;                  \
    }
/*-----------------*
 |  Private data
 *-----------------*/
//test ram data
uchar ram_d1;
user_state_t userstate; //user state
static uchar ui_state;  //this is just for indicating UI state (standby or run) and compare with
//machine side to check if it matches.
uchar start_no_tick;                  //when change to run state, set this.
@near uint user_time_minute;          //running time count in minute
uchar user_time_second;               //running time count in sencod
uint user_distance;                   //running distance integral,in 0.01km
@near static uchar flag_speed_change; //flag for speed changed
ulong user_calories;                  //running calories integral,in 0.1km

//error
uchar error_id;

//image
uint state_sec;
uchar state_tick;

//use for distance calculation, time for 10meter, in 1s
static uint user_distance_10m_time;
//use for calories calculation, time for 100c in 20ms
static uint user_calories_100c_cnt, user_calories_100c_time;

@near static uchar user_machine_state_cnt;  //count for user and machine state check, in second
@near static uchar user_machine_state_cnt1; //count for user and machine state check, in second

@near ulong user_total_distance, user_total_distance_bp;

//@near static run_mode_t runmode_old;
@near static uchar run_in_prog_mode;
@near static uchar set_speed_before_start;
@near static uchar start_cnt;
@near static uchar show_factory_mode;

@near uchar show_for_a_while;
@near euchar flag_motor_params_changed;

typedef enum {
    TEST_STATE_BEGIN,
    TEST_STATE_RC,
    TEST_STATE_LED,
    TEST_STATE_RUN40,
    TEST_STATE_STOP40,
    TEST_STATE_SENSOR,
    TEST_STATE_AUTO,
    TEST_STATE_RUN60,
    TEST_STATE_STOP60,
    TEST_STATE_NET_START,
    TEST_STATE_NET,
    TEST_STATE_NET_END,
    TEST_STATE_END
} test_state_t;
/*--------------------*
 |  Private functions
 *--------------------*/

//@near uchar flag_true_run,key_true_cnt,disp_true_run;
/*--------------------------------------------------------------------------*
 |
 |  time_proc
 |  Call periodically in main loop
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
void timer_proc(void)
{
    if (sec >= TIME_BASE_SEC) //one second base timer
    {
        sec = 0;
    }
    else
    {
        sec++;
    }
}

/*--------------------------------------------------------------------------*
 |
 |  time_calculation
 |  Call to calculate the running time
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
static void time_calculation(void)
{
    if (userstate == USER_STATE_RUN)
    {
        if (user_time_second >= 60)
        {
            user_time_second = 0;
            user_time_minute++;
        }
        if (sec == 0)
        {
            user_time_second++;
        }
        //the maximum running time is 99minutes 59seconds, time up then go to EOC
        if (user_time_minute >= USER_TIME_MAX && user_time_second >= 60)
        {
            GOTO_STATE(USER_STATE_EOC);
            //user_request = USER_REQUEST_STOP;
            beep(BEEP_KEY);
        }
    }
}
/*--------------------------------------------------------------------------*
 |
 |  distance_calculation
 |  Call to calculate the running distance
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
static void distance_calculation(void)
{
    static uint user_distance_old; //save the distance when speed changed
    ulong templ;
    if (userstate == USER_STATE_RUN)
    {
        user_steps_total = user_steps_pause + user_steps;
        //solution 2, refer to design document for details
        if (user_distance == 0)
        {
            user_distance_old = 0; //reset at the beginning
        }
        if (flag_speed_change) //set when speed change
        {
            user_distance_10m_time = 0;
            user_distance_old = user_distance;
            flag_speed_change = 0;
        }
        if (sec == 0 && user_distance_10m_time <= 0xffff)
        {
            user_distance_10m_time++;
        }

        templ = user_distance_10m_time;
        templ *= machine_speed_target;
        templ /= 1080; //500000;//
        //templ /= 108;
        user_distance = templ + user_distance_old;

        user_calories = 1554ul * user_distance / 25;

        if (user_distance > store_point.dist)
            set_wifi_flag(FLAG_WIFI_STORE_POINT);
        if (user_distance / 100 > store_mp.km)
            set_wifi_flag(FLAG_WIFI_STORE_MP);

        //the maximum running distance is 99.9km, reach target then go to EOC
        if (user_distance >= USER_DISTANCE_MAX)
        {
            //userstate = USER_STATE_EOC;
            //user_request = USER_REQUEST_STOP;
            //beep(BEEP_KEY);
            //clear when reach MAX
            user_distance = 0;
            user_calories = 0;
            user_distance_10m_time = 0;
            user_distance_old = 0;
            user_total_distance += 99;
            user_total_distance_bp += USER_DISTANCE_MAX;
        }
        user_total_distance = user_total_distance_bp + user_distance;
        //user_total_distance_bp+=user_distance;
        if (user_total_distance > USER_TOTAL_DISTANCE_MAX)
        {
            user_total_distance -= USER_TOTAL_DISTANCE_MAX;
        }
    }
    else //if (userstate == USER_STATE_READY)
    {
        user_distance_10m_time = 0;
        //user_total_distance_bp = user_total_distance;
    }

    //if (user_distance>USER_DISTANCE_MAX)user_distance = 0;
}
/*--------------------------------------------------------------------------*
 |
 |  calories_calculation
 |  Call to calculate the running calories
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
static void calories_calculation(void)
{
    uint temp16;
    ulong temp32;
    if (userstate == USER_STATE_RUN)
    {
        //time for 100 c
        //in 20ms
        //for UT
        if (user_speed_target > 0 || no_current_cnt < 10)
        {
            temp16 = 100 + user_gradient_target;
            temp32 = machine_speed_target * temp16;
            user_calories_100c_time = (uint)(USER_CALORIES_100C_SCALE / temp32);
            if (user_calories_100c_cnt >= user_calories_100c_time)
            {
                //increase every 100c, refer to design document for details.
                user_calories++;
                user_calories_100c_cnt = 0;
            }
            else
            {
                user_calories_100c_cnt++;
            }
        }
        //the maximum running distance is 99.9km, reach target then go to EOC
        if (user_calories >= USER_CALORIES_MAX)
        {
            user_calories = 0;
        }
    }
    else if (userstate == USER_STATE_READY)
    {
        user_calories_100c_cnt = 0;
        user_calories_100c_time = 0;
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
@near uint rpm_target_scale_mile;
static void speed_rpm_convert(void)
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

static void total_dist_write(void)
{
    eeprom_write_long(1, user_total_distance);
}

/*--------------------------------------------------------------------------*
 |
 |  UserConsumerDisplay
 |  Call periodically in UserOperation() if in consumer mode
 |
 |  Description: To update speed,time,calories,heart rate, and prompts.
 |
 *--------------------------------------------------------------------------*/
@near static uint display_cnt;
@near display_seg_t display_seg;

@near static uchar const lib_start[MATRIX1_SIZE] =
    {
        0x09, 0x15, 0x15, 0x12, 0x00, 0x10, 0x7F, 0x11, 0x00, 0x0A, 0x15, 0x15, 0x0F, 0x01, 0x00, 0x11,
        0x1F, 0x09, 0x10, 0x00, 0x10, 0x7F, 0x11}; // start
@near static uchar const lib_reset[MATRIX1_SIZE] =
    {
        0x11, 0x1F, 0x09, 0x10, 0x10, 0x0E, 0x15, 0x15, 0x0D, 0x00, 0x09, 0x15, 0x15, 0x12, 0x00, 0x0E,
        0x15, 0x15, 0x0D, 0x10, 0x7F, 0x11, 0x11}; // reset

static void UserConsumerDisplay(void)
{
    uchar digit_left, digit_right; // left and right side
    uchar text[6];
    uint digit_int;

    disp_matrix_all(0x00);

    if (waiting == 0)
    {
        //ImageBlank();
        switch (userstate)
        {
        case USER_STATE_TICK:
        case USER_STATE_READY:
        case USER_STATE_RUN:
        case USER_STATE_PAUSE:
        case USER_STATE_STOP:
        case USER_STATE_EOC:
            if (runmode == RUN_MODE_AUTO)
            {
                SET_LED_AUTO;
            }
            else if (runmode == RUN_MODE_FIXED)
            {
                SET_LED_FIXED;
            }
            else if (runmode == RUN_MODE_STANDBY)
            {
                SET_LED_STANDBY;
            }
            else if (runmode == RUN_MODE_NEW)
            {
                if (tutorial_state >= TUTORIAL_STEP2_END)
                {
                    SET_LED_AUTO;
                }
                else
                {
                    SET_LED_FIXED;
                }
            }
            else if (runmode == RUN_MODE_CHECK)
            {
                CLEAR_LED_ALL;
                disp_matrix_text("CALI", 0);
                return;
            }

            if (flag_Gsensor_disconnected > 0 && flag_Gsensor_disconnected < 3)
            {
                SET_LED_ERROR;
            }
            else if (error_id == 0)
            {
                CLEAR_LED_ERROR;
            }

            switch (net_state)
            {
            case NET_STATE_CLOUD:
                CLEAR_LED_NET;
                break;
            case NET_STATE_LOCAL:
                SET_LED_NET;
                break;
            case NET_STATE_UNKNOWN:
            case NET_STATE_OFFLINE:
                disp_alternant_net(100, 200);
                break;
            case NET_STATE_UAP:
            case NET_STATE_UNPROV:
                disp_alternant_net(200, 800);
                break;
            case NET_STATE_UPDATING:
                disp_alternant2_net(100, 200, 100, 800);
                break;
            }

            if (userstate == USER_STATE_TICK)
            {
                display_cnt = 0;
                disp_matrix1_text(lib_start);
                disp_matrix_digit_ascii(3 - state_sec, 29);
                break;
            }
            if (has_wifi_flag(FLAG_WIFI_RESTORE))
            {
                disp_matrix1_text(lib_reset);
                break;
            }

            if (runmode == RUN_MODE_AUTO && flag_Gsensor_disconnected > 0 && flag_Gsensor_disconnected < 3)
            {

                disp_matrix_text("E08", 0);
                break;
            }

            if (run_in_prog_mode == 0)
            {
                if (display_seg > DISPLAY_FOR_A_WHILE)
                {
                    if (show_for_a_while == 0)
                    {
                        display_cnt = 0;
                        show_for_a_while = 1;
                    }
                }
                else if (display_seg < DISPLAY_SIZE)
                {
                    display_seg = display_cnt / DISPLAY_INTERVAL;
                }

                if (display_cnt > DISPLAY_INTERVAL * DISPLAY_SIZE)
                {
                    display_cnt = 0;
                    display_seg = DISPLAY_TIME;
                    if (show_for_a_while > 0)
                        show_for_a_while = 0;
                }
                else
                {
                    display_cnt++;
                }

                if (runmode == RUN_MODE_NEW)
                {
                    // FIXME: don't change display_seg and show "NEW"
                    disp_matrix_text("NEW", 0);
                    sprintf(text, "%d.%d", (int)machine_speed_target / 30, (int)((machine_speed_target % 30) / 3));
                    disp_matrix_text(text, 1);
                    break;
                }
            }

            if (display_seg == DISPLAY_TIME)
            {
                disp_matrix_text("TIME", 0);

                if (user_time_minute < 60)
                {
                    digit_left = user_time_minute;
                    digit_right = user_time_second;
                }
                else
                {
                    digit_left = user_time_minute / 60;
                    digit_right = user_time_minute % 60;
                }

                if (digit_left > 99)
                {
                    digit_left = 99; //the largest time is 99 hours
                }
                if (digit_right > 59)
                {
                    digit_right = 59;
                }
                if (user_time_minute > 59 && sec > 25)
                {
                    sprintf(text, "%d %02d", (int)digit_left, (int)digit_right);
                }
                else
                {
                    sprintf(text, "%d:%02d", (int)digit_left, (int)digit_right);
                }
                disp_matrix_text(text, 1);
            }
            else if (display_seg == DISPLAY_SPEED || display_seg == DISPLAY_SPEED_TEMP)
            {
                disp_matrix_text("SPD", 0);

                if (runmode == RUN_MODE_FIXED && display_seg == DISPLAY_SPEED_TEMP)
                {
                    digit_int = fixed_mode_speed;
                }
                else
                {
                    digit_int = machine_speed_target;
                }

                sprintf(text, "%d.%d", (int)digit_int / 30, (int)((digit_int % 30) / 3));
                disp_matrix_text(text, 1);
            }
            else if (display_seg == DISPLAY_DIST)
            {
                disp_matrix_text("KM", 0);

                digit_int = user_distance;
                if (digit_int > USER_DISTANCE_MAX)
                {
                    digit_int = USER_DISTANCE_MAX; //the largest is 99.9 km
                }
                sprintf(text, "%d.%02d", digit_int / 100, digit_int % 100);
                disp_matrix_text(text, 1);
            }
            else if (display_seg == DISPLAY_CAL)
            {
                disp_matrix_text("CAL", 0);

                digit_int = user_calories;

                if (user_calories < 100000)
                {
                    sprintf(text, "%d.%01d", digit_int / 100, (digit_int % 100) / 10);
                }
                else if (user_calories < 1000000)
                {
                    sprintf(text, "%d", digit_int / 100);
                }

                disp_matrix_text(text, 1);
            }
            else if (display_seg == DISPLAY_CUR_VOL)
            {
                sprintf(text, "%d.%d", (int)(machine_current_motor / 10), (int)(machine_current_motor % 10));
                disp_matrix_text(text, 0);

                sprintf(text, "%d", (int)(machine_volt_motor));
                disp_matrix_text(text, 1);
            }
            else if (display_seg == DISPLAY_SENSOR)
            {

                sprintf(text, "%ld", tension / 100);
                disp_matrix_text(text, 0);

                sprintf(text, "%ld", tension2 / 100);
                disp_matrix_text(text, 1);
            }
            else if (display_seg == DISPLAY_PROG_F1)
            {
                disp_matrix_text("F1", 0);
                sprintf(text, "%d", (int)dc_motor_rating_f1);
                disp_matrix_text(text, 1);
            }
            else if (display_seg == DISPLAY_PROG_F2)
            {
                disp_matrix_text("F2", 0);
                sprintf(text, "%d", (int)dc_motor_startup_volt);
                disp_matrix_text(text, 1);
            }
            else if (display_seg == DISPLAY_PROG_F3)
            {
                disp_matrix_text("F3", 0);
                sprintf(text, "%d", (int)dc_motor_rating_volt);
                disp_matrix_text(text, 1);
            }
            else if (display_seg == DISPLAY_PROG_MAX || display_seg == DISPLAY_LIMIT)
            {
                disp_matrix_text("MAX", 0);
                sprintf(text, "%d.%d", (uint)speed_limit_max / 30, (uint)((speed_limit_max % 30) / 3));
                disp_matrix_text(text, 1);
            }
            else if (display_seg == DISPLAY_PROG_FACT)
            {
                disp_matrix_text("FACT", 0);
                if (show_factory_mode == 0)
                {
                    disp_matrix_text("OFF", 1);
                }
                else if (show_factory_mode == 1)
                {
                    disp_matrix_text("ON", 1);
                }
            }
            else if (display_seg == DISPLAY_GOAL)
            {
                disp_matrix_text("GOAL", 0);
                disp_matrix_text("DONE", 1);
            }
            break;
        case USER_STATE_SLEEP: //no display
            if (runmode == RUN_MODE_STANDBY)
            {
                SET_LED_STANDBY;
            }
            break;
        case USER_STATE_FAULT: //display error_id in field0, others off
            sprintf(text, "E0%d", (int)error_id);
            disp_matrix_text(text, 0);
            //SET_LED(LED_ERROR);
            if (error_id != 0)
            {
                SET_LED_ERROR;
            }
            break;
        } /* switch(userstate) */
    }
    else //all display on and one beep when power up
    {
        //ONE BEEP
        if (waiting_cnt == DISPLAY_ALL_ON_DELAY)
        {
            beep(BEEP_KEY);
        }

        disp_matrix_text("WAIT", 0);

        if (waiting_cnt > 0) //set with the waiting variable
        {
            waiting_cnt--;
        }
        else
        {
            waiting = 0;
        }

        digit_left = waiting_cnt / 10;
        image[7] |= 0x80;
        image[9] |= 0x80;
        if (digit_left != MATRIX_SIZE)
        {
            //FIXME: the magic number 12 / 7, which is `MATRIX_SIZE * 10 / DISPLAY_ALL_ON_DELAY`
            for (digit_right = 0; digit_right < MATRIX_SIZE - digit_left * 12 / 7; digit_right++)
            {
                image[MATRIX_ADDR - 2 * digit_right] |= 0x18;
            }
        }

        CLEAR_LED_ALL;
    }
}

/*--------------------------------------------------------------------------*
 |
 |  UserConsumerKeys
 |  Call periodically in in main loop
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
int rcCheck(void);

static void ProgModeKeys(void)
{
    switch (key_id)
    {
    case KEY_MODE_PRESS:
        beep(BEEP_KEY);
        display_seg++;
        if (display_seg == DISPLAY_PROG_END)
            display_seg = DISPLAY_PROG_F1;
        break;
    case KEY_UP_PRESS:
        if (display_seg == DISPLAY_PROG_F1)
        {
            if (dc_motor_rating_f1 < DC_MOTOR_RATING_VOLT_MAX)
            {
                dc_motor_rating_f1++;
                eeprom_wrchar(EEPROM_ADDR_RATING_F1, dc_motor_rating_f1);
            }
        }
        else if (display_seg == DISPLAY_PROG_F2)
        {
            if (dc_motor_startup_volt < DC_MOTOR_STARTUP_VOLT_MAX)
            {
                dc_motor_startup_volt++;
                eeprom_wrchar(EEPROM_ADDR_STARTUP_VOLT, dc_motor_startup_volt);
            }
        }
        else if (display_seg == DISPLAY_PROG_F3)
        {
            if (dc_motor_rating_volt < DC_MOTOR_RATING_VOLT_MAX)
            {
                dc_motor_rating_volt++;
                eeprom_wrchar(EEPROM_ADDR_RATING_VOLT, dc_motor_rating_volt);
            }
        }
        else if (display_seg == DISPLAY_PROG_MAX)
        {
            if (speed_limit_max < SPEED_TARGET_MAX)
            {
                speed_limit_max += SPEED_INC;
                eeprom_wrchar(EEPROM_ADDR_SPEED_LIMIT, speed_limit_max);
            }
        }
        else if (display_seg == DISPLAY_PROG_FACT)
        {
            eeprom_wrchar(EEPROM_ADDR_FACTORY_FINISH, show_factory_mode);
            show_factory_mode = 1 - show_factory_mode;
        }
        flag_motor_params_changed = 1;
        break;
    case KEY_DOWN_PRESS:
        if (display_seg == DISPLAY_PROG_F1)
        {
            if (dc_motor_rating_f1 > DC_MOTOR_RATING_VOLT_MIN)
            {
                dc_motor_rating_f1--;
                eeprom_wrchar(EEPROM_ADDR_RATING_F1, dc_motor_rating_f1);
            }
        }
        else if (display_seg == DISPLAY_PROG_F2)
        {
            if (dc_motor_startup_volt > DC_MOTOR_STARTUP_VOLT_MIN)
            {
                dc_motor_startup_volt--;
                eeprom_wrchar(EEPROM_ADDR_STARTUP_VOLT, dc_motor_startup_volt);
            }
        }
        else if (display_seg == DISPLAY_PROG_F3)
        {
            if (dc_motor_rating_volt > DC_MOTOR_RATING_VOLT_MIN)
            {
                dc_motor_rating_volt--;
                eeprom_wrchar(EEPROM_ADDR_RATING_VOLT, dc_motor_rating_volt);
            }
        }
        else if (display_seg == DISPLAY_PROG_MAX)
        {
            if (speed_limit_max > 60) // 2 kmh
            {
                speed_limit_max -= SPEED_INC;
                eeprom_wrchar(EEPROM_ADDR_SPEED_LIMIT, speed_limit_max);
            }
        }
        else if (display_seg == DISPLAY_PROG_FACT)
        {
            eeprom_wrchar(EEPROM_ADDR_FACTORY_FINISH, show_factory_mode);
            show_factory_mode = 1 - show_factory_mode;
        }
        flag_motor_params_changed = 1;
        break;
    case KEY_MODE_STOP_LONG_PRESS:
    case KEY_STOP_PRESS:
        beep(BEEP_KEY);
        run_in_prog_mode = 0;
        display_seg = DISPLAY_TIME;
        display_cnt = 0;
        break;
    }
}

void UserConsumerKeys(void)
{
    /*---------------------------------------------------*
  |  Process key function associate with the key press
  *---------------------------------------------------*/
    CHECK_KEY_ID

    if (key_id != KEY_NONE && key_id_done == 0 && waiting == 0) //&& error_id==0
    {
        key_id_done = 1;
        button_id = key_id;
        if (run_in_prog_mode == 1)
        {
            ProgModeKeys();
        }
        else if (stepdown_flag == STEPDOWN_NONE)
        {
            switch (key_id)
            {
            case KEY_MODE_PRESS:
                beep(BEEP_KEY);

                if (runmode == RUN_MODE_STANDBY)
                {
                    start_no_tick = 0;
                    runmode = eeprom_rdchar(EEPROM_ADDR_RUNMODE);
                    flag_mode_changed = 1;
                    GOTO_STATE(USER_STATE_READY);
                }
                else if (runmode == RUN_MODE_AUTO)
                {
                    runmode = RUN_MODE_FIXED;
                    flag_mode_changed = 1;
                }
                else if (runmode == RUN_MODE_FIXED)
                {
                    runmode = RUN_MODE_AUTO;
                    flag_mode_changed = 1;
                }
                //if (global_fan_speed++ > 25) global_fan_speed = 3;
                break;
            case KEY_UP_PRESS:
                if (userstate == USER_STATE_SLEEP)
                    break;
                beep(BEEP_KEY);
                display_seg = DISPLAY_SPEED_TEMP;
                if (runmode == RUN_MODE_FIXED || runmode == RUN_MODE_NEW)
                {
                    fixed_mode_speed += SPEED_INC;
                    if (fixed_mode_speed > speed_limit_max)
                    {
                        fixed_mode_speed = speed_limit_max;
                        display_seg = DISPLAY_LIMIT;
                    }
                    if (fixed_mode_speed % SPEED_INC != 0)
                    {
                        fixed_mode_speed -= fixed_mode_speed % SPEED_INC;
                    }

                    if (machine_speed_target == 0)
                    {
                        set_speed_before_start = 1;
                    }
                }

                key_id = KEY_NONE;
                break;
            case KEY_DOWN_PRESS:
                if (userstate == USER_STATE_SLEEP)
                    break;
                beep(BEEP_KEY);
                display_seg = DISPLAY_SPEED_TEMP;
                if (runmode == RUN_MODE_FIXED || runmode == RUN_MODE_NEW)
                {
                    if (fixed_mode_speed < SPEED_INC + SPEED_TARGET_MIN1)
                    {
                        fixed_mode_speed = SPEED_TARGET_MIN1;
                    }
                    else
                    {
                        fixed_mode_speed -= SPEED_INC;
                    }

                    if (machine_speed_target == 0)
                        fixed_mode_speed = 0;

                    if (fixed_mode_speed % SPEED_INC != 0)
                    {
                        fixed_mode_speed += SPEED_INC - fixed_mode_speed % SPEED_INC;
                    }

                    if (machine_speed_target == 0)
                    {
                        set_speed_before_start = 1;
                    }
                }

                key_id = KEY_NONE;
                break;
            case KEY_STOP_PRESS:
                if (userstate == USER_STATE_SLEEP)
                    break;
                beep(BEEP_KEY);
                if (runmode == RUN_MODE_AUTO || runmode == RUN_MODE_NEW)
                {
                    stepdown_flag = STEPDOWN_STOP;
                    break;
                }
                else if (runmode == RUN_MODE_CHECK)
                {
                    display_seg = DISPLAY_TIME;
                    stepdown_flag = STEPDOWN_STOP;
                }
                if (runmode == RUN_MODE_FIXED)
                {
                    // if (fixed_mode_speed > 0)
                    // eeprom_wrchar(EEPROM_ADDR_FIXED_SPEED, fixed_mode_speed);
                    fixed_mode_speed = 0;
                    display_seg = DISPLAY_SPEED_TEMP;
                }
                break;
            case KEY_MODE_LONG_PRESS:
                if (runmode == RUN_MODE_STANDBY)
                {
                    beep(BEEP_KEY_INVALID);
                    set_wifi_flag(FLAG_WIFI_RESTORE);
                    start_no_tick = 0;
                    runmode = eeprom_rdchar(EEPROM_ADDR_RUNMODE);
                    flag_mode_changed = 1;
                    GOTO_STATE(USER_STATE_READY);
                }
                else if (userstate == USER_STATE_READY)
                {
                    beep(BEEP_KEY);
                    GOTO_STATE(USER_STATE_SLEEP);
                    runmode = RUN_MODE_STANDBY;
                    flag_mode_changed = 1;
                }
                break;
            case KEY_MODE_UP_PRESS:
                display_seg = DISPLAY_SENSOR;
                break;
            case KEY_MODE_DOWN_PRESS:
                display_seg = DISPLAY_CUR_VOL;
                break;
            case KEY_MODE_STOP_PRESS:
                break;
            case KEY_MODE_STOP_LONG_PRESS:
                if (runmode < RUN_MODE_STANDBY)
                {
                    beep(BEEP_KEY);
                    run_in_prog_mode = 1;
                    display_seg = DISPLAY_PROG_F1;
                }
                break;
            case KEY_MODE_UP_LONG_PRESS:
                if (runmode != RUN_MODE_CHECK)
                {
                    beep(BEEP_KEY);
                    runmode = RUN_MODE_CHECK;
                    flag_mode_changed = 1;
                    userstate = USER_STATE_READY;
                    fixed_mode_speed = 120;
                    user_request = USER_REQUEST_START;
                    display_seg = DISPLAY_CHECK;
                }
            }
        }
    }
}

static void reset_statistic_data(void)
{
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

static void check_max_speed(void)
{                                     
    if (max_speed_unlocked == 0 && user_total_distance > 200)    
    {                                                            
        speed_limit_max = SPEED_TARGET_MAX;                      
        max_speed_unlocked = 1;                                  
        display_seg = DISPLAY_LIMIT;                                   
        beep(BEEP_GOAL);                                         
        eeprom_wrchar(EEPROM_ADDR_MAX_SPEED_UNLOCKED, 1);        
        eeprom_wrchar(EEPROM_ADDR_SPEED_LIMIT, speed_limit_max); 
    }
}

/*--------------------------------------------------------------------------*
 |
 | UserConsumerOperation
 |
 | Description: To process operations in consumer mode
 |
 |  Entry:  None
 |  Exit:   None
 *--------------------------------------------------------------------------*/
static void UserConsumerOperation(void)
{
    uint temp16, tempi;
    long bias_abs;

    bias_abs = (tension_bias + tension2_bias) / 2;

    if (flag_mode_changed == 1)
    {
        if (runmode != RUN_MODE_STANDBY && runmode != RUN_MODE_CHECK)
        {
            eeprom_wrchar(EEPROM_ADDR_RUNMODE, runmode);
            if (runmode == RUN_MODE_FIXED)
            {
                if (machine_speed_target > 0)
                {
                    fixed_mode_speed = machine_speed_target;
                }
            }
        }
        no_current_cnt = 0;
        flag_mode_changed = 0;
    }
    ui_state = USER_STATE_READY;

    if (++state_tick >= TIME_BASE_SEC)
    {
        state_tick = 0;
        state_sec++;
    }

    switch (userstate)
    {
    case USER_STATE_SLEEP:
        if (runmode != RUN_MODE_STANDBY)
        {
            beep(BEEP_KEY);
            start_no_tick = 0;
            GOTO_STATE(USER_STATE_READY);
        }
        //else
        else if (state_sec == 1 && state_tick == 0)
        {
            reset_statistic_data();
            user_time_minute = 0;
            user_time_second = 0;

            user_distance = 0;
            user_calories = 0;

            user_steps_total = 0;
            user_steps_pause = 0;

            user_total_distance_bp = user_total_distance;

            goal_status = GOAL_ONGOING;
        }
        break;
    case USER_STATE_READY:
        stepdown_flag = STEPDOWN_NONE;

        if (runmode == RUN_MODE_CHECK)
        {
            GOTO_STATE(USER_STATE_RUN);
            break;
        }

        if (state_sec >= TO_SLEEP_CNT_MAX || runmode == RUN_MODE_STANDBY)
        {
            runmode = RUN_MODE_STANDBY;
            flag_mode_changed = 1;
            GOTO_STATE(USER_STATE_SLEEP);
        }
        else if (bias_abs > 2500 // 1000 * 1000
                 && waiting == 0 && flag_Gsensor_disconnected <= 2 && state_tick > 1)
        {
            if (start_cnt++ < 15)
                break;
            if (runmode == RUN_MODE_AUTO)
                user_speed_target = SPEED_TARGET_MIN1;
            else if (runmode == RUN_MODE_FIXED)
            {
                //fixed_mode_speed = eeprom_rdchar(EEPROM_ADDR_FIXED_SPEED);
                //FIXME:
                if (set_speed_before_start == 0)
                {
                    fixed_mode_speed = fixed_start_speed;
                }
                else
                {
                    set_speed_before_start = 0;
                }
            }
            beep(BEEP_KEY);
            if (start_no_tick == 0 && (runmode == RUN_MODE_AUTO && flag_Gsensor_disconnected == 0 || runmode == RUN_MODE_FIXED && flag_Gsensor_disconnected <= 2))
            {
                GOTO_STATE(USER_STATE_TICK);
            }
            else
            {
                user_request = USER_REQUEST_START;
                no_current_cnt = 0;
                GOTO_STATE(USER_STATE_RUN);
                check_max_speed();
            }
        }
        else if (runmode == RUN_MODE_NEW && tutorial_state == TUTORIAL_FINISH && flag_Gsensor_disconnected == 0)
        {
            run_new();
        }
        else
        {
            start_cnt = 0;
        }
        break;
    case USER_STATE_TICK:
        if (state_sec >= 3)
        {
            user_request = USER_REQUEST_START;
            no_current_cnt = 0;
            GOTO_STATE(USER_STATE_RUN);
            check_max_speed();
        }
        if (state_tick == 0 && state_sec >= 1)
        {
            beep(BEEP_KEY);
        }
        break;
    case USER_STATE_RUN:
        ui_state = USER_STATE_RUN;
        run();
        if (user_request == USER_REQUEST_STOP)
        {
            total_dist_write();
            user_steps_pause = user_steps_total;
            if (stepdown_flag == STEPDOWN_PAUSE)
            {
                GOTO_STATE(USER_STATE_PAUSE);
            }
            else
            {
                GOTO_STATE(USER_STATE_STOP);
            }
            stepdown_flag = STEPDOWN_NONE;
        }

        if (goal_status != GOAL_ACHIEVED && goal_value > 0)
        {
            if ((goal_type == 0 && user_time_minute >= goal_value) || (goal_type == 1 && user_distance / 100 >= goal_value) || (goal_type == 2 && user_calories / 100 >= goal_value))
            {
                if (goal_status == GOAL_ONGOING)
                {
                    display_seg = DISPLAY_GOAL;
                    beep(BEEP_GOAL);
                }
                goal_status = GOAL_ACHIEVED;
            }
            else if (goal_status == GOAL_CHANGED)
                goal_status = GOAL_ONGOING;
        }
        break;

    case USER_STATE_PAUSE:
        start_no_tick = 1;
        GOTO_STATE(USER_STATE_READY);
        break;
    case USER_STATE_STOP:
        if (tension_bias + tension2_bias < 600 || tutorial_state == TUTORIAL_STEP3_BEGIN || tutorial_state == TUTORIAL_STEP1_BEGIN)
        {
            if (runmode == RUN_MODE_CHECK)
            {
                if (machine_speed_target == 0)
                {
                    runmode = eeprom_rdchar(EEPROM_ADDR_RUNMODE);
                    flag_mode_changed = 1;
                }
            }
            else if (start_cnt++ >= 3)
            {
                start_no_tick = 1;
                GOTO_STATE(USER_STATE_READY);
            }
        }
        else
        {
            start_cnt = 0;
        }
        break;
    case USER_STATE_EOC:
        if (state_sec > EOC_STATE_CNT_MAX)
        {
            total_dist_write();
            GOTO_STATE(USER_STATE_READY);
        }
        else
        {
            if (stepdown_cnt >= 6)
            {
                stepdown_cnt = 0;
                if (user_speed_target > SPEED_TARGET_MIN1)
                {
                    user_speed_target--;
                    user_request |= USER_REQUEST_NEW_SPEED;
                }
                else
                {
                    if (state_sec < EOC_STATE_CNT_FLASH_BEEP)
                    {
                        state_sec = EOC_STATE_CNT_FLASH_BEEP;
                    }
                    user_request = USER_REQUEST_STOP;
                }
            }
            else
            {
                stepdown_cnt++;
            }
            if (user_speed_target <= SPEED_TARGET_MIN1 && sec == 0)
            {
                if (state_sec > EOC_STATE_CNT_FLASH_BEEP)
                {
                    beep(BEEP_KEY);
                }
            }
        }

        if (state_sec < EOC_STATE_CNT_FLASH_BEEP)
        {
            ui_state = USER_STATE_RUN;
        }
        break;
    case USER_STATE_FAULT:
        if (error_id == 0)
        {
            CLEAR_LED_ERROR;
            start_no_tick = 0;
            GOTO_STATE(USER_STATE_READY);
        }
        break;
    }

    if (pcerr_com == 0 && (ui_state != USER_STATE_RUN) && machine_state == MACHINE_STATE_RUN)
    {
        if (user_machine_state_cnt > 3)
        {
            user_machine_state_cnt = 0;
            user_request = USER_REQUEST_STOP; //when no match, request send stop command
            start_no_tick = 1;
            GOTO_STATE(USER_STATE_READY);
        }
        else if (sec == 0)
        {
            user_machine_state_cnt++;
        }
    }
    else
    {
        user_machine_state_cnt = 0;
    }
    //user run, machine stop. stop user side
    if (pcerr_com == 0 && ui_state == USER_STATE_RUN && machine_state == MACHINE_STATE_IDLE)
    {
        if (user_machine_state_cnt1 > 10)
        {
            user_machine_state_cnt1 = 0;
            user_request = USER_REQUEST_STOP; //when no match, request send stop command
            start_no_tick = 1;
            GOTO_STATE(USER_STATE_READY);
        }
        else if (sec == 0)
        {
            user_machine_state_cnt1++;
        }
    }
    else
    {
        user_machine_state_cnt1 = 0;
    }
    //when speed change, set the flag for distance_calculation()
    if ((user_request & USER_REQUEST_NEW_SPEED) && userstate == USER_STATE_RUN)
    {
        flag_speed_change = 1;
    }
}

static void prepare_statistic_data(void)
{
    uint temp16;

    if (has_wifi_flag(FLAG_WIFI_STORE_MP) && store_mp.km < user_distance / 100)
    {
        temp16 = user_time_minute * 60 + user_time_second;
        store_mp.dur = temp16 - store_mp.time;
        store_mp.time = temp16;
        store_mp.km = user_distance / 100;
    }

    if (has_wifi_flag(FLAG_WIFI_STORE_POINT) && store_point.dist < user_distance)
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
    }
}
/*--------------------------------------------------------------------------*
 |
 | detect_error
 |
 | Description: To detect error of Display board or from Power board
 |
 |  Entry:  None
 |  Exit:   None
 *--------------------------------------------------------------------------*/
void detect_error(void)
{
    uchar error_id_last = error_id;

#if 0 // 1 for test sensor only
    if (flag_Gsensor_disconnected == 3)
    {
        error_id = 8;

#else
    if (pcerr_com == 1)
    {
        error_code = ERROR_COMMUNICATION;
    }

    if (error_code != 0 || flag_Gsensor_disconnected == 3)
    {
        if (error_code & ERROR_COMMUNICATION)
        {
            error_id = 1;
        }
        else if (error_code & ERROR_MOSFET)
        {
            error_id = 2;
        }
        else if (error_code & ERROR_SPEED_SENSOR)
        {
            error_id = 3;
        }
        else if (error_code & ERROR_DCMOTOR_CURRENT)
        {
            error_id = 5;
        }
        else if (error_code & ERROR_DCMOTOR_ALARM)
        {
            error_id = 5;
        }
        else if (error_code & ERROR_MOTOR_DISCONNECT)
        {
            error_id = 6;
        }
        else if (flag_Gsensor_disconnected == 3)
        {
            error_id = 8;
        }
#endif
    //when error, beep
    if (error_id_last == 0 && error_id != 0)
    {
        beep(BEEP_ERROR);
        set_wifi_flag(FLAG_WIFI_ERROR_ID);
        if (userstate != USER_STATE_SLEEP)
        {
            GOTO_STATE(USER_STATE_FAULT);
        }
        else //clear error in idle state
        {
            user_request = USER_REQUEST_ERROR_RESET;
            error_code = 0; //reset all fault
            error_id = 0;
        }
    }
}
else
{
    error_id = 0;
}
}

@near static test_state_t teststate;
static void FactoryTestOperation(void)
{
    uchar text[6];
    if (++state_tick >= TIME_BASE_SEC)
    {
        state_tick = 0;
        state_sec++;
    }

    CHECK_KEY_ID

    if (key_id != KEY_NONE && key_id_done == 0)
    {
        key_id_done = 1;
        if (run_in_prog_mode)
        {
            ProgModeKeys();
        }
        else if (key_id == KEY_MODE_PRESS)
        {
            beep(BEEP_KEY);
            key_id_done = 1;
            disp_matrix_all(0x00);
            if (teststate == TEST_STATE_NET_END)
            {
                set_wifi_flag(FLAG_WIFI_RESTORE);
            }
            else if (teststate == TEST_STATE_END)
            {
                // reset to factory.
                factory_finish = 1;
                eeprom_factory();
                user_total_distance = 0;
                user_total_distance_bp = 0;
                speed_limit_max = SPEED_LIMIT_MAX_FACTORY;
                acceleration_param = 2;
                // continue
                waiting = 1;
                waiting_cnt = DISPLAY_ALL_ON_DELAY;
                display_seg = DISPLAY_TIME;
                display_cnt = 0;
                return;
            }
            else if (teststate == TEST_STATE_SENSOR)
            {
                user_request = USER_REQUEST_START;
                stepdown_flag = STEPDOWN_NONE;
                runmode = RUN_MODE_AUTO;
            }
            else if (teststate == TEST_STATE_LED)
            {
                CLEAR_LED_ALL;
                fixed_mode_speed = 120;
                stepdown_flag = STEPDOWN_NONE;
                user_request = USER_REQUEST_START;
            }
            else if (teststate == TEST_STATE_AUTO)
            {
                eeprom_wrchar(EEPROM_ADDR_TEST_RUN60, 1);
                stepdown_flag = STEPDOWN_NONE;
                user_request = USER_REQUEST_START;
                fixed_mode_speed = 180;
            }
            else if (teststate == TEST_STATE_RUN60)
            {
                eeprom_wrchar(EEPROM_ADDR_TEST_RUN60, 0);
            }
            
            if (teststate != TEST_STATE_NET && !run_in_prog_mode)
                teststate += 1;
        }
        else if (key_id == KEY_UP_PRESS)
        {
            fixed_mode_speed += SPEED_INC;
            if (fixed_mode_speed > SPEED_TARGET_MAX)
                fixed_mode_speed = SPEED_TARGET_MAX;
        }
        else if (key_id == KEY_DOWN_PRESS)
        {
            if (fixed_mode_speed < SPEED_INC + SPEED_TARGET_MIN1)
            {
                fixed_mode_speed = SPEED_TARGET_MIN1;
            }
            else
            {
                fixed_mode_speed -= SPEED_INC;
            }
        }
        else if (key_id == KEY_STOP_PRESS && (teststate == TEST_STATE_RUN40 || teststate == TEST_STATE_RUN60))
        {
            beep(BEEP_KEY);
            run_in_prog_mode = 1;
            display_seg = DISPLAY_PROG_F1;
        }
    }

    switch (teststate)
    {
    case TEST_STATE_BEGIN:
        teststate = TEST_STATE_RC;
        waiting = 0;
        waiting_cnt = 0;
        disp_matrix_all(0x00);
        CLEAR_LED_ALL;
        if (eeprom_rdchar(EEPROM_ADDR_TEST_RUN60) == 1)
        {
            teststate = TEST_STATE_RUN60;
            user_request = USER_REQUEST_START;
            fixed_mode_speed = 180;
        }
        break;
    case TEST_STATE_RC:
        disp_matrix_text("TEST", 0);
        break;
    case TEST_STATE_LED:
        disp_matrix_all(0xff);
        SET_LED_ALL;
        break;
    case TEST_STATE_NET_START:
        disp_matrix_text("FACT", 0);
        set_wifi_flag(FLAG_WIFI_FACTORY);
        net_state = NET_STATE_UNKNOWN;
        teststate = TEST_STATE_NET;
        state_sec = 0;
        break;
    case TEST_STATE_NET:
        disp_matrix_all(0x0);
        if (state_sec > 60)
        {
            teststate = TEST_STATE_NET_END;
            break;
        }
        switch (net_state)
        {
        case NET_STATE_CLOUD:
            teststate = TEST_STATE_NET_END;
            break;
        case NET_STATE_LOCAL:
            teststate = TEST_STATE_NET_END;
        case NET_STATE_UNKNOWN:
            SET_LED_NET;
            break;
        case NET_STATE_OFFLINE:
        case NET_STATE_UAP:
            disp_alternant_net(100, 200);
            break;
        case NET_STATE_UPDATING:
            disp_alternant2_net(100, 200, 100, 800);
            break;
        case NET_STATE_UNPROV:
            disp_alternant_net(200, 800);
            break;
        }
        disp_matrix_text("NET", 0);
        break;
    case TEST_STATE_NET_END:
        disp_matrix_all(0x00);
        disp_matrix_text("NET", 0);
        if (net_state == NET_STATE_CLOUD || net_state == NET_STATE_LOCAL)
        {
            disp_matrix_text("OK", 1);
        }
        else if (state_sec > 60)
        {
            disp_matrix_text("ERR", 1);
        }
        break;
    case TEST_STATE_SENSOR:
        disp_matrix_all(0x00);

        sprintf(text, "%ld", tension / 100);
        disp_matrix_text(text, 0);

        sprintf(text, "%ld", tension2 / 100);
        disp_matrix_text(text, 1);
        break;
    case TEST_STATE_RUN40:
    case TEST_STATE_RUN60:
        speed_rpm_convert();
        runmode = RUN_MODE_FIXED;
        run();
        if (run_in_prog_mode)
        {
            UserConsumerDisplay();
        }
        else
        {
            disp_matrix_all(0x0);
            disp_matrix_text("RUN", 0);
            sprintf(text, "%d.%d", fixed_mode_speed / 30, ((fixed_mode_speed % 30) / 3));
            disp_matrix_text(text, 1);
        }
        break;
    case TEST_STATE_STOP40:
    case TEST_STATE_STOP60:
        disp_matrix_text("STOP", 0);
        speed_rpm_convert();
        stepdown_flag = STEPDOWN_PAUSE;
        run();
        if (machine_speed_target == 0 && teststate == TEST_STATE_STOP60)
        {
            teststate = TEST_STATE_END;
            stepdown_flag = STEPDOWN_NONE;
            disp_matrix_all(0x0);
        }
        break;
    case TEST_STATE_END:
        disp_matrix_text("END", 0);
        break;
    case TEST_STATE_AUTO:
        speed_rpm_convert();
        //run();
        UserConsumerOperation();
        UserConsumerDisplay();
        break;
    }
}
/*--------------------------------------------------------------------------*
 |
 |  useroperation
 |  Call periodically in main loop
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
void useroperation(void)
{
    if (runmode == RUN_MODE_AUTO || runmode == RUN_MODE_FIXED || runmode == RUN_MODE_NEW)
    {
        time_calculation();
        distance_calculation();
        // calories_calculation();
        prepare_statistic_data();
    }
    HX711_Weight();
    UserConsumerKeys();
    speed_rpm_convert();
    UserConsumerDisplay(); /* update display */
    UserConsumerOperation();
    //image function, call periodically                                    //20ms
    DisplayDriverProcessLED(); //20ms
}

void testoperation(void)
{
    HX711_Weight();

    FactoryTestOperation();

    DisplayDriverProcessLED();
}
