#ifndef __RUN_MODE_H
#define __RUN_MODE_H

#include "newtype.h"


typedef enum
{
    RUN_MODE_AUTO,          //0
    RUN_MODE_FIXED,         //1
    RUN_MODE_STANDBY,       //2
    RUN_MODE_NEW,
    RUN_MODE_CHECK,
    RUN_MODE_LOCK
} run_mode_t;

extern run_mode_t runmode;

//step down when pause or stop key press
typedef enum
{
    STEPDOWN_NONE,
    STEPDOWN_PAUSE,
    STEPDOWN_STOP,
    STEPDOWN_START
} stepdown_t;

@near extern stepdown_t stepdown_flag;
@near euchar stepdown_cnt;


typedef enum
{
    TUTORIAL_BEGIN = 0,
    TUTORIAL_STEP1_BEGIN,
    TUTORIAL_STEP1_END,
    TUTORIAL_STEP2_BEGIN,
    TUTORIAL_STEP2_END,
    TUTORIAL_STEP3_BEGIN,
    TUTORIAL_STEP3_END,
    TUTORIAL_FINISH,
    TUTORIAL_STOP_FIRST,
    TUTORIAL_WAIT
} tutorial_state_t;

@near extern tutorial_state_t tutorial_state;

void run_auto(void);
void run_fixed(void);
void run_new(void);

void run(void);

#endif