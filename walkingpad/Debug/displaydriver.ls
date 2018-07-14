   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2824                     ; 33 void LED_Send_Command_Bit(uchar dat, uchar n)
2824                     ; 34 {
2826                     	switch	.text
2827  0000               _LED_Send_Command_Bit:
2829  0000 89            	pushw	x
2830  0001 88            	push	a
2831       00000001      OFST:	set	1
2834                     ; 36     for (i = 0; i < n; i++)
2836  0002 0f01          	clr	(OFST+0,sp)
2838  0004 2013          	jra	L7102
2839  0006               L3102:
2840                     ; 38         LED_CLOCK = 0;
2842  0006 72175005      	bres	_PB_ODR,#3
2843                     ; 47         dat <<= 1;
2845  000a 0802          	sll	(OFST+1,sp)
2846                     ; 48         LED_DATA = carry();
2848  000c 4f            	clr	a
2849  000d 49            	rlc	a
2850  000e 44            	srl	a
2851  000f 90155005      	bccm	_PB_ODR,#2
2852                     ; 50         LED_CLOCK = 1;
2854  0013 72165005      	bset	_PB_ODR,#3
2855                     ; 36     for (i = 0; i < n; i++)
2857  0017 0c01          	inc	(OFST+0,sp)
2858  0019               L7102:
2861  0019 7b01          	ld	a,(OFST+0,sp)
2862  001b 1103          	cp	a,(OFST+2,sp)
2863  001d 25e7          	jrult	L3102
2864                     ; 52 }
2867  001f 5b03          	addw	sp,#3
2868  0021 81            	ret
2913                     ; 54 void LED_Send_Data_Bit(uchar dat)
2913                     ; 55 {
2914                     	switch	.text
2915  0022               _LED_Send_Data_Bit:
2917  0022 88            	push	a
2918  0023 88            	push	a
2919       00000001      OFST:	set	1
2922                     ; 57     for (i = 0; i < 8; i++)
2924  0024 0f01          	clr	(OFST+0,sp)
2925  0026               L5402:
2926                     ; 59         LED_CLOCK = 0;
2928  0026 72175005      	bres	_PB_ODR,#3
2929                     ; 68         dat >>= 1;
2931  002a 0402          	srl	(OFST+1,sp)
2932                     ; 69         LED_DATA = carry();
2934  002c 4f            	clr	a
2935  002d 49            	rlc	a
2936  002e 44            	srl	a
2937  002f 90155005      	bccm	_PB_ODR,#2
2938                     ; 71         LED_CLOCK = 1;
2940  0033 72165005      	bset	_PB_ODR,#3
2941                     ; 57     for (i = 0; i < 8; i++)
2943  0037 0c01          	inc	(OFST+0,sp)
2946  0039 7b01          	ld	a,(OFST+0,sp)
2947  003b a108          	cp	a,#8
2948  003d 25e7          	jrult	L5402
2949                     ; 73 }
2952  003f 85            	popw	x
2953  0040 81            	ret
2989                     ; 75 void LED_Write_Command(uchar command)
2989                     ; 76 {
2990                     	switch	.text
2991  0041               _LED_Write_Command:
2993  0041 88            	push	a
2994       00000000      OFST:	set	0
2997                     ; 77     LED_CLOCK = 1;
2999  0042 72165005      	bset	_PB_ODR,#3
3000                     ; 80     LED_CS2 = 0;
3002  0046 72135005      	bres	_PB_ODR,#1
3003                     ; 82     LED_Send_Command_Bit(0x80, 3);
3005  004a ae0003        	ldw	x,#3
3006  004d a680          	ld	a,#128
3007  004f 95            	ld	xh,a
3008  0050 adae          	call	_LED_Send_Command_Bit
3010                     ; 83     LED_Send_Command_Bit(command, 9);
3012  0052 ae0009        	ldw	x,#9
3013  0055 7b01          	ld	a,(OFST+1,sp)
3014  0057 95            	ld	xh,a
3015  0058 ada6          	call	_LED_Send_Command_Bit
3017                     ; 85     LED_CS2 = 1;
3019  005a 72125005      	bset	_PB_ODR,#1
3020                     ; 86 }
3023  005e 84            	pop	a
3024  005f 81            	ret
3093                     ; 88 void DisplayDriverProcessLED(void)
3093                     ; 89 {
3094                     	switch	.text
3095  0060               _DisplayDriverProcessLED:
3097  0060 5208          	subw	sp,#8
3098       00000008      OFST:	set	8
3101                     ; 93     uchar* const image_up = images[LED_UP];
3103  0062 ce0000        	ldw	x,_images
3104  0065 1f03          	ldw	(OFST-5,sp),x
3105                     ; 94     uchar* const image_down = images[LED_DOWN];
3107  0067 ce0002        	ldw	x,_images+2
3108  006a 1f06          	ldw	(OFST-2,sp),x
3109                     ; 98     LED_CS2 = 0;
3111  006c 72135005      	bres	_PB_ODR,#1
3112                     ; 100     LED_Send_Command_Bit(0xA0, 3);
3114  0070 ae0003        	ldw	x,#3
3115  0073 a6a0          	ld	a,#160
3116  0075 95            	ld	xh,a
3117  0076 ad88          	call	_LED_Send_Command_Bit
3119                     ; 101     LED_Send_Command_Bit(0, 7);
3121  0078 ae0007        	ldw	x,#7
3122  007b 4f            	clr	a
3123  007c 95            	ld	xh,a
3124  007d ad81          	call	_LED_Send_Command_Bit
3126                     ; 103     c = image_down[0];
3128  007f 1e06          	ldw	x,(OFST-2,sp)
3129  0081 f6            	ld	a,(x)
3130  0082 6b05          	ld	(OFST-3,sp),a
3131                     ; 104     for (i = 0; c > 0 && i < 7; i++)
3133  0084 0f08          	clr	(OFST+0,sp)
3135  0086 201d          	jra	L7212
3136  0088               L3212:
3137                     ; 106         c >>= 1;
3139  0088 0405          	srl	(OFST-3,sp)
3140                     ; 107         if (carry())
3142  008a 2417          	jruge	L3312
3143                     ; 108             image_down[LED_DOWN_SIZE - 1 - i] |= 0x80;
3145  008c 7b08          	ld	a,(OFST+0,sp)
3146  008e 5f            	clrw	x
3147  008f 4d            	tnz	a
3148  0090 2a01          	jrpl	L41
3149  0092 53            	cplw	x
3150  0093               L41:
3151  0093 97            	ld	xl,a
3152  0094 1f01          	ldw	(OFST-7,sp),x
3153  0096 ae0018        	ldw	x,#24
3154  0099 72f001        	subw	x,(OFST-7,sp)
3155  009c 72fb06        	addw	x,(OFST-2,sp)
3156  009f f6            	ld	a,(x)
3157  00a0 aa80          	or	a,#128
3158  00a2 f7            	ld	(x),a
3159  00a3               L3312:
3160                     ; 104     for (i = 0; c > 0 && i < 7; i++)
3162  00a3 0c08          	inc	(OFST+0,sp)
3163  00a5               L7212:
3166  00a5 0d05          	tnz	(OFST-3,sp)
3167  00a7 2707          	jreq	L5312
3169  00a9 9c            	rvf
3170  00aa 7b08          	ld	a,(OFST+0,sp)
3171  00ac a107          	cp	a,#7
3172  00ae 2fd8          	jrslt	L3212
3173  00b0               L5312:
3174                     ; 110     for (i = LED_UP_SIZE - 1; i >= 0; i--)
3176  00b0 a616          	ld	a,#22
3177  00b2 6b08          	ld	(OFST+0,sp),a
3178  00b4               L7312:
3179                     ; 112         LED_Send_Data_Bit(image_up[i]);
3181  00b4 7b08          	ld	a,(OFST+0,sp)
3182  00b6 5f            	clrw	x
3183  00b7 4d            	tnz	a
3184  00b8 2a01          	jrpl	L61
3185  00ba 53            	cplw	x
3186  00bb               L61:
3187  00bb 97            	ld	xl,a
3188  00bc 72fb03        	addw	x,(OFST-5,sp)
3189  00bf f6            	ld	a,(x)
3190  00c0 cd0022        	call	_LED_Send_Data_Bit
3192                     ; 113         LED_Send_Data_Bit(image_down[i + 2]);
3194  00c3 7b08          	ld	a,(OFST+0,sp)
3195  00c5 5f            	clrw	x
3196  00c6 4d            	tnz	a
3197  00c7 2a01          	jrpl	L02
3198  00c9 53            	cplw	x
3199  00ca               L02:
3200  00ca 97            	ld	xl,a
3201  00cb 72fb06        	addw	x,(OFST-2,sp)
3202  00ce e602          	ld	a,(2,x)
3203  00d0 cd0022        	call	_LED_Send_Data_Bit
3205                     ; 110     for (i = LED_UP_SIZE - 1; i >= 0; i--)
3207  00d3 0a08          	dec	(OFST+0,sp)
3210  00d5 9c            	rvf
3211  00d6 0d08          	tnz	(OFST+0,sp)
3212  00d8 2eda          	jrsge	L7312
3213                     ; 115     LED_Send_Data_Bit(0);
3215  00da 4f            	clr	a
3216  00db cd0022        	call	_LED_Send_Data_Bit
3218                     ; 116     LED_Send_Data_Bit(image_down[1]);
3220  00de 1e06          	ldw	x,(OFST-2,sp)
3221  00e0 e601          	ld	a,(1,x)
3222  00e2 cd0022        	call	_LED_Send_Data_Bit
3224                     ; 119     LED_CS2 = 1;
3226  00e5 72125005      	bset	_PB_ODR,#1
3227                     ; 120 }
3230  00e9 5b08          	addw	sp,#8
3231  00eb 81            	ret
3257                     ; 121 void DisplayDriverInitializeLED(void)
3257                     ; 122 {
3258                     	switch	.text
3259  00ec               _DisplayDriverInitializeLED:
3263                     ; 124     LED_CS2 = 1;
3265  00ec 72125005      	bset	_PB_ODR,#1
3266                     ; 125     LED_Write_Command(LED_SYS_DIS);
3268  00f0 4f            	clr	a
3269  00f1 cd0041        	call	_LED_Write_Command
3271                     ; 127     LED_Write_Command(LED_COM_OPTION);
3273  00f4 a624          	ld	a,#36
3274  00f6 cd0041        	call	_LED_Write_Command
3276                     ; 129     LED_Write_Command(LED_RC_MASTER_MODE);
3278  00f9 a618          	ld	a,#24
3279  00fb cd0041        	call	_LED_Write_Command
3281                     ; 131     LED_Write_Command(LED_SYS_EN);
3283  00fe a601          	ld	a,#1
3284  0100 cd0041        	call	_LED_Write_Command
3286                     ; 136     LED_Write_Command(LED_PWM_DUTY + PWM_DUTY_16);
3288  0103 a6af          	ld	a,#175
3289  0105 cd0041        	call	_LED_Write_Command
3291                     ; 139     LED_Write_Command(LED_BLINK_OFF);
3293  0108 a608          	ld	a,#8
3294  010a cd0041        	call	_LED_Write_Command
3296                     ; 141     LED_Write_Command(LED_ON);
3298  010d a603          	ld	a,#3
3299  010f cd0041        	call	_LED_Write_Command
3301                     ; 143 }
3304  0112 81            	ret
3328                     	xdef	_LED_Write_Command
3329                     	xdef	_LED_Send_Data_Bit
3330                     	xdef	_LED_Send_Command_Bit
3331                     	switch	.ubsct
3332  0000               _ram_d4:
3333  0000 00            	ds.b	1
3334                     	xdef	_ram_d4
3335                     	xdef	_DisplayDriverProcessLED
3336                     	xdef	_DisplayDriverInitializeLED
3337                     	xref	_images
3357                     	end
