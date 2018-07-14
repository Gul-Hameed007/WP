#include <stdio.h>
#include "declare.h"
#include "eeprom.h"
#include "key.h"
#include "beep.h"
#include "image.h"
#include "miwifi.h"
#include "run_mode.h"
#include "sensor.h"
#include "control.h"

typedef enum {
    TEST_STATE_BEGIN,
    TEST_STATE_RC,
    TEST_VERSION,
    TEST_STATE_LED,
    TEST_STATE_SENSOR,
    TEST_STATE_RUN,
    TEST_STATE_RUN_NET_OK,
    TEST_STATE_RUN_NET_ERR,
    TEST_STATE_STOP,
    TEST_STATE_FAN_TEST,
    TEST_STATE_END,
    TEST_STATE_NORMAL
} test_state_t;

extern const uchar FW_VERSION[];

@near static test_state_t teststate;

bool global_fan_test;

void show_net_state(void)
{
    switch (net_state)
    {
    case NET_STATE_CLOUD:
    case NET_STATE_LOCAL:
        teststate = TEST_STATE_RUN_NET_OK;
        eeprom_wrchar(EEPROM_ADDR_TEST_STATE, teststate);
        set_wifi_flag(FLAG_WIFI_RESTORE);
        break;
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
}

static void FactoryTestKeys(void)
{
    check_key_id();

    if (key_id != KEY_NONE && key_id_done == 0)
    {
        key_id_done = 1;

        if (key_id == KEY_MODE_PRESS || key_id == KEY_MODE_PRESS_BTN) // for all state
        {
            beep(BEEP_KEY);
            key_id_done = 1;
            disp_matrix_all(0x00);
            switch (teststate)
            {
            case TEST_STATE_LED:
                CLEAR_LED_ALL;
                break;
            case TEST_STATE_SENSOR:
                stepdown_flag = STEPDOWN_NONE;
                user_request = USER_REQUEST_START;
                fixed_mode_speed = 180;

                // factory to test net;
                set_wifi_flag(FLAG_WIFI_FACTORY);
                net_state = NET_STATE_UNKNOWN;
                state_sec = 0;
                break;
            case TEST_STATE_STOP:
                if (machine_speed_target != 0)
                {
                    user_request = USER_REQUEST_STOP;
                }
                break;
            case TEST_STATE_END:
                user_total_distance = 0;
                speed_limit_max = 180;
                acceleration_param = 2;
                // continue
                waiting = 1;
                waiting_cnt = DISPLAY_ALL_ON_DELAY;
                display_seg = DISPLAY_TIME;
                display_cnt = 0;
                break;
            }

            if (!run_in_prog_mode && teststate != TEST_STATE_RUN)
            {
                if (teststate == TEST_STATE_RUN_NET_OK || teststate == TEST_STATE_RUN_NET_ERR)
                {
                    if (key_id == KEY_MODE_PRESS_BTN)
                    {
                        teststate += 1 + TEST_STATE_RUN_NET_ERR - teststate;
                    }
                }
                else
                {
                    teststate += 1;
                }

                eeprom_wrchar(EEPROM_ADDR_TEST_STATE, teststate);
            }
        }
        else if (teststate >= TEST_STATE_RUN && teststate <= TEST_STATE_RUN_NET_ERR)
        {
 /*            if (key_id == KEY_UP_PRESS)
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
            else  */
            if (key_id == KEY_STOP_LONG_PRESS)
            {
                beep(BEEP_KEY);
                run_in_prog_mode = 1;
                display_seg = DISPLAY_PROG_F1;
            }
        }
    }
}

extern void init_params(void);

void FactoryTestOperation(void)
{
    static uchar laststate;

    if (error_id != 0)
    {
        disp_matrix_all(0x00);
        disp_custom(LED_UP, "E%02d", (uint)error_id);
        if (error_id == 8 && flag_Gsensor_disconnected < 3)
        {
            disp_text_down(flag_Gsensor_disconnected == 1 ? "L" : "R");
        }
        return;
    }

    if (run_in_prog_mode)
    {
        ProgModeKeys();
    }
    else if (teststate == TEST_STATE_NORMAL)
    {
        UserConsumerKeys();
    }
    else if (teststate != TEST_STATE_BEGIN || state_sec > 3)
    {
        FactoryTestKeys();
    }

    switch (teststate)
    {
    case TEST_STATE_BEGIN:
        if (state_sec == 0 && state_tick == 1)
        {
            waiting = 0;
            waiting_cnt = 0;
            disp_matrix_all(0x00);
            CLEAR_LED_ALL;
            global_fan_test = 0;
            laststate = eeprom_rdchar(EEPROM_ADDR_TEST_STATE);
            if (laststate >= TEST_STATE_RUN && laststate <= TEST_STATE_RUN_NET_ERR)
            {
                // teststate = laststate;
                if (laststate == TEST_STATE_RUN)
                {
                    set_wifi_flag(FLAG_WIFI_FACTORY);
                    net_state = NET_STATE_UNKNOWN;
                    // state_sec = 0;
                }
            }
            else if (laststate >= TEST_STATE_END)
            {
                eeprom_factory();
                init_params();
                return;
            }
            else
            {
                teststate = TEST_STATE_RC;
            }
        }
        else if (state_sec < 3)
        {
            disp_matrix_all(0x00);
            disp_text_up("WAIT");
            disp_d_down(3 - state_sec);
        }
        else
        {
            teststate = laststate;
            user_request = USER_REQUEST_START;
            fixed_mode_speed = 180;
        }
        break;
    case TEST_STATE_RC:
        disp_matrix_all(0x00);
        disp_text_up("TEST");
        break;
    case TEST_VERSION:
        disp_matrix_all(0x00);
        disp_d_down((uint)power_board_version);
        disp_text_up(FW_VERSION);
        break;
    case TEST_STATE_LED:
        disp_matrix_all(0xff);
        SET_LED_ALL;
        break;
    case TEST_STATE_SENSOR:
        disp_matrix_all(0x00);
        disp_ld(tension / 100, LED_UP);
        disp_ld(tension2 / 100, LED_DOWN);        
        break;
    case TEST_STATE_NORMAL:
        speed_rpm_convert();
        UserConsumerOperation();
        UserConsumerDisplay();
        break;
    case TEST_STATE_RUN:
    case TEST_STATE_RUN_NET_OK:
    case TEST_STATE_RUN_NET_ERR:
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
            if (teststate == TEST_STATE_RUN)
            {
                disp_text_up("NET");
                show_net_state();
                if (state_sec > 60)
                {
                    teststate = TEST_STATE_RUN_NET_ERR;
                    eeprom_wrchar(EEPROM_ADDR_TEST_STATE, teststate);
                }
            }
            else if (teststate == TEST_STATE_RUN_NET_OK)
            {
               disp_text_up("OK");
            }
            else if (teststate == TEST_STATE_RUN_NET_ERR)
            {
                disp_text_up("ERR");
            }
            else
            {
                disp_text_up("RUN");
            }
            disp_1f_down((uint)fixed_mode_speed / 3);
        }
        break;
    case TEST_STATE_STOP:
        disp_text_up("STOP");
        speed_rpm_convert();
        stepdown_flag = STEPDOWN_PAUSE;
        run();
        break;
    case TEST_STATE_FAN_TEST:
        disp_text_up("FAN");
        disp_text_down("TEST");
        if (global_fan_test == 0) global_fan_test = 1;
        break;
    case TEST_STATE_END:
        disp_text_up("END");
        if (global_fan_test == 1) global_fan_test = 0;
        break;
    }
}
