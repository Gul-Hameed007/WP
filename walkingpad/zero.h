/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *  Copyright (c) 2008 by MKS Controls
 *
 *
 *  File name: zero.h
 *  Module:
 *  Language:  ANSI C
 *  $Revision: 1 $
 *
 *
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */ /*****************************************************************************************/
/*****************************************************************************************/
/*****************************************************************************************/
//define types
#include <newtype.h>
/*****************************************************************************************/
//general purpose
//volatile uchar  regb;
//fault and protection
uint error_code; //record error code by each bit
uchar cnt_rec2;
uchar cnt_tra2;
bool pcorder;
bool pcerr_com;
uchar pccom_cnt;                            //count of rec' and tra'
@near uchar pcrxd[RXD_CNT], pctxd[TXD_CNT]; //rec' and tra' array

//user variable
uchar user_request;      //command request from display board to power board
uchar user_speed_target; //speed setting, in 0.1km/h
uint user_rpm_target;    //calculate from user_speed_target and send to machine
// uchar user_gradient_target; //gradient setting, from 0 to 10, in percent.
//display
uchar waiting_cnt; //waiting time, in 20ms of main loop period
bool waiting;      //set to 1 , display "wait"
//power board information
uchar power_board_version; //software version of power board

//power state and information
bool machine_state; //power board machine state
//uchar machine_dc_motor_state;         //dc motor
//uchar machine_ac_motor_state;         //lift motor
uchar machine_speed_target; //should equal to user_speed_target
uint machine_rpm_target;    //convert from machine_speed_target
//uint machine_rpm_measured;                //rpm measured from speed sensor
//uint machine_current_measured;        //dc motor current
//uchar machine_dc_motor_duty;          //the current pwm duty output to dc motor
//uchar machine_dc_motor_duty_target;   //duty target to dc motor
//uint machine_gradient_measured;       //gradient measured from sensor
// uint machine_gradient_target;       //gradient target from machine

@near uchar dc_motor_rating_volt;  //user setting, volt
@near uchar dc_motor_startup_volt; //user setting, current
@near uchar dc_motor_rating_f1;    //,dc_motor_step_para;                                  //user setting, motor rating
@near uchar machine_current_motor;
@near uchar machine_volt_motor;

@near uint user_steps, user_steps_total, user_steps_pause, user_steps_last;

@near uchar speed_limit_max;

@near uchar fixed_mode_speed;

@near bool tutorial_finish;

@near uchar acceleration_param;

@near bool factory_finish;

@near bool max_speed_unlocked;

@near uchar fixed_start_speed;

@near uchar goal_type;
@near uint goal_value;
@near goal_status_t goal_status;

@near bool flag_auto; // fixed mode auto start stop flag
@near uchar flag_disp;