#include "control.h"
#include "beep.h"
#include "sensor.h"
#include "miwifi.h"
#include "declare.h"
#include "image.h"
#include "time.h"
#include "eeprom.h"

//error definition
#define ERROR_MOSFET 0x0001          //mosfet is shortened
#define ERROR_DCMOTOR_ALARM 0x0002   //ALARM from TD310
#define ERROR_DCMOTOR_CURRENT 0x0004 //dc motor current is too large, taking as shorten
#define ERROR_SPEED_SENSOR 0x0008    //with pwm output, not speed feedback
//#define ERROR_DRIVE_FAIL                              0x0010  //without drive, but has speed signal
#define ERROR_MOTOR_DISCONNECT 0x0010 //without drive, but has speed signal
#define ERROR_COMMUNICATION 0x0080    //communication lost

uchar error_id;
 bool skip_error;

 clock_t error_time;

#define CP_SIZE 5
 static uchar currents[CP_SIZE];
 static uint powers[CP_SIZE];
 static uchar cp_index;
 static uint cp_count;
 static union {
    uint avg;
    ulong accu;
} current, power;

/*--------------------------------------------------------------------------*
 |
 | detect_error
 |
 | Description: To detect error of Display board or from Power board
 |
 *--------------------------------------------------------------------------*/
void detect_error(void)
{
    static uchar error_id_last;

    uchar i;
    clock_t curr_time = clock();

    if (error_id == 10 || error_id == 11)
    {
        if (curr_time / CLOCKS_PER_SEC + server_time >= error_time + (30 - (error_id - 10) * 20) * 60ul) // 30 minutes
        {
            eeprom_wrchar(EEPROM_ADDR_ERROR_ID, 0);
            eeprom_write_long(EEPROM_ADDR_ERROR_TIME, 0);
            //WWDG->CR |= 0x80;
            //WWDG->CR &= (uchar)~0x40;
         	IAP_CMD=0xF00F;		//ÃüÁî¼Ä´æÆ÷---½âËø
         	IAP_CMD=0x7887;		//ÃüÁî¼Ä´æÆ÷---ÖØ¶Á´úÂëÑ¡Ïî
        }
    }
    else
    {
        if (curr_time >= error_time + CLOCKS_PER_SEC * 60ul) // 1 minute
        {
            error_time = curr_time;
            currents[cp_index] = (uchar)(current.accu / cp_count);
            powers[cp_index] = (uint)(power.accu / cp_count);
            current.accu = 0;
            power.accu = 0;
            cp_index = (cp_index + 1) % CP_SIZE;
            for (i = 0; i < CP_SIZE; i++)
            {
                current.avg += currents[i];
                power.avg += powers[i];
            }
            current.avg /= CP_SIZE;
            power.avg /= CP_SIZE;
            /*
            if ((power.avg > 5400 || current.avg > 35) && user_time_minute >= 60) //1 hour
            {
                error_id = 11;
            }
            else 
            */
            if ((power.avg > 5000 || current.avg > 30) && user_time_minute >= 120) // 2 hours
            {
                error_id = 10;
            }
            if (error_id == 10) // || error_id ==11
            {
                error_time /= CLOCKS_PER_SEC;
                if (IS_TIME_SET)
                {
                    error_time += server_time;
                    eeprom_wrchar(EEPROM_ADDR_ERROR_ID, error_id);
                    eeprom_write_long(EEPROM_ADDR_ERROR_TIME, error_time);
                }
            }

            current.avg = 0;
            power.avg = 0;
            cp_count = 0;
        }
        current.accu += machine_current_motor;
        power.accu += machine_volt_motor * machine_current_motor;
        cp_count++;
    }

    if (pcerr_com == 1)
    {
        error_code = ERROR_COMMUNICATION;
    }

    if (!skip_error && (error_code != 0 || flag_Gsensor_disconnected > 0) || error_id >= 10)
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
        else if (flag_Gsensor_disconnected > 0)
        {
            error_id = 8;
        }

        if (error_id != 0 && error_id_last == 0)
        {
            set_wifi_flag(FLAG_WIFI_ERROR_ID);
            beep(BEEP_ERROR);
            SET_LED_ERROR;
        }
        //when error, beep
        // if (error_id_last == 0 && error_id != 0)
        // {
        //     beep(BEEP_ERROR);
        //     set_wifi_flag(FLAG_WIFI_ERROR_ID);
        //     if (userstate != USER_STATE_SLEEP)
        //     {
        //         GOTO_STATE(USER_STATE_FAULT);
        //     }
        //     else //clear error in idle state
        //     {
        //         user_request = USER_REQUEST_ERROR_RESET;
        //         error_code = 0; //reset all fault
        //         error_id = 0;
        //     }
        // }
    }
    else if (error_id_last != 0)
    {
        error_id = 0;
        CLEAR_LED_ERROR;
    }

    error_id_last = error_id;
}
