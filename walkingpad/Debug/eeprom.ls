   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2812                     ; 27 uchar eeprom_wrchar(uint addr, uchar ucdata)
2812                     ; 28 {
2814                     	switch	.text
2815  0000               _eeprom_wrchar:
2817  0000 89            	pushw	x
2818       00000000      OFST:	set	0
2821                     ; 30     FLASH->DUKR = 0xAE;
2823  0001 35ae5064      	mov	20580,#174
2824                     ; 31     FLASH->DUKR = 0x56; //unlock
2826  0005 35565064      	mov	20580,#86
2827                     ; 34     *((u8 *)addr) = ucdata;
2829  0009 7b05          	ld	a,(OFST+5,sp)
2830  000b 1e01          	ldw	x,(OFST+1,sp)
2831  000d f7            	ld	(x),a
2833  000e               L3102:
2834                     ; 35     while ((FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS)) == 0)
2836  000e c6505f        	ld	a,20575
2837  0011 a505          	bcp	a,#5
2838  0013 27f9          	jreq	L3102
2839                     ; 37     FLASH->IAPSR = (u8)(~0x08); //lock at last
2841  0015 35f7505f      	mov	20575,#247
2842                     ; 39 }
2845  0019 85            	popw	x
2846  001a 81            	ret
2889                     ; 41 void eeprom_write_long(uint addr, ulong ucdata)
2889                     ; 42 {
2890                     	switch	.text
2891  001b               _eeprom_write_long:
2893  001b 89            	pushw	x
2894       00000000      OFST:	set	0
2897                     ; 44     FLASH->DUKR = 0xAE;
2899  001c 35ae5064      	mov	20580,#174
2900                     ; 45     FLASH->DUKR = 0x56; //unlock
2902  0020 35565064      	mov	20580,#86
2903                     ; 48     *((u8 *)addr) = *((u8 *)(&ucdata));
2905  0024 7b05          	ld	a,(OFST+5,sp)
2906  0026 1e01          	ldw	x,(OFST+1,sp)
2907  0028 f7            	ld	(x),a
2908                     ; 49     *((u8 *)(addr + 1)) = *((u8 *)(&ucdata) + 1);
2910  0029 7b06          	ld	a,(OFST+6,sp)
2911  002b 1e01          	ldw	x,(OFST+1,sp)
2912  002d e701          	ld	(1,x),a
2913                     ; 50     *((u8 *)(addr + 2)) = *((u8 *)(&ucdata) + 2);
2915  002f 7b07          	ld	a,(OFST+7,sp)
2916  0031 1e01          	ldw	x,(OFST+1,sp)
2917  0033 e702          	ld	(2,x),a
2918                     ; 51     *((u8 *)(addr + 3)) = *((u8 *)(&ucdata) + 3);
2920  0035 7b08          	ld	a,(OFST+8,sp)
2921  0037 1e01          	ldw	x,(OFST+1,sp)
2922  0039 e703          	ld	(3,x),a
2924  003b               L5402:
2925                     ; 52     while ((FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS)) == 0)
2927  003b c6505f        	ld	a,20575
2928  003e a505          	bcp	a,#5
2929  0040 27f9          	jreq	L5402
2930                     ; 54     FLASH->IAPSR = (u8)(~0x08); //lock at last
2932  0042 35f7505f      	mov	20575,#247
2933                     ; 55 }
2936  0046 85            	popw	x
2937  0047 81            	ret
2980                     ; 57 void eeprom_write_int(uint addr, uint ucdata)
2980                     ; 58 {
2981                     	switch	.text
2982  0048               _eeprom_write_int:
2984  0048 89            	pushw	x
2985       00000000      OFST:	set	0
2988                     ; 60     FLASH->DUKR = 0xAE;
2990  0049 35ae5064      	mov	20580,#174
2991                     ; 61     FLASH->DUKR = 0x56; //unlock
2993  004d 35565064      	mov	20580,#86
2994                     ; 64     *((u8 *)addr) = *((u8 *)(&ucdata));
2996  0051 7b05          	ld	a,(OFST+5,sp)
2997  0053 1e01          	ldw	x,(OFST+1,sp)
2998  0055 f7            	ld	(x),a
2999                     ; 65     *((u8 *)(addr + 1)) = *((u8 *)(&ucdata) + 1);
3001  0056 7b06          	ld	a,(OFST+6,sp)
3002  0058 1e01          	ldw	x,(OFST+1,sp)
3003  005a e701          	ld	(1,x),a
3005  005c               L7702:
3006                     ; 66     while ((FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS)) == 0)
3008  005c c6505f        	ld	a,20575
3009  005f a505          	bcp	a,#5
3010  0061 27f9          	jreq	L7702
3011                     ; 68     FLASH->IAPSR = (u8)(~0x08); //lock at last
3013  0063 35f7505f      	mov	20575,#247
3014                     ; 69 }
3017  0067 85            	popw	x
3018  0068 81            	ret
3057                     ; 71 void eeprom_read(void)
3057                     ; 72 {
3058                     	switch	.text
3059  0069               _eeprom_read:
3063                     ; 73     user_total_distance = eeprom_read_long(EEPROM_ADDR_TOTAL_DIST);
3065  0069 ce4003        	ldw	x,16387
3066  006c cf0002        	ldw	_user_total_distance+2,x
3067  006f ce4001        	ldw	x,16385
3068  0072 cf0000        	ldw	_user_total_distance,x
3069                     ; 74     dc_motor_rating_volt = eeprom_rdchar(EEPROM_ADDR_RATING_VOLT);
3071  0075 5540060000    	mov	_dc_motor_rating_volt,16390
3072                     ; 75     dc_motor_rating_f1 = eeprom_rdchar(EEPROM_ADDR_RATING_F1);
3074  007a 5540070000    	mov	_dc_motor_rating_f1,16391
3075                     ; 76     dc_motor_startup_volt = eeprom_rdchar(EEPROM_ADDR_STARTUP_VOLT);
3077  007f 5540080000    	mov	_dc_motor_startup_volt,16392
3078                     ; 77     runmode = eeprom_rdchar(EEPROM_ADDR_RUNMODE);
3080  0084 55400b0000    	mov	_runmode,16395
3081                     ; 78     if (runmode == RUN_MODE_NEW) 
3083  0089 b600          	ld	a,_runmode
3084  008b a103          	cp	a,#3
3085  008d 2604          	jrne	L3112
3086                     ; 80         runmode = RUN_MODE_FIXED;
3088  008f 35010000      	mov	_runmode,#1
3089  0093               L3112:
3090                     ; 82     fixed_start_speed = eeprom_rdchar(EEPROM_ADDR_FIXED_SPEED);
3092  0093 55400c0000    	mov	_fixed_start_speed,16396
3093                     ; 83     speed_limit_max = eeprom_rdchar(EEPROM_ADDR_SPEED_LIMIT);
3095  0098 55400d0000    	mov	_speed_limit_max,16397
3096                     ; 84     tutorial_finish = eeprom_rdchar(EEPROM_ADDR_TUTORIAL_FINISH);
3098  009d 725d400e      	tnz	16398
3099  00a1 2602          	jrne	L43
3100  00a3 2006          	jp	L41
3101  00a5               L43:
3102  00a5 72100000      	bset	_tutorial_finish
3103  00a9 2004          	jra	L61
3104  00ab               L41:
3105  00ab 72110000      	bres	_tutorial_finish
3106  00af               L61:
3107                     ; 85     acceleration_param = eeprom_rdchar(EEPROM_ADDR_ACC_PARAM);
3109  00af 55400f0000    	mov	_acceleration_param,16399
3110                     ; 86     factory_finish = eeprom_rdchar(EEPROM_ADDR_FACTORY_FINISH);
3112  00b4 725d4010      	tnz	16400
3113  00b8 2602          	jrne	L63
3114  00ba 2006          	jp	L02
3115  00bc               L63:
3116  00bc 72100000      	bset	_factory_finish
3117  00c0 2004          	jra	L22
3118  00c2               L02:
3119  00c2 72110000      	bres	_factory_finish
3120  00c6               L22:
3121                     ; 87     max_speed_unlocked = eeprom_rdchar(EEPROM_ADDR_MAX_SPEED_UNLOCKED);
3123  00c6 725d4011      	tnz	16401
3124  00ca 2602          	jrne	L04
3125  00cc 2006          	jp	L42
3126  00ce               L04:
3127  00ce 72100000      	bset	_max_speed_unlocked
3128  00d2 2004          	jra	L62
3129  00d4               L42:
3130  00d4 72110000      	bres	_max_speed_unlocked
3131  00d8               L62:
3132                     ; 88     flag_auto = eeprom_rdchar(EEPROM_ADDR_AUTO);
3134  00d8 725d4012      	tnz	16402
3135  00dc 2602          	jrne	L24
3136  00de 2006          	jp	L03
3137  00e0               L24:
3138  00e0 72100000      	bset	_flag_auto
3139  00e4 2004          	jra	L23
3140  00e6               L03:
3141  00e6 72110000      	bres	_flag_auto
3142  00ea               L23:
3143                     ; 89     flag_disp = eeprom_rdchar(EEPROM_ADDR_DISP);
3145  00ea 5540130000    	mov	_flag_disp,16403
3146                     ; 91     goal_type = eeprom_rdchar(EEPROM_ADDR_GOAL_TYPE);
3148  00ef 5540140000    	mov	_goal_type,16404
3149                     ; 92     goal_value = eeprom_read_int(EEPROM_ADDR_GOAL_VALUE);
3151  00f4 ce4015        	ldw	x,16405
3152  00f7 cf0000        	ldw	_goal_value,x
3153                     ; 94     store_point.offline_dist = eeprom_read_int(EEPROM_ADDR_OFFLINE_DIST);
3155  00fa ce4017        	ldw	x,16407
3156  00fd cf0015        	ldw	_store_point+21,x
3157                     ; 95     store_point.offline_energy = eeprom_read_long(EEPROM_ADDR_OFFLINE_ENERGY);
3159  0100 ce401b        	ldw	x,16411
3160  0103 cf0019        	ldw	_store_point+25,x
3161  0106 ce4019        	ldw	x,16409
3162  0109 cf0017        	ldw	_store_point+23,x
3163                     ; 96     store_point.offline_steps = eeprom_read_int(EEPROM_ADDR_OFFLINE_STEPS);
3165  010c ce401d        	ldw	x,16413
3166  010f cf001b        	ldw	_store_point+27,x
3167                     ; 97     store_point.offline_time = eeprom_read_int(EEPROM_ADDR_OFFLINE_TIME);
3169  0112 ce401f        	ldw	x,16415
3170  0115 cf001d        	ldw	_store_point+29,x
3171                     ; 98 }
3174  0118 81            	ret
3209                     ; 100 void eeprom_factory(void)
3209                     ; 101 {
3210                     	switch	.text
3211  0119               _eeprom_factory:
3213  0119 89            	pushw	x
3214       00000002      OFST:	set	2
3217                     ; 104     FLASH->DUKR = 0xAE;
3219  011a 35ae5064      	mov	20580,#174
3220                     ; 105     FLASH->DUKR = 0x56; //unlock
3222  011e 35565064      	mov	20580,#86
3223                     ; 106     for (addr = EEPROM_ADDR_INI; addr < EEPROM_ADDR_RATING_VOLT; addr++)
3225  0122 ae4000        	ldw	x,#16384
3226  0125 1f01          	ldw	(OFST-1,sp),x
3227  0127               L3312:
3228                     ; 107         *((u8 *)addr) = (u8)0;
3230  0127 1e01          	ldw	x,(OFST-1,sp)
3231  0129 7f            	clr	(x)
3232                     ; 106     for (addr = EEPROM_ADDR_INI; addr < EEPROM_ADDR_RATING_VOLT; addr++)
3234  012a 1e01          	ldw	x,(OFST-1,sp)
3235  012c 1c0001        	addw	x,#1
3236  012f 1f01          	ldw	(OFST-1,sp),x
3239  0131 1e01          	ldw	x,(OFST-1,sp)
3240  0133 a34006        	cpw	x,#16390
3241  0136 25ef          	jrult	L3312
3242                     ; 108     for (addr = EEPROM_ADDR_RUNMODE; addr <= EEPROM_ADDR_TEST_STATE; addr++) // skip F1 F2 F3
3244  0138 ae400b        	ldw	x,#16395
3245  013b 1f01          	ldw	(OFST-1,sp),x
3246  013d               L1412:
3247                     ; 109         *((u8 *)addr) = (u8)0;
3249  013d 1e01          	ldw	x,(OFST-1,sp)
3250  013f 7f            	clr	(x)
3251                     ; 108     for (addr = EEPROM_ADDR_RUNMODE; addr <= EEPROM_ADDR_TEST_STATE; addr++) // skip F1 F2 F3
3253  0140 1e01          	ldw	x,(OFST-1,sp)
3254  0142 1c0001        	addw	x,#1
3255  0145 1f01          	ldw	(OFST-1,sp),x
3258  0147 1e01          	ldw	x,(OFST-1,sp)
3259  0149 a3407e        	cpw	x,#16510
3260  014c 25ef          	jrult	L1412
3262  014e               L1512:
3263                     ; 110     while ((FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS)) == 0)
3265  014e c6505f        	ld	a,20575
3266  0151 a505          	bcp	a,#5
3267  0153 27f9          	jreq	L1512
3268                     ; 112     FLASH->IAPSR = (u8)(~0x08); //lock at last
3270  0155 35f7505f      	mov	20575,#247
3271                     ; 114     eeprom_wrchar(EEPROM_ADDR_RUNMODE, RUN_MODE_FIXED);
3273  0159 4b01          	push	#1
3274  015b ae400b        	ldw	x,#16395
3275  015e cd0000        	call	_eeprom_wrchar
3277  0161 84            	pop	a
3278                     ; 115     eeprom_wrchar(EEPROM_ADDR_FACTORY_FINISH, 1);
3280  0162 4b01          	push	#1
3281  0164 ae4010        	ldw	x,#16400
3282  0167 cd0000        	call	_eeprom_wrchar
3284  016a 84            	pop	a
3285                     ; 116     eeprom_wrchar(EEPROM_ADDR_FLAG_UPDATE, 0);
3287  016b 4b00          	push	#0
3288  016d ae407f        	ldw	x,#16511
3289  0170 cd0000        	call	_eeprom_wrchar
3291  0173 84            	pop	a
3292                     ; 117 }
3295  0174 85            	popw	x
3296  0175 81            	ret
3309                     	xref	_user_total_distance
3310                     	xref	_store_point
3311                     	xref.b	_runmode
3312                     	xdef	_eeprom_factory
3313                     	xdef	_eeprom_write_int
3314                     	xdef	_eeprom_write_long
3315                     	xdef	_eeprom_read
3316                     	xdef	_eeprom_wrchar
3317                     	xref	_flag_disp
3318                     	xbit	_flag_auto
3319                     	xref	_goal_value
3320                     	xref	_goal_type
3321                     	xref	_fixed_start_speed
3322                     	xbit	_max_speed_unlocked
3323                     	xbit	_factory_finish
3324                     	xref	_acceleration_param
3325                     	xbit	_tutorial_finish
3326                     	xref	_speed_limit_max
3327                     	xref	_dc_motor_rating_f1
3328                     	xref	_dc_motor_startup_volt
3329                     	xref	_dc_motor_rating_volt
3348                     	end
