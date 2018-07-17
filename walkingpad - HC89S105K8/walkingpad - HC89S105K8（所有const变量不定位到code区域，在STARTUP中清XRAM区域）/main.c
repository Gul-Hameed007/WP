/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *  Copyright (c) 2008 by MKS Controls
 *
 *
 *  File name: Main.c
 *  Module:
 *  Language:  ANSI C
 *  $Revision: 1 $
 *
 *
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#include "zero.h"
#include "sensor.h"
#include "displaydriver.h"
#include "control.h"
#include "time.h"
#include "miwifi.h"
#include <intrins.h>

extern void ini(void);
extern void commu(void);
extern void key_scan(void);
extern void buzzcon(void);
extern void feed_wdg(void);

void main(void)
{
    ini();
    while (1)
    {
        feed_wdg();
        timer_proc();
        key_scan();
        detect_error();
        key_scan();
        HX711_Weight();

		if (factory_finish == 0)
		{
			FactoryTestOperation();     
		}
		else
		{
           useroperation();
		}

        DisplayDriverProcessLED();
        key_scan();
        commu();
        key_scan();

#ifdef MIwifi
        commu_wifi();
#else
        commu_uart();
#endif

        buzzcon();
        key_scan();

        while (timer_1ms < TIME_BASE_MAIN)
        {
            _nop_(); //20ms
        }
        timer_1ms = 0;
    }
}
