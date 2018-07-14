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

/*****************************************************************************************/
void key_scan(void)
{
    static uint key_press_timer;
    static uchar key_relse_timer;
    static uint key_input, key_input_last;
    static bool key_start_stop;

    if (key_id != KEY_NONE && key_id_done == 0) return;
    key_input_last = key_input;
    key_input = 0;
    //set KI as input before key scanning
    // KO1 = 1;
    // KO2 = 1;
    // KO3 = 1;
    // KO4 = 1;
    // K1_DDR = 1;
    // K2_DDR = 1;
    // K3_DDR = 1;
    // K4_DDR = 1;
    K5_DDR = 0;
    if (KI5 == 0)
    {
        key_input = KEY_MODE_PRESS_BTN;
    }
    //K5_DDR = 1;
    //  KO5 = 1;
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
    if (key_id == KEY_NONE)                   
    {                                         
        if ((key_id = rcCheck()) != KEY_NONE) 
            key_id_done = 0;                  
    }
}