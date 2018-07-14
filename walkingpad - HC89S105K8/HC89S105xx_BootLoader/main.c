/**
*   ************************************************************************************
*								�Ϻ�оʥ���ӹɷ����޹�˾
*								    www.holychip.cn
*	************************************************************************************
*	@Examle Version		V1.0.0.0
*	@Date				2017.09.15
*	************************************************************************************
*									 ģ�����ܽ���
*	1����д����10�������
*	2����������ʱ��Լ4.2ms���Ҳ���ʱ����Ӧ�κ��жϣ���������ر�־λ��������ɺ���Ӧ
*	3��������Ӧ�ó����������Ӧ�ó���д��������1K�ֽ�Ϊ������λ��
*	4���������÷���������������������д��������4K�ֽ�Ϊ������λ��
*	5�����ñ������޷���д���򣬶�ȡ������ȫΪ��
*	************************************************************************************
*									 Ӧ��ע������
*	1��CPUʱ����Ҫ����Ϊ1-16MHz֮�������������Flash��д֮ǰ��Ҫ����FREQ_CLK�Ĵ������ü�
*	   ����ֵ��Ϊ��ǰCPUʱ��Ƶ�ʡ�
*	2����������д������в��ܱ����
*	3�����ݴ�ŵ�ַ��Ҫ�ڳ����ŵ�ַ֮��
*	4���ڶ���λ����ʹ��ʱ���޷��ڷ��滷���²鿴code������
*	************************************************************************************
*  								       �ͻ�����
*	��л��ʹ�����ǵĵ�Ƭ���������ִ����Ժ�����ʹ�ô������ʡ�������Ϻ�оʥ���ӹٷ�QQȺ
*	****************************����֧��Ⱥ��201030494***********************************
*   ************************************************************************************
**/
#include <stdio.h>
#include <string.h>

#include "HC89S105xx.h"
#include "main.h"
#include "xmodem.h"


#define Baudrate   115200//Baudrate

void System_init(void);	  							//ϵͳ��ʼ��
void InitialUART1(unsigned long u32Baudrate);        //UART��ʼ��

void Flash_EraseBlock(unsigned int Address);		//��������
void FLASH_ProgramWord(unsigned int Address,unsigned char datt);	//д����һ�����ݵ�FLASH����
void Flash_ReadArr(unsigned int Address,unsigned char Length,unsigned char *SaveArr);	//��FLASH�����ȡ���ⳤ�ȵ�����
//void Flash_RestWithReadOption(void);				//��λ�ض�OPTION
void Flash_RestWithoutReadOption(void);	   			//��λ���ض�OPTION
//unsigned int Flash_HeadArr(unsigned int Address);	//���㵱ǰ��ַ�������׵�ַ

char const code query_get[]="get_down\r";
char const code query_update[]="update_fw";
char const code result_ready[]="result \"ready\"\r";
char const code result_ok[]="ok";
//char const code reboot[]="reboot\r";
char recv[21];

unsigned int receive_num,retry_num;            // xmodem receive num, reboot try num
unsigned char eeprom_buff[128],try_times;					// 1:update 0:goto user application

#if 0
void delay(unsigned long dly_cnt)
{
   while(dly_cnt>0)dly_cnt--;
}
#endif
/***************************************************************************************
  * @ʵ��Ч��	
***************************************************************************************/		
void main(void)	
{
   unsigned char i;
   
	System_init();	   					//ϵͳ��ʼ��
	FREQ_CLK = 0x10;					//������дʱ�ӳ�ʼ����FREQ_CLKֵ��Ϊ��ǰCPUƵ��
   receive_num = 0;
   retry_num = 0;
   try_times = 10;

   //Flash_ReadArr(0x907F,1,update);
   //if(update!=1)//�޸���
   //{   
   //   Flash_RestWithoutReadOption();
   //}
   Flash_ReadArr(0x9000,128,eeprom_buff);
   if(eeprom_buff[127]!=1)//�޸���
   {
      Flash_RestWithoutReadOption();
   }
   
   //����Ӧ�ó���
   InitialUART1(Baudrate);
   while(try_times --)
   {
      _outnbyte(query_get,sizeof(query_get)-1);
		if(_innbyte(recv,15,2)>0)
		{
         recv[14]='\0';
			if(strstr(recv,query_update)==NULL)	continue;
		}
		else continue;
	
		_outnbyte(result_ready,sizeof(result_ready)-1);
		if(_innbyte(recv,3,2)>0)
		{
			recv[2]='\0';
			if(strstr(recv,result_ok)==NULL)
			{
				continue;
			}
		}
		else continue;

		receive_num=xmodemReceive((unsigned char *)MAIN_USER_RESET_ADDR,(int)(FLASH_END-FLASH_START));
      if(receive_num>0)
      {
            // while(1)
            // {
            //     retry_num=10;
            //     _outnbyte(reboot,sizeof(reboot)-1);
            //     if(_innbyte(recv,3,2)>0 && retry_num > 0)
            //     {
            //         retry_num--;
            //         recv[2]='\0';
            //         if(strstr(recv,result_ok)!=NULL)    break;
            //     }
            // }
         Flash_EraseBlock(0x9000);
         eeprom_buff[127]=0;
         for(i=0;i<128;i++)
         {
            FLASH_ProgramWord(0x9000+i,eeprom_buff[i]);
         }
         break;
      }
   }
   Flash_RestWithoutReadOption();//�û���������������Ҫ����һ�����ض�����ѡ��������λ�������û��ͻḴλ��0x0000H ������ʼִ���û�Ӧ�ó���
}

unsigned char WriteFlash(unsigned char* DataAddress, unsigned char DataCount, unsigned char* Source)
{
   unsigned int Address = (unsigned int) DataAddress;
   unsigned char * DataPointer = Source;
   unsigned int Offset;
   //set offset according memory type
   Offset = FLASH_START;
    
   Flash_EraseBlock(Address);//ɾ���õ�ַ��������
   
   while(DataCount>0)
   {
      FLASH_ProgramWord(Address,*DataPointer);	
      Address++;
      DataPointer++;
      DataCount--;
   }
   
   return 1;
}//WriteFlash

/***************************************************************************************
  * @˵��  	ϵͳ��ʼ��
  *	@����	��
  * @����ֵ ��
  * @ע		�رտ��Ź��Լ�ʱ�ӳ�ʼ��
***************************************************************************************/
void System_init(void)
{
	WDTCCR = 0x00;						//�رտ��Ź�
/*
	while((CLKCON&0x20)!=0x20);			//�ȴ��ڲ���Ƶ��������
	CLKDIV = 0x02;						//CPUʱ��2��Ƶ��ȷ���ڽ���RC32��ƵʱCPUʱ��С��16M
	CLKSWR &=~ 0x10;					//�л�Ϊ�ڲ���Ƶʱ��
	while((CLKSWR&0x40)!=0x00);			//�ȴ��ڲ���Ƶ�л����
	CLKDIV = 0x04;						//OSCʱ��4��Ƶ
*/  
	CLKCON=0x02; //enable�ڲ���ƵRC
	while((CLKCON&0x20)!=0x20);			//�ȴ��ڲ���ƵRC����
	CLKSWR &= ~0x10;						//ѡ���ڲ���Ƶʱ��Ϊ��ʱ�ӣ�Fosc=32MHz
	while((CLKSWR&0x40)!=0x00);			//�ȴ��ڲ���Ƶ�л����
	CLKDIV = 0x02;						//Fosc2��Ƶ�õ�Fcpu��Fcpu=16MHz 
}

void InitialUART1(unsigned long u32Baudrate) //
{
/**********************************UART���ó�ʼ��**************************************/
   P3M2=0x28; 							//P34������� P35��������
   
   TXD_MAP = 0x1C;						//TXDӳ��P34
	RXD_MAP = 0x1D;						//RXDӳ��P35		
   SBRTH = (65536 - (1000000/u32Baudrate)-1)>>8;//0xFF;
	SBRTL = (65536 - (1000000/u32Baudrate)-1);//0x98;							//������9600 /*16 MHz */
	SCON2 = 0x12;						//���������ʷ�������8λUART�������ʿɱ�
	SCON = 0x10;						//�����н���
	//ES1 = 1;							//ʹ�ܴ����ж�
	//EA = 1;								//ʹ�����ж�	
}

/***************************************************************************************
  * @˵��  	����������Լ����4.2ms��ʱ��
  * @����  	Address ���������������ڵ�����һ����ַ
  *			ȡֵ��Χ��0X0000-0XFFFF
  * @����ֵ ��
  * @ע		ֻҪ�����������������һ����ַ���Ϳ��Բ���������
***************************************************************************************/
void Flash_EraseBlock(unsigned int Address)
{
	IAP_CMD = 0xF00F;	//����Ĵ���---����
	IAP_ADDR = Address;	//д�������ַ
	IAP_CMD = 0xD22D;	//ѡ�������ʽ�� ��������
	IAP_CMD = 0xE11E; 	//������ IAP_ADDRL&IAP_ADDRH ָ�� 0xFF��ͬʱ�Զ�����
}

/***************************************************************************************
  * @˵��  	д����һ�����ݵ�FLASH����
  * @����  	Address ��FLASH��ʼ��ַ
  *			ȡֵ��Χ��0X0000-0XFFFF
  *	@����	datt��д�������
  *			ȡֵ��Χ��0X00-0XFF
  * @����ֵ ��
  * @ע		д֮ǰ�����ȶԲ������������в���
***************************************************************************************/
void FLASH_ProgramWord(unsigned int Address,unsigned char datt)
{
	IAP_DATA=datt; 		//��������ݣ�д�����ݼĴ���������ڽ���֮ǰ
	IAP_CMD=0xF00F;		//����Ĵ���---����
	IAP_ADDR=Address;	//��ַ�Ĵ���---д��ַ
	IAP_CMD=0xB44B;		//����Ĵ���---�ֽڱ��
	IAP_CMD=0xE11E;		//����Ĵ���---����һ��
}

#if 0
/***************************************************************************************
  * @˵��  	�����λ�ض�OPTION
  * @����  	��
  * @����ֵ ��
  * @ע		��16K��ROM֮����һ��ֻ����OPTION���򣬴�ŵ����ݰ������û������һЩ���ݡ���
  *			�����õ����롢оƬ��һЩ���á��ڶ���λ������ص�����
***************************************************************************************/
void Flash_RestWithReadOption(void)
{
	IAP_CMD=0xF00F;		//����Ĵ���---����
	IAP_CMD=0x7887;		//����Ĵ���---�ض�����ѡ��
} 
#endif
/***************************************************************************************
  * @˵��  	�����λ���ض�OPTION
  * @����  	��
  * @����ֵ ��
  * @ע		��16K��ROM֮����һ��ֻ����OPTION���򣬴�ŵ����ݰ������û������һЩ���ݡ���
  *			�����õ����롢оƬ��һЩ���á��ڶ���λ������ص�����
***************************************************************************************/
void Flash_RestWithoutReadOption(void)
{
	IAP_CMD=0xF00F;		//����Ĵ���---����
	IAP_CMD=0x8778;		//����Ĵ���---���ض�����ѡ��
}

/***************************************************************************************
  * @˵��  	��FLASH�����ȡ���ⳤ�ȵ�����
  * @����  	Address ��FLASH��ʼ��ַ
  *			ȡֵ��Χ��0X0000-0XFFFF
  *	@����	Length �� ��ȡ���ݳ���
  *			ȡֵ��Χ��0X00-0XFF
  *	@����	*SaveArr����ȡ���ݴ�ŵ������׵�ַ
  * @����ֵ ��
  * @ע		��
***************************************************************************************/
void Flash_ReadArr(unsigned int Address,unsigned char Length,unsigned char *SaveArr)
{
	while(Length--)
	*(SaveArr++)=*((unsigned char code *)(Address++));
}

#if 0
/***************************************************************************************
  * @˵��  	���㵱ǰ��ַ�������׵�ַ
  * @����  	Address ��FLASH��ǰ��ַ
  *			ȡֵ��Χ��0X0000-0XFFFF
  * @����ֵ �����׵�ַ
  * @ע		��
***************************************************************************************/
unsigned int Flash_HeadArr(unsigned int Address)
{
	Address&=~0x7f;
	return Address;
}
#endif


