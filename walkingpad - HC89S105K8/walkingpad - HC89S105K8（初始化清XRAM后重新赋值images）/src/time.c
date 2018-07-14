#include "time.h"
#include "declare.h"

volatile clock_t __clocks;

clock_t clock(void)
{
    return __clocks;
}


//time base
uchar volatile timer_1ms;          //time base for 200us in interrupt routine

void TIMER1_Rpt(void) interrupt TIMER1_VECTOR
{
    #ifdef wuyuanbeep
     ebool flag_beep;
    #endif
    
    __clocks ++;

    if(timer_1ms<250)
    {
        timer_1ms++;
    }

#ifdef  wuyuanbeep
    if(flag_beep)
    {
        BUZZ^=1;
    }
    else
    {
        BEEP_OFF;
    }
#endif
    return;
}


uint state_sec;
uchar state_tick;

void timer_proc(void)
{
    if (state_tick++ >= TIME_BASE_SEC) //one second base timer
    {
        state_tick = 0;
        state_sec ++;
    }
}
