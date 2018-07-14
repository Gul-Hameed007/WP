#include "beep.h"

//requirement for each beep mode
// #define BEEP_KEY_ON_CNT                             5           //0.5s 1 time
// #define BEEP_KEY_OFF_CNT                            5           //0.5s 1 time
// #define BEEP_KEY_NUMBER                             0           //actual number = +1
// #define BEEP_KEY_INVALID_ON_CNT                     15          //1s 1 time
// #define BEEP_KEY_INVALID_OFF_CNT                    15          //1s 1 time
// #define BEEP_KEY_INVALID_NUMBER                     0           //actual number = +1
// #define BEEP_SAFETY_OFF_ON_CNT                      3//6            //0.2s 3 times
// #define BEEP_SAFETY_OFF_OFF_CNT                     3//80           //0.2s 3 times
// #define BEEP_SAFETY_OFF_NUMBER                      2           //actual number = +1
// #define BEEP_ERROR_ON_CNT                           15          //1s 9 times
// #define BEEP_ERROR_OFF_CNT                          15          //1s 9 times
// #define BEEP_ERROR_NUMBER                           8           //actual number = +1
static uchar const beep_setting[][3] =
{ // ON_CNT, OFF_CNT, NUMBER
    {0, 0, 0},      // BEEP_NONE
    {5, 5, 0},      // BEEP_KEY
    {15, 15, 0},    // BEEP_KEY_INVALID
    {3, 3, 2},      // BEEP_SAFETY_OFF
    {15, 15, 8},    // BEEP_ERROR
    {5, 5, 5}       // BEEP_GOAL
};

static uchar beepmode;                     //beep sound mode
static uchar beep_on_cnt;                       //on time in 1 beep, in 20ms
static uchar beep_off_cnt;                      //off time in 1 beep interval, in 20ms of main loop
static uchar beep_number;                  //number in a beep mode
static bool beep_request;                 //request beep action, set with the beepmode

#ifdef wuyuanbeep
@near bool flag_beep;
#endif

/*--------------------------------------------------------------------------*
 |
 |  beep
 |  Call to set the beep sound mode
 |
 |  See user.h for details.
 |
 *--------------------------------------------------------------------------*/
void beep(uchar beepm)
{
    beepmode = beepm;
    beep_request = 1;
}

/*--------------------------------------------------------------------------*
 |
 | buzzcon
 |
 | Description: To beeper drive
 |
 |  Entry:  None
 |  Exit:   None
 *--------------------------------------------------------------------------*/
void buzzcon(void)
{
    if (beep_request)
    {
        beep_request = 0;
        beep_on_cnt = beep_setting[beepmode][0];
        beep_off_cnt = beep_setting[beepmode][1];
        beep_number = beep_setting[beepmode][2];
    }
    if (beep_on_cnt > 0)
    {
#ifdef wuyuanbeep
        flag_beep = 1;
#else
        BEEP_ON;
#endif
        beep_on_cnt--;
    }
    else
    {
#ifdef wuyuanbeep
        flag_beep = 0;
#else
        BEEP_OFF;
#endif
        if (beep_number > 0)
        {
            if (beep_off_cnt > 0)
            {
                beep_off_cnt--;
            }
            else        //1 beep end
            {
                beep_number--;      //beep all the time if safty off
                beep_on_cnt = beep_setting[beepmode][0];    //reload on time
                beep_off_cnt = beep_setting[beepmode][1];
            }
        }
        else            //beep mode end
        {
            beep_on_cnt = 0;
            beep_off_cnt = 0;
        }
    }
}