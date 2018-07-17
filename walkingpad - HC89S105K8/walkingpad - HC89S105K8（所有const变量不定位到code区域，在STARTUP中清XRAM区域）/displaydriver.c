/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *  Copyright (c) 2008 by MKS Controls
 *
 *
 *  File name: displaydriver.c
 *  Module:    Application module
 *  Language:  ANSI C
 *  $Revision: 1 $
 *
 *  Source code for DisplayDriver module descibed in DisplayDriver.h
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#ifndef DISPLAYDRIVER_C
#define DISPLAYDRIVER_C
#include "declare.h"
#include "image.h"
#include "displaydriver.h"

/*------------------*
 | Public Functions
 *------------------*/
// static void LED_Delay(uint delay)
// {
//     while (delay)
//     {
//         delay--;
//     }
// }
void LED_Send_Command_Bit(uchar dat, uchar n)
{
    uchar i;
    for (i = 0; i < n; i++)
    {
        LED_CLOCK = 0;
        if (dat & 0x80)
        {
             LED_DATA = 1;
        }
        else
        {
             LED_DATA = 0;
        }
        dat <<= 1;
        //LED_Delay(5);
        LED_CLOCK = 1;
    }
}

void LED_Send_Data_Bit(uchar dat)
{
    uchar i;
    for (i = 0; i < 8; i++)
    {
        LED_CLOCK = 0;
        if (dat & 0x01)
        {
             LED_DATA = 1;
        }
        else
        {
             LED_DATA = 0;
        }
        dat >>= 1;
        //LED_Delay(5);
        LED_CLOCK = 1;
    }
}

void LED_Write_Command(uchar command)
{
    LED_CLOCK = 1;
    //  LED_CS2 = 1;
    //LED_Delay(5);
    LED_CS2 = 0;
    //LED_Delay(5);
    LED_Send_Command_Bit(0x80, 3);
    LED_Send_Command_Bit(command, 9);
    //LED_Delay(5);
    LED_CS2 = 1;
}

void DisplayDriverProcessLED(void)
{
    //refresh all LCD_RAM
    schar i;
    uchar c;
    uchar* const image_up = images[LED_UP];
    uchar* const image_down = images[LED_DOWN];
    //DisplayDriverInitializeLED2();
    //  LED_CS2 = 1;
    //LED_Delay(5);
    LED_CS2 = 0;
    //LED_Delay(5);
    LED_Send_Command_Bit(0xA0, 3);
    LED_Send_Command_Bit(0, 7);

    c = image_down[0];
    for (i = 0; c > 0 && i < 7; i++)
    {
        if (c&0x01)
            image_down[LED_DOWN_SIZE - 1 - i] |= 0x80;
        c >>= 1;
    }
    for (i = LED_UP_SIZE - 1; i >= 0; i--)
    {
        LED_Send_Data_Bit(image_up[i]);
        LED_Send_Data_Bit(image_down[i + 2]);
    }
    LED_Send_Data_Bit(0);
    LED_Send_Data_Bit(image_down[1]);

    //LED_Delay(5);
    LED_CS2 = 1;
}
void DisplayDriverInitializeLED(void)
{
    //uchar i;
    LED_CS2 = 1;
    LED_Write_Command(LED_SYS_DIS);
    //LED_Delay(1000);
    LED_Write_Command(LED_COM_OPTION);
    //LED_Delay(1000);
    LED_Write_Command(LED_RC_MASTER_MODE);
    //LED_Delay(1000);
    LED_Write_Command(LED_SYS_EN);
//LED_Delay(1000);
#if 1//def DEBUG
    LED_Write_Command(LED_PWM_DUTY + PWM_DUTY_1);
#else
    LED_Write_Command(LED_PWM_DUTY + PWM_DUTY_16);
#endif
    //LED_Delay(1000);
    LED_Write_Command(LED_BLINK_OFF);
    //LED_Delay(1000);
    LED_Write_Command(LED_ON);
    //LED_Delay(1000);
}

#endif
