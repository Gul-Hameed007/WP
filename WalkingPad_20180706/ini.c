#include "declare.h"
#include "displaydriver.h"
#include "eeprom.h"
#include "image.h"

extern void init_uart_sim(void);

#define RAM_ADDR_START 0x0000
#define RAM_ADDR_END 0x05ff
//uchar reset_state;
//test ram data
euchar ram_d0;
euchar ram_d1;
euchar ram_d2;
euchar ram_d3;
euchar ram_d4;
euchar ram_d5;
euchar ram_d6;
euchar ram_d7;

@near eulong user_total_distance;
/*****************************************************************************************/
static void portddr_set(void)
{
    //GPIO config
    /* PA*/
    PA_DDR = 0xFF;
    PA_CR1 = 0xFF;
    PA_ODR |= 0x04;
    /* PB*/
    PB_DDR = 0xFF;
    PB_CR1 = 0xFF;
    LED_CS2 = 1;
    LED_RD = 1;
    /* PC*/
    PC_DDR = 0x5F;
    PC_CR1 = 0x5F;
    PC_ODR |= 0x1E;
    /* PD*/
    PD_DDR = 0xB7; //0xB3;
    PD_CR1 = 0xB7; //0xB3;
    //PD_CR2 = 0x10;                // enable PD4 external interrupt

    /* PE*/
    PE_DDR = 0xFF;
    PE_CR1 = 0xFF;

    /* PF*/
    PF_DDR = 0xFF;
    PF_CR1 = 0xFF;
	
}
/*****************************************************************************************/

static void ExtiInit(void)
{

    PE_DDR &= (uchar)(~(0x01 << 5)); // PE5 input for rc control TLI interrupt
    PE_CR1 &= (uchar)(~(0x01 << 5)); // PE5 floating input
    PE_CR2 |= (0x01 << 5);           // PE5 external interrupt enable

    //		ITC_SPR2 &= (3<<6);						// clear sortware interrupt priority
    //    ITC_SPR2 |= (1<<6);						// set sortware interrupt priority 01

    EXTI_CR2 &= (uchar)(~(0x03 << 0));
    EXTI_CR2 |= 0X01 << 1; // PE Falling edge

} //ExtiInit
/*****************************************************************************************/

static void TIM2_Init(void)
{
  TIM2_CR1 = 0x00;    // disable timer
  TIM2_IER = 0x01;    // update interrupt enable
  TIM2_PSCR = 0x04;   // 16M/(2^PSCR) = 1M 1us
  TIM2_ARRH = 0x00;
  TIM2_ARRL = 50;     // 50us
  TIM2_CR1 |= 0x01;
}

void feed_wdg(void)
{
    IWDG_KR = 0XAA; //feed the dog
}

void timer1_ini(void) //T1 138us overflow int
{
    TIM1_IER = 0X01; //timer1 update interrupt
    TIM1_EGR = 0X01; //capture generation
    TIM1_PSCRH = 0X00;
    TIM1_PSCRL = 0X08; //138.67us, 16M/16
    TIM1_ARRH = 0X00;
    TIM1_ARRL = 251; //246;                    //
    TIM1_CR1 = 0X01; //counter start
    TXD = 1;
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
    uint i;
    //System config
    CLK_ICKR = 0x01;   // HSI enable(default)
    CLK_SWR = 0xE1;    // HSI selected(default)
    CLK_CKDIVR = 0x00; // fHSI = fMASTER = fCPU = 16M
    portddr_set();
    //Power on delay
    /************Wait mcu until stable***************/
    for(i=60000;i>0;)i--;
    for(i=60000;i>0;)i--;
    for(i=60000;i>0;)i--;
    //reset_state=RST_SR;
    //System config
     CLK_ICKR = 0x01;   // HSI enable(default)
     CLK_SWR = 0xE1;    // HSI selected(default)
     CLK_CKDIVR = 0x00; // fHSI = fMASTER = fCPU = 16M
    //  CC = 0x28;                      //
    //set SWIM as I/O port
    //CFG_GCR=0X01;
     portddr_set();
    
    ExtiInit();
    TIM2_Init();

    TIM4_PSCR = 0x05;      // fTIM4 = fMASTER(16M)/32, T = 2us
    TIM4_ARR = TIMER4_CNT; // T=200us
    TIM4_IER = 0x01;       // TIM4 interrrupt enable register
    TIM4_CR1 = 0x01;       // TIM4 control register

    /* Configure UART2 */
    UART2_BRR2 = 0x0E; //
    UART2_BRR1 = 0x08; //115200
    TC_FLAG = 0;
    RXNE_FLAG = 0;
    OR_FLAG = 0;
    UART2_CR2 = 0x60;
    TXEN_FLAG = 0; //txd disable
    RXEN_FLAG = 1; //rxd enable
    TX = 1;

    //WDG initial
    IWDG_KR = 0XCC;  // init the dog
    IWDG_KR = 0X55;  // enable
    IWDG_PR = 0X05;  //
    IWDG_RLR = 0XC8; // 680MS
    IWDG_KR = 0XAA;  //feed the dog
    //Interrupt config
    enableInterrupts();
    ITC_SPR1 = (uchar)0xFF;
    ITC_SPR2 = (uchar)0xFF;
    ITC_SPR3 = (uchar)0xFF;
    ITC_SPR4 = (uchar)0xFF;
    ITC_SPR5 = (uchar)0xFF;
    ITC_SPR6 = (uchar)0xF5;
    ITC_SPR7 = (uchar)0xFF;

    //LCD_BL=1;
    //Variables initialization. Automatically reset all RAM during initializaiton
    if (ram_d0 == 0x11 && ram_d1 == 0x33 && ram_d2 == 0x55 && ram_d3 == 0x77 && ram_d4 == 0x99 && ram_d5 == 0xaa && ram_d6 == 0xcc && ram_d7 == 0xee)
    {
        return;
    }
    //initial all RAM
    for (i = RAM_ADDR_START; i <= RAM_ADDR_END; i++)
    {
        *((uchar *)i) = 0;
    }
    ram_d0 = 0x11;
    ram_d1 = 0x33;
    ram_d2 = 0x55;
    ram_d3 = 0x77;
    ram_d4 = 0x99;
    ram_d5 = 0xaa;
    ram_d6 = 0xcc;
    ram_d7 = 0xee;

    //initialization for display driver
    DisplayDriverInitializeLED();

    CLEAR_LED_ALL;

    init_uart_sim();

    init_params();

    eeprom_wrchar(EEPROM_ADDR_FLAG_UPDATE, 0);
}
