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


eulong user_total_distance;
uchar eeprom_buff[128];
/**-------------------------------------------------------------*
  * @说明  	扇区擦除，约消耗4.2ms的时间
  * @参数  	fui_Address ：被擦除的扇区内的任意一个地址
  *			取值范围：0x0000-0x3FFF
  * @返回值 无
  * @注		只要操作扇区里面的任意一个地址，就可以擦除此扇区
  *-------------------------------------------------------------*/
void Flash_EraseBlock(uint addr)
{
	EA = 0;
	IAP_CMD = 0xF00F;				//Flash解锁
	IAP_ADDR = addr;			//写入擦除地址
	IAP_CMD = 0xD22D;				//选择操作方式， 扇区擦除
	IAP_CMD = 0xE11E; 				//触发后IAP_ADDRL&IAP_ADDRH指向0xFF，同时自动锁定
	EA = 1;
}
/*---------------------------------------------------------------------------*
 |  eeprom_wrchar
 |
 |  write uchar to eeprom; if done, return 1, or 0
 *---------------------------------------------------------------------------*/
uchar eeprom_wrchar(uint addr, uchar ucdata)
{
   uchar i;   
   
   for(i=0;i<128;i++)//在擦除之前，读出该扇区的全部存储值
      eeprom_buff[i] = eeprom_rdchar(EEPROM_ADDR_INI+i);
	Flash_EraseBlock(EEPROM_ADDR_INI);//在新的一次写入前，必须先擦除，不然新写入的值会不能正确存储	
   
   eeprom_buff[addr-EEPROM_ADDR_INI] = ucdata;//替换为要写入的新值
   EA=0;
   for(i=0;i<128;i++)//再全部写入
   {
      addr=EEPROM_ADDR_INI+i;
		//FREQ_CLK = 0x10;					//指明当前系统时钟
	   IAP_DATA=eeprom_buff[i]; 	//待编程数据，写入数据寄存器必须放在解锁之前
		IAP_CMD=0xF00F;		//Flash解锁
		IAP_ADDR=addr;		   //写入地址
		IAP_CMD=0xB44B;		//字节编程
		IAP_CMD=0xE11E;	   //触发一次操作	
	}
   EA=1;

   return(1);
}

void eeprom_write_long(uint addr, ulong ucdata)
{
      uchar i;
      for(i=0;i<4;i++)
      {
            eeprom_wrchar(addr+i,*((u8 *)(&ucdata) + i));
      }
}

void eeprom_write_int(uint addr, uint ucdata)
{
      uchar i;
      for(i=0;i<2;i++)
      {
            eeprom_wrchar(addr+i,*((u8 *)(&ucdata) + i));
      }
}

void eeprom_read(void)
{
    user_total_distance = eeprom_read_long(EEPROM_ADDR_TOTAL_DIST);
    dc_motor_rating_volt = eeprom_rdchar(EEPROM_ADDR_RATING_VOLT);
    dc_motor_rating_f1 = eeprom_rdchar(EEPROM_ADDR_RATING_F1);
    dc_motor_startup_volt = eeprom_rdchar(EEPROM_ADDR_STARTUP_VOLT);
    runmode = eeprom_rdchar(EEPROM_ADDR_RUNMODE);
    if (runmode == RUN_MODE_NEW) 
    {
        runmode = RUN_MODE_FIXED;
    }
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
    uint addr;
    // clear all first
    for (addr = EEPROM_ADDR_INI; addr < EEPROM_ADDR_RATING_VOLT; addr++)
        eeprom_wrchar(addr,0);
    for (addr = EEPROM_ADDR_RUNMODE; addr <= EEPROM_ADDR_TEST_STATE; addr++) // skip F1 F2 F3
        eeprom_wrchar(addr,0);

    eeprom_wrchar(EEPROM_ADDR_RUNMODE, RUN_MODE_FIXED);
    eeprom_wrchar(EEPROM_ADDR_FACTORY_FINISH, 1);
    eeprom_wrchar(EEPROM_ADDR_FLAG_UPDATE, 0);
}
