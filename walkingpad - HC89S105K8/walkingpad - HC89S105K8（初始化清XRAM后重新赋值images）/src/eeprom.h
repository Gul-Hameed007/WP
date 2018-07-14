#ifndef __EEPROM_H
#define __EEPROM_H
#include "newtype.h"

//initial address of EEPROM
#define EEPROM_ADDR_INI 0x9000

#define EEPROM_ADDR(offset) (EEPROM_ADDR_INI + offset)

#define EEPROM_ADDR_TOTAL_DIST          EEPROM_ADDR(1)   //u32
#define EEPROM_ADDR_RATING_VOLT         EEPROM_ADDR(6)
#define EEPROM_ADDR_RATING_F1           EEPROM_ADDR(7)
#define EEPROM_ADDR_STARTUP_VOLT        EEPROM_ADDR(8)
#define EEPROM_ADDR_RUNMODE             EEPROM_ADDR(11)
#define EEPROM_ADDR_FIXED_SPEED         EEPROM_ADDR(12)
#define EEPROM_ADDR_SPEED_LIMIT         EEPROM_ADDR(13)
#define EEPROM_ADDR_TUTORIAL_FINISH     EEPROM_ADDR(14)
#define EEPROM_ADDR_ACC_PARAM           EEPROM_ADDR(15)
#define EEPROM_ADDR_FACTORY_FINISH      EEPROM_ADDR(16)
#define EEPROM_ADDR_MAX_SPEED_UNLOCKED  EEPROM_ADDR(17)
#define EEPROM_ADDR_AUTO                EEPROM_ADDR(18)
#define EEPROM_ADDR_DISP                EEPROM_ADDR(19)

#define EEPROM_ADDR_GOAL_TYPE           EEPROM_ADDR(20)
#define EEPROM_ADDR_GOAL_VALUE          EEPROM_ADDR(21)  //u16

#define EEPROM_ADDR_OFFLINE_DIST        EEPROM_ADDR(23)  //u16
#define EEPROM_ADDR_OFFLINE_ENERGY      EEPROM_ADDR(25)  //u32
#define EEPROM_ADDR_OFFLINE_STEPS       EEPROM_ADDR(29)  //u16
#define EEPROM_ADDR_OFFLINE_TIME        EEPROM_ADDR(31)  //u16

#define EEPROM_ADDR_ERROR_ID            EEPROM_ADDR(35)
#define EEPROM_ADDR_ERROR_TIME          EEPROM_ADDR(36)  //u32

#define EEPROM_ADDR_TEST_STATE          EEPROM_ADDR(125)
#define EEPROM_ADDR_INSURE_BINDED       EEPROM_ADDR(126)
#define EEPROM_ADDR_FLAG_UPDATE         EEPROM_ADDR(127)


#define eeprom_rdchar(addr)     (*((u8 code*)addr))
#define eeprom_read_int(addr)   (eeprom_rdchar(addr)<<8 | eeprom_rdchar(addr+1))//(*((u16 code*)addr))
#define eeprom_read_long(addr)  (eeprom_rdchar(addr)<<24 | eeprom_rdchar(addr+1)<<16 | eeprom_rdchar(addr+2)<<8 | eeprom_rdchar(addr+3))//(*((u32 code*)addr))

uchar eeprom_wrchar(uint addr, uchar ucdata);
void eeprom_read(void);
void eeprom_write_long(uint addr, ulong value);
void eeprom_write_int(uint addr, uint value);
void eeprom_factory(void);

#endif