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
 *  DEFINITION
 *  Hearder file for a display driver module.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#ifndef DISPLAYDRIVER_H
#define DISPLAYDRIVER_H
#define LED_CMD                 (unsigned char)0x04     /*lcd command mode */
#define LED_WRITE               (unsigned char)0x05     /*lcd write mode */
#define LED_READ                (unsigned char)0x06     /*lcd read mode */
#define LED_SYS_DIS             (unsigned char)0x00     //close system clock
#define LED_SYS_EN              (unsigned char)0x01     //open system clock
#define LED_OFF                 (unsigned char)0x02     
#define LED_ON                  (unsigned char)0x03     
#define LED_BLINK_OFF           (unsigned char)0x08     
#define LED_BLINK_ON            (unsigned char)0X09     
#define LED_SLAVE_MODE          (unsigned char)0X10     //open led slave mode
#define LED_RC_MASTER_MODE      (unsigned char)0X18    //internal RC clock
#define LED_EXT_CLK_MASTER_MODE (unsigned char)0X1C     //external clock
//#define LED_COM_OPTION          (unsigned char)0X20     //8COM,NMOS mode
//#define LED_COM_OPTION          (unsigned char)0X28     //8COM, PMOS mode
#define LED_COM_OPTION          (unsigned char)0X24     //16COM, NMOS mode
//#define LED_COM_OPTION            (unsigned char)0X2C     //16COM, PMOS mode
#define LED_PWM_DUTY            (unsigned char)0XA0    //PWM brightness
#define PWM_DUTY_1              (unsigned char)0X00    //PWM brightness 1/16DUTY
#define PWM_DUTY_2              (unsigned char)0X01    //PWM brightness 2/16DUTY
#define PWM_DUTY_3              (unsigned char)0X02    //PWM brightness 3/16DUTY
#define PWM_DUTY_4              (unsigned char)0X03    //PWM brightness 4/16DUTY
#define PWM_DUTY_5              (unsigned char)0X04    //PWM brightness 5/16DUTY
#define PWM_DUTY_6              (unsigned char)0X05    //PWM brightness 6/16DUTY
#define PWM_DUTY_7              (unsigned char)0X06    //PWM brightness 7/16DUTY
#define PWM_DUTY_8              (unsigned char)0X07    //PWM brightness 8/16DUTY
#define PWM_DUTY_9              (unsigned char)0X08    //PWM brightness 9/16DUTY
#define PWM_DUTY_10             (unsigned char)0X09    //PWM brightness 10/16DUTY
#define PWM_DUTY_11             (unsigned char)0X0A    //PWM brightness 11/16DUTY
#define PWM_DUTY_12             (unsigned char)0X0B    //PWM brightness 12/16DUTY
#define PWM_DUTY_13             (unsigned char)0X0C    //PWM brightness 13/16DUTY
#define PWM_DUTY_14             (unsigned char)0X0D    //PWM brightness 14/16DUTY
#define PWM_DUTY_15             (unsigned char)0X0E    //PWM brightness 15/16DUTY
#define PWM_DUTY_16             (unsigned char)0X0F    //PWM brightness 16/16DUTY

/*--------------------*
 |  Public functions
 *--------------------*/
/*---------------------------------------------------------------------------*
 |  DisplayDriverInitialize
 |
 |  Initializes the pointer to the image.
 |
 |  Entry:  No requirements
 |  Exit:   Returns nothing
 *---------------------------------------------------------------------------*/
void DisplayDriverInitializeLED(void);
/*---------------------------------------------------------------------------*
 |  DisplayDriverProcess
 |
 |  Handles shifting data out to the display.
 |  First we send 3bits write ID and 6bits address,immiediately followed by data.
 |  Every time we send 8bits out,so we have to seperate the same ram data into two part:
 |  3bitsID+5bitsAddress;1bitAddress+7bitdata;
 |  the left least bit data+7bits data in next address;---
 |  Entry:  No requirements
 |  Exit:   Returns nothing
 *---------------------------------------------------------------------------*/
void DisplayDriverProcessLED(void);
/*---------------------------------------------------------------------------*
 |  DisplayDriverShutdown
 |
 |  Shuts off all banks lines and any other processing needed to blank the
 |  display for minimal power consumption.  Typically used when line cross
 |  has been lost.
 |
 |  Entry:  No requirements
 |  Exit:   Returns nothing
 *----------------------------------------------------------------------------*/
void DisplayDriverShutdown(void);
#endif
