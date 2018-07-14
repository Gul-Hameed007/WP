#ifndef __SENSOR_H
#define __SENSOR_H
#include "newtype.h"

 euchar flag_Gsensor_disconnected;
 eulong tension, tension2;
 elong tension_bias, tension2_bias;
 euchar no_current_cnt;
 euchar fold_cnt;

void HX711_Weight(void);
void calc_disconnect(void);

#endif