/**
*   ************************************************************************************
*								上海芯圣电子股份有限公司
*								    www.holychip.cn
*	************************************************************************************
*	@Examle Version		V1.0.0.0
*	@Date				2017.09.15
*	************************************************************************************
*									 模块性能介绍
*	1、擦写次数10万次以上
*	2、扇区擦除时间约4.2ms，且擦除时不响应任何中断，但会置相关标志位，擦除完成后响应
*	3、可设置应用程序读保护，应用程序写保护（以1K字节为保护单位）
*	4、可以设置仿真器扇区读保护，扇区写保护（以4K字节为保护单位）
*	5、设置保护后无法擦写程序，读取的数据全为零
*	************************************************************************************
*									 应用注意事项
*	1、CPU时钟需要配置为1-16MHz之间的正整数，且Flash擦写之前需要配置FREQ_CLK寄存器，该寄
*	   存器值即为当前CPU时钟频率。
*	2、扇区擦除写入过程中不能被打断
*	3、数据存放地址需要在程序存放地址之后
*	4、第二复位向量使能时，无法在仿真环境下查看code区数据
*	************************************************************************************
*  								       客户服务
*	感谢您使用我们的单片机，若发现错误或对函数的使用存在疑问。请添加上海芯圣电子官方QQ群
*	****************************技术支持群：201030494***********************************
*   ************************************************************************************
**/
#include <stdio.h>
#include <string.h>

#include "HC89S105xx.h"
#include "main.h"
#include "xmodem.h"


#define Baudrate   115200//Baudrate

void System_init(void);	  							//系统初始化
void InitialUART1(unsigned long u32Baudrate);        //UART初始化

void Flash_EraseBlock(unsigned int Address);		//扇区擦除
void FLASH_ProgramWord(unsigned int Address,unsigned char datt);	//写入任一个数据到FLASH里面
void Flash_ReadArr(unsigned int Address,unsigned char Length,unsigned char *SaveArr);	//从FLASH里面读取任意长度的数据
//void Flash_RestWithReadOption(void);				//复位重读OPTION
void Flash_RestWithoutReadOption(void);	   			//复位不重读OPTION
//unsigned int Flash_HeadArr(unsigned int Address);	//计算当前地址的扇区首地址

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
  * @实现效果	
***************************************************************************************/		
void main(void)	
{
   unsigned char i;
   
	System_init();	   					//系统初始化
	FREQ_CLK = 0x10;					//扇区读写时钟初始化，FREQ_CLK值即为当前CPU频率
   receive_num = 0;
   retry_num = 0;
   try_times = 10;

   //Flash_ReadArr(0x907F,1,update);
   //if(update!=1)//无更新
   //{   
   //   Flash_RestWithoutReadOption();
   //}
   Flash_ReadArr(0x9000,128,eeprom_buff);
   if(eeprom_buff[127]!=1)//无更新
   {
      Flash_RestWithoutReadOption();
   }
   
   //更新应用程序
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
   Flash_RestWithoutReadOption();//用户启动程序的最后需要放置一条不重读代码选项的软件复位程序，那用户就会复位到0x0000H 处，开始执行用户应用程序。
}

unsigned char WriteFlash(unsigned char* DataAddress, unsigned char DataCount, unsigned char* Source)
{
   unsigned int Address = (unsigned int) DataAddress;
   unsigned char * DataPointer = Source;
   unsigned int Offset;
   //set offset according memory type
   Offset = FLASH_START;
    
   Flash_EraseBlock(Address);//删除该地址所在扇区
   
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
  * @说明  	系统初始化
  *	@参数	无
  * @返回值 无
  * @注		关闭看门狗以及时钟初始化
***************************************************************************************/
void System_init(void)
{
	WDTCCR = 0x00;						//关闭看门狗
/*
	while((CLKCON&0x20)!=0x20);			//等待内部高频晶振起振
	CLKDIV = 0x02;						//CPU时钟2分频，确保在进行RC32分频时CPU时钟小于16M
	CLKSWR &=~ 0x10;					//切换为内部高频时钟
	while((CLKSWR&0x40)!=0x00);			//等待内部高频切换完成
	CLKDIV = 0x04;						//OSC时钟4分频
*/  
	CLKCON=0x02; //enable内部高频RC
	while((CLKCON&0x20)!=0x20);			//等待内部高频RC起振
	CLKSWR &= ~0x10;						//选择内部高频时钟为主时钟，Fosc=32MHz
	while((CLKSWR&0x40)!=0x00);			//等待内部高频切换完成
	CLKDIV = 0x02;						//Fosc2分频得到Fcpu，Fcpu=16MHz 
}

void InitialUART1(unsigned long u32Baudrate) //
{
/**********************************UART配置初始化**************************************/
   P3M2=0x28; 							//P34推挽输出 P35上拉输入
   
   TXD_MAP = 0x1C;						//TXD映射P34
	RXD_MAP = 0x1D;						//RXD映射P35		
   SBRTH = (65536 - (1000000/u32Baudrate)-1)>>8;//0xFF;
	SBRTL = (65536 - (1000000/u32Baudrate)-1);//0x98;							//波特率9600 /*16 MHz */
	SCON2 = 0x12;						//独立波特率发生器，8位UART，波特率可变
	SCON = 0x10;						//允许串行接收
	//ES1 = 1;							//使能串口中断
	//EA = 1;								//使能总中断	
}

/***************************************************************************************
  * @说明  	扇区擦除，约消耗4.2ms的时间
  * @参数  	Address ：被擦除的扇区内的任意一个地址
  *			取值范围：0X0000-0XFFFF
  * @返回值 无
  * @注		只要操作扇区里面的任意一个地址，就可以擦除此扇区
***************************************************************************************/
void Flash_EraseBlock(unsigned int Address)
{
	IAP_CMD = 0xF00F;	//命令寄存器---解锁
	IAP_ADDR = Address;	//写入擦除地址
	IAP_CMD = 0xD22D;	//选择操作方式， 扇区擦除
	IAP_CMD = 0xE11E; 	//触发后 IAP_ADDRL&IAP_ADDRH 指向 0xFF，同时自动锁定
}

/***************************************************************************************
  * @说明  	写入任一个数据到FLASH里面
  * @参数  	Address ：FLASH起始地址
  *			取值范围：0X0000-0XFFFF
  *	@参数	datt：写入的数据
  *			取值范围：0X00-0XFF
  * @返回值 无
  * @注		写之前必须先对操作的扇区进行擦除
***************************************************************************************/
void FLASH_ProgramWord(unsigned int Address,unsigned char datt)
{
	IAP_DATA=datt; 		//待编程数据，写入数据寄存器必须放在解锁之前
	IAP_CMD=0xF00F;		//命令寄存器---解锁
	IAP_ADDR=Address;	//地址寄存器---写地址
	IAP_CMD=0xB44B;		//命令寄存器---字节编程
	IAP_CMD=0xE11E;		//命令寄存器---触发一次
}

#if 0
/***************************************************************************************
  * @说明  	软件复位重读OPTION
  * @参数  	无
  * @返回值 无
  * @注		在16K的ROM之外有一个只读的OPTION区域，存放的内容包括：用户定义的一些数据、用
  *			户设置的密码、芯片的一些配置、第二复位向量相关的内容
***************************************************************************************/
void Flash_RestWithReadOption(void)
{
	IAP_CMD=0xF00F;		//命令寄存器---解锁
	IAP_CMD=0x7887;		//命令寄存器---重读代码选项
} 
#endif
/***************************************************************************************
  * @说明  	软件复位不重读OPTION
  * @参数  	无
  * @返回值 无
  * @注		在16K的ROM之外有一个只读的OPTION区域，存放的内容包括：用户定义的一些数据、用
  *			户设置的密码、芯片的一些配置、第二复位向量相关的内容
***************************************************************************************/
void Flash_RestWithoutReadOption(void)
{
	IAP_CMD=0xF00F;		//命令寄存器---解锁
	IAP_CMD=0x8778;		//命令寄存器---不重读代码选项
}

/***************************************************************************************
  * @说明  	从FLASH里面读取任意长度的数据
  * @参数  	Address ：FLASH起始地址
  *			取值范围：0X0000-0XFFFF
  *	@参数	Length ： 读取数据长度
  *			取值范围：0X00-0XFF
  *	@参数	*SaveArr：读取数据存放的区域首地址
  * @返回值 无
  * @注		无
***************************************************************************************/
void Flash_ReadArr(unsigned int Address,unsigned char Length,unsigned char *SaveArr)
{
	while(Length--)
	*(SaveArr++)=*((unsigned char code *)(Address++));
}

#if 0
/***************************************************************************************
  * @说明  	计算当前地址的扇区首地址
  * @参数  	Address ：FLASH当前地址
  *			取值范围：0X0000-0XFFFF
  * @返回值 扇区首地址
  * @注		无
***************************************************************************************/
unsigned int Flash_HeadArr(unsigned int Address)
{
	Address&=~0x7f;
	return Address;
}
#endif


