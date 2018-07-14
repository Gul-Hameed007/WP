#include "key.h"
#include "newtype.h"
#include "declare.h"
#include "beep.h"
#include "eeprom.h"
#include "control.h"


void ProgModeKeys(void)
{
    check_key_id();

    if (key_id != KEY_NONE && key_id_done == 0 && waiting == 0) //&& error_id==0
    {
        key_id_done = 1;
        switch (key_id)
        {
        case KEY_MODE_PRESS:
        case KEY_MODE_PRESS_BTN:
            beep(BEEP_KEY);
            display_seg++;
            if (display_seg == DISPLAY_PROG_END)
                display_seg = DISPLAY_PROG_F1;
            break;
        case KEY_UP_PRESS:
            if (display_seg == DISPLAY_PROG_F1)
            {
                if (dc_motor_rating_f1 < DC_MOTOR_RATING_F1_MAX)
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
                    speed_limit_max += 3;
                    if (speed_limit_max > SPEED_TARGET_MAX)
                        speed_limit_max = SPEED_TARGET_MAX;
                    eeprom_wrchar(EEPROM_ADDR_SPEED_LIMIT, speed_limit_max);
                }
            }
            else if (display_seg == DISPLAY_PROG_FACT)
            {
                eeprom_wrchar(EEPROM_ADDR_FACTORY_FINISH, show_factory_mode);
                show_factory_mode = !show_factory_mode;
            }
            flag_motor_params_changed = 1;
            break;
        case KEY_DOWN_PRESS:
            if (display_seg == DISPLAY_PROG_F1)
            {
                if (dc_motor_rating_f1 > DC_MOTOR_RATING_F1_MIN)
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
                    speed_limit_max -= 3;
                    if (speed_limit_max < 60)
                        speed_limit_max = 60;
                    eeprom_wrchar(EEPROM_ADDR_SPEED_LIMIT, speed_limit_max);
                }
            }
            else if (display_seg == DISPLAY_PROG_FACT)
            {
                eeprom_wrchar(EEPROM_ADDR_FACTORY_FINISH, show_factory_mode);
                show_factory_mode = !show_factory_mode;
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
}
