#include "time.h"
#include "declare.h"

//test ram data
uchar ram_d7;

volatile clock_t __clocks;

clock_t clock(void)
{
    return __clocks;
}


//time base
volatile uchar timer_1ms;          //time base for 200us in interrupt routine

@far @interrupt void TIM4_isr (void)
{
    #ifdef wuyuanbeep
    @near ebool flag_beep;
    #endif

    TIM4_SR &= 0x7E;            //clear Flag
    
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
