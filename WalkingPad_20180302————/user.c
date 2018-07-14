/* * ** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *  Copyright (c) 2008 by MKS Controls
 *
 *
 *  File name: user.c
 *  Module:
 *  Language:  ANSI C
 *  $Revision: 1 $
 *
 *
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#include <declare.h>
#include <image.h>
#include <imagemap.h>
#include <displaydriver.h>

#include "sensor.h"
#include "beep.h"
#include "run_mode.h"
#include "miwifi.h"


/*------------------*
 |  Module options
 *------------------*/
extern void eeprom_write(void);
/*--------------------*
 |  Type definitions
 *--------------------*/
/*-------------*
 |  Constants
 *-------------*/
//error definition
#define ERROR_MOSFET                                        0x0001  //mosfet is shortened
#define ERROR_DCMOTOR_ALARM                         0x0002  //ALARM from TD310
#define ERROR_DCMOTOR_CURRENT                           0x0004  //dc motor current is too large, taking as shorten
#define ERROR_SPEED_SENSOR                              0x0008  //with pwm output, not speed feedback
//#define ERROR_DRIVE_FAIL                              0x0010  //without drive, but has speed signal
#define ERROR_MOTOR_DISCONNECT                      0x0010  //without drive, but has speed signal
#define ERROR_LIFTMOTOR_SENSOR                      0x0020  //with drive, not signal change 
#define ERROR_LIFTMOTOR_SELF                            0x0040  //VR sensor self learn fail 
#define ERROR_COMMUNICATION                         0x0080  //communication lost
//safety switch status
#define SAFTY_SWITCH_OFF            1               //safety switch - OFF level
#define SAFETY_STATE_ON             1
#define SAFETY_STATE_OFF            0
//user mode
#define BOARD_MODE_CONSUMER         0               //normal run
#define BOARD_MODE_TEST                 1               //test mode
//define FAT detection function
#define FAT_FUNC
//sex
#define SEX_MALE                                    1
#define SEX_FEMALE                              2
#define SEX_DEFUALT                             SEX_MALE
//age
#define AGE_DEFUALT                             25
#define AGE_MIN                                 10
#define AGE_MAX                                 99
//HEIGHT
#define HEIGHT_DEFUALT                          170
#define HEIGHT_MIN                              100
#define HEIGHT_MAX                              200
#define HEIGHT_DEFUALT_MILE                 68
#define HEIGHT_MIN_MILE                         40
#define HEIGHT_MAX_MILE                         80
//WEIGHT
#define WEIGHT_DEFUALT                          65
#define WEIGHT_MIN                              20
#define WEIGHT_MAX                              150
#define WEIGHT_DEFUALT_MILE                 154
#define WEIGHT_MIN_MILE                         44
#define WEIGHT_MAX_MILE                         330
//FAT RESULT
#define FAT_UW                                      19          //<= under weight
#define FAT_NW                                      25          //<=normal weight
#define FAT_OW                                      29          //<=over weight
#define FAT_OB                                      30          //>= obesity    
//user program
#define USER_PROGRAM_NONE           0               //
#define USER_PROGRAM_P1             1               //
#define USER_PROGRAM_P2             2               //
#define USER_PROGRAM_P3             3               //
#define USER_PROGRAM_P4             4               //
#define USER_PROGRAM_P5             5               //
#define USER_PROGRAM_P6             6               //
#define USER_PROGRAM_P7             7
#define USER_PROGRAM_P8             8
#define USER_PROGRAM_P9             9
//#define USER_PROGRAM_P10          10
//#define USER_PROGRAM_P11          11
//#define USER_PROGRAM_P12          12
#ifdef  FAT_FUNC
#define USER_PROGRAM_FAT            (PROGRAM_SIZE+1)
#endif
#define PROGRAM_P1  {30, 30, 60, 50, 50, 50, 40, 40, 40, 30}
#define PROGRAM_P2  {30, 30, 40, 40, 50, 50, 50, 60, 60, 40}
#define PROGRAM_P3  {30, 30, 50, 60, 70, 80, 60, 40, 30, 30}
#define PROGRAM_P4  {30, 60, 60, 60, 80, 80, 80, 30, 30, 30}
#define PROGRAM_P5  {20, 50, 60, 70, 80, 80, 70, 70, 30, 30}
#define PROGRAM_P6  {20,100,100, 80, 80, 70, 60, 30, 20, 20}
#define PROGRAM_P7  {30, 40, 50, 60, 70, 80, 70, 60, 40, 30}
#define PROGRAM_P8  {30, 80, 60, 90, 80, 80, 80, 30,100, 30}
#define PROGRAM_P9  {20, 40, 60, 80, 80, 80, 70, 70, 30, 30}
#ifdef KM_MILE
#define PROGRAM1_P1 {18, 18, 37, 31, 31, 31, 25, 25, 25, 18}
#define PROGRAM1_P2 {18, 18, 25, 25, 31, 31, 31, 37, 37, 25}
#define PROGRAM1_P3 {18, 18, 31, 37, 43, 50, 37, 25, 18, 18}
#define PROGRAM1_P4 {18, 37, 37, 37, 50, 50, 50, 18, 18, 18}
#define PROGRAM1_P5 {12, 31, 37, 43, 50, 50, 43, 43, 18, 18}
#define PROGRAM1_P6 {12, 62, 62, 50, 50, 43, 37, 18, 12, 12}
#define PROGRAM1_P7 {18, 25, 31, 37, 43, 50, 43, 37, 25, 18}
#define PROGRAM1_P8 {18, 50, 37, 56, 50, 50, 50, 18, 62, 18}
#define PROGRAM1_P9 {12, 25, 37, 50, 50, 50, 43, 43, 18, 18}
#else
#define PROGRAM_P31 {30, 30, 50, 60, 40, 50, 60, 40, 30, 30}
#define PROGRAM_P41 {30, 60, 60, 60, 50, 50, 40, 30, 30, 30}
#define PROGRAM_P51 {20, 50, 60, 50, 60, 60, 50, 40, 30, 30}
#define PROGRAM_P61 {20, 50, 50, 40, 40, 30, 60, 30, 20, 20}
#define PROGRAM_P71 {30, 40, 50, 60, 50, 40, 50, 60, 40, 30}
#define PROGRAM_P81 {30, 50, 60, 50, 40, 30, 50, 30, 60, 30}
#define PROGRAM_P91 {20, 40, 60, 50, 50, 40, 50, 60, 30, 30}
#endif
uchar const program_table[PROGRAM_SIZE][PROGRAM_DIV] =
{
    PROGRAM_P1,
    PROGRAM_P2,
    PROGRAM_P3,
    PROGRAM_P4,
    PROGRAM_P5,
    PROGRAM_P6,
    PROGRAM_P7,
    PROGRAM_P8,
    PROGRAM_P9
};
uchar const program_table2[PROGRAM_SIZE][PROGRAM_DIV] =
{
#ifdef KM_MILE
    PROGRAM1_P1,
    PROGRAM1_P2,
    PROGRAM1_P3,
    PROGRAM1_P4,
    PROGRAM1_P5,
    PROGRAM1_P6,
    PROGRAM1_P7,
    PROGRAM1_P8,
    PROGRAM1_P9
#else
    PROGRAM_P1,
    PROGRAM_P2,
    PROGRAM_P31,
    PROGRAM_P41,
    PROGRAM_P51,
    PROGRAM_P61,
    PROGRAM_P71,
    PROGRAM_P81,
    PROGRAM_P91
#endif
};
//for incline
#ifdef  TM1320CA
#define INCL_P1 {1, 2, 3, 3, 1, 2, 2, 3, 2, 2}// 0333444110
#define INCL_P2 {1, 2, 3, 3, 2, 2, 3, 4, 2, 2}//2223333442
#define INCL_P3 {1, 2, 2, 3, 1, 2, 2, 2, 2, 1}//
#define INCL_P4 {2, 2, 3, 3, 2, 2, 4, 6, 2, 2}//
#define INCL_P5 {1, 2, 4, 3, 2, 2, 4, 5, 2, 1}//
#define INCL_P6 {2, 2, 6, 2, 3, 4, 2, 2, 2, 1}//
#define INCL_P7 {4, 5, 6, 6, 9, 9,10,12, 6, 3}//
#define INCL_P8 {3, 5, 4, 4, 3, 4, 4, 3, 3, 2}//
#define INCL_P9 {3, 5, 3, 4, 2, 3, 4, 2, 3, 2}//
uchar const incl_table[PROGRAM_SIZE][PROGRAM_DIV] =
{
    INCL_P1,
    INCL_P2,
    INCL_P3,
    INCL_P4,
    INCL_P5,
    INCL_P6,
    INCL_P7,
    INCL_P8,
    INCL_P9
};
#endif
#define USER_TOTAL_DISTANCE_MAX               999999// 99999999
#define DISTANCE_KM_LUB                                 30000   //in 10meter
#define DISTANCE_ML_LUB                                 18800   //in 10meter
//user time setting range,in minute
#define USER_TIME_SETTING_MAX                       99
#define USER_TIME_SETTING_MIN                       5
//user distance setting range, in 0.01km
#define USER_DISTANCE_SETTING_MAX               9990
#define USER_DISTANCE_SETTING_MIN               50
//user calories setting range, in 0.1C
#define USER_CALORIES_SETTING_MAX               9990
#define USER_CALORIES_SETTING_MIN               100

//stay at fault state maximum time
#define FAULT_STATE_CNT_MAX                     6                   //in second
//stay at eoc state maximum time
#define EOC_STATE_CNT_MAX                           35                  //in second
#define EOC_STATE_CNT_FLASH_BEEP                    30                  //in second, before this time in EOC, 
//'End' flash and beep for alarm
//from standby/idle/pause state to sleep state count maximum time
#define TO_SLEEP_CNT_MAX                            600                 //in second
//from pause state to standby state count maximum time
#define TO_STANDBY_CNT_MAX                          50                  //in second
//macro for field update
#define UserDigitsDisplayUpdate(fieldId)  ImageFieldSetEx(fieldId,&buffer[0])
#define IMAGE_PROCESS_CNT_MAX           5                   //call imageprocess every 100ms, in 20ms
//constant use to calculate heart rate (pulse/minute) from one pulse period measured.
//user_hr = HR_SCALE/period_measured.
#ifdef HR_USE_CAPTURE
#define HR_SCALE                            468750
#else
#define HR_SCALE                            300000
#endif
#define HR_SIGNAL_OFF_DLY               150//70                 //in 20ms,
#define HR_SIGNAL_STEADY_DLY            5                   //in second
#define USER_TIME_MAX                   1080//99                    //99 minutes, in 1minute
#define USER_DISTANCE_MAX               9990                //99.99km,in 0.01km
#define USER_CALORIES_MAX               9999                //999C,in 0.1C
//calories scale
//#define USTYLE_NK
#if 1           //for UT
#ifdef USTYLE_NK
#define USER_CALORIES_100C_SCALE        (1022727+70)        //refer to design document for details.
#else
#define USER_CALORIES_100C_SCALE        (256045+100)            //refer to design document for details.
#endif                                                              //10 for compensation
#else           //for OMA 
#define USER_CALORIES_100C_SCALE        (600000+100)            //refer to design document for details.
#endif                                                              //10 for compensation
//distance scale
#define USER_DISTANCE_10M_SCALE     (18000+0)           //refer to design document for details.
//10 for compensation
//heart rate constant
#define USER_HR_MAX                     200
#define USER_HR_MIN                     50
#define USER_HR_INI                     120
#ifdef HR_USE_CAPTURE
#define PERIOD_INI_MIN                  4687                //100
#define PERIOD_INI_MAX                  9375                //50
//discard period out of this range
#define HR_PERIOD_MAX                   11800               //40bpm
#define HR_PERIOD_MIN                   1900                //240bpm
//after steady,discard period large or less than period_measured below value
#define HR_PERIOD_BIAS                  500
#define HR_PERIOD_COMP                  100
#else
#define PERIOD_INI_MIN                  3000                //100
#define PERIOD_INI_MAX                  6000                //50
//discard period out of this range
#define HR_PERIOD_MAX                   7500                //40bpm
#define HR_PERIOD_MIN                   1250                //240bpm
//after steady,discard period large or less than period_measured below value
#define HR_PERIOD_BIAS                  300
#define HR_PERIOD_COMP                  100
#endif      //end of HR_USE_CAPTURE
//time to cancel userprogram or usermode in standby when no key input, in second
#define PROGRAM_MODE_CANCEL_TIME        50
//initial value
#define SPEED_INITIAL_VALUE         SPEED_TARGET_MIN                            //in 0.1km/h
#define TIME_INITIAL_VALUE              10      //USER_TIME_SETTING_MIN                 //in minute
#define DISTANCE_INITIAL_VALUE      100 //USER_DISTANCE_SETTING_MIN                 //in 0.01km
#define CALORIES_INITIAL_VALUE      500 //USER_CALORIES_SETTING_MIN                 //in 0.1KC
//KEY slew rate setting, in 20ms
#define KEY_SLEW_RATE0                  1                                       //key pressed first
#define KEY_SLEW_RATE1                  (KEY_SLEW_RATE0+40)             //key pressed continuously for value*20ms
#define KEY_SLEW_RATE2                  (KEY_SLEW_RATE1+25)             //key pressed continuously for value*20ms               
#define KEY_SLEW_RATE3                  (KEY_SLEW_RATE2+15)             //key pressed continuously for value*20ms               
#define KEY_SLEW_RATE4                  (KEY_SLEW_RATE3+10)             //key pressed continuously for value*20ms               
#define KEY_SLEW_RATE5                  (KEY_SLEW_RATE4+6)              //key pressed continuously for value*20ms               
//digit display solid delay time
#define DIGIT_SOLID_TIME                25                          //in 20ms
#define SPEED_MAX_TIME              100
/*-----------------*
 |  Private data
 *-----------------*/
//test ram data
uchar ram_d1;
uchar safety_on_cnt,safety_off_cnt;     //for safty switch debounce
uchar safety_state,safety_state_last;                           //
uchar boardmode;            //control board mode(consumer, test)
uchar usermode;         //user mode (manual, time, distance, calories)
uchar userprogram;      //program user selection
uchar userstate;            //user state
uchar user_state;           //this is just for indicating UI state (standby or run) and compare with
//machine side to check if it matches.
uchar run_state_wait_3s;    //from stanby to run, count 3 second to send command to power board
uchar run_state_entry;  //when change to run state, set this.
uchar run_state_wait_sec;       //for 3s counting more accurately
uchar user_time_setting;    //record the time setting for USER MODE or PROGRAM, in minute
@near uint user_time_minute;        //running time count in minute
uchar user_time_second;     //running time count in sencod
uint user_distance_setting; //distance setting for USER MODE,in 0.01km
uint user_distance;             //running distance integral,in 0.01km
uint user_distance_old;         //save the distance when speed changed
uchar flag_speed_change;        //flag for speed changed
uint user_calories_setting; //calories setting for USER MODE, in 0.1C
uint user_calories;             //running calories integral,in 0.1km
uint user_calories_old;         //save the calories when speed changed
uchar user_hr;                  //user heart rate measurement
uint period_measured;       //one heart rate pulse period after filter

//error
uchar error_id,error_id_last,error_liftmotor_sensor_cnt;
uchar fault_state_cnt;          //time count in fault state, time up will go to standby state, in second
uchar eoc_state_cnt;                //time count in EOC state, time up will go to standby state, in second
uint standby_to_sleep_cnt;  //time count for going to sleep mode from standby state, in second
uint idle_to_sleep_cnt;     //time count for going to sleep mode from idle state, in second
//uchar pause_to_standby_cnt;   //time count for going to standby mode from pause state, in second
//image
uchar image_process_cnt;        //for 100ms count
//heart rate
uchar hr_signal_cnt;                //use to count when there is no heart rate signal
uchar hr_signal_steady;         //flag to indicate HR is steady
uchar hr_signal_steady_cnt; //when new signal come, count to steady
uchar flag_hr_signal_steady_cnt;        //flag for count hr signal
uchar hr_signal_new_cnt;        //count for new hr signal
uchar hr_signal_coeff;          //for first order filter
//use for distance calculation, time for 10meter, in 1s
uint user_distance_10m_cnt,user_distance_10m_time;
//use for calories calculation, time for 100c in 20ms
uint user_calories_100c_cnt,user_calories_100c_time;
//userprogram process
@near uint user_program_time;           //in second
@near uchar user_program_seg;           //indicate the current seg in program table
@near uchar user_program_seg_last;  //indicate the last seg
//@near uchar user_program_seg_update;  //flag for seg update display
//@near uchar user_program_seg_update_cnt;  //hold the seg displap for 1 second
@near uchar user_program_mode_cancel_delay;     //in standby, no keys for this time will cancel
//userprogram or user mode, in second
@near uchar user_machine_state_cnt;         //count for user and machine state check, in second
@near uchar user_machine_state_cnt1;            //count for user and machine state check, in second
//delay for digit solid when adjusting TIME/DISTANCE/CALORIES in standby
@near uchar digit_solid_delay;      //in 20ms
//step down when pause or stop
//only send stop request to power board to stop the machine at once when pull safty switch down
@near uchar stepdown_flag;
@near uchar user_speed_target_pause;                //record speed target before entering pause state
@near uchar stepdown_cnt;                               //count for speed decrease, in 20ms
//FLAG INC
//@near uchar flag_incl_setting;
//uchar flag_spd_setting;
//FLAG INC
//uchar flag_incl_setting;
//uchar flag_spd_setting;
//@near uchar flag_hr_display;
//@near uchar incl_hr_cnt;
//flag for self test and burn in test
//uchar flag_self_test,self_test_debounce;
@near uchar flag_burnin_test,burnin_test_debounce;
@near uchar user_test_display_cnt;
@near uchar version_display_cnt,key_version_debounce;
@near uint fat_weight;
@near uchar fat_step,fat_sex,fat_age,fat_height,fat_result;     //for fat detection
@near uchar f_fat_func,fat_step_cnt;
uchar flag_false_hr_signal;         //flag for false signal detected in isr
euchar reset_state;
//@near uint display_time_cnt,incl_pm_cnt;
//@near uchar flag_dist_setting,flag_cal_setting;
//@near uint road_cnt;
uchar km_mile_debounce,flag_mile,display_speed_max;         //for mile and km convertion
@near uchar f_disp_total_distance,clr_distance_cnt,flag_lub;
@near ulong  user_total_distance,user_total_distance_old,user_total_distance_bp;
@near uchar oil_beep_cnt;
/*--------------------*
 |  Private functions
 *--------------------*/
#ifdef NO_SP_SEN
@near uchar key_para_cnt,para_step,f_para_set;
@near euchar alarm_code;
#endif
#ifdef BLUETOOTH
@near euchar flag_module_2_mobile;
@near uchar first;
@near euchar command_id_mcu,command_id_mcu2;
@near uchar flag_running,running_cnt;
#endif
@near uchar flag_true_run,key_true_cnt,disp_true_run;
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
    if(sec>=TIME_BASE_SEC)          //one second base timer
    {
        sec=0;
#if 0
        if(minu>=59)    //one minute base timer
        {
            minu=0;
            if(hour>=59)
            {
                hour=0;    //one hour base timer
            }
            else
            {
                hour++;
            }
        }
        else
        {
            minu++;
        }
#endif
//      TEST4=!TEST4;
    }
    else
    {
        sec++;
    }
    //20ms process
    if (digit_solid_delay!=0)
    {
        digit_solid_delay--;    //for digit display solid delay in standby
    }
    if (display_speed_max!=0)
    {
        display_speed_max--;
    }
}

#if 0
/*--------------------------------------------------------------------------*
 |
 |  filter
 |  Call to array average
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
uint filter(uint *array)    //average,remove the max and the min,for 10 number
{
    unsigned int maximum,minimum,avg;
    unsigned char k;
    maximum=array[0];
    minimum=array[0];
    avg=array[0];
    for (k=1; k<10; k++)
    {
        if (maximum<array[k])
        {
            maximum=array[k];
        }
        if (minimum>array[k])
        {
            minimum=array[k];
        }
        avg=avg+array[k];
    }
    avg=(avg-maximum-minimum);
    avg=avg>>3; //avg=sum/8
    return(avg);
}
#endif
#if 0
/****************************************************************************************************
*
*  MODULE: FirstOrderFilter(uint Input, uchar Coeff, uint* Output)
*
*  ARGUMENTS: The function has three arguments: in     - input signal (to be filtered)
*                                               in     - output signal
*                                               in     - filter coeff (0-100)
*                                               out    - output signal
*
*
*       y(kT) = (1-Wf*T)*y(kT-T) + (Wf*T) * x(kT)                                                   }
*       y(kT) = (1-a)*y(kT-T) + a * x(kT)                                                           }
*  RANGE ISSUES: The function returns 16bit signed value. NegativePILimit <= controller output <= PositivePILimit
*                The controller parameters (gains) - 16bit positive signed values.
*                The scale values: 0 <= scale values <= 30.
*
*  SPECIAL ISSUES: The function calculates correct results if the saturaion mode is set or not .
*
*
****************************************************************************************************/
void FirstOrderFilter(uint Input, uchar coeff, uint *Output)
{
    uint Temp,Temp1;
    ulong Temp2,Temp3;
    Temp = 100 - coeff ;
    Temp1 = *Output;
    Temp2 = Temp*Temp1;
    Temp3 = coeff*Input;
    Temp1 = (uint)((Temp2 + Temp3)/100);
    *Output = Temp1;
    //*Output = L_mult(FRAC16(1) - coeff , extract_h(*Output))+ L_mult(coeff,Input);
}
#endif

/*--------------------------------------------------------------------------*
 |
 |  time_calculation
 |  Call to calculate the running time
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
void time_calculation(void)
{
    if (userstate == USER_STATE_RUN && run_state_entry==0)
    {
        if (user_time_second>=60)
        {
            user_time_second=0;
            user_time_minute++;
        }
        if (sec==0)
        {
            user_time_second++;
        }
#ifdef BLUETOOTH
        if (usermode!=USER_MODE_TIME&&userprogram==USER_PROGRAM_NONE&&flag_program==0)
#else
        if (usermode!=USER_MODE_TIME&&userprogram==USER_PROGRAM_NONE)
#endif
        {
            //the maximum running time is 99minutes 59seconds, time up then go to EOC
            if (user_time_minute>=USER_TIME_MAX&&user_time_second>=60)
            {
                if (usermode==USER_MODE_NONE)
                {
                    userstate = USER_STATE_EOC;
                    //user_request = USER_REQUEST_STOP;
                    beep(BEEP_KEY);
                }
                else
                {
                    user_time_minute=0;
                    user_time_second=0;
                }
            }
        }
        else
        {
            //time up then go to EOC
#ifdef BLUETOOTH
            if (usermode == USER_MODE_TIME ||userprogram!=USER_PROGRAM_NONE||flag_program==1)
#else
            if (usermode == USER_MODE_TIME ||userprogram!=USER_PROGRAM_NONE)
#endif
            {
                if (user_time_minute>=(user_time_setting-1)&&user_time_second>=60)
                {
                    userstate = USER_STATE_EOC;
                    //user_request = USER_REQUEST_STOP;
                    beep(BEEP_KEY);
                }
            }
        }
    }
    //else if (userstate == USER_STATE_STANDBY)
   // {
    //    user_time_minute=0;
    //    user_time_second=0;
    //}
    //if(user_time_minute>USER_TIME_MAX)user_time_minute=0;
}
/*--------------------------------------------------------------------------*
 |
 |  distance_calculation
 |  Call to calculate the running distance
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
void distance_calculation(void)
{
    ulong templ;
    if (userstate == USER_STATE_RUN && run_state_entry==0)
    {
#if 0               //solution 1, refer to design document for details
        //time for 10 meter, in 20ms.  see design document for details.
        if (user_speed_target>0)
        {
            user_distance_10m_time = USER_DISTANCE_10M_SCALE/user_speed_target;
            if (user_distance_10m_cnt>=user_distance_10m_time)
            {
                //increase every 10meter, refer to design document for details.
                user_distance++;
                user_distance_10m_cnt=0;
            }
            else
            {
                user_distance_10m_cnt++;
            }
        }
#else               //solution 2, refer to design document for details
#ifdef BLUETOOTH
        //to check if running
        if(flag_running)
        {
            //running_cnt=0;
            if(user_steps_old==user_steps)
            {
                running_cnt++;
            }
            else
            {
                running_cnt=0;
            }
            user_steps_old=user_steps;
            if(running_cnt>100)
            {
                flag_running=0;
                running_cnt=0;
            }
        }
        else
        {
            //running_cnt1=0;
            if(running_cnt>3)
            {
                running_cnt=0;
                if(user_steps>(user_steps_old+1))
                {
                    flag_running=1;
                }
                user_steps_old=user_steps;  //renew
            }
            else if(sec==0)
            {
                running_cnt++;
            }
        }
        user_steps_total=user_steps_pause+user_steps;
#endif
        if(user_distance==0)
        {
            user_distance_old=0;    //reset at the beginning
        }
        if(flag_speed_change)                               //set when speed change
        {
            user_distance_10m_time=0;
            user_distance_old=user_distance;
            flag_speed_change=0;
        }
        if(sec==0&&user_distance_10m_time<=0xffff)
        {
#ifdef BLUETOOTH
            if(flag_true_run==0&&flag_running==1||flag_true_run==1)//(flag_running==1&&flag_module_2_mobile==1||flag_module_2_mobile==0)
#endif
                user_distance_10m_time++;
        }
        templ=user_distance_10m_time;
        templ*=user_speed_target;//500000;//
        templ/=360;
        user_distance = templ + user_distance_old;
#endif
        if (usermode!=USER_MODE_DISTANCE)
        {
            //the maximum running distance is 99.9km, reach target then go to EOC
            if (user_distance>=USER_DISTANCE_MAX)
            {
                //userstate = USER_STATE_EOC;
                //user_request = USER_REQUEST_STOP;
                //beep(BEEP_KEY);
                //clear when reach MAX
                user_distance = 0;
                user_distance_10m_time=0;
                user_distance_old=0;
                user_total_distance+=99;
                user_total_distance_bp+=USER_DISTANCE_MAX;
            }
        }
        else
        {
            //reach target then go to EOC
            //if (usermode==USER_MODE_DISTANCE)
            //{
            if (user_distance>=user_distance_setting)
            {
                userstate = USER_STATE_EOC;
                //user_request = USER_REQUEST_STOP;
                beep(BEEP_KEY);
            }
            //}
        }
        user_total_distance=user_total_distance_bp+user_distance;
        //user_total_distance_bp+=user_distance;
        if(user_total_distance>USER_TOTAL_DISTANCE_MAX)
        {
            user_total_distance-=USER_TOTAL_DISTANCE_MAX;
        }
    }
    else //if (userstate == USER_STATE_STANDBY)
    {
        user_distance_10m_cnt=0;
        user_distance_10m_time=0;
#ifdef BLUETOOTH
        flag_running=0;
        user_steps_old=0;
        running_cnt=0;
        user_steps=0;
#endif
        user_total_distance_bp=user_total_distance;
    }
    if(userstate == USER_STATE_STANDBY)
    {
        user_steps_total=0;
        user_steps_pause=0;
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
void calories_calculation(void)
{
    uint temp16;
    ulong temp32;
    if (userstate == USER_STATE_RUN && run_state_entry==0)
    {
        //time for 100 c
        //in 20ms
#if 1   //for UT
        if (user_speed_target>0)
        {
            temp16 = 100+user_gradient_target;
            temp32 = user_speed_target*temp16;
            user_calories_100c_time = (uint)(USER_CALORIES_100C_SCALE/temp32);
            if (user_calories_100c_cnt>=user_calories_100c_time)
            {
                //increase every 100c, refer to design document for details.
#ifdef BLUETOOTH
                if(flag_true_run==0&&flag_running==1||flag_true_run==1)//(flag_running==1&&flag_module_2_mobile==1||flag_module_2_mobile==0)
#endif
                    user_calories++;
                user_calories_100c_cnt=0;
            }
            else
            {
                user_calories_100c_cnt++;
            }
        }
#else   //for OMA
        if (user_speed_target>0)
        {
            temp16 = 100+user_gradient_target;
            temp32 = user_speed_target*temp16;
            user_calories_100c_time = (uint)(USER_CALORIES_100C_SCALE/temp32);
            if (user_calories_100c_cnt>=user_calories_100c_time)
            {
                //increase every 100c, refer to design document for details.
#ifdef BLUETOOTH
                if(flag_true_run==0&&flag_running==1||flag_true_run==1)//(flag_running==1&&flag_module_2_mobile==1||flag_module_2_mobile==0)
#endif
                    user_calories++;
                user_calories_100c_cnt=0;
            }
            else
            {
                user_calories_100c_cnt++;
            }
        }
#endif
        if (usermode != USER_MODE_CALORIES)
        {
            //the maximum running distance is 99.9km, reach target then go to EOC
            if (user_calories>=USER_CALORIES_MAX)
            {
                //userstate = USER_STATE_EOC;
                //user_request = USER_REQUEST_STOP;
                //beep(BEEP_KEY);
                //clear when reach MAX
                user_calories = 0;
            }
        }
        else
        {
            //reach target then go to EOC
            //if (usermode == USER_MODE_CALORIES)
            //{
            if (user_calories>=user_calories_setting)
            {
                userstate = USER_STATE_EOC;
                //user_request = USER_REQUEST_STOP;
                beep(BEEP_KEY);
            }
            //}
        }
    }
    else if (userstate == USER_STATE_STANDBY)
    {
        user_calories_100c_cnt=0;
        user_calories_100c_time=0;
    }
    //if (user_calories>USER_CALORIES_MAX)user_calories = 0;
}
void hr_period_ini(void)
{
    period[5]=HR_PERIOD_INI;
    period[4]=HR_PERIOD_INI;
    period[3]=HR_PERIOD_INI;
    period[2]=HR_PERIOD_INI;
    period[1]=HR_PERIOD_INI;
    period[0]=HR_PERIOD_INI;
}
/*--------------------------------------------------------------------------*
 |
 |  hr_calculation
 |  Call to calculate user heart rate
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
void hr_calculation(void)
{
#if 1
    uint maximum,minimum;
    uchar k;
    ulong templ;
#endif
    if(sec==0&&flag_hr_signal_steady_cnt==1)
    {
        hr_signal_steady_cnt++;
    }
    if (hr_signal==1)               //with signal feedback
    {
        hr_signal_cnt=0;
        hr_signal=0;                    //reset after calculation in 20ms. in 20ms there is
        //should be new rpm signal interrupt which will set
        //this flag in CAPTURE ISR
#ifdef FAT_FUNC
        //for fat func
        if(f_fat_func==1&&fat_step==5)      //calcutlate the fat result
        {
            if(fat_step_cnt>5)
            {
                templ=fat_weight*100;
                templ/=fat_height;
                templ*=100;
                templ/=fat_height;
#ifdef KM_MILE
                if(flag_mile)
                {
                    templ*=10;
                    templ/=142;
                }
#endif
                fat_result=(uchar)templ;
            }
            else
            {
                fat_step_cnt++;
            }
            return;                                 //no hr calculation when fat detection
        }
        else
        {
            fat_step_cnt=0;
            fat_result=0;
        }
#endif
#if 0
        //discard period out of this range
        if (period_isr<HR_PERIOD_MIN || period_isr>HR_PERIOD_MAX)
        {
            flag_hr_signal_steady_cnt=0;
            return;
        }
#endif
#if 1
        //update the array
        //for heart rate detection, 20ms main loop time is fast enough to update the array
        //heart rate range: 40-240bpm, the fast time 250ms
        if (hr_signal_steady_cnt<HR_SIGNAL_STEADY_DLY)  //&&user_hr<USER_HR_INI)
        {
            //if (period_isr<PERIOD_INI_MAX&&period_isr>PERIOD_INI_MIN)
            //{
#if 0
            period[9]=HR_PERIOD_INI;
            period[8]=HR_PERIOD_INI;
            period[7]=HR_PERIOD_INI;
            period[6]=HR_PERIOD_INI;
#endif
            period[5]=HR_PERIOD_INI;
            period[4]=HR_PERIOD_INI;
            period[3]=HR_PERIOD_INI;
            period[2]=HR_PERIOD_INI;
            period[1]=period[0];
            if(flag_false_hr_signal==1)
            {
                period[0]=HR_PERIOD_INI;
            }
            else
            {
                period[0]=period_isr;
            }
            //hr_signal_steady_cnt++;
            //}
            flag_hr_signal_steady_cnt=1;
        }
        else    //if (hr_signal_steady_cnt>=HR_SIGNAL_STEADY_DLY)       //after steay, discard some bad number
        {
#if 0
            period[9]=period[8];
            period[8]=period[7];
            period[7]=period[6];
            period[6]=period[5];
#endif
            period[5]=period[4];
            period[4]=period[3];
            period[3]=period[2];
            period[2]=period[1];
            period[1]=period[0];
            if(flag_false_hr_signal==1)
            {
                //if(userstate==USER_STATE_RUN)period[0]=HR_PERIOD_INI2;
                //else period[0]=HR_PERIOD_INI1;
            }
            else
            {
                if (period_isr>period_measured+HR_PERIOD_BIAS)
                {
                    period_isr = period_measured + HR_PERIOD_COMP;
                }
                else if (period_isr<period_measured-HR_PERIOD_BIAS)
                {
                    period_isr = period_measured - HR_PERIOD_COMP;
                }
                period[0]=period_isr;
            }
            flag_hr_signal_steady_cnt=0;
        }
        //filter
        maximum=period[0];
        minimum=period[0];
        period_measured=period[0];
        for (k=1; k<6; k++)
        {
            if (maximum<period[k])
            {
                maximum=period[k];
            }
            if (minimum>period[k])
            {
                minimum=period[k];
            }
            period_measured+=period[k];
        }
        period_measured=(period_measured-maximum-minimum);
        period_measured=period_measured>>2;
        //if(boardmode==BOARD_MODE_TEST)period_measured=period_isr;     //for board test mode
#else
        //the first order filter didn't work now!!!!why?
        hr_signal_new_cnt++;
        if (hr_signal_new_cnt>98)
        {
            hr_signal_new_cnt=98;
        }
        hr_signal_coeff=100-hr_signal_new_cnt;
        FirstOrderFilter(period_isr,hr_signal_coeff,&period_measured);
#endif
        //refer to design document for details
        if (period_measured!=0)
        {
            user_hr = HR_SCALE/period_measured;
        }
        else
        {
            user_hr = 0;
        }
        if (user_hr>USER_HR_MAX)
        {
            user_hr=USER_HR_MAX;
        }
        if (user_hr<USER_HR_MIN && user_hr!=0)
        {
            user_hr=USER_HR_MIN;
        }
    }
    else
    {
        if (hr_signal_cnt>=HR_SIGNAL_OFF_DLY)
        {
            period_measured = 0;
            user_hr = 0;
            hr_signal_steady_cnt=0;
            flag_hr_signal_steady_cnt=0;
            //hr_signal_new_cnt=0;
            hr_period_ini();
#ifdef FAT_FUNC
            fat_result=0;       //clear when no hr
            fat_step_cnt=0;
#endif
        }
        else
        {
            hr_signal_cnt++;
        }
    }
    flag_false_hr_signal=0;             //reset after one calc
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
@near uint rpm_target_scale_mile,user_rpm_target_old;
void speed_rpm_convert(void)
{
    uint tempi;
    if(user_speed_target>100)
    {
        tempi=(user_speed_target-100);
        tempi*=(SPEED_TARGET_SHI-100);    //实际最高
        tempi/=(SPEED_TARGET_MAX-100);    //显示速度
        tempi+=100;
    }
    else
    {
        tempi=user_speed_target;
    }
    //user speed to rpm
    user_rpm_target = tempi;//user_speed_target;
    //if(user_rpm_target_old!=user_rpm_target)
    //{
    //	flag_speed_change=1;
    //}
    user_rpm_target_old=user_rpm_target;
#ifdef KM_MILE
    if(flag_mile)
    {
        rpm_target_scale_mile=RPM_TARGET_SCALE*16;
        rpm_target_scale_mile/=10;
        user_rpm_target = user_rpm_target*rpm_target_scale_mile/10;
    }
    else
#endif
        user_rpm_target = user_rpm_target*RPM_TARGET_SCALE/10;
    tempi = machine_rpm_target*10/RPM_TARGET_SCALE;
    machine_speed_target = tempi;
    if(machine_speed_target>user_speed_target)
    {
        machine_speed_target=user_speed_target;
    }
}
/*--------------------*
 |  Public functions
 *--------------------*/
void UserSpeedKeys(uchar key_no)
{
    key_id_done=1;          //indicate this key command has been process
    if (userstate==USER_STATE_RUN&&run_state_entry==0)
    {
        beep(BEEP_KEY);
        user_speed_target=key_no;
        user_request|=USER_REQUEST_NEW_SPEED;
        //flag_spd_setting=1;
    }
}
#ifdef  TM1320CA
/*--------------------------------------------------------------------------*
 |
 |  UserInclKeys
 |  Instant Incl keys input
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
void UserInclKeys(uchar key_no)
{
    key_id_done=1;          //indicate this key command has been process
    if (userstate==USER_STATE_RUN&&run_state_entry==0)
    {
        beep(BEEP_KEY);
        user_gradient_target=key_no;
        user_request|=USER_REQUEST_NEW_GRADIENT;
        //flag_incl_setting=1;
    }
}
#endif
/*--------------------------------------------------------------------------*
 |
 |  UserKeySlew
 |  Keys slew process
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
uchar UserKeySlew(void)
{
    //this key can be processed in slew
    key_slew_cnt++;         //in 20ms
    //process when first time presure and after 0.8s, 0.3s, 0.2s
    if (key_slew_cnt==KEY_SLEW_RATE0||key_slew_cnt==KEY_SLEW_RATE1
            ||key_slew_cnt==KEY_SLEW_RATE2||key_slew_cnt==KEY_SLEW_RATE3
            ||key_slew_cnt==KEY_SLEW_RATE4||key_slew_cnt==KEY_SLEW_RATE5)
    {
        //go to key process
    }
    else
    {
        return(0);
    }
    if (key_slew_cnt>=KEY_SLEW_RATE5)
    {
        key_slew_cnt=KEY_SLEW_RATE4;
    }
    return(1);
}
/*--------------------------------------------------------------------------*
 |
 |  key_up_setting
 |  speed or incl up Keys process in standby state
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
void key_up_setting(void)
{
#ifdef NO_SP_SEN
    if(f_para_set==1)
    {
        if(para_step<=4)
        {
            beep(BEEP_KEY);
        }
        if(para_step==3)        //
        {
            if (user_speed_target<SPEED_TARGET_MAX)
            {
                user_speed_target++;
                user_request|=USER_REQUEST_NEW_SPEED;
            }
        }
        else if(para_step==1)       //
        {
            if(dc_motor_startup_volt<DC_MOTOR_STARTUP_VOLT_MAX)
            {
                dc_motor_startup_volt++;
            }
            //else  dc_motor_startup_volt=DC_MOTOR_STARTUP_VOLT_MIN;
        }
        else if(para_step==2)       //
        {
            if(dc_motor_rating_volt<DC_MOTOR_RATING_VOLT_MAX)
            {
                dc_motor_rating_volt++;
            }
            //else dc_motor_rating_volt=DC_MOTOR_RATING_VOLT_MIN;
        }
        else if(para_step==0)   //
        {
            if(dc_motor_rating_f1<DC_MOTOR_RATING_F1_MAX)
            {
                dc_motor_rating_f1++;
            }
            //else dc_motor_rating_f1=DC_MOTOR_RATING_F1_MIN;
        }
        else if(para_step==4)   //
        {
            if(dc_motor_step_para<DC_MOTOR_STEP_PARA_MAX)
            {
                dc_motor_step_para++;
            }
            //else dc_motor_rating_f1=DC_MOTOR_RATING_F1_MIN;
        }
#if 0
        digit_solid_delay=DIGIT_SOLID_TIME;
#endif
    }
    else
#endif
    {
        if (usermode==USER_MODE_NONE)
        {
            if (userprogram!=USER_PROGRAM_NONE) //in user program, select TIME
            {
                beep(BEEP_KEY);
#if 0
                if (user_time_setting<USER_TIME_SETTING_MAX)
                {
                    beep(BEEP_KEY);
                    user_time_setting++;
                    digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
                    //decrease every 20ms
                }
                else if (key_slew_cnt==KEY_SLEW_RATE0)
                {
                    beep(BEEP_KEY_INVALID);
                }
#else
                if(f_fat_func==0)
                {
                    //beep(BEEP_KEY);
                    if (user_time_setting<USER_TIME_SETTING_MAX)
                    {
                        user_time_setting++;
                    }
                    else
                    {
                        user_time_setting=USER_TIME_SETTING_MIN;
                    }
                    digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
                    //decrease every 20ms
                }
#ifdef FAT_FUNC
                else
                {
                    //if(fat_step<=4)beep(BEEP_KEY);
                    if(fat_step==1)     //sex
                    {
                        if(fat_sex==SEX_MALE)
                        {
                            fat_sex=SEX_FEMALE;
                        }
                        else
                        {
                            fat_sex=SEX_MALE;
                        }
                    }
                    else if(fat_step==2)    //age
                    {
                        if(fat_age<AGE_MAX)
                        {
                            fat_age++;
                        }
                        else
                        {
                            fat_age=AGE_MIN;
                        }
                    }
                    else if(fat_step==3)    //height
                    {
#ifdef KM_MILE
                        if(flag_mile)
                        {
                            if(fat_height<HEIGHT_MAX_MILE)
                            {
                                fat_height++;
                            }
                            else
                            {
                                fat_height=HEIGHT_MIN_MILE;
                            }
                        }
                        else
                        {
                            if(fat_height<HEIGHT_MAX)
                            {
                                fat_height++;
                            }
                            else
                            {
                                fat_height=HEIGHT_MIN;
                            }
                        }
#else
                        if(fat_height<HEIGHT_MAX)
                        {
                            fat_height++;
                        }
                        else
                        {
                            fat_height=HEIGHT_MIN;
                        }
#endif
                    }
                    else if(fat_step==4)    //weight
                    {
#ifdef KM_MILE
                        if(flag_mile)
                        {
                            if(fat_weight<WEIGHT_MAX_MILE)
                            {
                                fat_weight++;
                            }
                            else
                            {
                                fat_weight=WEIGHT_MIN_MILE;
                            }
                        }
                        else
                        {
                            if(fat_weight<WEIGHT_MAX)
                            {
                                fat_weight++;
                            }
                            else
                            {
                                fat_weight=WEIGHT_MIN;
                            }
                        }
#else
                        if(fat_weight<WEIGHT_MAX)
                        {
                            fat_weight++;
                        }
                        else
                        {
                            fat_weight=WEIGHT_MIN;
                        }
#endif
                    }
                }
#endif
#endif
            }
        }
        else            //in user mode, select TIME or DISTANCE or CALORIES number
        {
            beep(BEEP_KEY);
            if (usermode==USER_MODE_TIME)   //adjust time number
            {
#if 0
                if (user_time_setting<USER_TIME_SETTING_MAX)
                {
                    if(user_time_setting==0)
                    {
                        user_time_setting=TIME_INITIAL_VALUE;
                    }
                    else
                    {
                        user_time_setting++;
                    }
                    beep(BEEP_KEY);
                    digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
                    //decrease every 20ms
                }
                else if (key_slew_cnt==KEY_SLEW_RATE0)
                {
                    beep(BEEP_KEY_INVALID);
                }
#else
                if(user_time_setting==0)
                {
                    user_time_setting=TIME_INITIAL_VALUE;
                }
                else if (user_time_setting<USER_TIME_SETTING_MAX)
                {
                    user_time_setting++;
                }
                else
                {
                    user_time_setting=USER_TIME_SETTING_MIN;
                }
                //beep(BEEP_KEY);
                digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
                //decrease every 20ms
#endif
            }
            else if (usermode==USER_MODE_DISTANCE)  //adjust distance number
            {
#if 0
                if (user_distance_setting<USER_DISTANCE_SETTING_MAX)
                {
                    beep(BEEP_KEY);
                    if(user_distance_setting==0)
                    {
                        user_distance_setting=DISTANCE_INITIAL_VALUE;
                    }
                    else
                    {
                        user_distance_setting+=10;
                    }
                    digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
                    //decrease every 20ms
                }
                else if (key_slew_cnt==KEY_SLEW_RATE0)
                {
                    beep(BEEP_KEY_INVALID);
                }
#else
                if(user_distance_setting==0)
                {
                    user_distance_setting=DISTANCE_INITIAL_VALUE;
                }
                else if (user_distance_setting<USER_DISTANCE_SETTING_MAX)
                {
                    user_distance_setting+=10;
                }
                else
                {
                    user_distance_setting=USER_DISTANCE_SETTING_MIN;
                }
                //beep(BEEP_KEY);
                digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
#endif
            }
            else if  (usermode==USER_MODE_CALORIES) //adjust calories number
            {
#if 0
                if (user_calories_setting<USER_CALORIES_SETTING_MAX)
                {
                    beep(BEEP_KEY);
                    if(user_calories_setting==0)
                    {
                        user_calories_setting=CALORIES_INITIAL_VALUE;
                    }
                    else
                    {
                        user_calories_setting+=10;
                    }
                    digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
                    //decrease every 20ms
                }
                else if (key_slew_cnt==KEY_SLEW_RATE0)
                {
                    beep(BEEP_KEY_INVALID);
                }
#else
                if(user_calories_setting==0)
                {
                    user_calories_setting=CALORIES_INITIAL_VALUE;
                }
                else if (user_calories_setting<USER_CALORIES_SETTING_MAX)
                {
                    user_calories_setting+=10;
                }
                else
                {
                    user_calories_setting=USER_CALORIES_SETTING_MIN;
                }
                //beep(BEEP_KEY);
                digit_solid_delay=DIGIT_SOLID_TIME;         //to keep the digit solid
                //decrease every 20ms
#endif
            }
            //else usermode=USER_MODE_NONE;
        }
    }
}
/*--------------------------------------------------------------------------*
 |
 |  key_down_setting
 |  speed or incl down Keys process in standby state
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
void key_down_setting(void)
{
#ifdef NO_SP_SEN
    if(f_para_set==1)
    {
        if(para_step<=4)
        {
            beep(BEEP_KEY);
        }
        if(para_step==3)        //
        {
            if(user_speed_target>SPEED_TARGET_MIN&&flag_mile==0||user_speed_target>SPEED_TARGET_MIN1&&flag_mile==1)
            {
                user_speed_target--;
                user_request|=USER_REQUEST_NEW_SPEED;
            }
        }
        else if(para_step==1)     //
        {
            if(dc_motor_startup_volt>DC_MOTOR_STARTUP_VOLT_MIN)
            {
                dc_motor_startup_volt--;
            }
            //else  dc_motor_startup_volt=DC_MOTOR_STARTUP_VOLT_MAX;
        }
        else if(para_step==2)     //sex
        {
            if(dc_motor_rating_volt>DC_MOTOR_RATING_VOLT_MIN)
            {
                dc_motor_rating_volt--;
            }
            //else dc_motor_rating_volt=DC_MOTOR_RATING_VOLT_MAX;
        }
        else if(para_step==0) //height
        {
            if(dc_motor_rating_f1>DC_MOTOR_RATING_F1_MIN)
            {
                dc_motor_rating_f1--;
            }
            //else dc_motor_rating_f1=DC_MOTOR_RATING_F1_MAX;
        }
        else if(para_step==4) //height
        {
            if(dc_motor_step_para>DC_MOTOR_STEP_PARA_MIN)
            {
                dc_motor_step_para--;
            }
        }
    }
    else
#endif
    {
        if (usermode==USER_MODE_NONE)
        {
            if (userprogram!=USER_PROGRAM_NONE) //in user program, select TIME
            {
                beep(BEEP_KEY);
#if 0
                if (user_time_setting>USER_TIME_SETTING_MIN)
                {
                    beep(BEEP_KEY);
                    user_time_setting--;
                    digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
                    //decrease every 20ms
                }
                else if (key_slew_cnt==KEY_SLEW_RATE0)
                {
                    beep(BEEP_KEY_INVALID);
                }
#else
                if(f_fat_func==0)
                {
                    //beep(BEEP_KEY);
                    if (user_time_setting>USER_TIME_SETTING_MIN)
                    {
                        user_time_setting--;
                    }
                    else
                    {
                        user_time_setting=USER_TIME_SETTING_MAX;
                    }
                    digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
                    //decrease every 20ms
                }
#ifdef FAT_FUNC
                else
                {
                    //if(fat_step<=4)beep(BEEP_KEY);
                    if(fat_step==1)     //sex
                    {
                        if(fat_sex==SEX_MALE)
                        {
                            fat_sex=SEX_FEMALE;
                        }
                        else
                        {
                            fat_sex=SEX_MALE;
                        }
                    }
                    else if(fat_step==2)    //age
                    {
                        if(fat_age>AGE_MIN)
                        {
                            fat_age--;
                        }
                        else
                        {
                            fat_age=AGE_MAX;
                        }
                    }
                    else if(fat_step==3)    //height
                    {
#ifdef KM_MILE
                        if(flag_mile)
                        {
                            if(fat_height>HEIGHT_MIN_MILE)
                            {
                                fat_height--;
                            }
                            else
                            {
                                fat_height=HEIGHT_MAX_MILE;
                            }
                        }
                        else
                        {
                            if(fat_height>HEIGHT_MIN)
                            {
                                fat_height--;
                            }
                            else
                            {
                                fat_height=HEIGHT_MAX;
                            }
                        }
#else
                        if(fat_height>HEIGHT_MIN)
                        {
                            fat_height--;
                        }
                        else
                        {
                            fat_height=HEIGHT_MAX;
                        }
#endif
                    }
                    else if(fat_step==4)    //weight
                    {
#ifdef KM_MILE
                        if(flag_mile)
                        {
                            if(fat_weight>WEIGHT_MIN_MILE)
                            {
                                fat_weight--;
                            }
                            else
                            {
                                fat_weight=WEIGHT_MAX_MILE;
                            }
                        }
                        else
                        {
                            if(fat_weight>WEIGHT_MIN)
                            {
                                fat_weight--;
                            }
                            else
                            {
                                fat_weight=WEIGHT_MAX;
                            }
                        }
#else
                        if(fat_weight>WEIGHT_MIN)
                        {
                            fat_weight--;
                        }
                        else
                        {
                            fat_weight=WEIGHT_MAX;
                        }
#endif
                    }
                }
#endif
#endif
            }
        }
        else            //in user mode, select TIME or DISTANCE or CALORIES number
        {
            beep(BEEP_KEY);
            if (usermode==USER_MODE_TIME)   //adjust time number
            {
#if 0
                if (user_time_setting>USER_TIME_SETTING_MIN)
                {
                    beep(BEEP_KEY);
                    user_time_setting--;
                    digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
                    //decrease every 20ms
                }
                else if (key_slew_cnt==KEY_SLEW_RATE0)
                {
                    beep(BEEP_KEY_INVALID);
                }
#else
                //beep(BEEP_KEY);
                if (user_time_setting>USER_TIME_SETTING_MIN)
                {
                    user_time_setting--;
                }
                else
                {
                    user_time_setting=USER_TIME_SETTING_MAX;
                }
                digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
#endif
            }
            else if (usermode==USER_MODE_DISTANCE)  //adjust distance number
            {
#if 0
                if (user_distance_setting>USER_DISTANCE_SETTING_MIN)
                {
                    beep(BEEP_KEY);
                    user_distance_setting-=10;
                    digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
                    //decrease every 20ms
                }
                else if (key_slew_cnt==KEY_SLEW_RATE0)
                {
                    beep(BEEP_KEY_INVALID);
                }
#else
                //beep(BEEP_KEY);
                if (user_distance_setting>USER_DISTANCE_SETTING_MIN)
                {
                    user_distance_setting-=10;
                }
                else
                {
                    user_distance_setting=USER_DISTANCE_SETTING_MAX;
                }
                digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
                //decrease every 20ms
#endif
            }
            else if  (usermode==USER_MODE_CALORIES) //adjust calories number
            {
#if 0
                if (user_calories_setting>USER_CALORIES_SETTING_MIN)
                {
                    beep(BEEP_KEY);
                    user_calories_setting-=10;
                    digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
                    //decrease every 20ms
                }
                else if (key_slew_cnt==KEY_SLEW_RATE0)
                {
                    beep(BEEP_KEY_INVALID);
                }
#else
                //beep(BEEP_KEY);
                if (user_calories_setting>USER_CALORIES_SETTING_MIN)
                {
                    user_calories_setting-=10;
                }
                else
                {
                    user_calories_setting=USER_CALORIES_SETTING_MAX;
                }
                digit_solid_delay=DIGIT_SOLID_TIME;     //to keep the digit solid
                //decrease every 20ms
#endif
            }
            //else usermode=USER_MODE_NONE;
        }
    }
}
void total_dist_write(void)
{
    eeprom_write();
}
#ifdef NO_SP_SEN
void exit_para_set(void)
{
    //eeprom_write_motor_para();
    eeprom_write();
    //eeprom_request=EEPROM_REQUEST_WRITE;           //renew the eeprom value
    //eeprom_write_part = EEPROM_WRITE_PARA;
    f_para_set=0;
}
#endif
/*--------------------------------------------------------------------------*
 |
 |  UserConsumerKeys
 |  Call periodically in in main loop
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
void UserConsumerKeys(void)
{
    /* --------------*
     |  Safety switch
     * --------------*/
#if 0//无安全锁 
    if(SAFTY==SAFTY_SWITCH_OFF)     //SWITCH PUT OFF, protection
    {
        if(safety_off_cnt>=3)
        {
            safety_state = SAFETY_STATE_OFF;
            safety_on_cnt=0;
            if(userstate==USER_STATE_SLEEP&&safety_state==safety_state_last)
            {
            }
            else if(userstate!=USER_STATE_IDLE)
            {
                if(userstate==USER_STATE_RUN)
                {
                    total_dist_write();
                }
#ifdef  NO_SP_SEN
                if(f_para_set==1)
                {
                    exit_para_set();
                }
#endif
                userstate=USER_STATE_IDLE;
                user_request=USER_REQUEST_STOP;
                beep(BEEP_SAFETY_OFF);
                f_disp_total_distance=0;
            }
        }
        else
        {
            safety_off_cnt++;
        }
    }
    else
    {
        if(safety_on_cnt>=10)           //put on
        {
            f_disp_total_distance=0;
            safety_state = SAFETY_STATE_ON;
            safety_off_cnt=0;
            if(userstate==USER_STATE_IDLE||(userstate==USER_STATE_SLEEP&&safety_state!=safety_state_last))
            {
                f_disp_total_distance=0;
                userstate=USER_STATE_STANDBY;
                beep(BEEP_KEY);
                all_display_on_cnt=DISPLAY_ALL_ON_DELAY;        //all on for 1 second
                all_display_on=1;
            }
        }
        else
        {
            safety_on_cnt++;
        }
    }
    safety_state_last=safety_state;
#endif
    if(key_id==KEY_DIST_CLR)
    {
        if(sec==0)
        {
            clr_distance_cnt++;
        }
        if(clr_distance_cnt>3)
        {
            key_id_done=1;
            clr_distance_cnt=0;
            if (userstate==USER_STATE_IDLE&&f_disp_total_distance==1)
            {
                user_total_distance=0;
                beep(BEEP_KEY);
            }
            if(userstate==USER_STATE_STANDBY&&flag_lub==1)
            {
                flag_lub=0;
                beep(BEEP_KEY);
            }
            eeprom_write();
        }
    }
    else
    {
        clr_distance_cnt=0;
    }
    /*---------------------------------------------------*
     |  keys for self test or burn in test
     |    Only enter test mode in standby state
     |  Only quit when power off
     *---------------------------------------------------*/
    if(userstate!=USER_STATE_RUN)
    {
        if(flag_burnin_test==0)
        {
#ifdef  KM_MILE
            if(key_id == KEY_KM_MILE)
            {
                if(km_mile_debounce>250&&key_id_done==0)            //5s
                {
                    display_speed_max=SPEED_MAX_TIME;
                    key_id_done=1;
                    beep(BEEP_KEY_INVALID);
                    if(flag_mile==0)
                    {
                        flag_mile=1;
                    }
                    else
                    {
                        flag_mile=0;
                    }
                    f_disp_total_distance=0;
                    //eeprom_request=EEPROM_REQUEST_WRITE;          //renew the eeprom value
                    //eeprom_write_part = EEPROM_WRITE_KMH_MPH;
                    //eeprom_write_part_buff = EEPROM_WRITE_U1_BUFF|EEPROM_WRITE_U2_BUFF|EEPROM_WRITE_U3_BUFF;
                    eeprom_write();
                }
                else
                {
                    km_mile_debounce++;
                }
            }
            else
            {
                km_mile_debounce=0;
            }
#endif
#if 0
            if(key_id == KEY_SELF_TEST)
            {
                if(self_test_debounce>200)
                {
                    flag_self_test=1;
                    boardmode=BOARD_MODE_TEST;
                    user_request|=USER_REQUEST_SELF_TEST;
                    self_test_debounce=0;
                }
                else
                {
                    self_test_debounce++;
                }
            }
            else
            {
                self_test_debounce=0;
            }
//#else
            if(key_id == KEY_BURNIN_TEST)
            {
                if(burnin_test_debounce>200)
                {
                    flag_burnin_test=1;
                    boardmode=BOARD_MODE_TEST;
                    user_request|=USER_REQUEST_BURNIN_TEST;
                    burnin_test_debounce=0;
                }
                else
                {
                    burnin_test_debounce++;
                }
            }
            else
            {
                burnin_test_debounce=0;
            }
#endif
            if(key_id == KEY_VERSION&&version_display_cnt==0)
            {
                if(key_version_debounce>150)
                {
                    key_version_debounce=0;
                    if(userstate == USER_STATE_IDLE)
                    {
                        f_disp_total_distance=1;
                    }
                    else
                    {
                        version_display_cnt=100;
                    }
                }
                else
                {
                    key_version_debounce++;
                }
            }
            else
            {
                key_version_debounce=0;
            }
        }
    }
#ifdef NO_SP_SEN
    //for ajust para during debug of machine
    if(userstate==USER_STATE_RUN)
    {
        if(key_id==KEY_PARA_SET)
        {
            if(sec==0)
            {
                key_para_cnt++;
            }
            if(key_para_cnt>=3)
            {
                key_para_cnt=0;
                beep(BEEP_KEY);
                if(f_para_set==0)
                {
                    f_para_set=1;
                }
                else
                {
                    exit_para_set();
                }
                para_step=0;
            }
        }
        else
        {
            key_para_cnt=0;
        }
    }
#endif
#ifdef BLUETOOTH
    //TO switch true run mode
#if 0
    if(userstate==USER_STATE_RUN)//&&flag_module_2_mobile==1)
    {
        if(key_id==KEY_MODE)
        {
            if(sec==0)
            {
                key_true_cnt++;
            }
            if(key_true_cnt>3)
            {
                key_true_cnt=0;
                if(flag_true_run==0)
                {
                    flag_true_run=1;    //off
                    beep(BEEP_SAFETY_OFF);
                }
                else
                {
                    flag_true_run=0;    //on true mode
                    beep(BEEP_KEY);
                }
                eeprom_write();
            }
        }
        else
        {
            key_true_cnt=0;
        }
    }
    else
#endif
        if(userstate==USER_STATE_STANDBY)//&&flag_module_2_mobile==0)
        {
            if(key_id==KEY_SPEED_UP)
            {
                if(sec==0)
                {
                    key_true_cnt++;
                }
                if(key_true_cnt>3)
                {
                    disp_true_run=100;
                    key_true_cnt=0;
                    if(flag_true_run==0)
                    {
                        flag_true_run=1;
                        beep(BEEP_SAFETY_OFF);
                    }
                    else
                    {
                        flag_true_run=0;
                        beep(BEEP_KEY);
                    }
                    eeprom_write();
                }
            }
            else
            {
                key_true_cnt=0;
            }
        }
#endif
    /*---------------------------------------------------*
     |  Process key function associate with the key press
     *---------------------------------------------------*/
    if(key_id != KEY_NONE && key_id_done==0 &&all_display_on==0  //&& error_id==0
            && userstate!=USER_STATE_IDLE)  //&& userstate!=USER_STATE_FAULT)       //
    {
        if (userstate == USER_STATE_SLEEP)  //any key to wake up from sleep mode
        {
            key_id_done=1;
            userstate=USER_STATE_STANDBY;
            userprogram=USER_PROGRAM_NONE;
            usermode=USER_MODE_NONE;
            beep(BEEP_KEY);
            //LCD_BL=1;
            return;
        }
        //any keys input will reset the count of entering sleep mode
        standby_to_sleep_cnt=0;
        idle_to_sleep_cnt=0;
        //user_program_mode_cancel_delay=0;
        if(stepdown_flag==STEPDOWN_NONE)
        {
            switch(key_id)
            {
            case KEY_RUN_MODE:
                key_id_done=1;
                if(runmode!=RUN_MODE_LOCK)//(userstate == USER_STATE_STANDBY&&runmode!=RUN_MODE_LOCK)
                {
                    beep(BEEP_KEY);
                    if(runmode==RUN_MODE_AUTO)
                    {
                        runmode=RUN_MODE_FIXED;
                    }
                    else
                    {
                        runmode=RUN_MODE_AUTO;
                    }
                }
                break;
            case KEY_RESTORE:
                key_id_done=1;
                if(userstate == USER_STATE_STANDBY)
                {
                    beep(BEEP_KEY);
                    set_wifi_flag(FLAG_WIFI_RESTORE);
                }
                break;
            case KEY_MODE:
                key_id_done=1;          //indicate this key command has been process
#ifdef NO_SP_SEN
                if (f_para_set==0&&userstate == USER_STATE_STANDBY)
#else
                if (userstate == USER_STATE_STANDBY)    //&& userprogram == USER_PROGRAM_NONE)
#endif
                {
                    beep(BEEP_KEY);
                    if(f_fat_func==0)
                    {
                        userprogram = USER_PROGRAM_NONE;
                        if(flag_mile==0)
                        {
                            user_speed_target=SPEED_TARGET_MIN;
                        }
                        else
                        {
                            user_speed_target=SPEED_TARGET_MIN1;
                        }
#ifdef  TM1320CA
                        user_gradient_target =0;
#endif
                        if (usermode == USER_MODE_NONE)
                        {
                            usermode = USER_MODE_TIME;
                            //initial setting
                            user_time_setting=TIME_INITIAL_VALUE;
                            user_distance_setting=0;
                            user_calories_setting=0;
#ifdef BLUETOOTH
                            if(flag_module_2_mobile==1)
                            {
                                flag_mode_steps=0;
                                flag_program=0;
                                flag_match=0;
                                flag_btm_hrc=0;
                                flag_mode_time=1;
                                flag_mode_dist=0;
                                flag_mode_cal=0;
                            }
#endif
                        }
                        else if (usermode == USER_MODE_TIME)
                        {
                            usermode = USER_MODE_DISTANCE;
                            //flag_dist_setting=1;
                            //flag_cal_setting=0;
                            //initial setting
                            user_time_setting=0;
                            user_distance_setting=DISTANCE_INITIAL_VALUE;
                            user_calories_setting=0;
#ifdef BLUETOOTH
                            if(flag_module_2_mobile==1)
                            {
                                flag_mode_steps=0;
                                flag_program=0;
                                flag_match=0;
                                flag_btm_hrc=0;
                                flag_mode_time=0;
                                flag_mode_dist=1;
                                flag_mode_cal=0;
                            }
#endif
                        }
                        else if (usermode == USER_MODE_DISTANCE)
                        {
                            usermode = USER_MODE_CALORIES;
                            //flag_dist_setting=0;
                            //flag_cal_setting=1;
                            //initial setting
                            user_time_setting=0;
                            user_distance_setting=0;
                            user_calories_setting=CALORIES_INITIAL_VALUE;
#ifdef BLUETOOTH
                            if(flag_module_2_mobile==1)
                            {
                                flag_mode_steps=0;
                                flag_program=0;
                                flag_match=0;
                                flag_btm_hrc=0;
                                flag_mode_time=0;
                                flag_mode_dist=0;
                                flag_mode_cal=1;
                            }
#endif
                        }
                        else
                        {
                            usermode = USER_MODE_NONE;
                            //initial setting
                            if(flag_mile==0)
                            {
                                user_speed_target=SPEED_TARGET_MIN;
                            }
                            else
                            {
                                user_speed_target=SPEED_TARGET_MIN1;
                            }
                            usermode = USER_MODE_NONE;
                            user_time_setting=0;
                            user_distance_setting=0;
                            user_calories_setting=0;
#ifdef BLUETOOTH
                            if(flag_module_2_mobile==1)
                            {
                                flag_mode_steps=0;
                                flag_program=0;
                                flag_match=0;
                                flag_btm_hrc=0;
                                flag_mode_time=0;
                                flag_mode_dist=0;
                                flag_mode_cal=0;
                            }
#endif
                        }
                    }
#ifdef FAT_FUNC
                    else
                    {
                        //beep(BEEP_KEY);
                        if(fat_step<5)
                        {
                            fat_step++;
                        }
                        else
                        {
                            fat_step=1;
                        }
                    }
#endif
                }
#ifdef NO_SP_SEN
                else if(f_para_set==1)
                {
                    beep(BEEP_KEY);
                    if(para_step<4)
                    {
                        para_step++;
                    }
                    else
                    {
                        para_step=0;
                    }
                }
#endif
                break;
            case KEY_PROGRAM:
                key_id_done=1;          //indicate this key command has been process
#ifdef NO_SP_SEN
                if (f_para_set==0&&userstate == USER_STATE_STANDBY)
#else
                if (userstate == USER_STATE_STANDBY)
#endif
                {
                    beep(BEEP_KEY);
                    usermode=USER_MODE_NONE;        //cancel user mode
#ifndef FAT_FUNC
                    if (userprogram<PROGRAM_SIZE)
#else
                    if (userprogram<=PROGRAM_SIZE)
#endif
                    {
                        userprogram++;
#ifdef FAT_FUNC
                        if(userprogram==USER_PROGRAM_FAT)
                        {
                            f_fat_func=1;
                            fat_step=0;
                            fat_sex=SEX_DEFUALT;
                            fat_age=AGE_DEFUALT;
#ifdef KM_MILE
                            if(flag_mile)
                            {
                                fat_weight=WEIGHT_DEFUALT_MILE;
                                fat_height=HEIGHT_DEFUALT_MILE;
                            }
                            else
                            {
                                fat_weight=WEIGHT_DEFUALT;
                                fat_height=HEIGHT_DEFUALT;
                            }
#else
                            fat_weight=WEIGHT_DEFUALT;
                            fat_height=HEIGHT_DEFUALT;
#endif
                        }
#endif
                        //initial speed and time
                        if(f_fat_func==0)
                        {
                            user_time_setting=10;
                            if(flag_mile==0)
                            {
                                user_speed_target=program_table[userprogram-1][0];
                            }
                            else
                            {
                                user_speed_target=program_table2[userprogram-1][0];
                            }
#ifdef  TM1320CA
                            user_gradient_target = incl_table[userprogram-1][0];
#endif
                        }
                    }
                    else
                    {
                        userprogram = USER_PROGRAM_NONE;
                        user_time_setting=0;
                        if(flag_mile==0)
                        {
                            user_speed_target=SPEED_TARGET_MIN;
                        }
                        else
                        {
                            user_speed_target=SPEED_TARGET_MIN1;
                        }
                        usermode = USER_MODE_NONE;
                        user_time_setting=0;
                        user_distance_setting=0;
                        user_calories_setting=0;
                        f_fat_func=0;
                        fat_step=0;
                    }
                }
#ifdef NO_SP_SEN
                else if(f_para_set==1)
                {
                    beep(BEEP_KEY);
                    eeprom_write();//
                    //eeprom_write_motor_para();    //set
                    //eeprom_request=EEPROM_REQUEST_WRITE;          //renew the eeprom value
                    //eeprom_write_part = EEPROM_WRITE_PARA;
                }
#endif
                break;
            case KEY_STOP:
                key_id_done=1;          //indicate this key command has been process
                switch(userstate)
                {
                case USER_STATE_IDLE:
                    break;
                case USER_STATE_STANDBY:
                    beep(BEEP_KEY);
                    userstate=USER_STATE_SLEEP;
                    break;
                case USER_STATE_RUN:
                    if(stepdown_flag==STEPDOWN_NONE)
                    {
                        beep(BEEP_KEY);
                        stepdown_flag=STEPDOWN_STOP;                //not stop at once, step down
                        user_speed_target=machine_speed_target;     //step down from machine speed
                        stepdown_cnt=6;
                    }
#ifdef NO_SP_SEN
                    if(f_para_set==1)
                    {
                        exit_para_set();
                    }
#endif
                    break;
#ifdef ZT
                case USER_STATE_PAUSE:
                    userstate=USER_STATE_STANDBY;
                    userprogram=USER_PROGRAM_NONE;
                    usermode=USER_MODE_NONE;
                    beep(BEEP_KEY);
                    break;
#endif
                case USER_STATE_EOC:
                    break;
                case USER_STATE_SLEEP:
                    break;
                case USER_STATE_FAULT:
                    break;
                }
                break;
            case KEY_START_STOP:
                key_id_done=1;          //indicate this key command has been process
                switch(userstate)
                {
                case USER_STATE_IDLE:
                    break;
                case USER_STATE_STANDBY:
                    if(f_fat_func==0)
                    {
                        beep(BEEP_KEY);
                        userstate=USER_STATE_RUN;
                        run_state_entry=1;
                    }
                    break;
                case USER_STATE_RUN:
                    if(stepdown_flag==STEPDOWN_NONE)
                    {
                        beep(BEEP_KEY);
                        //userstate=USER_STATE_STANDBY;
                        //user_request=USER_REQUEST_STOP;
#ifdef ZT
                        stepdown_flag=STEPDOWN_PAUSE;
                        if(userprogram==USER_PROGRAM_NONE)
                        {
                            if(flag_mile==0)
                            {
                                user_speed_target_pause=SPEED_TARGET_MIN;
                            }
                            else
                            {
                                user_speed_target_pause=SPEED_TARGET_MIN1;
                            }
                        }
                        else
                        {
                            user_speed_target_pause=user_speed_target;
                        }
#else
                        stepdown_flag=STEPDOWN_STOP;                //not stop at once, step down
#endif
                        user_speed_target=machine_speed_target;     //step down from machine speed
                        stepdown_cnt=6;
                    }
#ifdef NO_SP_SEN
                    if(f_para_set==1)
                    {
                        exit_para_set();
                    }
#endif
                    break;
#ifdef ZT
                case USER_STATE_PAUSE:
                    beep(BEEP_KEY);
                    userstate=USER_STATE_RUN;
                    user_speed_target=user_speed_target_pause;
                    run_state_entry=1;
                    break;
#endif
                case USER_STATE_EOC:
                    break;
                case USER_STATE_SLEEP:
                    break;
                case USER_STATE_FAULT:
                    break;
                }
                break;
            case KEY_SPEED_UP:
                if(UserKeySlew()==0)
                {
                    break;
                }
#ifdef NO_SP_SEN
                if (f_para_set==0&&userstate==USER_STATE_RUN&&run_state_entry==0)
#else
                if (userstate==USER_STATE_RUN&&run_state_entry==0)//&&stepdown_flag==STEPDOWN_NONE) //||userstate==USER_STATE_PAUSE)
#endif
                {
                    if(flag_mile==0)
                    {
                        if (user_speed_target<SPEED_TARGET_MAX)
                        {
                            beep(BEEP_KEY);
                            user_speed_target++;
                        }
                        else if (key_slew_cnt==KEY_SLEW_RATE0)
                        {
                            beep(BEEP_KEY_INVALID);
                        }
                    }
                    else
                    {
                        if (user_speed_target<SPEED_TARGET_MAX1)
                        {
                            beep(BEEP_KEY);
                            user_speed_target++;
                        }
                        else if (key_slew_cnt==KEY_SLEW_RATE0)
                        {
                            beep(BEEP_KEY_INVALID);
                        }
                    }
                    user_request|=USER_REQUEST_NEW_SPEED;
                }
#ifdef NO_SP_SEN
                else if (f_para_set==0&&userstate==USER_STATE_STANDBY||f_para_set==1)
#else
                else if (userstate==USER_STATE_STANDBY)
#endif
                {
                    key_up_setting();
                }
                break;
            case KEY_SPEED_DOWN:
                //this key can be processed in slew
                if(UserKeySlew()==0)
                {
                    break;
                }
#ifdef NO_SP_SEN
                if (f_para_set==0&&userstate==USER_STATE_RUN&&run_state_entry==0)
#else
                if (userstate==USER_STATE_RUN&&run_state_entry==0)//&&stepdown_flag==STEPDOWN_NONE) //||userstate==USER_STATE_PAUSE)
#endif
                {
                    if(flag_mile==0)
                    {
                        if (user_speed_target>SPEED_TARGET_MIN)
                        {
                            beep(BEEP_KEY);
                            user_speed_target--;
                        }
                        else if (key_slew_cnt==KEY_SLEW_RATE0)
                        {
                            beep(BEEP_KEY_INVALID);
                        }
                    }
                    else
                    {
                        if (user_speed_target>SPEED_TARGET_MIN1)
                        {
                            beep(BEEP_KEY);
                            user_speed_target--;
                        }
                        else if (key_slew_cnt==KEY_SLEW_RATE0)
                        {
                            beep(BEEP_KEY_INVALID);
                        }
                    }
                    user_request|=USER_REQUEST_NEW_SPEED;
                }
#ifdef NO_SP_SEN
                else if (f_para_set==0&&userstate==USER_STATE_STANDBY||f_para_set==1)
#else
                else if (userstate==USER_STATE_STANDBY)
#endif
                {
                    key_down_setting();
                }
                break;
#ifdef TM1320CA
            case KEY_INCL_UP:
                //key slew process
                if(UserKeySlew()==0)
                {
                    break;
                }
                if (userstate==USER_STATE_RUN&&run_state_entry==0)  //&&stepdown_flag==STEPDOWN_NONE)
                {
                    //flag_incl_setting=1;
                    //incl_pm_cnt=0;
                    if (user_gradient_target<LIFT_MOTOR_GRADIENT_MAX)
                    {
                        beep(BEEP_KEY);
                        user_gradient_target++;
                    }
                    else if (key_slew_cnt==KEY_SLEW_RATE0)
                    {
                        beep(BEEP_KEY_INVALID);
                    }
                    user_request|=USER_REQUEST_NEW_GRADIENT;
                }
                else if(userstate==USER_STATE_STANDBY)
                {
                    key_up_setting();
                }
                break;
            case KEY_INCL_DOWN:
                //key slew process
#ifdef NO_SP_SEN
                if(f_para_set==1)
                {
                    key_id_done=1;
                    beep(BEEP_KEY);
                    if(para_step<4)
                    {
                        para_step++;
                    }
                    else
                    {
                        para_step=0;
                    }
                }
                else
#endif
                {
                    if(UserKeySlew()==0)
                    {
                        break;
                    }
                    if (userstate==USER_STATE_RUN&&run_state_entry==0)  //&&stepdown_flag==STEPDOWN_NONE)
                    {
                        //flag_incl_setting=1;
                        //incl_pm_cnt=0;
                        if(user_gradient_target>0)
                        {
                            beep(BEEP_KEY);
                            user_gradient_target--;
                        }
                        else if (key_slew_cnt==KEY_SLEW_RATE0)
                        {
                            beep(BEEP_KEY_INVALID);
                        }
                        user_request|=USER_REQUEST_NEW_GRADIENT;
                    }
                    else if (userstate==USER_STATE_STANDBY)
                    {
                        key_down_setting();
                    }
                }
                break;
#endif
            }
        }
    }
}
#if 0
/*--------------------------------------------------------------------------*
 |
 |  UserTestKeys
 |  Call periodically in in main loop
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
void UserTestKeys(void)
{
#ifndef  TM1320CA
    //BEEP when there is key pressing
    if(key_id != KEY_NONE)
    {
        beep(BEEP_KEY);
    }
#endif
}
#endif
void total_dist_disp(ulong dist)
{
    uchar  temp8;
    ulong temp32;
    temp32=dist/100;
    temp32=temp32%10000;
#ifdef LED01
    ImageCNT(temp32);
#endif
#ifdef LED02
    if(temp32/1000>0)
    {
        disp_matrix_digit8x4(temp32/1000,0,0);
    }
    if(temp32/100>0)
    {
        disp_matrix_digit8x4(temp32/100,5,0);
    }
    if(temp32/10>0)
    {
        disp_matrix_digit8x4(temp32/10,10,0);
    }
    disp_matrix_digit8x4(temp32%10,15,0);
#endif
}
/*--------------------------------------------------------------------------*
 |
 |  UserConsumerDisplay
 |  Call periodically in UserOperation() if in consumer mode
 |
 |  Description: To update speed,time,calories,heart rate, and prompts.
 |
 *--------------------------------------------------------------------------*/
@near uint display_timeORdistORcalr_cnt;
/************************************点阵 纵向取模，字节正序********************************************/
uchar const lib_start[MATRIX1_SIZE]=
{
    0x09,0x15,0x15,0x12,0x00,0x10,0x7F,0x11,0x00,0x0A,0x15,0x15,0x0F,0x01,0x00,0x11,
    0x1F,0x09,0x10,0x00,0x10,0x7F,0x11
};
uchar const lib_restore[MATRIX1_SIZE]=
{
    0x11,0x1F,0x09,0x10,0x10,0x00,0x00,0x0E,0x15,0x15,0x0D,0x00,0x00,0x19,0x15,0x15,
    0x13,0x00,0x00,0x10,0x7F,0x11,0x11
};
#if 0
uchar const lib_wait[MATRIX1_SIZE]=
{
    0x18,0x07,0x1C,0x07,0x18,0x00,0x00,0x0A,0x15,0x15,0x0F,0x01,0x00,0x00,0x11,0x5F,
    0x01,0x00,0x00,0x10,0x7F,0x11,0x11
};
uchar const lib_time[MATRIX1_SIZE]=
{
    0x10,0x7F,0x11,0x11,0x00,0x00,0x11,0x5F,0x01,0x00,0x00,0x1F,0x10,0x1F,0x10,0x0F,
    0x00,0x00,0x0E,0x15,0x15,0x0D,0x00
};
uchar const lib_km[MATRIX1_SIZE]=
{
    0x00,0x00,0x00,0x00,0x00,0x00,0x41,0x7F,0x04,0x1A,0x11,0x00,0x1F,0x10,0x1F,0x10,
    0x0F,0x00,0x00,0x00,0x00,0x00,0x00
};
uchar const lib_kcal[MATRIX1_SIZE]=
{
    0x41,0x7F,0x04,0x1A,0x11,0x00,0x00,0x0E,0x11,0x11,0x0A,0x00,0x00,0x0A,0x15,0x15,
    0x0F,0x01,0x00,0x41,0x7F,0x01,0x00
};
#endif
uchar i;
void UserConsumerDisplay(void)
{
    uchar  temp8,tmp8;
    uint  temp16,tempi,tep;
#if 0
#ifdef  KM_MILE
    if(flag_mile)
    {
        tempi=DISTANCE_ML_LUB;
    }
    else
#endif
        tempi=DISTANCE_KM_LUB;
    temp16=user_total_distance%tempi;
    tep=user_total_distance/tempi;
    if(temp16==0&&tep>0)//(temp16>=tempi-2)
    {
        flag_lub=1;     //pump on for 40s
        user_total_distance_bp+=1;
        user_total_distance+=1;
        total_dist_write();
    }
#if 1
    if(flag_lub==1&&userstate==USER_STATE_STANDBY)//((userstate==USER_STATE_RUN&&run_state_entry==0)||userstate==USER_STATE_STANDBY||userstate==USER_STATE_PAUSE))
    {
        if(sec==0)
        {
            oil_beep_cnt++;
        }
        if(oil_beep_cnt>=20)
        {
            oil_beep_cnt=0;
        }
        if(oil_beep_cnt>=10)
        {
            //oil_beep_cnt=0;
            if(sec==0)
            {
                beep(BEEP_KEY);    //beep(BEEP_SAFETY_OFF);
            }
            //oil_beep=1;
        }
    }
    else
    {
        oil_beep_cnt=0;
    }
#endif
#endif
#if 0
    ImageAll(0x00);
    disp_matrix_digit_ascii_SP(i);
    disp_matrix_digit_ascii(i,46,1);
    if(sec==0)
    {
        i++;
    }
    if(i>=62)
    {
        i=0;
    }
    /*image[i]=0x01<<j;
    image[i+24]=0x01<<j;
    if(sec%25==0)i++;
    if(i>=24)
    {
        i=0;
        j++;
    }
    if(j>=8)j=0;*/
    //disp_matrix1_text(lib1_8945);
    //disp_matrix_text(lib_7832);
    /*for(temp8=0;temp8<MATRIX_SIZE;temp8++)
    prog[temp8]=temp8%8;
    disp_prog(prog);*/
    /*for(temp8=0;temp8<MATRIX1_SIZE;temp8++)
    prog1[temp8]=(MATRIX1_SIZE-temp8)%8;
    disp1_prog(prog1);  */
    //text_copy2matrix(welcome,1);
    //text_copy2matrix1(welcome,1);
    /*disp_matrix_digit8x4(33-i,0,0);
    disp_matrix_digit8x4(i,46,1);
    if(sec==0)i++;
    if(i>=34)i=0;*/
    /*disp_matrix_digit8x4(1,0,0);
    disp_matrix_digit8x4(2,5,0);
    MATRIX_11=0x14;
    disp_matrix_digit8x4(3,12,0);
    disp_matrix_digit8x4(4,17,0);

    disp_matrix_digit8x4(5,46,1);
    disp_matrix_digit8x4(6,41,1);
    MATRIX1_13=0x14;
    disp_matrix_digit8x4(7,34,1);
    disp_matrix_digit8x4(8,29,1);   */
    //disp_matrix1_text(lib_wait);
    //ImageTime(12,34);
    //SET_COL;
    //ImageCNT(i);
    //if(sec%25==0)i++;
    //if(i>9999)i=0;
#else
    ImageAll(0x00);
    if(all_display_on==0)
    {
        //ImageBlank();
        switch(userstate)
        {
#if 0
        case USER_STATE_IDLE:           //all field '---', icons off
            if(f_disp_total_distance==1)
            {
                total_dist_disp(user_total_distance);
            }
            else if(display_speed_max>0)
            {
                SET_SPEED_P1;
#ifdef KM_MILE
                if(flag_mile==0)
                {
                    ImageSpeed(SPEED_TARGET_MIN);
                }
                else
                {
                    ImageSpeed(SPEED_TARGET_MIN1);
                }
#else
                if(flag_mile==0)
                {
                    ImageSpeed(SPEED_TARGET_MAX);
                }
                else
                {
                    ImageSpeed(SPEED_TARGET_MAX1);
                }
#endif
            }
#if 0
            else
            {
                ImageAll(PATTERN_DASH);
            }
#endif
            if(flag_lub==1)
            {
                TIME_3=0;
                TIME_2=PATTERN_0;//PATTERN_o;
                TIME_1=PATTERN_I;//PATTERN_i;
                TIME_0=PATTERN_L;
            }
            else
            {
                //ImageAll(PATTERN_DASH);
                TIME_3=PATTERN_5;
                TIME_2=PATTERN_A;
                TIME_1=PATTERN_F;
                TIME_0=PATTERN_E;
            }
            break;
#endif
        case USER_STATE_IDLE:
        case USER_STATE_STANDBY:
        case USER_STATE_RUN:
        case USER_STATE_PAUSE:
        case USER_STATE_EOC:
            if(0)//(flag_Gsensor_disconnected==1)//检测到压力传感器未接
            {
                disp_matrix_digit_ascii(62,37,1);//(63,37,1);  //!
                break;
            }
            if(runmode==RUN_MODE_AUTO)
            {
                SET_LED_AUTO;
            }
            if(runmode==RUN_MODE_FIXED)
            {
                SET_LED_FIXED;
            }
            if(runmode==RUN_MODE_LOCK)
            {
                SET_LED_LOCK;
            }
            if(run_state_entry==1)
            {
                display_timeORdistORcalr_cnt=0;
                disp_matrix1_text(lib_start);
                if (run_state_wait_3s<=1)
                {
                    temp8=3;
                }
                else
                {
                    temp8=4-run_state_wait_3s;
                }
#if 0
                disp_matrix_digit8x4(temp8,10,0);
#else
                disp_matrix_digit_ascii(temp8,9,0);
#endif
                break;
            }
            if(has_wifi_flag(FLAG_WIFI_RESTORE))
            {
                disp_matrix1_text(lib_restore);
                break;
            }
            if(0)//测试，显示速度
            {
                if(userstate==USER_STATE_RUN)
                {
                    temp8=user_speed_target;
                }
                else
                {
                    temp8=0;
                }
                if(temp16/100>0)
                {
                    disp_matrix_digit_ascii(temp8/100,5,0);
                }
                disp_matrix_digit_ascii((temp8%100)/10,11,0);
                MATRIX_18=0x01;
                disp_matrix_digit_ascii(temp8%10,19,0);
                break;
            }
            if(display_timeORdistORcalr_cnt<250)
            {
#if 0
                disp_matrix1_text(lib_time);
#else
                disp_matrix_digit_ascii(29,46,1);  //T
                disp_matrix_digit_ascii(18,40,1);  //I
                disp_matrix_digit_ascii(22,34,1);  //M
                disp_matrix_digit_ascii(14,28,1);  //E
#endif
            }
            else if(display_timeORdistORcalr_cnt<500)
            {
#if 0
                disp_matrix1_text(lib_km);
#else
                disp_matrix_digit_ascii(20,40,1);  //K
                disp_matrix_digit_ascii(22,34,1);  //M
#endif
            }
            else
            {
#if 0
                disp_matrix1_text(lib_kcal);
#else
                disp_matrix_digit_ascii(20,46,1);  //K
                disp_matrix_digit_ascii(12,40,1);  //C
                disp_matrix_digit_ascii(10,34,1);  //A
                disp_matrix_digit_ascii(21,28,1);  //L
#endif
            }
            display_timeORdistORcalr_cnt++;
            if(display_timeORdistORcalr_cnt>=750)
            {
                display_timeORdistORcalr_cnt=0;
            }
            if(display_timeORdistORcalr_cnt<250)//TIME
            {
                if(0)//(userstate == USER_STATE_STANDBY)
                {
                    temp8=0;
                    tmp8=0;
                }
                else
                {
                    if(user_time_minute<60)
                    {
                        temp8=user_time_minute;
                        tmp8=user_time_second;
                    }
                    else
                    {
                        temp8=user_time_minute/60;
                        tmp8=user_time_minute%60;
                    }
                }
                if(temp8>99)
                {
                    temp8=99;    //the largest time is 99 minutes
                }
                if(tmp8>59)
                {
                    tmp8=59;
                }
#ifdef LED01
                ImageTime(temp8,tmp8);
                SET_COL;
                if(user_time_minute>=60&&sec>25)
                {
                    CLR_COL;
                }
#endif
#ifdef LED02
#if 0
                if(temp8/10>0)
                {
                    disp_matrix_digit8x4(temp8/10,0,0);
                }
                disp_matrix_digit8x4(temp8%10,5,0);
                MATRIX_11=0x14;
                disp_matrix_digit8x4(tmp8/10,12,0);
                disp_matrix_digit8x4(tmp8%10,17,0);
                if(user_time_minute>=60&&sec>25)
                {
                    MATRIX_11&=0xeb;
                }
#else
                if(temp8/10>0)
                {
                    disp_matrix_digit_ascii_SP(temp8/10);
                }
                disp_matrix_digit_ascii(temp8%10,5,0);
                MATRIX_12=0x14;
                disp_matrix_digit_ascii(tmp8/10,13,0);
                disp_matrix_digit_ascii(tmp8%10,19,0);
                if(user_time_minute>=60&&sec>25)
                {
                    MATRIX_12&=0xeb;
                }
#endif
#endif
            }
            else
            {
                if(0)//(userstate == USER_STATE_STANDBY)
                {
                    temp16=0;
                }
                else
                {
                    if(display_timeORdistORcalr_cnt<500)//DIST
                    {
                        temp16=user_distance;
                        if(temp16>USER_DISTANCE_MAX)
                        {
                            temp16=USER_DISTANCE_MAX;    //the largest is 99.9 km
                        }
#ifdef LED01
                        temp16/=100;
#endif
                    }
                    else //CALR
                    {
                        temp16=user_calories;
#ifdef LED01
                        temp16/=10;
#endif
                    }
                }
#ifdef LED01
                ImageCNT(temp16);
#endif
#ifdef LED02
#if 0
                if(temp16/1000>0)
                {
                    disp_matrix_digit8x4(temp16/1000,0,0);
                }
                if(display_timeORdistORcalr_cnt<500)//DIST
                {
                    if(temp16/1000>0)
                    {
                        temp16=temp16%1000;
                    }
                    disp_matrix_digit8x4(temp16/100,5,0);
                    MATRIX_11=0x01;
                    disp_matrix_digit8x4((temp16%100)/10,12,0);
                    disp_matrix_digit8x4(temp16%10,17,0);
                }
                else//CAL
                {
                    if(temp16/1000>0)
                    {
                        temp16=temp16%1000;
                        disp_matrix_digit8x4(temp16/100,5,0);
                    }
                    else if(temp16/100>0)
                    {
                        disp_matrix_digit8x4(temp16/100,5,0);
                    }
                    disp_matrix_digit8x4((temp16%100)/10,10,0);
                    MATRIX_16=0x01;
                    disp_matrix_digit8x4(temp16%10,17,0);
                }
#else
                if(temp16/1000>0)
                {
                    disp_matrix_digit_ascii_SP(temp16/1000);
                }
                if(display_timeORdistORcalr_cnt<500)//DIST
                {
                    if(temp16/1000>0)
                    {
                        temp16=temp16%1000;
                    }
                    disp_matrix_digit_ascii(temp16/100,5,0);
                    MATRIX_12=0x01;
                    disp_matrix_digit_ascii((temp16%100)/10,13,0);
                    disp_matrix_digit_ascii(temp16%10,19,0);
                }
                else//CAL
                {
                    if(temp16/1000>0)
                    {
                        temp16=temp16%1000;
                        disp_matrix_digit_ascii(temp16/100,5,0);
                    }
                    else if(temp16/100>0)
                    {
                        disp_matrix_digit_ascii(temp16/100,5,0);
                    }
                    disp_matrix_digit_ascii((temp16%100)/10,11,0);
                    MATRIX_18=0x01;
                    disp_matrix_digit_ascii(temp16%10,19,0);
                }
#endif
#endif
            }
            break;
        case USER_STATE_SLEEP:          //no display
            break;
        case USER_STATE_FAULT:          //display error_id in field0, others off
#if 0
            disp_matrix_digit8x4(14,42,1);  //E
            disp_matrix_digit8x4(0,37,1);   //0
            disp_matrix_digit8x4(error_id,32,1);  //
#else
            disp_matrix_digit_ascii(14,43,1);  //E
            disp_matrix_digit_ascii(0,37,1);   //0
            disp_matrix_digit_ascii(error_id,31,1);  //
#endif
            break;
        }  /* switch(userstate) */
    }
    else            //all display on and one beep when power up
    {
        //ONE BEEP
        if (all_display_on_cnt == DISPLAY_ALL_ON_DELAY)
        {
            beep(BEEP_KEY);
        }
#if 0
        disp_matrix1_text(lib_wait);
#else
        disp_matrix_digit_ascii(32,46,1);  //W
        disp_matrix_digit_ascii(10,40,1);  //A
        disp_matrix_digit_ascii(18,34,1);  //I
        disp_matrix_digit_ascii(29,28,1);  //T
#endif
        if(all_display_on_cnt>0)        //set with the all_display_on variable
        {
            all_display_on_cnt--;
        }
        else
        {
            all_display_on=0;
        }
#ifdef LED01
        if((all_display_on_cnt%50)!=0)
        {
            tmp8=1;
        }
        else
        {
            tmp8=0;
        }
        ImageCNT(all_display_on_cnt/50+tmp8);
#endif
#ifdef LED02
        temp8=all_display_on_cnt/10;
        if(temp8==MATRIX_SIZE)
        {
            image[3]|=0X80;
            image[4]|=0X80;
        }
        else
        {
            image[3]|=0X80;
            image[4]|=0X80;
            for(tmp8=0; tmp8<MATRIX_SIZE-temp8; tmp8++)
            {
                image[MATRIX_ADDR+tmp8]|=0X18;
            }
        }
        //for(tmp8=0;tmp8<=i;tmp8++)image[MATRIX_ADDR+tmp8]=0X18;
        //if((all_display_on_cnt%10)==0)i++;
        //if(i>=MATRIX_SIZE)i=MATRIX_SIZE-1;
#endif
    }
#endif
}
#if 0
/*--------------------------------------------------------------------------*
 |
 |  UserTestDisplay
 |  Call periodically in UserOperation() if in consumer mode
 |
 |  Description: To update digit fields and prompts.
 |
 *--------------------------------------------------------------------------*/
void UserTestDisplay(void)
{
#if 0
    //uchar i;
    ImageBlank();
    if(user_test_display_cnt<IMAGE_SIZE)
    {
        image[user_test_display_cnt]=0xff;
        if(sec==0||sec==25)
        {
            user_test_display_cnt++;
        }
    }
    else
    {
        user_test_display_cnt=0;
    }
#endif
#ifndef  TM1320CA
    ImageAll(0x00);
    if(user_test_display_cnt<10)
    {
        //if(error_id==0)
        //{
        SPD_0=
            SPD_1=
                SPD_2=imageDigit[user_test_display_cnt];
        //}
        //else
        //{
        //  SPD_1=PATTERN_E;
        //  SPD_0=imageDigit[error_id];
        //}
        //HR_2=
        HR_1=
            HR_0=imageDigit[user_test_display_cnt];
        CALR_2=
            CALR_1=
                CALR_0=imageDigit[user_test_display_cnt];
        DIST_0=
            DIST_1=
                DIST_2=imageDigit[user_test_display_cnt];
        TIME_0=
            TIME_1=
                TIME_2=
                    TIME_3=imageDigit[user_test_display_cnt];
    }
    else
    {
        ImageAll(0xff);
    }
    if(sec==0||sec==25)
    {
        user_test_display_cnt++;
    }
    if(user_test_display_cnt>11)
    {
        user_test_display_cnt=0;
    }
#endif
}
#endif
/*--------------------------------------------------------------------------*
 |
 | UserConsumerOperation
 |
 | Description: To process operations in consumer mode
 |
 |  Entry:  None
 |  Exit:   None
 *--------------------------------------------------------------------------*/
 
 @near uchar flag_module_2_mobile_old, runmode_old, autorun_delay_sec;
 
void UserConsumerOperation(void)
{
    uint temp16,tempi;
#ifdef BLUETOOTH
    if(flag_module_2_mobile==1)
    {
        if(flag_module_2_mobile_old==0)
        {
            beep(BEEP_SAFETY_OFF);
        }
        //if(user_steps==0&&userstate==USER_STATE_RUN)
        //{
        //   user_calories=0;
        //   user_distance=0;
        //}
        if(userstate==USER_STATE_SLEEP)
        {
            userstate=USER_STATE_STANDBY;
            userprogram = USER_PROGRAM_NONE;
            usermode = USER_MODE_NONE;
        }
        standby_to_sleep_cnt=0;
        idle_to_sleep_cnt=0;
    }
    else
    {
        if(flag_module_2_mobile_old==1)
        {
            beep(BEEP_KEY);
        }
    }
    flag_module_2_mobile_old=flag_module_2_mobile;
#endif
    if(userstate==USER_STATE_SLEEP)
    {
        if(tension_bias>200&&tension2_bias>200)
        {
            beep(BEEP_KEY);
            standby_to_sleep_cnt=0;
            idle_to_sleep_cnt=0;
            userstate=USER_STATE_STANDBY;
            userprogram = USER_PROGRAM_NONE;
            usermode = USER_MODE_NONE;
        }
    }
    if(runmode!=runmode_old)eeprom_write();
    runmode_old=runmode;
    switch(userstate)
    {
    case USER_STATE_IDLE:
#ifdef  SLEEP_MODE
        if (idle_to_sleep_cnt>=TO_SLEEP_CNT_MAX)
        {
            userstate=USER_STATE_SLEEP;
            idle_to_sleep_cnt=0;
        }
        else if (sec==0)
        {
            idle_to_sleep_cnt++;
        }
        standby_to_sleep_cnt=0;
#endif
        userprogram = USER_PROGRAM_NONE;
        usermode = USER_MODE_NONE;
        f_fat_func=0;
        fat_step=0;
#ifdef NO_SP_SEN
        f_para_set=0;
        para_step=0;
#endif
        break;
    case USER_STATE_STANDBY:
        eoc_state_cnt=0;
        fault_state_cnt=0;
        run_state_wait_3s=0;
        run_state_entry=0;
        //pause_to_standby_cnt=0;
#if 0//停机保留跑步数据	        
        user_distance=0;
        user_time_minute=0;
        user_time_second=0;
        user_calories=0;
#endif
        user_program_time=0;
        user_program_seg=0;
        user_program_seg_last=0;
        //user_program_seg_update=0;
        //user_program_seg_update_cnt=0;
        run_state_wait_sec=0;
        stepdown_flag=STEPDOWN_NONE;
        user_speed_target_pause=0;
        autorun_delay_sec=0;
#ifdef NO_SP_SEN
        f_para_set=0;
        para_step=0;
#endif
#ifdef BLUETOOTH
        current_program_seg=0;
        first=0;
#endif
#ifdef BLUETOOTH
        if (userprogram == USER_PROGRAM_NONE && usermode == USER_MODE_NONE&&flag_program==0)
#else
        if (userprogram == USER_PROGRAM_NONE && usermode == USER_MODE_NONE)
#endif
        {
            user_time_setting=0;
            user_distance_setting=0;
            user_calories_setting=0;
            if(flag_mile==0)
            {
                user_speed_target=SPEED_TARGET_MIN;
            }
            else
            {
                user_speed_target=SPEED_TARGET_MIN1;
            }
            user_gradient_target=0;
            //user_program_mode_cancel_delay=0;
            f_fat_func=0;
            fat_step=0;
            //flag_dist_setting=1;
            //flag_cal_setting=0;
        }
        //if (user_speed_target==0)user_speed_target=SPEED_INITIAL_VALUE;           //initial speed 0.8km/h
#ifdef SLEEP_MODE
        if (standby_to_sleep_cnt>=TO_SLEEP_CNT_MAX)
        {
            userstate=USER_STATE_SLEEP;
            standby_to_sleep_cnt=0;
        }
        //no sleep mode for OMA control
        else if (sec==0)
        {
            standby_to_sleep_cnt++;
        }
        idle_to_sleep_cnt=0;
#endif
        if((tension_bias>1000)&&all_display_on==0&&flag_Gsensor_disconnected==0&&runmode!=RUN_MODE_LOCK)
        {
            beep(BEEP_KEY);
            standby_to_sleep_cnt=0;
            idle_to_sleep_cnt=0;
            autorun_delay_sec=0;
            userstate=USER_STATE_RUN;
            run_state_entry=1;
            //run_state_wait_3s=4;
            if(runmode==RUN_MODE_FIXED)user_speed_target=fixed_mode_speed;
        }
        break;
#ifdef SLEEP_MODE
    case USER_STATE_SLEEP:
        standby_to_sleep_cnt=0;
        //pause_to_standby_cnt=0;
        idle_to_sleep_cnt=0;
        break;
#endif
    case USER_STATE_RUN:
        //in entry, wait 3s to send start command to power board
        if (run_state_entry==1)
        {
#if 1//停机保留数据，开机清除
				if(1)
				{
					user_distance=0;
					user_time_minute=0;
					user_time_second=0;
					user_calories=0;      
				}
#endif        	
            if (run_state_wait_3s >= 4)
            {
                run_state_wait_3s=0;
                run_state_entry=0;
                user_request=USER_REQUEST_START;
            }
            if (run_state_wait_sec==0)          //for 3 s counting, more accurately
            {
                run_state_wait_3s++;
                if (run_state_wait_3s==2||run_state_wait_3s==3||run_state_wait_3s==4)   // ||run_state_wait_3s==5||run_state_wait_3s==6)
                {
                    beep(BEEP_KEY);
                }
            }
            if(run_state_wait_sec>=TIME_BASE_SEC)
            {
                run_state_wait_sec=0;
            }
            else
            {
                run_state_wait_sec++;
            }
        }
//user_speed_target=SPEED_TARGET_MAX;//TEST
        //step down when pause or stop key press
        if (stepdown_flag==STEPDOWN_PAUSE||stepdown_flag==STEPDOWN_STOP)
        {
            if (stepdown_cnt>=6)
            {
                stepdown_cnt=0;
                if (user_speed_target>SPEED_TARGET_STEPDOWN&&run_state_entry==0)
                {
                    user_speed_target--;
                    user_request|=USER_REQUEST_NEW_SPEED;
                }
                else
                {
                    total_dist_write();
                    if(stepdown_flag==STEPDOWN_PAUSE)
                    {
                        userstate=USER_STATE_PAUSE;
                        user_steps_pause=user_steps_total;
                    }
                    else
                    {
                        userstate=USER_STATE_STANDBY;
                        userprogram=USER_PROGRAM_NONE;
                        usermode=USER_MODE_NONE;
                        //user_time_setting=0;
                        //user_calories_setting=0;
                        //user_distance_setting=0;
#ifdef BLUETOOTH
                        flag_mode_steps=0;
                        flag_program=0;
                        flag_match=0;
                        flag_btm_hrc=0;
                        flag_mode_time=0;
                        flag_mode_dist=0;
                        flag_mode_cal=0;
#endif
                    }
                    user_request=USER_REQUEST_STOP;
                    stepdown_flag=STEPDOWN_NONE;
                }
            }
            else
            {
                stepdown_cnt++;
            }
        }
        else if(runmode==RUN_MODE_AUTO&&run_state_entry==0)
        {
						run_auto();
        }
        else if(runmode==RUN_MODE_FIXED&&run_state_entry==0)
        {
           /* if(tension<tension_ini+2000||tension2<tension2_ini+2000||flag_Gsensor_disconnected==1)   
            {
            	 fixed_mode_speed=user_speed_target;
                beep(BEEP_KEY);
                stepdown_flag=STEPDOWN_STOP;
                user_speed_target=machine_speed_target;            	
            }     */	
            run_fixed();
        }
		  else if(runmode==RUN_MODE_LOCK&&run_state_entry==0)
		  {
				//锁止模式停机，并禁止开机
				beep(BEEP_KEY);
         	stepdown_flag=STEPDOWN_STOP;				//not stop at once, step down
         	user_speed_target=machine_speed_target;		//step down from machine speed
         	stepdown_cnt=6;				
		  }	        
        else if (userprogram!=USER_PROGRAM_NONE)
        {
            //time for 1 seg
            temp16 = user_time_setting*60/PROGRAM_DIV;          //in second
            //run time in second
            user_program_time = user_time_minute*60 + user_time_second;
            //buzz bi 2 time before update
#if 0
            if(sec==0&&user_program_seg_last<19)
            {
                tempi=(user_program_time+2)/temp16;
                if(tempi!=user_program_seg_last)
                {
                    beep(BEEP_KEY);
                }
                tempi=(user_program_time+1)/temp16;
                if(tempi!=user_program_seg_last)
                {
                    beep(BEEP_KEY);
                }
            }
#endif
            //the current seg
            user_program_seg = user_program_time/temp16;
#ifdef BLUETOOTH
            if(flag_module_2_mobile==1)
            {
                current_program_seg=user_program_seg;
            }
#endif
            //update when go to new seg
            if (user_program_seg_last != user_program_seg)
            {
                if(flag_mile==0)
                {
                    user_speed_target = program_table[userprogram-1][user_program_seg];
                }
                else
                {
                    user_speed_target = program_table2[userprogram-1][user_program_seg];
                }
#ifdef TM1320CA
                user_gradient_target = incl_table[userprogram-1][user_program_seg];
#endif
                //user_program_seg_update = 1;      //display the seg in SPEED LCD when update
                //set here and reset in display
                user_request |= USER_REQUEST_NEW_SPEED;
#ifdef TM1320CA
                user_request |= USER_REQUEST_NEW_GRADIENT;
#endif
                beep(BEEP_KEY);
            }
            user_program_seg_last = user_program_seg;
        }
#ifdef BLUETOOTH
        else if(flag_program==1)//&&flag_module_2_mobile==1)//
        {
            //time for 1 seg
            temp16 = user_time_setting*60/program_div;          //in second
            //temp16 +=1;
            //run time in second
            user_program_time = user_time_minute*60 + user_time_second;
            //the current seg
            user_program_seg = user_program_time/temp16;
            current_program_seg=user_program_seg;
            if(user_program_seg==0&&first==0)
            {
                first=1;
                user_speed_target = program_speed1[user_program_seg];
                user_gradient_target = program_incl[user_program_seg];
                if(user_speed_target<SPEED_TARGET_MIN)
                {
                    user_speed_target =SPEED_TARGET_MIN;
                }
                user_request |= USER_REQUEST_NEW_SPEED;
                user_request |= USER_REQUEST_NEW_GRADIENT;
            }
            //update when go to new seg
            if (user_program_seg_last != user_program_seg)
            {
                first=0;
                user_speed_target = program_speed1[user_program_seg];
                user_gradient_target = program_incl[user_program_seg];
                if(user_speed_target<SPEED_TARGET_MIN)
                {
                    user_speed_target =SPEED_TARGET_MIN;
                }
                user_request |= USER_REQUEST_NEW_SPEED;
                user_request |= USER_REQUEST_NEW_GRADIENT;
                beep(BEEP_KEY);
            }
            user_program_seg_last = user_program_seg;
        }
#endif
        break;
#ifdef ZT
    case USER_STATE_PAUSE:
#if 0
        if(pause_to_standby_cnt>TO_STANDBY_CNT_MAX)
        {
            userstate=USER_STATE_STANDBY;
            userprogram = USER_PROGRAM_NONE;
            usermode = USER_MODE_NONE;
            pause_to_standby_cnt=0;
        }
        else if (sec==0)
        {
            pause_to_standby_cnt++;
        }
#endif
#ifdef  SLEEP_MODE
        if (idle_to_sleep_cnt>=TO_SLEEP_CNT_MAX)
        {
            userstate=USER_STATE_SLEEP;
            idle_to_sleep_cnt=0;
        }
        else if (sec==0)
        {
            idle_to_sleep_cnt++;
        }
        standby_to_sleep_cnt=0;
#endif
        run_state_entry=0;
        run_state_wait_3s=0;
        run_state_wait_sec=0;
        break;
#endif
    case USER_STATE_EOC:
        //only stay about 50 second and then go to standby state
        if (eoc_state_cnt>EOC_STATE_CNT_MAX)
        {
            total_dist_write();
            userstate = USER_STATE_STANDBY;
            userprogram = USER_PROGRAM_NONE;
            usermode = USER_MODE_NONE;
            eoc_state_cnt=0;
#ifdef BLUETOOTH
            flag_mode_steps=0;
            flag_program=0;
            flag_match=0;
            flag_btm_hrc=0;
            flag_mode_time=0;
            flag_mode_dist=0;
            flag_mode_cal=0;
#endif
        }
        else
        {
            if(sec==0)
            {
                eoc_state_cnt++;
            }
            if (stepdown_cnt>=6)
            {
                stepdown_cnt=0;
                if (user_speed_target>SPEED_TARGET_MIN&&run_state_entry==0)
                {
                    user_speed_target--;
                    user_request|=USER_REQUEST_NEW_SPEED;
                }
                else
                {
                    if(eoc_state_cnt<EOC_STATE_CNT_FLASH_BEEP)
                    {
                        eoc_state_cnt=EOC_STATE_CNT_FLASH_BEEP;
                    }
                    user_request=USER_REQUEST_STOP;
                }
            }
            else
            {
                stepdown_cnt++;
            }
            if(user_speed_target<=SPEED_TARGET_MIN&&sec==0)
            {
                if (eoc_state_cnt>EOC_STATE_CNT_FLASH_BEEP)
                {
                    beep(BEEP_KEY);
                }
            }
        }
        break;
    case USER_STATE_FAULT:
        //only stay about 9 second and then go to standby state
        if (fault_state_cnt>FAULT_STATE_CNT_MAX||error_id==0)
        {
            userstate = USER_STATE_STANDBY;
            userprogram = USER_PROGRAM_NONE;
            usermode = USER_MODE_NONE;
            user_request=USER_REQUEST_ERROR_RESET;
            fault_state_cnt=0;
            error_code=0;           //reset all fault
            error_id=0;
            beep(BEEP_NONE);
        }
        else if (sec==0)
        {
            fault_state_cnt++;
        }
        break;
    }  /* switch(userstate) */
    //check if user and machine state match
    //for saftety
#if 1
    if (userstate==USER_STATE_RUN)
    {
        user_state=USER_STATE_RUN;
    }
    else if (userstate==USER_STATE_EOC&&eoc_state_cnt<EOC_STATE_CNT_FLASH_BEEP)
    {
        user_state=USER_STATE_RUN;
    }
    else
    {
        user_state=USER_STATE_STANDBY;
    }
    if (pcerr_com==0&&(user_state!=USER_STATE_RUN)&&machine_state==MACHINE_STATE_RUN)
    {
        if (user_machine_state_cnt>3)
        {
            user_machine_state_cnt=0;
            user_request=USER_REQUEST_STOP;     //when no match, request send stop command
        }
        else if (sec==0)
        {
            user_machine_state_cnt++;
        }
    }
    else
    {
        user_machine_state_cnt=0;
    }
    //user run, machine stop. stop user side
    if (pcerr_com==0&&user_state==USER_STATE_RUN&&machine_state==MACHINE_STATE_IDLE)
    {
        if (user_machine_state_cnt1>10)
        {
            user_machine_state_cnt1=0;
            user_request=USER_REQUEST_STOP;     //when no match, request send stop command
            userstate=USER_STATE_STANDBY;
        }
        else if (sec==0)
        {
            user_machine_state_cnt1++;
        }
    }
    else
    {
        user_machine_state_cnt1=0;
    }
    //when speed change, set the flag for distance_calculation()
    if((user_request&USER_REQUEST_NEW_SPEED) && userstate == USER_STATE_RUN && run_state_entry==0)
    {
        flag_speed_change=1;
    }
#endif
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
#if  0
    if (pcerr_com==1)
    {
        error_code=ERROR_COMMUNICATION;
    }
    if (error_code&ERROR_SPEED_SENSOR)
    {
        error_id=3;
    }
    else if (error_code&ERROR_DCMOTOR_CURRENT)
    {
        error_id=5;
    }
    else if (error_code&ERROR_MOSFET)
    {
        error_id=2;
    }
    else if (error_code&ERROR_DCMOTOR_ALARM)
    {
        error_id=5;
    }
    else if (error_code&ERROR_LIFTMOTOR_SENSOR)
    {
        error_id=4;
    }
    else if (error_code&ERROR_LIFTMOTOR_SELF)
    {
        error_id=4;
    }
    else if (error_code&ERROR_MOTOR_DISCONNECT)
    {
        error_id=6;
    }
    else if (error_code&ERROR_COMMUNICATION)
    {
        error_id=1;
    }
    else
    {
        error_id=0;
    }
    //when error, beep
    if(error_id_last==0&&error_id!=0)
    {
        beep(BEEP_ERROR);
    }
    error_id_last = error_id;
    if(error_id!=0)
    {
        if(userstate!=USER_STATE_IDLE)
        {
            userstate=USER_STATE_FAULT;
        }
        else            //clear error in idle state
        {
            user_request=USER_REQUEST_ERROR_RESET;
            error_code=0;         //reset all fault
            error_id=0;
        }
    }
#endif
}

/*--------------------------------------------------------------------------*
 |
 |  useroperation
 |  Call periodically in main loop
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
#ifdef HX711_WIM
@near uchar read_hx711_delay;
#endif
void useroperation(void)
{
    hr_calculation();
    switch(boardmode)
    {
    case BOARD_MODE_CONSUMER:
        time_calculation();
        distance_calculation();
        calories_calculation();
#ifdef HX711_WIM
        read_hx711_delay++;
        if(read_hx711_delay>5)
        {
            read_hx711_delay=0;
            HX711_Weight();
        }
#endif
        UserConsumerKeys();
        speed_rpm_convert();
        UserConsumerDisplay();   /* update display */
        UserConsumerOperation();
        break;
    case BOARD_MODE_TEST:
        //UserTestKeys();
        //UserTestDisplay();
        break;
    default:
        boardmode = BOARD_MODE_CONSUMER;
    }
    //image function, call periodically
#if 0
    if (image_process_cnt>=IMAGE_PROCESS_CNT_MAX)    //100ms
    {
        ImageProcess();
        image_process_cnt=0;
    }
    else
    {
        image_process_cnt++;
    }
    ImageOperation();
#endif                                      //20ms
    DisplayDriverProcessLED1();
    DisplayDriverProcessLED2();                                  //20ms
}
