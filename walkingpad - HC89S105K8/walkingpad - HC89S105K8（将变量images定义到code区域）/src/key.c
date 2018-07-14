/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *  Copyright (c) 2008 by MKS Controls
 *
 *
 *  File name: key.c
 *  Module:    Application module
 *  Language:  ANSI C
 *  $Revision: 1 $
 *
 *  GENERAL DESCRIPTION
 *  This is a software object for functions to detect keys input
 *
 *  CONSTRAINTS
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#include "declare.h"
#include "key.h"
//test ram data

uint key_id;               //key ID
bool key_id_done;      //indicate the key has been processed. reset when key released

static uint key_input, key_input_last;
/*****************************************************************************************/
void key_scan(void)
{
    uchar i;
    static uint key_press_timer;
    static uchar key_relse_timer;
    
    static bool key_start_stop;

    if (key_id != KEY_NONE && key_id_done == 0) return;
    key_input_last = key_input;
    key_input = 0;
    //set KI as input before key scanning
    P3M0 &= 0x0f;  
    for(i=100;i>0;i--);
    if (K5 == 0)
    {
        key_input = KEY_MODE_PRESS_BTN;
    }
    P3M0 |= 0x80;

    if (key_input > 0 && key_input_last == key_input)
    {
        key_press_timer++;
        key_relse_timer = 0;
        if (key_press_timer >= 6) //3)
        {
            //key_press_timer=100;
            //key_id=key_input;
            if (key_input != KEY_MODE_PRESS_BTN)
            {
                key_id = key_input;
            }
            else
            {
                if (key_press_timer > 450) //3s
                {
                    key_id = KEY_MODE_LONG_PRESS_BTN;
                    key_press_timer = 0;
                    key_start_stop = 0;
                }
                else
                {
                    key_start_stop = 1;
                }
            }
        }
    }
    else if (key_input == 0)
    {
        if (key_start_stop == 1)
        {
            key_id = KEY_MODE_PRESS_BTN;
            key_start_stop = 0;
        }
        else
        {
            key_press_timer = 0;
            key_relse_timer++;
            if (key_relse_timer > 19) //6)//3
            {
                key_relse_timer = 100;
                key_id_done = 0;
                key_id = KEY_NONE;
            }
        }
    }
}

int rcCheck(void);
void check_key_id(void)
{
    #if 0
    static uint rc_key_id;
    if ((rc_key_id = rcCheck()) != KEY_NONE)
    {
        //key_id_done = 0;
        if (key_id == KEY_NONE) 
        {
            key_id = rc_key_id;
            key_id_done = 0;
        } 
        else if (key_id == KEY_MODE_LONG_PRESS_BTN) 
        {
            if (rc_key_id == KEY_MODE_STOP_PRESS) 
            {
                key_id = KEY_MODE_STOP_LONG_PRESS_BTN;
                key_id_done = 0;
            } 
        }
    }

    #else
    if (key_id == KEY_NONE && key_input == 0)                   
    {                                         
        if ((key_id = rcCheck()) != KEY_NONE) 
            key_id_done = 0;                  
    } 
    else // if (key_id == KEY_MODE_LONG_PRESS_BTN || key_id == KEY_MODE_PRESS_BTN) 
    {
        if (rcCheck() == KEY_STOP_LONG_PRESS) 
        {
            key_id_done = 0;
            key_id = KEY_MODE_STOP_LONG_PRESS_BTN;
        }
    }
    #endif
}