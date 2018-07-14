#ifndef __KEY_H
#define __KEY_H
#include "newtype.h"

#define KEY_NONE 0x0000
#define KEY_MODE_PRESS 0x0001
#define KEY_UP_PRESS 0x0002
#define KEY_STOP_PRESS 0x0003
#define KEY_DOWN_PRESS 0x0004

#define KEY_MODE_UP_PRESS 0x0011
#define KEY_MODE_STOP_PRESS 0x0012
#define KEY_MODE_DOWN_PRESS 0x0013

#define KEY_LONG_PRESS 0x0100
#define KEY_MODE_LONG_PRESS 0x0101
#define KEY_UP_LONG_PRESS 0x0102
#define KEY_STOP_LONG_PRESS 0x0103
#define KEY_DOWN_LONG_PRESS 0x0104

#define KEY_MODE_UP_LONG_PRESS 0x0111
#define KEY_MODE_STOP_LONG_PRESS 0x0112
#define KEY_MODE_DOWN_LONG_PRESS 0x0113

#define KEY_MODE_PRESS_BTN 0x1000
#define KEY_MODE_LONG_PRESS_BTN 0x1100

euint key_id;      //key ID
ebool key_id_done;//indicate the key has been processed. reset when key released

void check_key_id(void);
#endif