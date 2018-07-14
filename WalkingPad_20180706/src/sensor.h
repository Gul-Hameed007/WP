#ifndef __SENSOR_H
#define __SENSOR_H
#include "newtype.h"

@near euchar flag_Gsensor_disconnected;
@near eulong tension, tension2;
@near elong tension_bias, tension2_bias;
@near euchar no_current_cnt;
@near euchar fold_cnt;

void HX711_Weight(void);
void calc_disconnect(void);

#endif