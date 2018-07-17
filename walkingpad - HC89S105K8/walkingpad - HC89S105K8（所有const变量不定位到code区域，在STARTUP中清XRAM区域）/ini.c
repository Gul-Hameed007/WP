#include "declare.h"
#include "displaydriver.h"
#include "eeprom.h"
#include "image.h"

//XRAM
#define XRAM_ADDR_START          0x0000
#define XRAM_ADDR_END            0x07ff
//uchar reset_state;

eulong user_total_distance;
/*****************************************************************************************/
static void portddr_set(void)
{
	//GPIO config
	/* P0*/
	P0M0 = 0x08;
   K1=1;
	P0M1 = 0x88;
	P0M2 = 0x88;
   LED_CS2 = 1;
	P0M3 = 0x88;
   LED_RD = 1;	
	/* P1*/
	P1M0 = 0x88;
   K3=1;
   K4=1;
	P1M1 = 0x82;
	P1M2 = 0x82;
	P1M3 = 0x88;
	/* P2*/
	P2M0 = 0x08;
	P2M1 = 0x08;
	P2M2 = 0x80;
	P2M3 = 0x88;
	/* P3*/
	P3M0 = 0x88;
	P3M1 = 0x82;
	P3M2 = 0x28;
	P3M3 = 0x88;
   BEEP_OFF;
	/* P4*/
	P4M0 = 0x88;
	P4M1 = 0x88;		
   K2=1;
	/* P5*/
	P5M0 = 0x88;
	P5M1 = 0x88;
	P5M2 = 0x88;	
	DT=1;
}

/*****************************************************************************************/

static void Exti1_ini(void)
{
   // P01 input for rc control TLI interrupt
	PITS0 |= 0x04;						//下降沿中断
	INT1_MAP = 0x01;					//INT1映射P0.1端口
	IE |= 0x04;							//打开INT1中断
	EA = 1;								//打开总中断
} //ExtiInit
/*****************************************************************************************/

static void timer0_ini(void)
{
	//Produce an 50us interruption 
/**********************************TIM0配置初始化**************************************/
	TCON1 |= 0x01;						//T0定时器时钟为Fcpu
	TMOD &= ~0x03;						//16位重装载定时器/计数器
	TH0 = 0xfc;
	TL0 = 0xe0;
	ET0 = 1;							//打开T0中断
	TCON |= 0x10;						//使能T0
	EA = 1;								//打开总中断	
}
void wdg_ini(void)
{
	/************************
	* WDT MCU reset
	************************/	
	WDTCCR = 0x00;						//关闭看门狗
/***********************************WDT配置初始化**************************************/
	WDTC = 0x57;						//允许WDT复位，允许掉电/空闲模式下运行，1024分频

	//WDT使用的是RC38K时钟，WDT_CLOCK_1024是1024分频，初值为0xFF
	//定时时间 	= 1024 * 9 / 38000
	//			    = 242ms
	WDTCCR = 40;//9;	//写入00时，将关闭WDT功能（但不关闭内部低频RC），
							//即相当于禁止WDT。写入非0数据时，将启动WDT。
}
void feed_wdg(void)
{
	WDTC |= 0x10;  //清狗
	//WDTCCR = 0x00;						//关闭看门狗
}
void clock_ini(void)
{
   WDTCCR = 0;	//关闭WDT
	CLKCON|=0x02; //enable内部高频RC
	while((CLKCON&0x20)!=0x20);			//等待内部高频RC起振
	CLKSWR &= ~0x10;						//选择内部高频时钟为主时钟，Fosc=32MHz
	while((CLKSWR&0x40)!=0x00);			//等待内部高频切换完成
	CLKDIV = 0x02;						//Fosc2分频得到Fcpu，Fcpu=16MHz 
}
void timer1_ini(void)
{
	//Produce an 200us interruption 
/**********************************TIM1配置初始化**************************************/
	TCON1 |= 0x10;						//T1定时器时钟为Fcpu
	TMOD &= ~0x30;						//16位重装载定时器/计数器
	TH1 = TIMER1_CNT>>8;
	TL1 = TIMER1_CNT;
	ET1 = 1;							//打开T1中断
	TCON |= 0x40;						//使能T1
    
	EA = 1;								//打开总中断	
}
void InitialUART1(ulong u32Baudrate) //WIFI通信
{
/**********************************UART配置初始化**************************************/
   TXD_MAP = 0x1C;						//TXD映射P34
	RXD_MAP = 0x1D;						//RXD映射P35		
   SBRTH = (65536 - (1000000/u32Baudrate)-1)>>8;//0xFF;
	SBRTL = (65536 - (1000000/u32Baudrate)-1);//0x98;							//波特率9600 /*16 MHz */
	SCON2 = 0x12;						//独立波特率发生器，8位UART，波特率可变
	SCON = 0x10;						//允许串行接收
	ES1 = 1;							//使能串口中断
	EA = 1;								//使能总中断	
}
void InitialUART2(ulong u32Baudrate) //下控通信
{
/**********************************UART配置初始化**************************************/
	TXD2_MAP = 0x1B;						//TXD映射P33
	RXD2_MAP = 0x1A;						//RXD映射P32		
   S2BRTH = (65536 - (1000000/u32Baudrate)-1)>>8;//0xFF;
	S2BRTL = (65536 - (1000000/u32Baudrate)-1);//0x98;							//波特率9600 /*16 MHz */
	S2CON2 = 0x12;						//独立波特率发生器，8位UART，波特率可变
	S2CON = 0x10;						//允许串行接收
	ES2 = 1;							//使能串口中断
	EA = 1;								//使能总中断	
}

void init_params(void)
{
    waiting_cnt = DISPLAY_ALL_ON_DELAY; //all on for 1 second
    waiting = 1;

    eeprom_read();

    //eeprom_read_motor_para();
    if (dc_motor_startup_volt < DC_MOTOR_STARTUP_VOLT_MIN ||dc_motor_startup_volt>DC_MOTOR_STARTUP_VOLT_MAX)
    {
        dc_motor_startup_volt = DC_MOTOR_STARTUP_VOLT_DEFAULT;
    }

    if (dc_motor_rating_volt < DC_MOTOR_RATING_VOLT_MIN || dc_motor_rating_volt > DC_MOTOR_RATING_VOLT_MAX)
    {
        dc_motor_rating_volt = DC_MOTOR_RATING_VOLT_DEFAULT;
    }
    if (dc_motor_rating_f1 < DC_MOTOR_RATING_F1_MIN ||dc_motor_rating_f1>DC_MOTOR_RATING_F1_MAX)
    {
        dc_motor_rating_f1 = DC_MOTOR_RATING_F1_DEFAULT;
    }
    //if(dc_motor_step_para<DC_MOTOR_STEP_PARA_MIN||dc_motor_step_para>DC_MOTOR_STEP_PARA_MAX)
    //{
    //    dc_motor_step_para=DC_MOTOR_STEP_PARA_DEFAULT;
    //}

    if (speed_limit_max < SPEED_TARGET_MIN1 || speed_limit_max > SPEED_TARGET_MAX)
    {
        speed_limit_max = SPEED_LIMIT_MAX_FACTORY;
    }

     if (fixed_start_speed > speed_limit_max || fixed_start_speed < SPEED_TARGET_MIN1)
     {
         fixed_start_speed = FIXED_MODE_DEFAULT_SPEED;
     }

    //FIXME: default speed for manual mode
    //fixed_mode_speed = FIXED_MODE_DEFAULT_SPEED;

    if (acceleration_param < 1 || acceleration_param > 3)
    {
        acceleration_param = 2;
    }

#if 0
    if (user_total_distance > 200 && max_speed_unlocked == 0)
    {
        speed_limit_max = SPEED_TARGET_MAX;
        max_speed_unlocked = 1;
        eeprom_wrchar(EEPROM_ADDR_MAX_SPEED_UNLOCKED, 1);
        eeprom_wrchar(EEPROM_ADDR_SPEED_LIMIT, speed_limit_max);
    }
#endif
    if (!flag_disp)
    {
        flag_disp = 0x17;
    }
}

void ini(void)
{
    //uint i;
   //System config
  // portddr_set();
   //clock_ini(); 
   //Power on delay
   /************Wait mcu until stable***************/
   //for(i=60000;i>0;)i--;
   //for(i=60000;i>0;)i--;
   //for(i=60000;i>0;)i--;
   //System config
   clock_ini(); 
   FREQ_CLK = 0x10;					//指明当前系统时钟 FLASH
	portddr_set();

   Exti1_ini();
   timer0_ini();
   timer1_ini();	
	InitialUART1(Wifi_Baudrate);
	InitialUART2(Baudrate);
   wdg_ini();	
   RSTFR=0;
   
   //initialization for display driver
   DisplayDriverInitializeLED();
   
   CLEAR_LED_ALL;

   init_params();

   eeprom_wrchar(EEPROM_ADDR_FLAG_UPDATE, 0);	
}
