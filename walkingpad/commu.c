/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *  Copyright (c) 2008 by MKS Controls
 *
 *
 *  File name: commu.c
 *  Module:
 *  Language:  ANSI C
 *  $Revision: 1 $
 *
 *
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#include "declare.h"

//test ram data
uchar ram_d3;
#define PCCOM_FAIL_CNT_MAX 15 //when no feedback for 5 times continuously, communicaiton error
#define WAIT_FEEDBACK_TIME 25 //in 20ms, wait in receive state

//communication status
#define COMMU_STATE_TRANSMIT 0
#define COMMU_STATE_RECEIVE 1

//--COMMUNICATION COMMAND ID
#define MACHINE_INFO_QUERY 0x01
#define MACHINE_CONTROL 0x02
#define MACHINE_CONTROL_NEW 0x03

//UART communication
uchar command_size;
static uchar command_id;
static uchar commu_state;
static uchar pccom_fail_cnt; //count communication fail time continuously
bool flag_txd_process;       //flag for txd process
extern void _putchar(char ch);
extern void turn_rx_off(void);
extern void init_uart_sim(void);
extern uchar getFanSpeed(void);

@near bool flag_motor_params_changed = 0;
//@near uchar global_fan_speed = 3;

void commu(void)
{
    uchar temp8, tempc;
    // ulong templ;
    if (commu_state == COMMU_STATE_TRANSMIT)
    {
        if (flag_motor_params_changed)
        {
            flag_motor_params_changed = 0;
            command_id = MACHINE_CONTROL;
        }
        commu_state = COMMU_STATE_RECEIVE; //switch to receive
        pctxd[0] = 0xf7;                   //answer basing the order function
        pctxd[1] = 0xf8;
        pctxd[3] = 0x01;
        pctxd[4] = 0x01;
        pctxd[5] = command_id;
        switch (command_id)
        {
        case MACHINE_INFO_QUERY: //query product information
            command_size = 0x08;
            break;
        case MACHINE_CONTROL: //machine control
            command_size = 0x16;
            pctxd[6] = user_request;
            user_request = USER_REQUEST_NONE;
            // pctxd[7] = user_rpm_target >> 8; //user_speed_target;
            // pctxd[8] = user_rpm_target;
            *((uint *)(pctxd + 7)) = user_rpm_target;
            pctxd[9] = 0; //user_gradient_target;
            //parameters
            pctxd[10] = dc_motor_startup_volt;
            pctxd[11] = dc_motor_rating_volt;
            pctxd[12] = 0; //LIFT_MOTOR_GRADIENT_MAX;
            // templ = RPM_MEASURED_SCALE;
            // pctxd[13] = templ >> 24;
            // pctxd[14] = templ >> 16;
            // pctxd[15] = templ >> 8;
            // pctxd[16] = templ;
            *((u32 *)(pctxd + 13)) = RPM_MEASURED_SCALE;
            // pctxd[17] = DC_MOTOR_RATING_RPM_DEFAULT >> 8; //
            // pctxd[18] = DC_MOTOR_RATING_RPM_DEFAULT;
            *((u16 *)(pctxd + 17)) = DC_MOTOR_RATING_RPM_DEFAULT;
            pctxd[19] = dc_motor_rating_f1;
            break;
        case MACHINE_CONTROL_NEW:
            command_size = 12;
            pctxd[6] = user_request;
            user_request = USER_REQUEST_NONE;
            // pctxd[7] = user_rpm_target >> 8;
            // pctxd[8] = user_rpm_target;
            *((uint *)(pctxd + 7)) = user_rpm_target;
            pctxd[9] = getFanSpeed();
            break;
        default: //error
            break;
        }
        pctxd[2] = command_size - 4; //command size
        temp8 = pctxd[2];
        for (tempc = 3; tempc < command_size - 2; tempc++)
        {
            temp8 = temp8 + pctxd[tempc];
        }
        pctxd[command_size - 2] = temp8; //checksum
        pctxd[command_size - 1] = 0xfd;  //end code
        flag_txd_process = 1;
        _putchar(pctxd[0]);
        turn_rx_off();
        pccom_cnt = 0;
    }
    else if (commu_state == COMMU_STATE_RECEIVE)
    {
        if (pcorder == 1) //new order coming from Power board
        {
            pccom_cnt = 0;
            pccom_fail_cnt = 0;
            pcerr_com = 0; //reset error
            pcorder = 0;
            commu_state = COMMU_STATE_TRANSMIT; //swith to transit next period
            command_id = pcrxd[5];              //pc order function
            cnt_rec2 = 0;
            cnt_tra2 = 0;
            //RXEN_FLAG=0;                              //rxd disable
            switch (command_id)
            {
            case MACHINE_INFO_QUERY: //inquiring product information
                //power_board_machine_type = pcrxd[7];
                power_board_version = pcrxd[8];
                //power_board_project_number = pcrxd[11];
                //treadmill_motor_type = pcrxd[9];
                //lift_motor_type = pcrxd[10];
                command_id = MACHINE_CONTROL;
                break;
            case MACHINE_CONTROL:                            //machine control
                machine_rpm_target = *((uint *)(pcrxd + 7)); // pcrxd[7] << 8 | pcrxd[8];
                user_steps_last = user_steps;
                user_steps = *((uint *)(pcrxd + 11)); // pcrxd[11] << 8 | pcrxd[12];
                machine_volt_motor = pcrxd[15];
                machine_current_motor = pcrxd[21];
                // //when user request to reset error, don't receive error code from power board
                // if ((user_request & USER_REQUEST_ERROR_RESET) == 0)
                // {
                error_code = pcrxd[19] << 8 | pcrxd[18];
                // }
                machine_state = pcrxd[20] & 0x01;
                machine_current_motor = pcrxd[21];
                if (power_board_version >= 100)
                    command_id = MACHINE_CONTROL_NEW;
                break;
            case MACHINE_CONTROL_NEW:
                machine_state = pcrxd[6];
                machine_rpm_target = *((uint *)(pcrxd + 7)); // pcrxd[7] << 8 | pcrxd[8];
                user_steps_last = user_steps;
                user_steps = *((uint *)(pcrxd + 9)); // pcrxd[9] << 8 | pcrxd[10];
                machine_volt_motor = pcrxd[11];
                machine_current_motor = pcrxd[12];
                error_code = pcrxd[14] << 8 | pcrxd[13];
                break;
            default:
                command_id = MACHINE_INFO_QUERY;
            }
        }
        else
        {
            if (pccom_cnt >= WAIT_FEEDBACK_TIME) //when no feedback for 0.3s, go to transmit state
            {
                if (pccom_fail_cnt >= PCCOM_FAIL_CNT_MAX)
                {
                    pcerr_com = 1; //alarm
                }
                else
                {
                    pccom_fail_cnt++;
                }
                init_uart_sim();
                commu_state = COMMU_STATE_TRANSMIT; //go to transmit command
                command_id = MACHINE_INFO_QUERY;
                cnt_rec2 = 0;
                cnt_tra2 = 0;
                pccom_cnt = 0;
            }
            else
            {
                pccom_cnt++; //in 20ms
            }
        }
    }
    else
    {
        commu_state = COMMU_STATE_TRANSMIT;
        command_id = MACHINE_INFO_QUERY; //to setup the communication
    }
}
