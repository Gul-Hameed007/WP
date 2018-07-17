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
	PITS0 |= 0x04;						//�½����ж�
	INT1_MAP = 0x01;					//INT1ӳ��P0.1�˿�
	IE |= 0x04;							//��INT1�ж�
	EA = 1;								//�����ж�
} //ExtiInit
/*****************************************************************************************/

static void timer0_ini(void)
{
	//Produce an 50us interruption 
/**********************************TIM0���ó�ʼ��**************************************/
	TCON1 |= 0x01;						//T0��ʱ��ʱ��ΪFcpu
	TMOD &= ~0x03;						//16λ��װ�ض�ʱ��/������
	TH0 = 0xfc;
	TL0 = 0xe0;
	ET0 = 1;							//��T0�ж�
	TCON |= 0x10;						//ʹ��T0
	EA = 1;								//�����ж�	
}
void wdg_ini(void)
{
	/************************
	* WDT MCU reset
	************************/	
	WDTCCR = 0x00;						//�رտ��Ź�
/***********************************WDT���ó�ʼ��**************************************/
	WDTC = 0x57;						//����WDT��λ���������/����ģʽ�����У�1024��Ƶ

	//WDTʹ�õ���RC38Kʱ�ӣ�WDT_CLOCK_1024��1024��Ƶ����ֵΪ0xFF
	//��ʱʱ�� 	= 1024 * 9 / 38000
	//			    = 242ms
	WDTCCR = 40;//9;	//д��00ʱ�����ر�WDT���ܣ������ر��ڲ���ƵRC����
							//���൱�ڽ�ֹWDT��д���0����ʱ��������WDT��
}
void feed_wdg(void)
{
	WDTC |= 0x10;  //�幷
	//WDTCCR = 0x00;						//�رտ��Ź�
}
void clock_ini(void)
{
   WDTCCR = 0;	//�ر�WDT
	CLKCON|=0x02; //enable�ڲ���ƵRC
	while((CLKCON&0x20)!=0x20);			//�ȴ��ڲ���ƵRC����
	CLKSWR &= ~0x10;						//ѡ���ڲ���Ƶʱ��Ϊ��ʱ�ӣ�Fosc=32MHz
	while((CLKSWR&0x40)!=0x00);			//�ȴ��ڲ���Ƶ�л����
	CLKDIV = 0x02;						//Fosc2��Ƶ�õ�Fcpu��Fcpu=16MHz 
}
void timer1_ini(void)
{
	//Produce an 200us interruption 
/**********************************TIM1���ó�ʼ��**************************************/
	TCON1 |= 0x10;						//T1��ʱ��ʱ��ΪFcpu
	TMOD &= ~0x30;						//16λ��װ�ض�ʱ��/������
	TH1 = TIMER1_CNT>>8;
	TL1 = TIMER1_CNT;
	ET1 = 1;							//��T1�ж�
	TCON |= 0x40;						//ʹ��T1
    
	EA = 1;								//�����ж�	
}
void InitialUART1(ulong u32Baudrate) //WIFIͨ��
{
/**********************************UART���ó�ʼ��**************************************/
   TXD_MAP = 0x1C;						//TXDӳ��P34
	RXD_MAP = 0x1D;						//RXDӳ��P35		
   SBRTH = (65536 - (1000000/u32Baudrate)-1)>>8;//0xFF;
	SBRTL = (65536 - (1000000/u32Baudrate)-1);//0x98;							//������9600 /*16 MHz */
	SCON2 = 0x12;						//���������ʷ�������8λUART�������ʿɱ�
	SCON = 0x10;						//�����н���
	ES1 = 1;							//ʹ�ܴ����ж�
	EA = 1;								//ʹ�����ж�	
}
void InitialUART2(ulong u32Baudrate) //�¿�ͨ��
{
/**********************************UART���ó�ʼ��**************************************/
	TXD2_MAP = 0x1B;						//TXDӳ��P33
	RXD2_MAP = 0x1A;						//RXDӳ��P32		
   S2BRTH = (65536 - (1000000/u32Baudrate)-1)>>8;//0xFF;
	S2BRTL = (65536 - (1000000/u32Baudrate)-1);//0x98;							//������9600 /*16 MHz */
	S2CON2 = 0x12;						//���������ʷ�������8λUART�������ʿɱ�
	S2CON = 0x10;						//�����н���
	ES2 = 1;							//ʹ�ܴ����ж�
	EA = 1;								//ʹ�����ж�	
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
   FREQ_CLK = 0x10;					//ָ����ǰϵͳʱ�� FLASH
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
