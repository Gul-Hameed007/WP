/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *  Copyright (c) 2008 by MKS Controls
 *
 *
 *  File name: newtype.h
 *  Module:
 *  Language:  ANSI C
 *  $Revision: 1 $
 *
 *
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#ifndef __NEWTYPE_H
#define __NEWTYPE_H

#include <stdbool.h>

#define MIwifi

#define TUTORIAL_FINISH_TAG 0x55

#define SIMULATE_SPEED

//define if using UART_SIM to communicate with power board
#define UART_SIM
#define wuyuanbeep                       //Passive buzzer
#define DC_MOTOR_RATING_RPM_DEFAULT 4900 //The motor rated speed
//#define RPM_TARGET_SCALE                            272 //4900RPM/18KM/H
#define RPM_TARGET_SCALE 272
#define SPEED_TARGET_MAX 180 //maximum speed set point
#define SPEED_TARGET_SHI 180 //The actual speed set point
//#define SPEED_TARGET_MIN                            10      //Start the speed setting
#define SPEED_TARGET_MAX1 112 //SPEED_TARGET_SHI*62/100 Miles
#define SPEED_TARGET_MIN1 15  //SPEED_TARGET_MIN*62/100 Miles
#define SPEED_TARGET_MIN 10
#define SPEED_TARGET_STEPDOWN 1 //SPEED_TARGET_MIN     //minimum speed set point
#define SPEED_LIMIT_MAX_FACTORY 90

#define ALARM_SPEED_SENSOR 0x01 //with pwm output, not speed feedback
#define ALARM_INCL_SENSOR 0x02
//motor parameter
#define DC_MOTOR_RATING_F1_MIN 5 //
#define DC_MOTOR_RATING_F1_MAX 250
#define DC_MOTOR_RATING_F1_DEFAULT 130
#define DC_MOTOR_RATING_RPM_MIN 2000 //rpm
#define DC_MOTOR_RATING_RPM_MAX 7000
//#define   DC_MOTOR_RATING_RPM_DEFAULT             5400
#define DC_MOTOR_RATING_VOLT_MIN 130 //in v
#define DC_MOTOR_RATING_VOLT_MAX 170
#define DC_MOTOR_RATING_VOLT_DEFAULT 150 // 160
#define DC_MOTOR_STARTUP_VOLT_MIN (5)    //in v
#define DC_MOTOR_STARTUP_VOLT_MAX (25)
#define DC_MOTOR_STARTUP_VOLT_DEFAULT (13)
#define DC_MOTOR_STEP_PARA_MIN 5 //
#define DC_MOTOR_STEP_PARA_MAX 25
#define DC_MOTOR_STEP_PARA_DEFAULT 10

/**********************************************************************************
|   if the DC motor speed signal is feedback from magnetic sensor on roller,
|   uncomment this definition, 1 pulse/rpm
|   if the speed signal is feedback from OPTO sensor on motor shaft,
|   comment this definition, 50 pulse/rpm
|   refer to the design file for details.
**********************************************************************************/
#if TREADMILL_MOTOR_SENSOR_TYPE == TREADMILL_MOTOR_SENSOR_MAGNETIC
#define DC_MOTOR_MAGNETIC_SENSOR
#endif

#define RPM_MEASURED_SCALE 833333 //calculated in system design document
#define CLOCK 16000               //16Mhz
#define TIMER4_CNT (100 - 1)
#define TIME_BASE_MAIN 100
#define TIME_BASE_SEC 49 //base on time_base_main, 1s

//user_request
#define USER_REQUEST_NONE 0
#define USER_REQUEST_START 0x01
#define USER_REQUEST_PAUSE 0x02
#define USER_REQUEST_STOP 0x02
#define USER_REQUEST_NEW_SPEED 0x04
#define USER_REQUEST_NEW_GRADIENT 0x08
#define USER_REQUEST_ERROR_RESET 0x10

//machine state feedback from power board
#define MACHINE_STATE_RUN 1  //running
#define MACHINE_STATE_IDLE 0 //stop
//machine dc/ac motor state
#define MACHINE_MOTOR_ON 1  //turn on
#define MACHINE_MOTOR_OFF 0 //turn off
//power up, all LCD on and one beep
#define DISPLAY_ALL_ON_DELAY 150 //in 20ms; total 3s

#define FIXED_MODE_DEFAULT_SPEED 90

#define INC_UCHAR(a) \
    if (a < 255)     \
    a++ // when used before "else", add {}, i.e. {INC_UCHAR(A);}

//define  new types
typedef signed char schar;
typedef signed int sint;
typedef signed long slong;
typedef unsigned char uchar;
typedef unsigned int uint;
typedef unsigned long ulong;
#define euchar extern uchar
#define euint extern uint
#define eulong extern ulong
#define elong extern long
#define ebool extern bool
//typedef unsigned char __flash prog_uchar;
//typedef unsigned int __flash prog_uint;
//#define PGM_UCHARP prog_uchar *
//#define PGM_UINTP  prog_uint *
typedef struct _bit_struct
{
    uchar bit0 : 1;
    uchar bit1 : 1;
    uchar bit2 : 1;
    uchar bit3 : 1;
    uchar bit4 : 1;
    uchar bit5 : 1;
    uchar bit6 : 1;
    uchar bit7 : 1;
} bit_field;
#define GET_BITFIELD(addr) (*((volatile bit_field *)(addr)))
/***************************************************************/

//user state
typedef enum {
    USER_STATE_READY,
    USER_STATE_RUN,
    USER_STATE_PAUSE,
    USER_STATE_STOP,
    USER_STATE_SLEEP,
    // USER_STATE_EOC,
    USER_STATE_FAULT,
    USER_STATE_TICK
} user_state_t;

typedef enum {
    GOAL_ONGOING,
    GOAL_ACHIEVED,
    GOAL_CHANGED
} goal_status_t;

typedef enum {
    // normal display cycle
    DISPLAY_TIME,
    DISPLAY_SPEED,
    DISPLAY_DIST,
    DISPLAY_CAL,
    DISPLAY_STEP,
    DISPLAY_SIZE,
    // prog mode display cycle
    DISPLAY_PROG_F1,
    DISPLAY_PROG_F2,
    DISPLAY_PROG_F3,
    DISPLAY_PROG_MAX,
    DISPLAY_PROG_FACT,
    DISPLAY_PROG_VERSION,
    DISPLAY_PROG_END,
    // display temporary for 10s
    DISPLAY_FOR_A_WHILE,
    DISPLAY_GOAL,
    DISPLAY_LIMIT,
    DISPLAY_CUR_VOL,
    DISPLAY_SENSOR,
    DISPLAY_SPEED_TEMP,
    DISPLAY_START_HINT,
    // display interval (in 20 ms)
    DISPLAY_INTERVAL = 250
} display_seg_t;

//commu buffer length
#define TXD_CNT 25
#define RXD_CNT 35

//alarm when no message from power board
#endif
//define I/0 pins and bit variables ######################################
/***********************************************/
#define TXEN_FLAG GET_BITFIELD(&UART2_CR2).bit3     // enable flag of TX
#define RXEN_FLAG GET_BITFIELD(&UART2_CR2).bit2     // enable flag of RX
#define TXE_FLAG GET_BITFIELD(&UART2_SR).bit6       // empty flag of TX
#define TC_FLAG GET_BITFIELD(&UART2_SR).bit6        // finish flag
#define RXNE_FLAG GET_BITFIELD(&UART2_SR).bit5      // not empty flag of RX
#define OR_FLAG GET_BITFIELD(&UART2_SR).bit3        // ERROR flag
#define EOP_FLAG GET_BITFIELD(&FLASH_IAPSR).bit2    //
#define PUL_FLAG GET_BITFIELD(&FLASH_IAPSR).bit1    //
#define WR_PG_DIS GET_BITFIELD(&FLASH_IAPSR).bit0   //
#define UNLOCK_FLAG GET_BITFIELD(&FLASH_IAPSR).bit3 //
#define SWIM_FLAG GET_BITFIELD(&CFG_GCR).bit0       //SWIM as I/O
//I/O ports definition
/*---------------------------*
 |  keys detection
 *---------------------------*/
#define K1_DDR GET_BITFIELD(&PC_DDR).bit1 //
#define K2_DDR GET_BITFIELD(&PC_DDR).bit2 //
#define K3_DDR GET_BITFIELD(&PC_DDR).bit3 //
#define K4_DDR GET_BITFIELD(&PC_DDR).bit4 //
#define KI1 GET_BITFIELD(&PC_IDR).bit1    //
#define KI2 GET_BITFIELD(&PC_IDR).bit2    //
#define KI3 GET_BITFIELD(&PC_IDR).bit3    //
#define KI4 GET_BITFIELD(&PC_IDR).bit4    //
#define KO1 GET_BITFIELD(&PC_ODR).bit1    //
#define KO2 GET_BITFIELD(&PC_ODR).bit2    //
#define KO3 GET_BITFIELD(&PC_ODR).bit3    //
#define KO4 GET_BITFIELD(&PC_ODR).bit4    //
/*---------------------------*
 |  Buzz output
 *---------------------------*/
#define BUZZ GET_BITFIELD(&PD_ODR).bit7
#define BEEP_OFF  \
    {             \
        BUZZ = 0; \
    }
#define BEEP_ON   \
    {             \
        BUZZ = 1; \
    }
/********************************
| COMMU CONTROL
*********************************/
#define TXD GET_BITFIELD(&PD_ODR).bit4     //
#define TXD_DDR GET_BITFIELD(&PD_DDR).bit4 //
#define RXD GET_BITFIELD(&PD_IDR).bit3     //
#define RXD_DDR GET_BITFIELD(&PD_DDR).bit3 //

#define TX GET_BITFIELD(&PD_ODR).bit5     //
#define TX_DDR GET_BITFIELD(&PD_DDR).bit5 //
#define RX GET_BITFIELD(&PD_IDR).bit6     //
#define RX_DDR GET_BITFIELD(&PD_DDR).bit6 //

/*---------------------------*
 |  safety switch detection
 *---------------------------*/
//#define SAFTY     GET_BITFIELD(&PD_IDR).bit2
#define K5_DDR GET_BITFIELD(&PD_DDR).bit2 //
#define KI5 GET_BITFIELD(&PD_IDR).bit2    //
#define KO5 GET_BITFIELD(&PD_ODR).bit2    //

/*---------------------------*
 |  LCD display module control
 *---------------------------*/
#define LED_CLOCK GET_BITFIELD(&PB_ODR).bit3 //WR
#define LED_DATA GET_BITFIELD(&PB_ODR).bit2
//#define LED_CS1                              GET_BITFIELD(&PB_ODR).bit0
#define LED_CS2 GET_BITFIELD(&PB_ODR).bit1
#define LED_RD GET_BITFIELD(&PB_ODR).bit4

//
#define HX711_CK1 GET_BITFIELD(&PC_ODR).bit6
#define HX711_DT1 GET_BITFIELD(&PC_IDR).bit5
#define HX711_CK2 GET_BITFIELD(&PD_ODR).bit0
#define HX711_DT2 GET_BITFIELD(&PC_IDR).bit7
/*---------------------------*
 |  test pin
 *---------------------------*/

#define DT_DDR GET_BITFIELD(&PA_DDR).bit2 //
#define DT_O GET_BITFIELD(&PA_ODR).bit2   //

#if 0
#define TEST1 GET_BITFIELD(&PORTD).bit3
#define TEST2 GET_BITFIELD(&PORTB).bit2
#define TEST3 GET_BITFIELD(&PORTC).bit4
#define TEST4 GET_BITFIELD(&PORTC).bit5
#endif
