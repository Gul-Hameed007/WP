#include "declare.h"
#include "control.h"

euint user_distance;
ebool global_fan_test;

uchar getFanSpeed(void)
{
    uchar sp;
    if (error_id == 10 || error_id == 11)
    {
        sp = 11;
    }
    else if (factory_finish)
    {
        if (user_distance < 10 || machine_speed_target < 30)
        {
            sp = 0;
        }
        else
        {
            sp = machine_speed_target / 30 + 5;
        }
    }
    else
    {
        if (global_fan_test == 1)
        {
            sp = 11;
        }
        else if (machine_speed_target < 30)
        {
            sp = 0;
        }
        else
        {
            sp = machine_speed_target / 30 + 5;
        }
    }

    return sp;
}
