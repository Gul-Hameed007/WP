   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2807                     ; 23 static void portddr_set(void)
2807                     ; 24 {
2809                     	switch	.text
2810  0000               L7571_portddr_set:
2814                     ; 27     PA_DDR = 0xFF;
2816  0000 35ff5002      	mov	_PA_DDR,#255
2817                     ; 28     PA_CR1 = 0xFF;
2819  0004 35ff5003      	mov	_PA_CR1,#255
2820                     ; 29     PA_ODR |= 0x04;
2822  0008 72145000      	bset	_PA_ODR,#2
2823                     ; 31     PB_DDR = 0xFF;
2825  000c 35ff5007      	mov	_PB_DDR,#255
2826                     ; 32     PB_CR1 = 0xFF;
2828  0010 35ff5008      	mov	_PB_CR1,#255
2829                     ; 33     LED_CS2 = 1;
2831  0014 72125005      	bset	_PB_ODR,#1
2832                     ; 34     LED_RD = 1;
2834  0018 72185005      	bset	_PB_ODR,#4
2835                     ; 36     PC_DDR = 0x5F;
2837  001c 355f500c      	mov	_PC_DDR,#95
2838                     ; 37     PC_CR1 = 0x5F;
2840  0020 355f500d      	mov	_PC_CR1,#95
2841                     ; 38     PC_ODR |= 0x1E;
2843  0024 c6500a        	ld	a,_PC_ODR
2844  0027 aa1e          	or	a,#30
2845  0029 c7500a        	ld	_PC_ODR,a
2846                     ; 40     PD_DDR = 0xB7; //0xB3;
2848  002c 35b75011      	mov	_PD_DDR,#183
2849                     ; 41     PD_CR1 = 0xB7; //0xB3;
2851  0030 35b75012      	mov	_PD_CR1,#183
2852                     ; 45     PE_DDR = 0xFF;
2854  0034 35ff5016      	mov	_PE_DDR,#255
2855                     ; 46     PE_CR1 = 0xFF;
2857  0038 35ff5017      	mov	_PE_CR1,#255
2858                     ; 49     PF_DDR = 0xFF;
2860  003c 35ff501b      	mov	_PF_DDR,#255
2861                     ; 50     PF_CR1 = 0xFF;
2863  0040 35ff501c      	mov	_PF_CR1,#255
2864                     ; 52 }
2867  0044 81            	ret
2894                     ; 55 static void ExtiInit(void)
2894                     ; 56 {
2895                     	switch	.text
2896  0045               L7771_ExtiInit:
2900                     ; 58     PE_DDR &= (uchar)(~(0x01 << 5)); // PE5 input for rc control TLI interrupt
2902  0045 721b5016      	bres	_PE_DDR,#5
2903                     ; 59     PE_CR1 &= (uchar)(~(0x01 << 5)); // PE5 floating input
2905  0049 721b5017      	bres	_PE_CR1,#5
2906                     ; 60     PE_CR2 |= (0x01 << 5);           // PE5 external interrupt enable
2908  004d 721a5018      	bset	_PE_CR2,#5
2909                     ; 65     EXTI_CR2 &= (uchar)(~(0x03 << 0));
2911  0051 c650a1        	ld	a,_EXTI_CR2
2912  0054 a4fc          	and	a,#252
2913  0056 c750a1        	ld	_EXTI_CR2,a
2914                     ; 66     EXTI_CR2 |= 0X01 << 1; // PE Falling edge
2916  0059 721250a1      	bset	_EXTI_CR2,#1
2917                     ; 68 } //ExtiInit
2920  005d 81            	ret
2948                     ; 71 static void TIM2_Init(void)
2948                     ; 72 {
2949                     	switch	.text
2950  005e               L1102_TIM2_Init:
2954                     ; 73   TIM2_CR1 = 0x00;    // disable timer
2956  005e 725f5300      	clr	_TIM2_CR1
2957                     ; 74   TIM2_IER = 0x01;    // update interrupt enable
2959  0062 35015301      	mov	_TIM2_IER,#1
2960                     ; 75   TIM2_PSCR = 0x04;   // 16M/(2^PSCR) = 1M 1us
2962  0066 3504530c      	mov	_TIM2_PSCR,#4
2963                     ; 76   TIM2_ARRH = 0x00;
2965  006a 725f530d      	clr	_TIM2_ARRH
2966                     ; 77   TIM2_ARRL = 50;     // 50us
2968  006e 3532530e      	mov	_TIM2_ARRL,#50
2969                     ; 78   TIM2_CR1 |= 0x01;
2971  0072 72105300      	bset	_TIM2_CR1,#0
2972                     ; 79 }
2975  0076 81            	ret
2999                     ; 81 void feed_wdg(void)
2999                     ; 82 {
3000                     	switch	.text
3001  0077               _feed_wdg:
3005                     ; 83     IWDG_KR = 0XAA; //feed the dog
3007  0077 35aa50e0      	mov	_IWDG_KR,#170
3008                     ; 84 }
3011  007b 81            	ret
3042                     ; 86 void timer1_ini(void) //T1 138us overflow int
3042                     ; 87 {
3043                     	switch	.text
3044  007c               _timer1_ini:
3048                     ; 88     TIM1_IER = 0X01; //timer1 update interrupt
3050  007c 35015254      	mov	_TIM1_IER,#1
3051                     ; 89     TIM1_EGR = 0X01; //capture generation
3053  0080 35015257      	mov	_TIM1_EGR,#1
3054                     ; 90     TIM1_PSCRH = 0X00;
3056  0084 725f5260      	clr	_TIM1_PSCRH
3057                     ; 91     TIM1_PSCRL = 0X08; //138.67us, 16M/16
3059  0088 35085261      	mov	_TIM1_PSCRL,#8
3060                     ; 92     TIM1_ARRH = 0X00;
3062  008c 725f5262      	clr	_TIM1_ARRH
3063                     ; 93     TIM1_ARRL = 251; //246;                    //
3065  0090 35fb5263      	mov	_TIM1_ARRL,#251
3066                     ; 94     TIM1_CR1 = 0X01; //counter start
3068  0094 35015250      	mov	_TIM1_CR1,#1
3069                     ; 95     TXD = 1;
3071  0098 7218500f      	bset	_PD_ODR,#4
3072                     ; 96 }
3075  009c 81            	ret
3108                     ; 98 void init_params(void)
3108                     ; 99 {
3109                     	switch	.text
3110  009d               _init_params:
3114                     ; 100     waiting_cnt = DISPLAY_ALL_ON_DELAY; //all on for 1 second
3116  009d 35960000      	mov	_waiting_cnt,#150
3117                     ; 101     waiting = 1;
3119  00a1 72100000      	bset	_waiting
3120                     ; 103     eeprom_read();
3122  00a5 cd0000        	call	_eeprom_read
3124                     ; 106     if (dc_motor_startup_volt < DC_MOTOR_STARTUP_VOLT_MIN ||dc_motor_startup_volt>DC_MOTOR_STARTUP_VOLT_MAX)
3126  00a8 c60000        	ld	a,_dc_motor_startup_volt
3127  00ab a105          	cp	a,#5
3128  00ad 2507          	jrult	L5502
3130  00af c60000        	ld	a,_dc_motor_startup_volt
3131  00b2 a11a          	cp	a,#26
3132  00b4 2504          	jrult	L3502
3133  00b6               L5502:
3134                     ; 108         dc_motor_startup_volt = DC_MOTOR_STARTUP_VOLT_DEFAULT;
3136  00b6 350d0000      	mov	_dc_motor_startup_volt,#13
3137  00ba               L3502:
3138                     ; 111     if (dc_motor_rating_volt < DC_MOTOR_RATING_VOLT_MIN || dc_motor_rating_volt > DC_MOTOR_RATING_VOLT_MAX)
3140  00ba c60000        	ld	a,_dc_motor_rating_volt
3141  00bd a182          	cp	a,#130
3142  00bf 2507          	jrult	L1602
3144  00c1 c60000        	ld	a,_dc_motor_rating_volt
3145  00c4 a1ab          	cp	a,#171
3146  00c6 2504          	jrult	L7502
3147  00c8               L1602:
3148                     ; 113         dc_motor_rating_volt = DC_MOTOR_RATING_VOLT_DEFAULT;
3150  00c8 35960000      	mov	_dc_motor_rating_volt,#150
3151  00cc               L7502:
3152                     ; 115     if (dc_motor_rating_f1 < DC_MOTOR_RATING_F1_MIN ||dc_motor_rating_f1>DC_MOTOR_RATING_F1_MAX)
3154  00cc c60000        	ld	a,_dc_motor_rating_f1
3155  00cf a105          	cp	a,#5
3156  00d1 2507          	jrult	L5602
3158  00d3 c60000        	ld	a,_dc_motor_rating_f1
3159  00d6 a1fb          	cp	a,#251
3160  00d8 2504          	jrult	L3602
3161  00da               L5602:
3162                     ; 117         dc_motor_rating_f1 = DC_MOTOR_RATING_F1_DEFAULT;
3164  00da 35820000      	mov	_dc_motor_rating_f1,#130
3165  00de               L3602:
3166                     ; 124     if (speed_limit_max < SPEED_TARGET_MIN1 || speed_limit_max > SPEED_TARGET_MAX)
3168  00de c60000        	ld	a,_speed_limit_max
3169  00e1 a10f          	cp	a,#15
3170  00e3 2507          	jrult	L1702
3172  00e5 c60000        	ld	a,_speed_limit_max
3173  00e8 a1b5          	cp	a,#181
3174  00ea 2504          	jrult	L7602
3175  00ec               L1702:
3176                     ; 126         speed_limit_max = SPEED_LIMIT_MAX_FACTORY;
3178  00ec 355a0000      	mov	_speed_limit_max,#90
3179  00f0               L7602:
3180                     ; 129      if (fixed_start_speed > speed_limit_max || fixed_start_speed < SPEED_TARGET_MIN1)
3182  00f0 c60000        	ld	a,_fixed_start_speed
3183  00f3 c10000        	cp	a,_speed_limit_max
3184  00f6 2207          	jrugt	L5702
3186  00f8 c60000        	ld	a,_fixed_start_speed
3187  00fb a10f          	cp	a,#15
3188  00fd 2404          	jruge	L3702
3189  00ff               L5702:
3190                     ; 131          fixed_start_speed = FIXED_MODE_DEFAULT_SPEED;
3192  00ff 355a0000      	mov	_fixed_start_speed,#90
3193  0103               L3702:
3194                     ; 137     if (acceleration_param < 1 || acceleration_param > 3)
3196  0103 725d0000      	tnz	_acceleration_param
3197  0107 2707          	jreq	L1012
3199  0109 c60000        	ld	a,_acceleration_param
3200  010c a104          	cp	a,#4
3201  010e 2504          	jrult	L7702
3202  0110               L1012:
3203                     ; 139         acceleration_param = 2;
3205  0110 35020000      	mov	_acceleration_param,#2
3206  0114               L7702:
3207                     ; 151     if (!flag_disp)
3209  0114 725d0000      	tnz	_flag_disp
3210  0118 2604          	jrne	L3012
3211                     ; 153         flag_disp = 0x17;
3213  011a 35170000      	mov	_flag_disp,#23
3214  011e               L3012:
3215                     ; 155 }
3218  011e 81            	ret
3292                     ; 157 void ini(void)
3292                     ; 158 {
3293                     	switch	.text
3294  011f               _ini:
3296  011f 89            	pushw	x
3297       00000002      OFST:	set	2
3300                     ; 161     CLK_ICKR = 0x01;   // HSI enable(default)
3302  0120 350150c0      	mov	_CLK_ICKR,#1
3303                     ; 162     CLK_SWR = 0xE1;    // HSI selected(default)
3305  0124 35e150c4      	mov	_CLK_SWR,#225
3306                     ; 163     CLK_CKDIVR = 0x00; // fHSI = fMASTER = fCPU = 16M
3308  0128 725f50c6      	clr	_CLK_CKDIVR
3309                     ; 164     portddr_set();
3311  012c cd0000        	call	L7571_portddr_set
3313                     ; 167     for(i=60000;i>0;)i--;
3315  012f aeea60        	ldw	x,#60000
3316  0132 1f01          	ldw	(OFST-1,sp),x
3317  0134               L3212:
3320  0134 1e01          	ldw	x,(OFST-1,sp)
3321  0136 1d0001        	subw	x,#1
3322  0139 1f01          	ldw	(OFST-1,sp),x
3325  013b 1e01          	ldw	x,(OFST-1,sp)
3326  013d 26f5          	jrne	L3212
3327                     ; 168     for(i=60000;i>0;)i--;
3329  013f aeea60        	ldw	x,#60000
3330  0142 1f01          	ldw	(OFST-1,sp),x
3331  0144               L1312:
3334  0144 1e01          	ldw	x,(OFST-1,sp)
3335  0146 1d0001        	subw	x,#1
3336  0149 1f01          	ldw	(OFST-1,sp),x
3339  014b 1e01          	ldw	x,(OFST-1,sp)
3340  014d 26f5          	jrne	L1312
3341                     ; 169     for(i=60000;i>0;)i--;
3343  014f aeea60        	ldw	x,#60000
3344  0152 1f01          	ldw	(OFST-1,sp),x
3345  0154               L7312:
3348  0154 1e01          	ldw	x,(OFST-1,sp)
3349  0156 1d0001        	subw	x,#1
3350  0159 1f01          	ldw	(OFST-1,sp),x
3353  015b 1e01          	ldw	x,(OFST-1,sp)
3354  015d 26f5          	jrne	L7312
3355                     ; 172      CLK_ICKR = 0x01;   // HSI enable(default)
3357  015f 350150c0      	mov	_CLK_ICKR,#1
3358                     ; 173      CLK_SWR = 0xE1;    // HSI selected(default)
3360  0163 35e150c4      	mov	_CLK_SWR,#225
3361                     ; 174      CLK_CKDIVR = 0x00; // fHSI = fMASTER = fCPU = 16M
3363  0167 725f50c6      	clr	_CLK_CKDIVR
3364                     ; 178      portddr_set();
3366  016b cd0000        	call	L7571_portddr_set
3368                     ; 180     ExtiInit();
3370  016e cd0045        	call	L7771_ExtiInit
3372                     ; 181     TIM2_Init();
3374  0171 cd005e        	call	L1102_TIM2_Init
3376                     ; 183     TIM4_PSCR = 0x05;      // fTIM4 = fMASTER(16M)/32, T = 2us
3378  0174 35055345      	mov	_TIM4_PSCR,#5
3379                     ; 184     TIM4_ARR = TIMER4_CNT; // T=200us
3381  0178 35635346      	mov	_TIM4_ARR,#99
3382                     ; 185     TIM4_IER = 0x01;       // TIM4 interrrupt enable register
3384  017c 35015341      	mov	_TIM4_IER,#1
3385                     ; 186     TIM4_CR1 = 0x01;       // TIM4 control register
3387  0180 35015340      	mov	_TIM4_CR1,#1
3388                     ; 189     UART2_BRR2 = 0x0E; //
3390  0184 350e5243      	mov	_UART2_BRR2,#14
3391                     ; 190     UART2_BRR1 = 0x08; //115200
3393  0188 35085242      	mov	_UART2_BRR1,#8
3394                     ; 191     TC_FLAG = 0;
3396  018c 721d5240      	bres	_UART2_SR,#6
3397                     ; 192     RXNE_FLAG = 0;
3399  0190 721b5240      	bres	_UART2_SR,#5
3400                     ; 193     OR_FLAG = 0;
3402  0194 72175240      	bres	_UART2_SR,#3
3403                     ; 194     UART2_CR2 = 0x60;
3405  0198 35605245      	mov	_UART2_CR2,#96
3406                     ; 195     TXEN_FLAG = 0; //txd disable
3408  019c 72175245      	bres	_UART2_CR2,#3
3409                     ; 196     RXEN_FLAG = 1; //rxd enable
3411  01a0 72145245      	bset	_UART2_CR2,#2
3412                     ; 197     TX = 1;
3414  01a4 721a500f      	bset	_PD_ODR,#5
3415                     ; 200     IWDG_KR = 0XCC;  // init the dog
3417  01a8 35cc50e0      	mov	_IWDG_KR,#204
3418                     ; 201     IWDG_KR = 0X55;  // enable
3420  01ac 355550e0      	mov	_IWDG_KR,#85
3421                     ; 202     IWDG_PR = 0X05;  //
3423  01b0 350550e1      	mov	_IWDG_PR,#5
3424                     ; 203     IWDG_RLR = 0XC8; // 680MS
3426  01b4 35c850e2      	mov	_IWDG_RLR,#200
3427                     ; 204     IWDG_KR = 0XAA;  //feed the dog
3429  01b8 35aa50e0      	mov	_IWDG_KR,#170
3430                     ; 206     enableInterrupts();
3433  01bc 9a            rim
3435                     ; 207     ITC_SPR1 = (uchar)0xFF;
3438  01bd 35ff7f70      	mov	_ITC_SPR1,#255
3439                     ; 208     ITC_SPR2 = (uchar)0xFF;
3441  01c1 35ff7f71      	mov	_ITC_SPR2,#255
3442                     ; 209     ITC_SPR3 = (uchar)0xFF;
3444  01c5 35ff7f72      	mov	_ITC_SPR3,#255
3445                     ; 210     ITC_SPR4 = (uchar)0xFF;
3447  01c9 35ff7f73      	mov	_ITC_SPR4,#255
3448                     ; 211     ITC_SPR5 = (uchar)0xFF;
3450  01cd 35ff7f74      	mov	_ITC_SPR5,#255
3451                     ; 212     ITC_SPR6 = (uchar)0xF5;
3453  01d1 35f57f75      	mov	_ITC_SPR6,#245
3454                     ; 213     ITC_SPR7 = (uchar)0xFF;
3456  01d5 35ff7f76      	mov	_ITC_SPR7,#255
3457                     ; 217     if (ram_d0 == 0x11 && ram_d1 == 0x33 && ram_d2 == 0x55 && ram_d3 == 0x77 && ram_d4 == 0x99 && ram_d5 == 0xaa && ram_d6 == 0xcc && ram_d7 == 0xee)
3459  01d9 b600          	ld	a,_ram_d0
3460  01db a111          	cp	a,#17
3461  01dd 262a          	jrne	L5412
3463  01df b600          	ld	a,_ram_d1
3464  01e1 a133          	cp	a,#51
3465  01e3 2624          	jrne	L5412
3467  01e5 b600          	ld	a,_ram_d2
3468  01e7 a155          	cp	a,#85
3469  01e9 261e          	jrne	L5412
3471  01eb b600          	ld	a,_ram_d3
3472  01ed a177          	cp	a,#119
3473  01ef 2618          	jrne	L5412
3475  01f1 b600          	ld	a,_ram_d4
3476  01f3 a199          	cp	a,#153
3477  01f5 2612          	jrne	L5412
3479  01f7 b600          	ld	a,_ram_d5
3480  01f9 a1aa          	cp	a,#170
3481  01fb 260c          	jrne	L5412
3483  01fd b600          	ld	a,_ram_d6
3484  01ff a1cc          	cp	a,#204
3485  0201 2606          	jrne	L5412
3487  0203 b600          	ld	a,_ram_d7
3488  0205 a1ee          	cp	a,#238
3489  0207 275a          	jreq	L22
3490                     ; 219         return;
3492  0209               L5412:
3493                     ; 222     for (i = RAM_ADDR_START; i <= RAM_ADDR_END; i++)
3495  0209 5f            	clrw	x
3496  020a 1f01          	ldw	(OFST-1,sp),x
3497  020c               L7412:
3498                     ; 224         *((uchar *)i) = 0;
3500  020c 1e01          	ldw	x,(OFST-1,sp)
3501  020e 7f            	clr	(x)
3502                     ; 222     for (i = RAM_ADDR_START; i <= RAM_ADDR_END; i++)
3504  020f 1e01          	ldw	x,(OFST-1,sp)
3505  0211 1c0001        	addw	x,#1
3506  0214 1f01          	ldw	(OFST-1,sp),x
3509  0216 1e01          	ldw	x,(OFST-1,sp)
3510  0218 a30600        	cpw	x,#1536
3511  021b 25ef          	jrult	L7412
3512                     ; 226     ram_d0 = 0x11;
3514  021d 35110000      	mov	_ram_d0,#17
3515                     ; 227     ram_d1 = 0x33;
3517  0221 35330000      	mov	_ram_d1,#51
3518                     ; 228     ram_d2 = 0x55;
3520  0225 35550000      	mov	_ram_d2,#85
3521                     ; 229     ram_d3 = 0x77;
3523  0229 35770000      	mov	_ram_d3,#119
3524                     ; 230     ram_d4 = 0x99;
3526  022d 35990000      	mov	_ram_d4,#153
3527                     ; 231     ram_d5 = 0xaa;
3529  0231 35aa0000      	mov	_ram_d5,#170
3530                     ; 232     ram_d6 = 0xcc;
3532  0235 35cc0000      	mov	_ram_d6,#204
3533                     ; 233     ram_d7 = 0xee;
3535  0239 35ee0000      	mov	_ram_d7,#238
3536                     ; 236     DisplayDriverInitializeLED();
3538  023d cd0000        	call	_DisplayDriverInitializeLED
3540                     ; 238     CLEAR_LED_ALL;
3542  0240 7212500a      	bset	_PC_ODR,#1
3545  0244 7214500a      	bset	_PC_ODR,#2
3548  0248 7216500a      	bset	_PC_ODR,#3
3551  024c 7218500a      	bset	_PC_ODR,#4
3554  0250 72145000      	bset	_PA_ODR,#2
3555                     ; 240     init_uart_sim();
3558  0254 cd0000        	call	_init_uart_sim
3560                     ; 242     init_params();
3562  0257 cd009d        	call	_init_params
3564                     ; 244     eeprom_wrchar(EEPROM_ADDR_FLAG_UPDATE, 0);
3566  025a 4b00          	push	#0
3567  025c ae407f        	ldw	x,#16511
3568  025f cd0000        	call	_eeprom_wrchar
3570  0262 84            	pop	a
3571                     ; 245 }
3572  0263               L22:
3575  0263 85            	popw	x
3576  0264 81            	ret
3589                     	xdef	_ini
3590                     	xdef	_init_params
3591                     	xdef	_timer1_ini
3592                     	xdef	_feed_wdg
3593                     	xref.b	_ram_d7
3594                     	xref.b	_ram_d6
3595                     	xref.b	_ram_d5
3596                     	xref.b	_ram_d4
3597                     	xref.b	_ram_d3
3598                     	xref.b	_ram_d2
3599                     	xref.b	_ram_d1
3600                     	xref.b	_ram_d0
3601                     	xref	_init_uart_sim
3602                     	xref	_eeprom_read
3603                     	xref	_eeprom_wrchar
3604                     	xref	_DisplayDriverInitializeLED
3605                     	xref	_flag_disp
3606                     	xref	_fixed_start_speed
3607                     	xref	_acceleration_param
3608                     	xref	_speed_limit_max
3609                     	xref	_dc_motor_rating_f1
3610                     	xref	_dc_motor_startup_volt
3611                     	xref	_dc_motor_rating_volt
3612                     	xbit	_waiting
3613                     	xref.b	_waiting_cnt
3632                     	end
