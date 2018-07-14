#ifndef __CONTROL_H
#define __CONTROL_H
#include "time.h"


#define SPEED_INC 15
/*-------------*
 |  Constants
 *-------------*/

//stay at fault state maximum time
#define FAULT_STATE_CNT_MAX 5 //in second
//stay at eoc state maximum time
#define EOC_STATE_CNT_MAX 35        //in second
#define EOC_STATE_CNT_FLASH_BEEP 30 //in second, before this time in EOC,
//'End' flash and beep for alarm
//from standby/idle/pause state to sleep state count maximum time
#define TO_SLEEP_CNT_MAX 600 //in second

#define USER_TIME_MAX 1080      //99                    //99 minutes, in 1minute
#define USER_DISTANCE_MAX 9999  //99.99km,in 0.01km
#define USER_CALORIES_MAX 65535 //999C,in 0.1C
//calories scale
#define USER_CALORIES_100C_SCALE (256045 + 100) //refer to design document for details.
                                                //10 for compensation
//distance scale
#define USER_DISTANCE_10M_SCALE (18000 + 0) //refer to design document for details.

@near ebool run_in_prog_mode;
@near euchar start_cnt;
@near ebool show_factory_mode;

@near ebool flag_motor_params_changed;

@near euint user_time_minute;          //running time count in minute
@near euchar user_time_second;               //running time count in sencod
euint user_distance;                   //running distance integral,in 0.01km
eulong user_calories;                  //running calories integral,in 0.1km

//error
euchar error_id;
@near ebool skip_error;
@near extern clock_t error_time;

@near ebool start_no_tick;

@near euint display_cnt;
@near extern display_seg_t display_seg;
@near extern user_state_t userstate;

@near eulong user_total_distance;

void reset_data(void);
void save_total_distance(void);

void speed_rpm_convert(void);

void FactoryTestOperation(void);

void ProgModeKeys(void);

void UserConsumerOperation(void);
void UserConsumerDisplay(void);
void UserConsumerKeys(void);

void useroperation(void);

void detect_error(void);

#endif