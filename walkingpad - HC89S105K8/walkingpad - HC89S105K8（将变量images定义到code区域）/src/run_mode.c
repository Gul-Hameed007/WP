#include "run_mode.h"
#include "declare.h"
#include "sensor.h"
#include "beep.h"
#include "eeprom.h"

#define QSIZE 10
#define THRESHOLD_H 8000000
#define THRESHOLD_L  160000
#define INC_STEP 20
#define SPEED_STEP 10
#define FIXED_SPEED_STEP 5
#define FIXED_SPEED_INTERVAL 10

 uchar stop_dly_cnt;

 uchar autorun_delay_sec;


 ulong bias_arr[QSIZE] = {0};
 uchar bias_idx = 0;
 uchar bias_arr_is_full = 0;
 uchar user_speed_inc = 0;
 ulong bias;


run_mode_t runmode;


//step down when pause or stop
//only send stop request to power board to stop the machine at once when pull safty switch down
 stepdown_t stepdown_flag;
 uchar stepdown_cnt; //count for speed decrease, in 20ms

 euchar no_current_cnt;

void run_auto(void)
{
    uchar i;
    uchar high_count = 0;
    uchar low_count = 0;
    //uchar cnt;
		
    if (flag_Gsensor_disconnected == 0)
    {
        autorun_delay_sec++;
        if (tension_bias < 0) tension_bias = 0;
        if (tension2_bias < 0) tension2_bias = 0;
        bias = (tension_bias * tension_bias 
                + tension2_bias * tension2_bias) / 4 ;
        bias_arr[bias_idx++] = bias;
        if (bias_idx == QSIZE) 
        {
            if (bias_arr_is_full == 0) bias_arr_is_full = 1;
            bias_idx = 0;
        }
        
        if (bias_arr_is_full == 0) return;
        
        high_count = 0;
        low_count = 0;
        for (i = bias_idx; i < bias_idx + QSIZE; ++i) 
        {
            high_count += (bias_arr[i % QSIZE] >= THRESHOLD_H);
            low_count += (bias_arr[i % QSIZE] <= THRESHOLD_L);
			
            //cnt = (bias_arr[i % QSIZE] * 1.0 / THRESHOLD_H) / (i + 1 - bias_idx);
            //if (cnt < 1) cnt = 0;
            //high_count += cnt;
						
            //cnt = THRESHOLD_L * 1.0 / (bias_arr[i % QSIZE] + 1.0) / (i + 1 - bias_idx);
            //if (cnt > QSIZE) cnt = QSIZE;
            //low_count += cnt;
        }	
			
        if (high_count >=  QSIZE / 2 - 1 || machine_speed_target == 0) 
        //if (high_count >= QSIZE * 2)
        {
        //if (autorun_delay_sec >= 1)//1
        //{
            autorun_delay_sec = 0;
            {
                //beep(BEEP_KEY);
                user_speed_inc += high_count - low_count;
                if (user_speed_inc > INC_STEP && low_count <= 1) 
                {
                    //if (user_speed_target < 90) 
                    //{
                    //    user_speed_target = 90;
                    //} 
                    //else 
                    {
                        //user_speed_target++;
                        user_speed_target = machine_speed_target + SPEED_STEP;
                        if (user_speed_target > SPEED_TARGET_MAX)
                        {
                            user_speed_target = SPEED_TARGET_MAX;
                        }
                    }
                    user_speed_inc = 0;
                    user_request |= USER_REQUEST_NEW_SPEED;
                }
                //user_request |= USER_REQUEST_NEW_SPEED;
            }
            //}
        }
        else if (low_count >= QSIZE / 2 - 1 && machine_speed_target > 0) 
        //else if (low_count >= QSIZE * 2)
        {
            //if(autorun_delay_sec >= 1)//1
            //{
            autorun_delay_sec = 0;
            if (machine_speed_target >= SPEED_TARGET_MIN1)
            {
                stop_dly_cnt = 0;
                    //beep(BEEP_KEY);
                user_speed_inc += low_count - high_count;
                if (user_speed_inc > INC_STEP / 2 && high_count <= 1) 
                {
                    //if (user_speed_target > 90) 
                    //{
                    //    user_speed_target = 90;
                    //}
                    //else
                    {
                        //user_speed_target--;
                        if (machine_speed_target > SPEED_STEP * 1.5) 
                        {
                            user_speed_target = machine_speed_target - SPEED_STEP * 1.5;
                            //user_request |= USER_REQUEST_NEW_SPEED;
                        }
                        else
                        {
                            user_speed_target = SPEED_TARGET_MIN1 - 1;
                        }
                        user_request |= USER_REQUEST_NEW_SPEED;
                    }
                    //user_request |= USER_REQUEST_NEW_SPEED;
                    user_speed_inc = 0;
                }
            }
            else
            {
                stop_dly_cnt++;
                if (high_count <= 1)
                {
                    beep(BEEP_KEY_INVALID);
                    user_speed_inc = 0;
                    stepdown_flag = STEPDOWN_PAUSE;
                    user_speed_target = machine_speed_target;
                }                           
            }
            //}
        }
        else
        {
            autorun_delay_sec = 0;
            user_speed_inc = 0;
        }
    }
    else //if(stepdown_flag==STEPDOWN_NONE)
    {
        beep(BEEP_ERROR);
        autorun_delay_sec = 0;
        stepdown_flag = STEPDOWN_STOP;
        user_speed_target = machine_speed_target;
        user_speed_inc = 0;
    }			
}

void run_fixed(void)
{
    bias = (tension_bias * tension_bias + tension2_bias * tension2_bias) / 4;
    if(flag_Gsensor_disconnected == 0)
    {
        autorun_delay_sec++;
        #if 0
        if (0 && bias < 90000) // 300 * 300
        {
            if(autorun_delay_sec >= 250)//1
            {
                autorun_delay_sec = 0;
                if(0)//user_speed_target>SPEED_TARGET_MIN)
                {
                    beep(BEEP_KEY);
                    user_speed_target--;
                    user_request |= USER_REQUEST_NEW_SPEED;
                }
                else
                {
                    beep(BEEP_KEY);
                    stepdown_flag = STEPDOWN_PAUSE;
                    user_speed_target = machine_speed_target;
                }
            }
        }
        else
        #endif
        {
			//fixed_mode_speed = 180;
            if (fixed_mode_speed > machine_speed_target) 
            {
                user_speed_inc ++;
                if (user_speed_inc >= FIXED_SPEED_INTERVAL) 
                {
                    user_speed_inc = 0;
                    if (fixed_mode_speed >= machine_speed_target + FIXED_SPEED_STEP) 
                    {
                        user_speed_target = machine_speed_target + FIXED_SPEED_STEP;
                    }
                    else
                    {
                        user_speed_target = fixed_mode_speed;
                    }
                    user_request |= USER_REQUEST_NEW_SPEED;
                } 
            } 
            else if (fixed_mode_speed < machine_speed_target)
            {
                user_speed_inc ++;
                if (user_speed_inc >= FIXED_SPEED_INTERVAL)
                {
                    user_speed_inc = 0;
                    if (fixed_mode_speed + FIXED_SPEED_STEP <= machine_speed_target)
                    {
                        user_speed_target = machine_speed_target - FIXED_SPEED_STEP;
                    }
                    else
                    {
                        user_speed_target = fixed_mode_speed;
                    }
                    user_request |= USER_REQUEST_NEW_SPEED;
                }
            }
                
            autorun_delay_sec = 0;
        }
    }
    else //if(stepdown_flag==STEPDOWN_NONE)
    {
        beep(BEEP_KEY);
        autorun_delay_sec = 0;
        stepdown_flag = STEPDOWN_STOP;
        user_speed_target = machine_speed_target;
    }
}

 tutorial_state_t tutorial_state;

void run_new(void)
{
    switch (tutorial_state)
    {
    case TUTORIAL_BEGIN:
        speed_limit_max = 120;
        acceleration_param = 2;
        tutorial_state = TUTORIAL_STOP_FIRST;
        break;
    case TUTORIAL_STOP_FIRST:
        fixed_mode_speed = 0;
        stepdown_flag = STEPDOWN_STOP;
        break;
    case TUTORIAL_STEP1_BEGIN:
        if (fixed_mode_speed != 90)
        {
            fixed_mode_speed = 90;
        }
        run_fixed();
        break;
    case TUTORIAL_STEP2_BEGIN:
        fixed_mode_speed = 120;
        run_fixed();
        break;
    case TUTORIAL_STEP2_END:
        tutorial_state = TUTORIAL_STOP_FIRST;
        break;
    case TUTORIAL_STEP3_BEGIN:
    case TUTORIAL_STEP3_END:
        if (fixed_mode_speed != 120)
        {
            fixed_mode_speed = 120;
            user_speed_target = SPEED_TARGET_MIN1;
            speed_limit_max = 120;
        }
        run_auto();
        break;
    case TUTORIAL_FINISH:
        tutorial_finish = TUTORIAL_FINISH_TAG;
        eeprom_wrchar(EEPROM_ADDR_TUTORIAL_FINISH, tutorial_finish);
        runmode = RUN_MODE_AUTO;
        break;
    }
}

void run_stepdown(void)
{
    if (machine_speed_target > SPEED_TARGET_MIN1)
    {
        if (stepdown_cnt >= 3)
        {
            if (user_speed_target > SPEED_TARGET_MIN1)
            {
                if (runmode == RUN_MODE_AUTO)
                {
                    user_speed_target -= 4;
                }
                else
                {
                    user_speed_target -= 2;
                }
                user_request |= USER_REQUEST_NEW_SPEED;
            }
            stepdown_cnt = 0;
        }
        else
        {
            stepdown_cnt++;
        }
    }
    else
    {
        if (stepdown_cnt >= 10)
        {
            user_request = USER_REQUEST_STOP;
        }
        else
        {
            stepdown_cnt++;
        }
    }
}

void run(void)
{
    if (stepdown_flag == STEPDOWN_PAUSE || stepdown_flag == STEPDOWN_STOP)
    {
        run_stepdown();
    }
    else if (runmode == RUN_MODE_AUTO)
    {
        run_auto();
    }
    else if (runmode == RUN_MODE_FIXED)
    {
        run_fixed();
    }
    else if (runmode == RUN_MODE_STANDBY)
    {
        beep(BEEP_KEY);
        stepdown_flag = STEPDOWN_STOP;            //not stop at once, step down
        user_speed_target = machine_speed_target; //step down from machine speed
        stepdown_cnt = 6;
    }
    else if (runmode == RUN_MODE_NEW)
    {
        run_new();
    }
    else if (runmode == RUN_MODE_CHECK)
    {
        run_fixed();
    }
}
