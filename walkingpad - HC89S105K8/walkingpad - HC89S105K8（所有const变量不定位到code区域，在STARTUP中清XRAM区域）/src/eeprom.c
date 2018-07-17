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
  * @˵��  	����������Լ����4.2ms��ʱ��
  * @����  	fui_Address ���������������ڵ�����һ����ַ
  *			ȡֵ��Χ��0x0000-0x3FFF
  * @����ֵ ��
  * @ע		ֻҪ�����������������һ����ַ���Ϳ��Բ���������
  *-------------------------------------------------------------*/
void Flash_EraseBlock(uint addr)
{
	EA = 0;
	IAP_CMD = 0xF00F;				//Flash����
	IAP_ADDR = addr;			//д�������ַ
	IAP_CMD = 0xD22D;				//ѡ�������ʽ�� ��������
	IAP_CMD = 0xE11E; 				//������IAP_ADDRL&IAP_ADDRHָ��0xFF��ͬʱ�Զ�����
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
   
   for(i=0;i<128;i++)//�ڲ���֮ǰ��������������ȫ���洢ֵ
      eeprom_buff[i] = eeprom_rdchar(EEPROM_ADDR_INI+i);
	Flash_EraseBlock(EEPROM_ADDR_INI);//���µ�һ��д��ǰ�������Ȳ�������Ȼ��д���ֵ�᲻����ȷ�洢	
   
   eeprom_buff[addr-EEPROM_ADDR_INI] = ucdata;//�滻ΪҪд�����ֵ
   EA=0;
   for(i=0;i<128;i++)//��ȫ��д��
   {
      addr=EEPROM_ADDR_INI+i;
		//FREQ_CLK = 0x10;					//ָ����ǰϵͳʱ��
	   IAP_DATA=eeprom_buff[i]; 	//��������ݣ�д�����ݼĴ���������ڽ���֮ǰ
		IAP_CMD=0xF00F;		//Flash����
		IAP_ADDR=addr;		   //д���ַ
		IAP_CMD=0xB44B;		//�ֽڱ��
		IAP_CMD=0xE11E;	   //����һ�β���	
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
