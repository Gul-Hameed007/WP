#include "HC89S105xx.h"
#include "newtype.h"
#include "key.h"


static volatile int rcTimer = 0; // clear at head or overflow, plus at every timer
static int rcTimerPre = 0;				// set at every interrupt tail
static int rcState = 0;					// 0:no signal; 1:head; 2:bit; 3:repeat head; 4:repeat tail
static ulong rcData = 0; // receive 32 bit
static int rcBitCount = 0;				// count for 32 bit
static bool rcEnd = 0;						// end signal for counting pressing time
static uchar rcTemp[4];

static int rcKeyId = 0;			 // key id
static int rcRepeatCount = 0; // repeat cycle count

#define LONG_PRESS_TIME 10

int rcCheck(void) // check for keyid
{
	int keyid = KEY_NONE;
	if (rcKeyId == KEY_NONE)
	{ // no key is pressed
		return KEY_NONE;
	}
	else if (rcRepeatCount > 0 && rcRepeatCount < LONG_PRESS_TIME && rcEnd == 1)
	{ // a short press and has already end
		keyid = rcKeyId;
	}
	else if (rcRepeatCount >= LONG_PRESS_TIME)
	{ // a long press
		keyid = rcKeyId + KEY_LONG_PRESS;
	}
	else
	{ // a short press and is still going
		return KEY_NONE;
	}

	// clear working state
	rcState = 0;
	rcTimer = 0;
	rcEnd = 0;
	rcKeyId = KEY_NONE;
	rcRepeatCount = 0;
	rcTemp[2] = 0;
	return keyid;
} //int rcCheck()

void INT1_Rpt() interrupt INT1_VECTOR
{
	if (rcState == 0)
	{ // detect head and wait for it
		rcState = 1;
        rcEnd = 0;
		rcTimer = 0;
	}
	else if (rcState == 1 && (rcTimer - rcTimerPre) > 200)
	{ // receive head 
      // [9ms - 7000us~11000us] [4.5ms - 3000us~6000us]
		rcState = 2;
		rcData = 0;
		rcBitCount = 0;
	}
	else if (rcState == 2 && (rcTimer - rcTimerPre) < 54)
	{ // receive 32 bit 
      // HIGH+LOW [DATA0 - 600us~1600us] [DATA1 - 1800us~2700us]
		rcData <<= 1;
		if (rcTimer - rcTimerPre >= 34)
		{ //1.7ms == 1  otherwise == 0
			rcData |= 0X01;
		}
		rcBitCount++;
		if (rcBitCount >= 32)
		{
			rcState = 3;
		}
	}
	else if (rcState == 3 && rcTimer > 2000)
	{ // detect repeat head and wait for it
		rcTimer = 0;
		rcState = 4;
	}
	else if (rcState == 4 && (rcTimer - rcTimerPre) < 250)
	{ // receive a repeat head
		rcState = 3;
		rcRepeatCount++;
	}
	else
	{
		rcState = 0;
	}
	rcTimerPre = rcTimer;

	if (rcBitCount >= 32)
	{ // process receive data
		rcTemp[0] = (uchar)((rcData >> 24) & 0xff);
		rcTemp[1] = (uchar)((rcData >> 16) & 0xff);
		rcTemp[2] = (uchar)((rcData >> 8) & 0xff);
		rcTemp[3] = (uchar)((rcData >> 0) & 0xff);

		rcData = 0;
		rcBitCount = 0;
		rcRepeatCount = 1;

		if (rcTemp[2] == (uchar)(~rcTemp[3]))
		{
			switch(rcTemp[2])
			{
				case 0x41:
				case 0x18:
					rcKeyId = KEY_UP_PRESS;
					break;
				case 0x81:
				case 0x80:
					rcKeyId = KEY_MODE_PRESS;
					break;
				case 0x53:
				case 0x60:
					rcKeyId = KEY_DOWN_PRESS;
					break;
				case 0x00:
				case 0x04:
					rcKeyId = KEY_STOP_PRESS;
					break;
				case 0xf1:
				case 0x40:
					rcKeyId = KEY_MODE_UP_PRESS;
					break;
				case 0xf2:
				case 0xc8:
					rcKeyId = KEY_MODE_STOP_PRESS;
					break;
				case 0xf3:
				case 0x28:
					rcKeyId = KEY_MODE_DOWN_PRESS;
					break;
			}
			// if (rcTemp[2] == 0x41 || rcTemp[2] == 0x18) //41           // speed up
			// 	rcKeyId = KEY_UP_PRESS;
			// else if (rcTemp[2] == 0x81 || rcTemp[2] == 0x80) // 81      // mode
			// 	rcKeyId = KEY_MODE_PRESS;
			// else if (rcTemp[2] == 0x53 || rcTemp[2] == 0x60) // 53      // speed down
			// 	rcKeyId = KEY_DOWN_PRESS;
			// else if (rcTemp[2] == 0x00 || rcTemp[2] == 0x04) // 00      // stop
			// 	rcKeyId = KEY_STOP_PRESS;
			// else if (rcTemp[2] == 0xf1 || rcTemp[2] == 0x40) // mode + speed up
			// 	rcKeyId = KEY_MODE_UP_PRESS;
			// else if (rcTemp[2] == 0xf2 || rcTemp[2] == 0xc8) // mode + stop
			// 	rcKeyId = KEY_MODE_STOP_PRESS;
			// else if (rcTemp[2] == 0xf3 || rcTemp[2] == 0x28) // mode + speed down
			// 	rcKeyId = KEY_MODE_DOWN_PRESS;
		}
	}
}

void TIMER0_Rpt(void) interrupt TIMER0_VECTOR
{
	if (rcState > 0)
	{ // start timer count
		rcTimer++;
	}

	if (rcTimer > 2400)
	{ // time overflow, no more repeat
        if(rcState == 3 || rcState == 4)
        {
            rcEnd = 1;
        }
		rcState = 0;
		rcTimer = 0;
		rcTemp[2] = 0;
	}
}
