/*--------------------------------------------------------------------------
HC89S105xx.H

Header file for generic HC89S105xx series microcontroller.
Copyright (c) 2009-2015 Shanghai Holychip Electronic Technology Co., Ltd.
All rights reserved.
--------------------------------------------------------------------------*/
#ifndef __HC89S105xx_H__
#define __HC89S105xx_H__

/* ------------------- BYTE Register-------------------- */
/* CPU */
sfr PSW        = 0xD0;            
sfr ACC        = 0xE0;
sfr B 	       = 0xF0;
sfr SP         = 0x81;
sfr DPL        = 0x82;
sfr DPH        = 0x83;
sfr INSCON     = 0xA3;
sfr16 DPTR     = 0x82;

/* SYS CLOCK  */
sfr CLKSWR     = 0x8E;
sfr CLKCON     = 0x8F;

/* power  */
sfr PCON       = 0x87;

/* FLASH */
sfr IAP_ADDRL  = 0xF9;
sfr IAP_ADDRH  = 0xFA;
sfr IAP_DATA   = 0xFB;
sfr IAP_CMDL   = 0xFC;
sfr IAP_CMDH   = 0xFD; 
  
sfr16 IAP_ADDR = 0xF9;
sfr16 IAP_CMD  = 0xFC;

/* REST */
sfr RSTFR      = 0xF8;

/* WDT  */
sfr WDTC       = 0xBD;

/* INTERRUPT */
sfr IE         = 0xA8;
sfr IE1        = 0xB8;
sfr IP0        = 0xA9;
sfr IP1        = 0xAA;
sfr IP2        = 0xB9;
sfr IP3        = 0xBA;
sfr IP4        = 0xB1;

sfr PINTF0     = 0x96;
sfr PINTF1     = 0x97;
                  
/* PORT */
sfr P0 	       = 0x80;       
sfr P1 	       = 0x90;            
sfr P2 	       = 0xA0;            
sfr P3 	       = 0xB0;            
sfr P4 	       = 0xC0;  
sfr P5 	       = 0xC8;  

/* TIMER */
sfr TCON       = 0x88;
sfr TMOD       = 0x89;
sfr TL0        = 0x8A;
sfr TL1        = 0x8B;
sfr TH0        = 0x8C;
sfr TH1        = 0x8D;

/* PCA */
sfr PCACLK     = 0xC9;
sfr PCAMOD0    = 0xCA;
sfr PCAMOD1    = 0xCB;
sfr CCAPL0     = 0xCC;
sfr CCAPH0     = 0xCD;
sfr CCAPL1     = 0xCE;
sfr CCAPH1     = 0xCF;
sfr PCACON     = 0xC1;
sfr PCACL      = 0xC2;
sfr PCACH      = 0xC3;

sfr16 CCAP0    = 0xCC;
sfr16 CCAP1    = 0xCE;
sfr16 PCAC     = 0xC2;

/* RTC */
sfr RTCC       = 0xBC;

/* UART */
sfr SCON       = 0x98;
sfr SBUF       = 0x99;
sfr SADDR      = 0x9A;
sfr SADEN      = 0x9B;
sfr SBRTL      = 0x9C;
sfr SBRTH      = 0x9D;
sfr SCON2      = 0x9E;

sfr16 SBRT     = 0x9C;

/* IIC */
sfr IICCON     = 0xA6;
sfr IICSTA     = 0xA7;
sfr IICDAT     = 0xAE;
sfr IICADR     = 0xAF;

/* SPI */
sfr SPDAT      = 0xAB;
sfr SPCTL      = 0xAC;
sfr SPSTAT     = 0xAD;

/* ADC */
sfr ADCC0      = 0xB4;
sfr ADCC1      = 0xB5;
sfr ADCRL      = 0xB6;
sfr ADCRH      = 0xB7;
sfr16 ADCR     = 0xB6;

/* CRC */
sfr CRCL       = 0xBE;
sfr CRCH       = 0xBF;
sfr16 CRCR     = 0xBE;

/* PWM */
sfr PWMEN      = 0xE1;
sfr PWM0C      = 0xE2;
sfr PWM0PL     = 0xE3;
sfr PWM0PH     = 0xE4;
sfr PWM0DL     = 0xE5;
sfr PWM0DH     = 0xE6;
sfr PWM0DT     = 0xE7;
sfr PWMFLT     = 0xE9;
sfr PWM1C      = 0xEA;
sfr PWM1PL     = 0xEB;
sfr PWM1PH     = 0xEC;
sfr PWM1DL     = 0xED;
sfr PWM1DH     = 0xEE;
sfr PWM1DT     = 0xEF;
sfr PWM2C      = 0xF2;
sfr PWM2PL     = 0xF3;
sfr PWM2PH     = 0xF4;
sfr PWM2DL     = 0xF5;
sfr PWM2DH     = 0xF6;
sfr PWM2DT     = 0xF7;

sfr16 PWM0P    = 0xE3;
sfr16 PWM0D    = 0xE5;
sfr16 PWM1P    = 0xEB;
sfr16 PWM1D    = 0xED;
sfr16 PWM2P    = 0xF3;
sfr16 PWM2D    = 0xF5;

/* LVD */
sfr LVDC       = 0xBB;

/*--------------------------  BIT Register -------------------- */
/*  PSW   */
sbit CY        = PSW^7;
sbit AC        = PSW^6;
sbit F0        = PSW^5;
sbit RS1       = PSW^4;
sbit RS0       = PSW^3;
sbit OV        = PSW^2;
sbit F1        = PSW^1;
sbit P         = PSW^0;

/*  IE   */ 
sbit EA        = IE^7;
sbit ES2       = IE^6;
sbit EWDT      = IE^5;
sbit ES1       = IE^4;
sbit ET1       = IE^3;
sbit EX1       = IE^2;
sbit ET0       = IE^1;
sbit EX0       = IE^0;

/*  IE1   */ 
sbit EX8_15    = IE1^6;
sbit EX2_7     = IE1^5;
sbit EADC      = IE1^4;
sbit ERTC      = IE1^2;
sbit EIIC      = IE1^1;
sbit ESPI      = IE1^0;

/*  RSTFR   */ 
sbit PORF      = RSTFR^7;
sbit EXRSTF    = RSTFR^6;
sbit BORF      = RSTFR^5;
sbit WDTRF     = RSTFR^4;
sbit SWRF      = RSTFR^3;
sbit PLVDSTF   = RSTFR^0;

/*  SCON  */
sbit S1FE      = SCON^7;
sbit S1RXOV    = SCON^6;
sbit S1TXCOL   = SCON^5;
sbit S1REN     = SCON^4;
sbit S1TB8     = SCON^3;
sbit S1RB8     = SCON^2;
sbit S1TI      = SCON^1;
sbit S1RI      = SCON^0;

/*  TCON  */
sbit TF1       = TCON^7;
sbit TR1       = TCON^6;
sbit TF0       = TCON^5;
sbit TR0       = TCON^4;

/* P0 */
sbit P0_0      = P0^0;
sbit P0_1      = P0^1;
sbit P0_2      = P0^2;
sbit P0_3      = P0^3;
sbit P0_4      = P0^4;
sbit P0_5      = P0^5;
sbit P0_6      = P0^6;
sbit P0_7      = P0^7;

/* P1 */
sbit P1_0      = P1^0;
sbit P1_1      = P1^1;
sbit P1_2      = P1^2;
sbit P1_3      = P1^3;
sbit P1_4      = P1^4;
sbit P1_5      = P1^5;
sbit P1_6      = P1^6;
sbit P1_7      = P1^7;

/* P2 */
sbit P2_0      = P2^0;
sbit P2_1      = P2^1;
sbit P2_2      = P2^2;
sbit P2_3      = P2^3;
sbit P2_4      = P2^4;
sbit P2_5      = P2^5;
sbit P2_6      = P2^6;
sbit P2_7      = P2^7;

/* P3 */
sbit P3_0      = P3^0;
sbit P3_1      = P3^1;
sbit P3_2      = P3^2;
sbit P3_3      = P3^3;
sbit P3_4      = P3^4;
sbit P3_5      = P3^5;
sbit P3_6      = P3^6;
sbit P3_7      = P3^7;

/* P4 */
sbit P4_0      = P4^0;
sbit P4_1      = P4^1;
sbit P4_2      = P4^2;
sbit P4_3      = P4^3;
sbit P4_4      = P4^4;
sbit P4_5      = P4^5;
sbit P4_6      = P4^6;
sbit P4_7      = P4^7;
  
/* P5 */
sbit P5_0      = P5^0;
sbit P5_1      = P5^1;
sbit P5_2      = P5^2;
sbit P5_3      = P5^3;
sbit P5_4      = P5^4;
sbit P5_5      = P5^5;


 /* XSFR_TIMER */ 
#define TCON1              (*(unsigned char volatile xdata *) 0xFE80) //

 /* XSFR_PCA */ 
#define PCA_PWM0           (*(unsigned char volatile xdata *) 0xFE84) //
#define PCA_PWM1           (*(unsigned char volatile xdata *) 0xFE85) //

 /* XSFR_UART2 */ 
#define S2CON              (*(unsigned char volatile xdata *) 0xFE88) //
#define S2CON2             (*(unsigned char volatile xdata *) 0xFE89) //
#define S2BUF              (*(unsigned char volatile xdata *) 0xFE8A) //
#define S2ADDR             (*(unsigned char volatile xdata *) 0xFE8B) //
#define S2ADEN             (*(unsigned char volatile xdata *) 0xFE8C) //
#define S2BRTH             (*(unsigned char volatile xdata *) 0xFE8D) //
#define S2BRTL             (*(unsigned char volatile xdata *) 0xFE8E) //
//EXTERN xdata volatile u16 S2BRT              (*(unsigned char volatile xdata *) 0xFE8D) //

 /* XSFR_SYSCLK */ 
#define CLKDIV             (*(unsigned char volatile xdata *) 0xFE91) //
#define FREQ_CLK           (*(unsigned char volatile xdata *) 0xFE92) //

 /* XSFR_ADC */ 
#define ADCWC0             (*(unsigned char volatile xdata *) 0xFE98) //
#define ADCWC1             (*(unsigned char volatile xdata *) 0xFE99) //
#define ADCC2              (*(unsigned char volatile xdata *) 0xFE9B) //
 
 /* XSFR_PWM_FLT */ 
#define PWM0DBC            (*(unsigned char volatile xdata *) 0xFE9C) //
#define PWM1DBC            (*(unsigned char volatile xdata *) 0xFE9D) //
#define PWM2DBC            (*(unsigned char volatile xdata *) 0xFE9E) //

 /* XSFR_WDT */ 
#define WDTCCR             (*(unsigned char volatile xdata *) 0xFEA0) //

 /* XSFR_CRC */ 
#define CRCC               (*(unsigned char volatile xdata *) 0xFEA2) //

 /* XSFR_BOR */ 
#define BORC               (*(unsigned char volatile xdata *) 0xFEA4) //
#define BORDBC             (*(unsigned char volatile xdata *) 0xFEA5) //


 /* XSFR_LVD */ 
#define LVDDBC             (*(unsigned char volatile xdata *) 0xFEA7) //

 /* XSFR_RST */ 
#define RSTDBC             (*(unsigned char volatile xdata *) 0xFEAA) //

 /* XSFR_CLK */ 
#define CLKPCKEN0          (*(unsigned char volatile xdata *) 0xFEAC) //
#define CLKPCKEN1          (*(unsigned char volatile xdata *) 0xFEAD) //

 /* XSFR_PITS */ 
#define PITS0              (*(unsigned char volatile xdata *) 0xFEB0) //
#define PITS1              (*(unsigned char volatile xdata *) 0xFEB1) //
#define PITS2              (*(unsigned char volatile xdata *) 0xFEB2) //
#define PITS3              (*(unsigned char volatile xdata *) 0xFEB3) //
#define PINTE0             (*(unsigned char volatile xdata *) 0xFEB8) //
#define PINTE1             (*(unsigned char volatile xdata *) 0xFEB9) //

 /* XSFR_PORT */ 
#define P0M0               (*(unsigned char volatile xdata *) 0xFF00) //
#define P0M1               (*(unsigned char volatile xdata *) 0xFF01) //
#define P0M2               (*(unsigned char volatile xdata *) 0xFF02) // 
#define P0M3               (*(unsigned char volatile xdata *) 0xFF03) // 
#define P0HPU              (*(unsigned char volatile xdata *) 0xFF04) // 
#define P0LPU              (*(unsigned char volatile xdata *) 0xFF05) // 

#define P1M0               (*(unsigned char volatile xdata *) 0xFF08) //
#define P1M1               (*(unsigned char volatile xdata *) 0xFF09) //
#define P1M2               (*(unsigned char volatile xdata *) 0xFF0A) //
#define P1M3               (*(unsigned char volatile xdata *) 0xFF0B) //
#define P1HPU              (*(unsigned char volatile xdata *) 0xFF0C) //
#define P1LPU              (*(unsigned char volatile xdata *) 0xFF0D) //

#define P2M0               (*(unsigned char volatile xdata *) 0xFF10) //
#define P2M1               (*(unsigned char volatile xdata *) 0xFF11) //
#define P2M2               (*(unsigned char volatile xdata *) 0xFF12) //
#define P2M3               (*(unsigned char volatile xdata *) 0xFF13) //
#define P2HPU              (*(unsigned char volatile xdata *) 0xFF14) //
#define P2LPU              (*(unsigned char volatile xdata *) 0xFF15) //

#define P3M0               (*(unsigned char volatile xdata *) 0xFF18) //
#define P3M1               (*(unsigned char volatile xdata *) 0xFF19) //
#define P3M2               (*(unsigned char volatile xdata *) 0xFF1A) //
#define P3M3               (*(unsigned char volatile xdata *) 0xFF1B) //
#define P3HPU              (*(unsigned char volatile xdata *) 0xFF1C) //
#define P3LPU              (*(unsigned char volatile xdata *) 0xFF1D) //

#define P4M0               (*(unsigned char volatile xdata *) 0xFF20) //
#define P4M1               (*(unsigned char volatile xdata *) 0xFF21) //
#define P4M3               (*(unsigned char volatile xdata *) 0xFF23) //
#define P4HPU              (*(unsigned char volatile xdata *) 0xFF24) //
#define P4LPU              (*(unsigned char volatile xdata *) 0xFF25) //

#define P5M0               (*(unsigned char volatile xdata *) 0xFF28) //
#define P5M1               (*(unsigned char volatile xdata *) 0xFF29) //
#define P5M2               (*(unsigned char volatile xdata *) 0xFF2A) //
#define P5HPU              (*(unsigned char volatile xdata *) 0xFF2C) //
#define P5LPU              (*(unsigned char volatile xdata *) 0xFF2D) //
 
 /* XSFR_MAP */ 
#define T0_MAP             (*(unsigned char volatile xdata *) 0xFF80) // 
#define T1_MAP             (*(unsigned char volatile xdata *) 0xFF81) //
#define RTCO_MAP           (*(unsigned char volatile xdata *) 0xFF84) //
#define BRTO_MAP           (*(unsigned char volatile xdata *) 0xFF85) //
#define ECI_MAP            (*(unsigned char volatile xdata *) 0xFF8A) // 
#define PCA0_MAP           (*(unsigned char volatile xdata *) 0xFF8B) //
#define PCA1_MAP           (*(unsigned char volatile xdata *) 0xFF8C) //
#define PWM0_MAP           (*(unsigned char volatile xdata *) 0xFF90) //
#define PWM01_MAP          (*(unsigned char volatile xdata *) 0xFF91) //
#define FLT0_MAP           (*(unsigned char volatile xdata *) 0xFF92) //
#define PWM1_MAP           (*(unsigned char volatile xdata *) 0xFF94) //
#define PWM11_MAP          (*(unsigned char volatile xdata *) 0xFF95) //
#define FLT1_MAP           (*(unsigned char volatile xdata *) 0xFF96) //
#define PWM2_MAP           (*(unsigned char volatile xdata *) 0xFF98) //
#define PWM21_MAP          (*(unsigned char volatile xdata *) 0xFF99) //
#define FLT2_MAP           (*(unsigned char volatile xdata *) 0xFF9A) //
#define TXD_MAP            (*(unsigned char volatile xdata *) 0xFFA0) //
#define RXD_MAP            (*(unsigned char volatile xdata *) 0xFFA1) //
#define SCL_MAP            (*(unsigned char volatile xdata *) 0xFFA2) //
#define SDA_MAP            (*(unsigned char volatile xdata *) 0xFFA3) //
#define SS_MAP             (*(unsigned char volatile xdata *) 0xFFA4) //
#define SCK_MAP            (*(unsigned char volatile xdata *) 0xFFA5) //
#define MOSI_MAP           (*(unsigned char volatile xdata *) 0xFFA6) //
#define MISO_MAP           (*(unsigned char volatile xdata *) 0xFFA7) //
#define TXD2_MAP           (*(unsigned char volatile xdata *) 0xFFA8) //
#define RXD2_MAP           (*(unsigned char volatile xdata *) 0xFFA9) //
#define INT0_MAP           (*(unsigned char volatile xdata *) 0xFFB0) //
#define INT1_MAP           (*(unsigned char volatile xdata *) 0xFFB1) //

 /* XSFR */ 
#define SN_DATA[8]         (*(unsigned char volatile xdata *) 0xFFC0) //
#define ID_DATA[8]         (*(unsigned char volatile xdata *) 0xFFC8) //
#define CHIP_ID[8]         (*(unsigned char volatile xdata *) 0xFFD0) //


/*------------------------------------------------
Interrupt Vectors:
Interrupt Address = (Number * 8) + 3
------------------------------------------------*/
#define INT0_VECTOR         0   /* 0x03 EXTERNal Interrupt 0 */
#define TIMER0_VECTOR       1   /* 0x0B Timer 0 */
#define INT1_VECTOR	        2   /* 0x13 EXTERNal Interrupt 1 */
#define TIMER1_VECTOR	    3   /* 0x1B Timer 1 */
#define UART1_VECTOR	    4   /* 0x23 Serial port 1 */
#define WDT_VECTOR	        5   /* 0x2B WDT */
#define LVD_VECTOR	        6   /* 0x33 LVD */
#define UART2_VECTOR	    7   /* 0x3B Serial port 2 */
#define SPI_VECTOR	        8   /* 0x43 SPI */
#define IIC_VECTOR	        9   /* 0x4B IIC */
#define PCA_VECTOR	        10  /* 0x53 PCA */
#define PWM_VECTOR	        11  /* 0x5B PWM */
#define RTC_VECTOR	        12  /* 0x63 RTC */
#define ADC_VECTOR	        14  /* 0x73 ADC */
#define INT2_7_VECTOR	    15  /* 0x7B INT2~INT7 */
#define INT8_15_VECTOR	    16  /* 0x83 INT8~INT15 */


#endif/* __HC89S105xx_H__ */
