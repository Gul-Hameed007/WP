/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *  Copyright (c) 2008 by MKS Controls
 *
 *
 *  File name: Image.h
 *  Module:    Application module
 *  Language:  ANSI C
 *  $Revision: 1 $
 *
 *  GENERAL DESCRIPTION
 *  This is a software object for functions to generate an output image
 *  for a fixed-segment display.  The module does not control hardware outputs
 *  to drive a display. The module only constructs an image in memory to be
 *  displayed and is optionally communicated through a COM port. It has an
 *  optional capability to handle two images:  the image being displayed and a
 *  working image. The module accepts high-level requests such as characters to
 *  be displayed and determines which segments should be turned on.
 *
 *  CONSTRAINTS
 *  The index of blank character must be same in all character sets.
 *  The index of all segments on character must be same in all character sets.
 *  Message ID numbers must conform to Standard Messages specification.
 *  Module Transport 0809.
 *  Module Ram 0301.
 *  Limitations - The module will not process new messages until
 *  the processing of an existing message is finished.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
//#include "STM8S105K.h"
//#include "STM8S.h"
#ifndef IMAGE_H
#define IMAGE_H
/*------------------*
 |  Constants
 *------------------*/
#define LED_IMAGE_SIZE                  48  // 23 + 25 cols
#define LED_UP_SIZE     23
#define LED_DOWN_SIZE   25

@near euchar image[];
@near euchar* const images[];
// @near euchar image_up[];
// @near euchar image_down[];

// Image mapping information: map Image data to the appropriate locations in the Image ram.
//*********************************** down part of matrix ***************************************//
//from left -> right: M1------>M24
//matrix
#define MATRIX_1        image[47]
#define MATRIX_2        image[45]
#define MATRIX_3        image[43]
#define MATRIX_4        image[41]
#define MATRIX_5        image[39]
#define MATRIX_6        image[37]
#define MATRIX_7        image[35]
#define MATRIX_8        image[33]
#define MATRIX_9        image[31]
#define MATRIX_10   image[29]
#define MATRIX_11   image[27]
#define MATRIX_12   image[25]
#define MATRIX_13   image[23]
#define MATRIX_14   image[21]
#define MATRIX_15   image[19]
#define MATRIX_16   image[17]
#define MATRIX_17   image[15]
#define MATRIX_18   image[13]
#define MATRIX_19   image[11]
#define MATRIX_20   image[9]
#define MATRIX_21   image[7]
#define MATRIX_22   image[5]
#define MATRIX_23   image[3]
#define MATRIX_24   image[1]
// #define  MATRIX_ADDR    47
// #define  MATRIX_SIZE 24

//*********************************** up part of matrix ***************************************//
//from left to right: M23------>M1
//matrix
#define MATRIX1_1       image[0]
#define MATRIX1_2       image[2]
#define MATRIX1_3       image[4]
#define MATRIX1_4       image[6]
#define MATRIX1_5       image[8]
#define MATRIX1_6       image[10]
#define MATRIX1_7       image[12]
#define MATRIX1_8       image[14]
#define MATRIX1_9       image[16]
#define MATRIX1_10  image[18]
#define MATRIX1_11  image[20]
#define MATRIX1_12  image[22]
#define MATRIX1_13  image[24]
#define MATRIX1_14  image[26]
#define MATRIX1_15  image[28]
#define MATRIX1_16  image[30]
#define MATRIX1_17  image[32]
#define MATRIX1_18  image[34]
#define MATRIX1_19  image[36]
#define MATRIX1_20  image[38]
#define MATRIX1_21  image[40]
#define MATRIX1_22  image[42]
#define MATRIX1_23  image[44]
//#define   MATRIX_24   image[47]
// #define  MATRIX1_ADDR   44
// #define  MATRIX1_SIZE   23

//***************** MODE, NET, ERROR state LED *****************//
#define SET_LED_NET         DT_O = 0
#define CLEAR_LED_NET       DT_O = 1
#define SET_LED_ERROR       KO1 = 0
#define CLEAR_LED_ERROR     KO1 = 1
#define CLEAR_LED_MODE      {KO2 = 1; KO3 = 1; KO4 = 1;}
#define SET_LED_STANDBY     {KO2 = 0; KO3 = 1; KO4 = 1;}
#define SET_LED_AUTO        {KO2 = 1;\
                             if (power_board_version >= 110) {KO3 = 1; KO4 = 0;}\
                             else {KO3 = 0; KO4 = 1;}\
                            }
#define SET_LED_FIXED       {KO2 = 1;\
                             if (power_board_version >= 110) {KO3 = 0; KO4 = 1;}\
                             else {KO3 = 1; KO4 = 0;}\
                            }
// #define SET_LED_AUTO_FIXED  {KO2 = 1; KO3 = 0; KO4 = 0;}
#define SET_LED_ALL         {KO1 = 0; KO2 = 0; KO3 = 0; KO4 = 0; DT_O = 0;}
#define CLEAR_LED_ALL       {KO1 = 1; KO2 = 1; KO3 = 1; KO4 = 1; DT_O = 1;}

typedef enum
{
    LED_UP,
    LED_DOWN
} led_location_t;
 
/*--------------------*
|  Public functions
*--------------------*/
/*---------------------------------------------------------------------------*
 |  ImageAll
 |
 |  Turn on the entire display. See Image.h for details
 *---------------------------------------------------------------------------*/
void disp_matrix_all(uchar number);
void disp_matrix(const uchar* const lib_text, const led_location_t ic);
#define disp_matrix_up(lib_text)   disp_matrix(lib_text, LED_UP)
#define disp_matrix_down(lib_text)   disp_matrix(lib_text, LED_DOWN)

void disp_text(const uchar* const text, const led_location_t ic);
#define disp_text_up(text)      disp_text(text, LED_UP)
#define disp_text_down(text)    disp_text(text, LED_DOWN)

void disp_1f(const uint num, const led_location_t ic);
#define disp_1f_up(num)     disp_1f(num, LED_UP)
#define disp_1f_down(num)   disp_1f(num, LED_DOWN)

void disp_2f(const uint num, const led_location_t ic);

void disp_d(const uint num, const led_location_t ic);
#define disp_d_up(num)      disp_d(num, LED_UP)
#define disp_d_down(num)    disp_d(num, LED_DOWN)

void disp_ld(const ulong num, const led_location_t ic);

void disp_custom(const led_location_t ic, uchar const* format, ...);

void disp_alternant_net(const uint on_ms, const uint off_ms);
void disp_alternant2_net(const uint on_ms1, const uint off_ms1, const uint on_ms2, const uint off_ms2);


#endif                                                            /* IMAGE_H */
