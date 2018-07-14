/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *  Copyright (c) 2002 by MKS Controls
 *
 *
 *  File name: eeprom.c
 *  Module:
 *  Language:  ANSI C
 *  $Revision: 1 $
 *
 *  This is an embedded software module design for interrupt process routine.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
#include <declare.h>
#include <eeprom.h>
#include "run_mode.h"
#include "miwifi.h"


@near eulong user_total_distance;

/*---------------------------------------------------------------------------*
 |  eeprom_wrchar
 |
 |  write uchar to eeprom; if done, return 1, or 0
 *---------------------------------------------------------------------------*/
uchar eeprom_wrchar(uint addr, uchar ucdata)
{
    //while(EOP_FLAG==1)return(0);
    FLASH->DUKR = 0xAE;
    FLASH->DUKR = 0x56; //unlock
    //FLASH->CR2 = 0x00; //
    //FLASH->NCR2 = 0xFF;
    *((u8 *)addr) = ucdata;
    while ((FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS)) == 0)
        ;
    FLASH->IAPSR = (u8)(~0x08); //lock at last
    //return(1);
}

void eeprom_write_long(uint addr, ulong ucdata)
{
    //while(EOP_FLAG==1)return(0);
    FLASH->DUKR = 0xAE;
    FLASH->DUKR = 0x56; //unlock
    //FLASH->CR2 = 0x00; //
    //FLASH->NCR2 = 0xFF;
    *((u8 *)addr) = *((u8 *)(&ucdata));
    *((u8 *)(addr + 1)) = *((u8 *)(&ucdata) + 1);
    *((u8 *)(addr + 2)) = *((u8 *)(&ucdata) + 2);
    *((u8 *)(addr + 3)) = *((u8 *)(&ucdata) + 3);
    while ((FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS)) == 0)
        ;
    FLASH->IAPSR = (u8)(~0x08); //lock at last
}

void eeprom_write_int(uint addr, uint ucdata)
{
    //while(EOP_FLAG==1)return(0);
    FLASH->DUKR = 0xAE;
    FLASH->DUKR = 0x56; //unlock
    //FLASH->CR2 = 0x00; //
    //FLASH->NCR2 = 0xFF;
    *((u8 *)addr) = *((u8 *)(&ucdata));
    *((u8 *)(addr + 1)) = *((u8 *)(&ucdata) + 1);
    while ((FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS)) == 0)
        ;
    FLASH->IAPSR = (u8)(~0x08); //lock at last
}

void eeprom_read(void)
{
    user_total_distance = eeprom_read_long(EEPROM_ADDR_TOTAL_DIST);
    dc_motor_rating_volt = eeprom_rdchar(EEPROM_ADDR_RATING_VOLT);
    dc_motor_rating_f1 = eeprom_rdchar(EEPROM_ADDR_RATING_F1);
    dc_motor_startup_volt = eeprom_rdchar(EEPROM_ADDR_STARTUP_VOLT);
    runmode = eeprom_rdchar(EEPROM_ADDR_RUNMODE);
    fixed_start_speed = eeprom_rdchar(EEPROM_ADDR_FIXED_SPEED);
    speed_limit_max = eeprom_rdchar(EEPROM_ADDR_SPEED_LIMIT);
    tutorial_finish = eeprom_rdchar(EEPROM_ADDR_TUTORIAL_FINISH);
    acceleration_param = eeprom_rdchar(EEPROM_ADDR_ACC_PARAM);
    factory_finish = eeprom_rdchar(EEPROM_ADDR_FACTORY_FINISH);
    max_speed_unlocked = eeprom_rdchar(EEPROM_ADDR_MAX_SPEED_UNLOCKED);
    flag_auto = eeprom_rdchar(EEPROM_ADDR_AUTO);
    flag_disp = eeprom_rdchar(EEPROM_ADDR_DISP);

    goal_type = eeprom_rdchar(EEPROM_ADDR_GOAL_TYPE);
    goal_value = eeprom_read_int(EEPROM_ADDR_GOAL_VALUE);

    store_point.offline_dist = eeprom_read_int(EEPROM_ADDR_OFFLINE_DIST);
    store_point.offline_energy = eeprom_read_long(EEPROM_ADDR_OFFLINE_ENERGY);
    store_point.offline_steps = eeprom_read_int(EEPROM_ADDR_OFFLINE_STEPS);
    store_point.offline_time = eeprom_read_int(EEPROM_ADDR_OFFLINE_TIME);
}

void eeprom_factory(void)
{
    // clear all first
    uint addr;
    FLASH->DUKR = 0xAE;
    FLASH->DUKR = 0x56; //unlock
    for (addr = EEPROM_ADDR_INI; addr < EEPROM_ADDR_RATING_VOLT; addr++)
        *((u8 *)addr) = (u8)0;
    for (addr = EEPROM_ADDR_RUNMODE; addr <= EEPROM_ADDR_FLAG_UPDATE; addr++) // skip F1 F2 F3
        *((u8 *)addr) = (u8)0;
    while ((FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS)) == 0)
        ;
    FLASH->IAPSR = (u8)(~0x08); //lock at last

    eeprom_wrchar(EEPROM_ADDR_RUNMODE, RUN_MODE_FIXED);
    eeprom_wrchar(EEPROM_ADDR_FACTORY_FINISH, 1);
}
