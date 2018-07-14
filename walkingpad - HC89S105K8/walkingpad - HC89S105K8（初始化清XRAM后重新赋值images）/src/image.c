/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *  Copyright (c) 2008 by MKS Controls
 *
 *
 *  File name: Image.c
 *  Module:    Application module
 *  Language:  ANSI C
 *  $Revision: 1 $
 *
 *  Source code for a Image module.  For details see Image.h
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#ifndef IMAGE_C
#define IMAGE_C
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include "declare.h"
#include "image.h"
#include "time.h"

/*-----------------------------------------------------*
 |  The buffer used by functions to construct the image
 *-----------------------------------------------------*/
 uchar image[LED_IMAGE_SIZE];
 uchar* images[2];// = {image, image + LED_UP_SIZE};
 const uchar code led_sizes[] = {LED_UP_SIZE, LED_DOWN_SIZE};

uchar const code ascii_2[][5] = //
    {
        {0x3E, 0x41, 0x41, 0x41, 0x3E}, // 0
        {0x00, 0x21, 0x7F, 0x01, 0x00}, // 1
        {0x21, 0x43, 0x45, 0x49, 0x31}, // 2
        {0x22, 0x41, 0x49, 0x49, 0x36}, // 3
        {0x0C, 0x14, 0x24, 0x7F, 0x04}, // 4
        {0x72, 0x51, 0x51, 0x51, 0x4E}, // 5
        {0x3E, 0x49, 0x49, 0x49, 0x26}, // 6
        {0x40, 0x40, 0x4F, 0x50, 0x60}, // 7
        {0x36, 0x49, 0x49, 0x49, 0x36}, // 8
        {0x32, 0x49, 0x49, 0x49, 0x3E}, // 9
        {0x1F, 0x28, 0x48, 0x28, 0x1F}, //A
        {0x7F, 0x49, 0x49, 0x49, 0x36}, //B
        {0x3E, 0x41, 0x41, 0x41, 0x22}, //C
        {0x7F, 0x41, 0x41, 0x41, 0x3E}, //D
        {0x3E, 0x49, 0x49, 0x49, 0x41}, //E
        {0x3F, 0x48, 0x48, 0x48, 0x40}, //F
        {0x3E, 0x41, 0x49, 0x49, 0x2E}, //G
        {0x7F, 0x08, 0x08, 0x08, 0x7F}, //H
        {0x00, 0x41, 0x7F, 0x41, 0x00}, //I
        {0x06, 0x01, 0x01, 0x01, 0x7E}, //J
        {0x7F, 0x08, 0x14, 0x22, 0x41}, //K
        {0x7E, 0x01, 0x01, 0x01, 0x01}, //L
        {0x7F, 0x20, 0x10, 0x20, 0x7F}, //M
        {0x7F, 0x20, 0x10, 0x08, 0x7F}, //N
        {0x3E, 0x41, 0x41, 0x41, 0x3E}, //O
        {0x3F, 0x48, 0x48, 0x48, 0x30}, //P
        {0x3C, 0x42, 0x46, 0x43, 0x3C}, //Q
        {0x3F, 0x48, 0x4C, 0x4A, 0x31}, //R
        {0x32, 0x49, 0x49, 0x49, 0x26}, //S
        {0x40, 0x40, 0x7F, 0x40, 0x40}, //T
        {0x7E, 0x01, 0x01, 0x01, 0x7E}, //U
        {0x7C, 0x02, 0x01, 0x02, 0x7C}, //V
        {0x7F, 0x02, 0x0C, 0x02, 0x7F}, //W
        {0x63, 0x14, 0x08, 0x14, 0x63}, //X
        {0x60, 0x10, 0x0F, 0x10, 0x60}, //Y
        {0x43, 0x45, 0x49, 0x51, 0x61}, //Z
        // {0x0C, 0x12, 0x12, 0x1C, 0x02}, //a
        // {0x00, 0x7E, 0x12, 0x12, 0x0C}, //b
        // {0x00, 0x0C, 0x12, 0x12, 0x12}, //c
        // {0x0C, 0x12, 0x12, 0x7E, 0x00}, //d
        // {0x0C, 0x1A, 0x1A, 0x0A, 0x00}, //e
        // {0x00, 0x3E, 0x48, 0x48, 0x40}, //f
        // {0x00, 0x12, 0x29, 0x29, 0x3E}, //g
        // {0x00, 0x7E, 0x10, 0x10, 0x0E}, //h
        // {0x00, 0x00, 0x2E, 0x00, 0x00}, //i
        // {0x00, 0x02, 0x02, 0x3C, 0x00}, //j
        // {0x00, 0x3E, 0x0C, 0x12, 0x00}, //k
        // {0x00, 0x3E, 0x00, 0x00, 0x00}, //l
        // {0x0E, 0x10, 0x0E, 0x10, 0x0E}, //m
        // {0x00, 0x1E, 0x10, 0x10, 0x0E}, //n
        // {0x00, 0x0C, 0x12, 0x12, 0x0C}, //o
        // {0x00, 0x3E, 0x28, 0x28, 0x10}, //p
        // {0x10, 0x28, 0x28, 0x3E, 0x00}, //q
        // {0x00, 0x1E, 0x08, 0x10, 0x00}, //r
        // {0x10, 0x2A, 0x2A, 0x2A, 0x04}, //s
        // {0x00, 0x10, 0x3C, 0x12, 0x00}, //t
        // {0x1C, 0x02, 0x02, 0x1C, 0x00}, //u
        // {0x00, 0x1C, 0x02, 0x1C, 0x00}, //v
        // {0x1C, 0x02, 0x04, 0x02, 0x1C}, //w
        // {0x12, 0x0C, 0x0C, 0x12, 0x00}, //x
        // {0x32, 0x09, 0x09, 0x3E, 0x00}, //y
        // {0x12, 0x16, 0x1A, 0x12, 0x00}, //z
        // {0x00, 0x00, 0x7A, 0x00, 0x00}, // !
};
/*--------------------*
 |  Public functions
 *--------------------*/

/*---------------------------------------------------------------------------*
 |  ImageAll
 |
 |  Turn on the entire display. See Image.h for details
 *---------------------------------------------------------------------------*/
void disp_matrix_all(uchar number)
{
    memset(image, number, LED_IMAGE_SIZE);
}

// display strings, 
// text: string to display
// ic: indicator the upper (0) or down (1) part of the led matrix
// e.g.
// display_text("WAIT", 0) will display "WAIT" on the upper part.

void disp_text(const uchar* const text, led_location_t ic)
{
    uchar* ptr;
    uchar c;//,i;
    uchar offset = 0;
    uchar* const ptr0 = images[ic];

    for (ptr = text; *ptr != 0; ptr++)
    {
        if (*ptr == '.' || *ptr == ':' || *ptr ==' ')
        {
            offset += 2;
        }
        else
        {
            offset += 6;
        }
    }
    offset--;

    offset = (led_sizes[ic] - offset) >> 1;

    for (ptr = text; *ptr != 0; ptr++)
    {
        c = *ptr;
        if (c == '.')
        {
            ptr0[offset] = 0x01;
            offset += 2;
            continue;
        }
        else if (c == ':')
        {
            ptr0[offset] = 0x14;
            offset += 2;
            continue;
        }
        else if (c == ' ')
        {
            ptr0[offset] = 0x00;
            offset += 2;
            continue;
        }
        
        if (c >= 'A' && c <= 'Z')
            c = c - 'A' + 10;
        // else if (c >= 'a' && c <= 'z')
        //     c = c - 'a' + 36;
        else if (c >= '0' && c <= '9')
            c = c - '0';
        else
            continue;

        memcpy(images[ic]+offset, ascii_2[c], 5);
        //for(i=0;i<5;i++)
        //{
           //(images[ic]+offset)[i]=ascii_2[c][i];
           //*(images[ic]+offset+i)=*(ascii_2[c]+i);
        //   images[ic][offset+i]=ascii_2[c][i];
        //}

        offset += 6;
    }
}

static uchar _text[6];

void disp_1f(const uint num, const led_location_t ic)
{
    disp_custom(ic, "%d.%d", num / 10, num % 10);
}

void disp_2f(const uint num, const led_location_t ic)
{
    disp_custom(ic, "%d.%02d", num / 100, num % 100);
}

void disp_d(const uint num, const led_location_t ic)
{
    disp_custom(ic, "%d", num);
}

void disp_ld(const ulong num, const led_location_t ic)
{
    disp_custom(ic, "%ld", num);
}

void disp_custom(const led_location_t ic, char* format, ...)
{
    va_list ap;
    va_start(ap, format);
    vsprintf(_text, format, ap);
    va_end(ap);
    disp_text(_text, ic);
}

//**************************************************************************//
void disp_matrix(const uchar* const lib_text, const led_location_t ic)
{
    memcpy(images[ic], lib_text, led_sizes[ic]);
}

void disp_alternant_net(const uint on_ms, const uint off_ms)
{
    uint temp = (clock() / CLOCKS_PER_MS) % (on_ms + off_ms);
    if (temp < on_ms)
        SET_LED_NET;
    else
        CLEAR_LED_NET;
}

void disp_alternant2_net(const uint on_ms1, const uint off_ms1, const uint on_ms2, const uint off_ms2)
{
    uint temp = (clock() / CLOCKS_PER_MS) % (on_ms1 + off_ms2 + on_ms2 + off_ms2);
    if (temp < on_ms1 || (temp >= on_ms1 + off_ms1 && temp < on_ms1 + off_ms1 + on_ms2))
        SET_LED_NET;
    else
        CLEAR_LED_NET;
}

#endif /* IMAGE_C */
