#include <stdio.h>
#include <string.h>
#include "newtype.h"
#include "declare.h"
#include "control.h"
#include "eeprom.h"
#include "image.h"
#include "beep.h"
#include "key.h"
#include "miwifi.h"
#include "run_mode.h"
#include "sensor.h"
#include "displaydriver.h"

static uchar ui_state;

@near static uchar user_machine_state_cnt;  //count for user and machine state check, in second
@near static uchar user_machine_state_cnt1; //count for user and machine state check, in second
@near static uchar show_for_a_while;

@near uint display_cnt;
@near display_seg_t display_seg;
@near bool start_no_tick;
@near ulong user_total_distance;

@near bool show_factory_mode;

@near ebool flag_sensor_may_reverted;

@near bool flag_may_stuck;

#if 0
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
#endif

/*--------------------------------------------------------------------------*
 |
 |  UserConsumerDisplay
 |  Call periodically in UserOperation() if in consumer mode
 |
 |  Description: To update speed,time,calories,heart rate, and prompts.
 |
 *--------------------------------------------------------------------------*/

@near static uchar const lib_start[LED_UP_SIZE] =
    {
        0x09, 0x15, 0x15, 0x12, 0x00, 0x10, 0x7F, 0x11, 0x00, 0x0A, 0x15, 0x15, 0x0F, 0x01, 0x00, 0x11,
        0x1F, 0x09, 0x10, 0x00, 0x10, 0x7F, 0x11}; // start
@near static uchar const lib_reset[LED_UP_SIZE] =
    {
        0x11, 0x1F, 0x09, 0x10, 0x10, 0x0E, 0x15, 0x15, 0x0D, 0x00, 0x09, 0x15, 0x15, 0x12, 0x00, 0x0E,
        0x15, 0x15, 0x0D, 0x10, 0x7F, 0x11, 0x11}; // reset
@near static uchar const lib_press[LED_UP_SIZE] =
    {
        0x3F, 0x24, 0x24, 0x18,
        0x02, 0x3E, 0x12, 0x20,
        0x20, 0x1C, 0x2A, 0x2A, 0x1A,
        0x00,
        0x12, 0x2A, 0x2A, 0x24,
        0x00,
        0x12, 0x2A, 0x2A, 0x24}; // press
@near static uchar const lib_rc_start[LED_DOWN_SIZE] =
    {
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x0C, 0x1E, 0x1E, 0x0C,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

static void GOTO_STATE(user_state_t state)
{
    userstate = state;
    state_sec = 0;
    state_tick = 0;
    start_cnt = 0;
}

static void set_runmode_led(void)
{
    switch (runmode)
    {
    case RUN_MODE_AUTO:
        SET_LED_AUTO;
        break;
    case RUN_MODE_FIXED:
        SET_LED_FIXED;
        break;
    case RUN_MODE_STANDBY:
        SET_LED_STANDBY;
        break;
    case RUN_MODE_NEW:
        if (tutorial_state >= TUTORIAL_STEP2_END && tutorial_state != TUTORIAL_STOP_FIRST)
        {
            SET_LED_AUTO;
        }
        else
        {
            SET_LED_FIXED;
        }
        break;
    }
}

void UserConsumerDisplay(void)
{
    uchar digit_left, digit_right; // left and right side
    uint digit_int;
    extern const uchar FW_VERSION[];

    disp_matrix_all(0x00);

    if (waiting == 0)
    {
        switch (userstate)
        {
        case USER_STATE_TICK:
        case USER_STATE_READY:
        case USER_STATE_RUN:
        case USER_STATE_PAUSE:
        case USER_STATE_STOP:
            // case USER_STATE_EOC:

            set_runmode_led();
            if (runmode == RUN_MODE_CHECK && userstate != USER_STATE_TICK)
            {
                CLEAR_LED_ALL;
                disp_text_up("CALI");
                return;
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

            if (runmode == RUN_MODE_LOCK)
            {
                CLEAR_LED_MODE;
                disp_text_up("LOCK");
                break;
            }
            if (userstate == USER_STATE_TICK)
            {
                display_cnt = 0;
                disp_matrix_up(lib_start);
                disp_d_down(3 - state_sec);
                break;
            }
            if (userstate == USER_STATE_STOP || stepdown_flag == STEPDOWN_STOP)
            {
                disp_text_up("STOP");
                break;
            }
            if (has_wifi_flag(FLAG_WIFI_RESTORE))
            {
                disp_matrix_up(lib_reset);
                break;
            }

            if (run_in_prog_mode == 0)
            {
                if (display_seg == DISPLAY_START_HINT)
                {
                    disp_matrix_up(lib_press);
                    if (state_tick < 35)
                        disp_matrix_down(lib_rc_start);
                    display_seg = DISPLAY_STEP;
                    display_cnt = 0;
                    break;
                }
                if (runmode == RUN_MODE_NEW)
                {
                    // FIXME: don't change display_seg and show "NEW"
                    disp_text_up("NEW");
                    disp_1f_down((uint)machine_speed_target / 3);
                    break;
                }

                if (show_for_a_while)
                {
                    if (display_cnt == 0)
                    {
                        display_seg = DISPLAY_STEP;
                        show_for_a_while = 0;
                    }
                }
                else if (display_seg > DISPLAY_FOR_A_WHILE)
                {
                    display_cnt = DISPLAY_INTERVAL * 2;
                    show_for_a_while = 1;
                }

                if (display_seg < DISPLAY_SIZE && display_cnt == 0)
                {
                    DisplayDriverInitializeLED();
                    display_cnt = DISPLAY_INTERVAL;
                    do
                    {
                        display_seg = (display_seg + 1) % DISPLAY_SIZE;
                    } while (!(flag_disp & (1 << display_seg)));
                }

                display_cnt--;
            }

            if (display_seg == DISPLAY_TIME)
            {
                disp_text_up("TIME");

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
                if (user_time_minute > 59 && state_tick > 25)
                {
                    disp_custom(LED_DOWN, "%d %02d", (uint)digit_left, (uint)digit_right);
                }
                else
                {
                    disp_custom(LED_DOWN, "%d:%02d", (uint)digit_left, (uint)digit_right);
                }
            }
            else if (display_seg == DISPLAY_SPEED || display_seg == DISPLAY_SPEED_TEMP)
            {
                disp_text_up("SPD");

                if (runmode == RUN_MODE_FIXED && userstate == USER_STATE_RUN)
                {
                    digit_int = fixed_mode_speed;
                }
                else
                {
                    digit_int = machine_speed_target;
                }
                disp_1f_down(digit_int / 3);
            }
            else if (display_seg == DISPLAY_DIST)
            {
                disp_text_up("KM");
                disp_2f(user_distance, LED_DOWN);
            }
            else if (display_seg == DISPLAY_CAL)
            {
                disp_text_up("CAL");

                if (user_calories < 100000)
                {
                    disp_1f_down((uint)(user_calories / 10));
                }
                else if (user_calories < 1000000)
                {
                    disp_d_down((uint)(user_calories / 100));
                }
            }
            else if (display_seg == DISPLAY_STEP)
            {
                disp_text_up("STEP");
                disp_d_down(user_steps_total < 10000 ? user_steps_total : user_steps_total % 10000);
            }
            else if (display_seg == DISPLAY_CUR_VOL)
            {
                disp_1f_up((uint)machine_current_motor);
                disp_d_down((uint)machine_volt_motor);
            }
            else if (display_seg == DISPLAY_SENSOR)
            {
                disp_ld(tension / 100, LED_UP);
                disp_ld(tension2 / 100, LED_DOWN);
            }
            else if (display_seg == DISPLAY_PROG_F1)
            {
                disp_text_up("F1");
                disp_d_down((int)dc_motor_rating_f1);
            }
            else if (display_seg == DISPLAY_PROG_F2)
            {
                disp_text_up("F2");
                disp_d_down((int)dc_motor_startup_volt);
            }
            else if (display_seg == DISPLAY_PROG_F3)
            {
                disp_text_up("F3");
                disp_d_down((int)dc_motor_rating_volt);
            }
            else if (display_seg == DISPLAY_PROG_MAX || display_seg == DISPLAY_LIMIT)
            {
                disp_text_up("MAX");
                disp_1f_down((uint)(speed_limit_max / 3));
            }
            else if (display_seg == DISPLAY_PROG_FACT)
            {
                disp_text_up("FACT");
                if (show_factory_mode == 0)
                {
                    disp_text_down("OFF");
                }
                else if (show_factory_mode == 1)
                {
                    disp_text_down("ON");
                }
                // disp_text_down(show_factory_mode ? "ON" : "OFF");
            }
            else if (display_seg == DISPLAY_PROG_VERSION)
            {
                disp_d_down((uint)power_board_version);
                disp_text_up(FW_VERSION);
            }
            else if (display_seg == DISPLAY_GOAL)
            {
                disp_text_up("GOAL");
                disp_text_down("DONE");
            }
            break;
        case USER_STATE_SLEEP: //no display
            if (runmode == RUN_MODE_STANDBY)
            {
                SET_LED_STANDBY;
            }
            if (state_sec == 1)
            {
                CLEAR_LED_NET;
                CLEAR_LED_ERROR;
            }
            break;
        case USER_STATE_FAULT:
            disp_custom(LED_UP, "E%02d", (uint)error_id);
            CLEAR_LED_MODE;
            SET_LED_ERROR;
            if (error_id == 8)
                set_runmode_led();
            else if (error_id == 10 || error_id == 11)
            {
                digit_int = (30 - (error_id - 10) * 20) * 60ul + (uint)(error_time - server_time - clock() / CLOCKS_PER_SEC);
                disp_custom(LED_DOWN, "%d:%02d", digit_int / 60, digit_int % 60);
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

        disp_text_up("WAIT");

        if (waiting_cnt > 0) //set with the waiting variable
        {
            waiting_cnt--;
        }
        else
        {
            waiting = 0;
        }

        digit_int = LED_DOWN_SIZE * (uint)(DISPLAY_ALL_ON_DELAY - waiting_cnt) / DISPLAY_ALL_ON_DELAY;
        if (digit_int > 0)
            memset(images[LED_DOWN], (char)0x18, digit_int);
        // CLEAR_LED_ALL;
    }
}

void UserConsumerKeys(void)
{
    /*---------------------------------------------------*
  |  Process key function associate with the key press
  *---------------------------------------------------*/
    check_key_id();

    if (key_id != KEY_NONE && key_id_done == 0 && waiting == 0) //&& error_id==0
    {
        key_id_done = 1;
        button_id = key_id;
        if (stepdown_flag == STEPDOWN_NONE)
        {
            switch (key_id)
            {
            case KEY_MODE_PRESS:
            case KEY_MODE_PRESS_BTN:
                beep(BEEP_KEY);

                if (runmode == RUN_MODE_STANDBY)
                {
                    start_no_tick = 0;
                    runmode = eeprom_rdchar(EEPROM_ADDR_RUNMODE);
                    flag_mode_changed = 1;
                    // GOTO_STATE(USER_STATE_READY);
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
                if (machine_speed_target > 0 && (runmode == RUN_MODE_FIXED || runmode == RUN_MODE_NEW))
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
                }

                key_id = KEY_NONE;
                break;
            case KEY_DOWN_PRESS:
                if (userstate == USER_STATE_SLEEP)
                    break;
                beep(BEEP_KEY);
                display_seg = DISPLAY_SPEED_TEMP;
                if (machine_speed_target > 0 && (runmode == RUN_MODE_FIXED || runmode == RUN_MODE_NEW))
                {
                    if (fixed_mode_speed < SPEED_INC + SPEED_TARGET_MIN1)
                    {
                        stepdown_flag = STEPDOWN_STOP;
                    }
                    else
                    {
                        fixed_mode_speed -= SPEED_INC;
                    }

                    if (fixed_mode_speed % SPEED_INC != 0)
                    {
                        fixed_mode_speed += SPEED_INC - fixed_mode_speed % SPEED_INC;
                    }
                }

                key_id = KEY_NONE;
                break;
            case KEY_STOP_PRESS:
                if (userstate == USER_STATE_SLEEP)
                    break;
                beep(BEEP_KEY);
                if (userstate == USER_STATE_READY)
                {
                    stepdown_flag = STEPDOWN_START;
                }
                else
                {
                    stepdown_flag = STEPDOWN_STOP;
                }
                break;
            case KEY_STOP_LONG_PRESS:
                if (userstate == USER_STATE_STOP)
                {
                    beep(BEEP_KEY);
                    flag_may_stuck = 1;
                }
                break;
            case KEY_MODE_LONG_PRESS_BTN:
                if (runmode == RUN_MODE_STANDBY)
                {
                    beep(BEEP_KEY_INVALID);
                    set_wifi_flag(FLAG_WIFI_RESTORE);
                    start_no_tick = 0;
                    runmode = eeprom_rdchar(EEPROM_ADDR_RUNMODE);
                    if (runmode == RUN_MODE_NEW)
                    {
                        runmode = RUN_MODE_FIXED;
                    }
                    flag_mode_changed = 1;
                    GOTO_STATE(USER_STATE_READY);
                    break;
                }
            case KEY_MODE_LONG_PRESS:
                if (userstate == USER_STATE_READY)
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
            //case KEY_MODE_STOP_LONG_PRESS:
            case KEY_MODE_STOP_LONG_PRESS_BTN:
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
                    GOTO_STATE(USER_STATE_TICK);
                    fixed_mode_speed = 120;
                }
            }
        }
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
void UserConsumerOperation(void)
{
    uint temp16;
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

    if (error_id > 0 && userstate != USER_STATE_FAULT && (error_id != 8 || runmode == RUN_MODE_AUTO || flag_Gsensor_disconnected == 3 && flag_auto))
    {
        if (machine_speed_target > 0)
            stepdown_flag = STEPDOWN_STOP;
        else
        {
            stepdown_flag = STEPDOWN_NONE;
            GOTO_STATE(USER_STATE_FAULT);
        }
    }

    switch (userstate)
    {
    case USER_STATE_SLEEP:
        if (runmode != RUN_MODE_STANDBY)
        {
            beep(BEEP_KEY);
            start_no_tick = 0;
            skip_error = 0;
            if (state_sec > 10)
                set_wifi_flag(FLAG_WIFI_SET_TIME);
            GOTO_STATE(USER_STATE_READY);
        }
        //else
        else if (state_sec == 1 && state_tick == 0)
        {
            reset_data();
            skip_error = 1;

            flag_sensor_may_reverted = 1;
        }
        break;
    case USER_STATE_READY:
        if (stepdown_flag != STEPDOWN_START)
            stepdown_flag = STEPDOWN_NONE;

        //if (runmode == RUN_MODE_CHECK)
        //{
        //    GOTO_STATE(USER_STATE_RUN);
        //    break;
        //}

        if (state_sec >= TO_SLEEP_CNT_MAX || runmode == RUN_MODE_STANDBY)
        {
            runmode = RUN_MODE_STANDBY;
            flag_mode_changed = 1;
            GOTO_STATE(USER_STATE_SLEEP);
        }
        else if (runmode == RUN_MODE_LOCK)
        {
            stepdown_flag = STEPDOWN_NONE;
            break;
        }
        else if (stepdown_flag == STEPDOWN_START)
        {
            stepdown_flag = STEPDOWN_NONE;
            if (runmode == RUN_MODE_FIXED || runmode == RUN_MODE_NEW && tutorial_state < TUTORIAL_STEP3_BEGIN)
            {
                fixed_mode_speed = fixed_start_speed;
                display_seg = DISPLAY_SPEED_TEMP;
                GOTO_STATE(USER_STATE_TICK);
            }
            // if (start_no_tick == 0)
            // {
            //     GOTO_STATE(USER_STATE_TICK);
            // }
            // else
            // {
            //     user_request = USER_REQUEST_START;
            //     no_current_cnt = 0;
            //     GOTO_STATE(USER_STATE_RUN);
            //     check_max_speed();
            // }
        }
        else if (bias_abs > 2500 && !flag_auto && (runmode == RUN_MODE_FIXED || runmode == RUN_MODE_NEW && tutorial_state < TUTORIAL_STEP3_BEGIN))
        {
            if (run_in_prog_mode == 0) 
            {
                if (start_cnt > 15)
                    display_seg = DISPLAY_START_HINT;
                else
                    start_cnt++;
            }
        }
        else if (bias_abs > 2500 // 1000 * 1000
                 && waiting == 0 && state_tick > 1 && (runmode == RUN_MODE_AUTO || (runmode == RUN_MODE_NEW && tutorial_state >= TUTORIAL_STEP3_BEGIN) || (flag_auto && runmode != RUN_MODE_NEW)))
        {
            if (start_cnt++ < 15)
                break;
            if (runmode == RUN_MODE_AUTO)
                user_speed_target = SPEED_TARGET_MIN1;
            else if (runmode == RUN_MODE_FIXED)
            {
                fixed_mode_speed = fixed_start_speed;
            }
            beep(BEEP_KEY);

            flag_sensor_may_reverted = 0;
#if 0
            if (start_no_tick == 0)
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
#else
            GOTO_STATE(USER_STATE_TICK);
#endif
        }
        else if (runmode == RUN_MODE_NEW && tutorial_state == TUTORIAL_FINISH && flag_Gsensor_disconnected == 0)
        {
            run_new();
        }
        else if (state_sec == 1 && state_tick == 1)
        {
            if (user_distance > store_point.dist && net_state < NET_STATE_UAP)
            {
                store_point.offline_dist += user_distance - store_point.dist;
                store_point.dist = user_distance;
                store_point.offline_energy += user_calories - store_point.energy;
                store_point.energy = user_calories;
                store_point.offline_steps += user_steps_total - store_point.steps;
                store_point.steps = user_steps_total;
                temp16 = user_time_minute * 60 + user_time_second;
                store_point.offline_time += temp16 - store_point.time;
                store_point.time = temp16;
                eeprom_write_int(EEPROM_ADDR_OFFLINE_DIST, store_point.offline_dist);
                eeprom_write_long(EEPROM_ADDR_OFFLINE_ENERGY, store_point.offline_energy);
                eeprom_write_int(EEPROM_ADDR_OFFLINE_STEPS, store_point.offline_steps);
                eeprom_write_int(EEPROM_ADDR_OFFLINE_TIME, store_point.offline_time);
            }
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
            // check_max_speed();
        }
        else if (stepdown_flag == STEPDOWN_STOP)
        {
            GOTO_STATE(USER_STATE_STOP);
        }
        else if (state_tick == 0 && state_sec >= 1)
        {
            beep(BEEP_KEY);
        }
        break;
    case USER_STATE_RUN:
        ui_state = USER_STATE_RUN;
        run();
        if (user_request == USER_REQUEST_STOP)
        {
            save_total_distance();
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
        if (machine_speed_target == 0)
            stepdown_flag = STEPDOWN_NONE;
        if (tension_bias + tension2_bias < 600 || tutorial_state == TUTORIAL_STEP3_BEGIN || tutorial_state == TUTORIAL_STEP1_BEGIN || !flag_auto && runmode == RUN_MODE_FIXED)
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
                flag_may_stuck = 0;
                GOTO_STATE(USER_STATE_READY);
            }
        }
        else
        {
            start_cnt = 0;
        }
        break;
    // case USER_STATE_EOC:
    //     if (state_sec > EOC_STATE_CNT_MAX)
    //     {
    //         eeprom_write_long(1, user_total_distance);
    //         GOTO_STATE(USER_STATE_READY);
    //     }
    //     else
    //     {
    //         if (stepdown_cnt >= 6)
    //         {
    //             stepdown_cnt = 0;
    //             if (user_speed_target > SPEED_TARGET_MIN1)
    //             {
    //                 user_speed_target--;
    //                 user_request |= USER_REQUEST_NEW_SPEED;
    //             }
    //             else
    //             {
    //                 if (state_sec < EOC_STATE_CNT_FLASH_BEEP)
    //                 {
    //                     state_sec = EOC_STATE_CNT_FLASH_BEEP;
    //                 }
    //                 user_request = USER_REQUEST_STOP;
    //             }
    //         }
    //         else
    //         {
    //             stepdown_cnt++;
    //         }
    //         if (user_speed_target <= SPEED_TARGET_MIN1 && is_new_second())
    //         {
    //             if (state_sec > EOC_STATE_CNT_FLASH_BEEP)
    //             {
    //                 beep(BEEP_KEY);
    //             }
    //         }
    //     }

    //     if (state_sec < EOC_STATE_CNT_FLASH_BEEP)
    //     {
    //         ui_state = USER_STATE_RUN;
    //     }
    //     break;
    case USER_STATE_FAULT:
        stepdown_flag = STEPDOWN_NONE;
        if (runmode == RUN_MODE_STANDBY)
        {
            CLEAR_LED_ERROR;
            GOTO_STATE(USER_STATE_SLEEP);
        }
        else if (error_id == 0 || (error_id == 8 && flag_Gsensor_disconnected < 3 && runmode == RUN_MODE_FIXED))
        {
            // CLEAR_LED_ERROR;
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
        else if (is_new_second())
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
        else if (is_new_second())
        {
            user_machine_state_cnt1++;
        }
    }
    else
    {
        user_machine_state_cnt1 = 0;
    }
}