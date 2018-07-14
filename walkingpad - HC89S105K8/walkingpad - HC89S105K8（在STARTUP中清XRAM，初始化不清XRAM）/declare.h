/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *  Copyright (c) 2008 by MKS Controls
 *
 *
 *  File name: declare.h
 *  Module:
 *  Language:  ANSI C
 *  $Revision: 1 $
 *
 *
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#include "HC89S105xx.h"
#include "newtype.h"
//general purpose
//volatile euchar  regb;
//fault and protection
euint error_code; //record error code by each bit
euchar cnt_rec2;
euchar cnt_tra2;
ebool pcorder;
ebool pcerr_com;
euchar pccom_cnt;                            //count of rec' and tra'
 euchar pcrxd[RXD_CNT], pctxd[TXD_CNT]; //rec' and tra' array

//user variable
euchar user_request;      //command request from display board to power board
euchar user_speed_target; //speed setting, in 0.1km/h
euint user_rpm_target;    //calculate from user_speed_target and send to machine
// euchar user_gradient_target; //gradient setting, from 0 to 10, in percent.
//for no lift motor, gradient = 0
//display
euchar waiting_cnt; //waiting time, in 20ms of main loop period
ebool waiting;      //set to 1 , display "wait"
//power board information
euchar power_board_version; //software version of power board

//power state and information
ebool machine_state; //power board machine state
//euchar machine_dc_motor_state;            //dc motor
//euchar machine_ac_motor_state;            //lift motor
euchar machine_speed_target; //should equal to user_speed_target
euint machine_rpm_target;    //convert from machine_speed_target
//euint machine_current_measured;       //dc motor current
//euchar machine_dc_motor_duty;         //the current pwm duty output to dc motor
//euchar machine_dc_motor_duty_target;  //duty target to dc motor
//euint machine_gradient_measured;      //gradient measured from sensor
// euint machine_gradient_target; //gradient target from machine

 euchar dc_motor_rating_volt;  //user setting, volt
 euchar dc_motor_startup_volt; //user setting, current
 euchar dc_motor_rating_f1;    //,dc_motor_step_para;                 //user setting, motor rating
 euchar machine_current_motor;
 euchar machine_volt_motor;

 euint user_steps, user_steps_total, user_steps_pause, user_steps_last;

 euchar speed_limit_max;

 euchar fixed_mode_speed;

 ebool tutorial_finish;

 euchar acceleration_param;

 ebool factory_finish;

 ebool max_speed_unlocked;

 euchar fixed_start_speed;

 euchar goal_type;
 euint goal_value;
 extern goal_status_t goal_status;
 ebool flag_auto;
 euchar flag_disp;