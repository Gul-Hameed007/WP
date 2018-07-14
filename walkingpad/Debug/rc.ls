   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2765                     	bsct
2766  0000               L7571_rcTimer:
2767  0000 0000          	dc.w	0
2768  0002               L1671_rcTimerPre:
2769  0002 0000          	dc.w	0
2770  0004               L3671_rcState:
2771  0004 0000          	dc.w	0
2772  0006               L5671_rcData:
2773  0006 00000000      	dc.l	0
2774  000a               L7671_rcBitCount:
2775  000a 0000          	dc.w	0
2776                     .bit:	section	.data,bit
2777  0000               L1771_rcEnd:
2778  0000 00            	dc.b	0
2779                     	bsct
2780  000c               L5771_rcKeyId:
2781  000c 0000          	dc.w	0
2782  000e               L7771_rcRepeatCount:
2783  000e 0000          	dc.w	0
2829                     ; 19 int rcCheck(void) // check for keyid
2829                     ; 20 {
2831                     	switch	.text
2832  0000               _rcCheck:
2834  0000 89            	pushw	x
2835       00000002      OFST:	set	2
2838                     ; 21 	int keyid = KEY_NONE;
2840  0001 5f            	clrw	x
2841  0002 1f01          	ldw	(OFST-1,sp),x
2842                     ; 22 	if (rcKeyId == KEY_NONE)
2844  0004 be0c          	ldw	x,L5771_rcKeyId
2845  0006 2603          	jrne	L5202
2846                     ; 24 		return KEY_NONE;
2848  0008 5f            	clrw	x
2850  0009 203d          	jra	L6
2851  000b               L5202:
2852                     ; 26 	else if (rcRepeatCount > 0 && rcRepeatCount < LONG_PRESS_TIME && rcEnd == 1)
2854  000b 9c            	rvf
2855  000c be0e          	ldw	x,L7771_rcRepeatCount
2856  000e 2d15          	jrsle	L1302
2858  0010 9c            	rvf
2859  0011 be0e          	ldw	x,L7771_rcRepeatCount
2860  0013 a3000a        	cpw	x,#10
2861  0016 2e0d          	jrsge	L1302
2863                     	btst	L1771_rcEnd
2864  001d 2406          	jruge	L1302
2865                     ; 28 		keyid = rcKeyId;
2867  001f be0c          	ldw	x,L5771_rcKeyId
2868  0021 1f01          	ldw	(OFST-1,sp),x
2870  0023 200f          	jra	L7202
2871  0025               L1302:
2872                     ; 30 	else if (rcRepeatCount >= LONG_PRESS_TIME)
2874  0025 9c            	rvf
2875  0026 be0e          	ldw	x,L7771_rcRepeatCount
2876  0028 a3000a        	cpw	x,#10
2877  002b 2f1e          	jrslt	L5302
2878                     ; 32 		keyid = rcKeyId + KEY_LONG_PRESS;
2880  002d be0c          	ldw	x,L5771_rcKeyId
2881  002f 1c0100        	addw	x,#256
2882  0032 1f01          	ldw	(OFST-1,sp),x
2884  0034               L7202:
2885                     ; 40 	rcState = 0;
2887  0034 5f            	clrw	x
2888  0035 bf04          	ldw	L3671_rcState,x
2889                     ; 41 	rcTimer = 0;
2891  0037 5f            	clrw	x
2892  0038 bf00          	ldw	L7571_rcTimer,x
2893                     ; 42 	rcEnd = 0;
2895  003a 72110000      	bres	L1771_rcEnd
2896                     ; 43 	rcKeyId = KEY_NONE;
2898  003e 5f            	clrw	x
2899  003f bf0c          	ldw	L5771_rcKeyId,x
2900                     ; 44 	rcRepeatCount = 0;
2902  0041 5f            	clrw	x
2903  0042 bf0e          	ldw	L7771_rcRepeatCount,x
2904                     ; 45 	rcTemp[2] = 0;
2906  0044 3f02          	clr	L3771_rcTemp+2
2907                     ; 46 	return keyid;
2909  0046 1e01          	ldw	x,(OFST-1,sp)
2911  0048               L6:
2913  0048 5b02          	addw	sp,#2
2914  004a 81            	ret
2915  004b               L5302:
2916                     ; 36 		return KEY_NONE;
2918  004b 5f            	clrw	x
2920  004c 20fa          	jra	L6
2952                     ; 49 @far @interrupt void rc_isr(void)
2952                     ; 50 {
2954                     	switch	.text
2955  004e               f_rc_isr:
2960                     ; 51 	if (rcState == 0)
2962  004e be04          	ldw	x,L3671_rcState
2963  0050 2610          	jrne	L7602
2964                     ; 53 		rcState = 1;
2966  0052 ae0001        	ldw	x,#1
2967  0055 bf04          	ldw	L3671_rcState,x
2968                     ; 54         rcEnd = 0;
2970  0057 72110000      	bres	L1771_rcEnd
2971                     ; 55 		rcTimer = 0;
2973  005b 5f            	clrw	x
2974  005c bf00          	ldw	L7571_rcTimer,x
2976  005e ac090109      	jpf	L1702
2977  0062               L7602:
2978                     ; 57 	else if (rcState == 1 && (rcTimer - rcTimerPre) > 200)
2980  0062 be04          	ldw	x,L3671_rcState
2981  0064 a30001        	cpw	x,#1
2982  0067 2622          	jrne	L3702
2984  0069 9c            	rvf
2985  006a be00          	ldw	x,L7571_rcTimer
2986  006c 72b00002      	subw	x,L1671_rcTimerPre
2987  0070 a300c9        	cpw	x,#201
2988  0073 2f16          	jrslt	L3702
2989                     ; 60 		rcState = 2;
2991  0075 ae0002        	ldw	x,#2
2992  0078 bf04          	ldw	L3671_rcState,x
2993                     ; 61 		rcData = 0;
2995  007a ae0000        	ldw	x,#0
2996  007d bf08          	ldw	L5671_rcData+2,x
2997  007f ae0000        	ldw	x,#0
2998  0082 bf06          	ldw	L5671_rcData,x
2999                     ; 62 		rcBitCount = 0;
3001  0084 5f            	clrw	x
3002  0085 bf0a          	ldw	L7671_rcBitCount,x
3004  0087 ac090109      	jra	L1702
3005  008b               L3702:
3006                     ; 64 	else if (rcState == 2 && (rcTimer - rcTimerPre) < 54)
3008  008b be04          	ldw	x,L3671_rcState
3009  008d a30002        	cpw	x,#2
3010  0090 263a          	jrne	L7702
3012  0092 9c            	rvf
3013  0093 be00          	ldw	x,L7571_rcTimer
3014  0095 72b00002      	subw	x,L1671_rcTimerPre
3015  0099 a30036        	cpw	x,#54
3016  009c 2e2e          	jrsge	L7702
3017                     ; 67 		rcData <<= 1;
3019  009e 3809          	sll	L5671_rcData+3
3020  00a0 3908          	rlc	L5671_rcData+2
3021  00a2 3907          	rlc	L5671_rcData+1
3022  00a4 3906          	rlc	L5671_rcData
3023                     ; 68 		if (rcTimer - rcTimerPre >= 34)
3025  00a6 9c            	rvf
3026  00a7 be00          	ldw	x,L7571_rcTimer
3027  00a9 72b00002      	subw	x,L1671_rcTimerPre
3028  00ad a30022        	cpw	x,#34
3029  00b0 2f04          	jrslt	L1012
3030                     ; 70 			rcData |= 0X01;
3032  00b2 72100009      	bset	L5671_rcData+3,#0
3033  00b6               L1012:
3034                     ; 72 		rcBitCount++;
3036  00b6 be0a          	ldw	x,L7671_rcBitCount
3037  00b8 1c0001        	addw	x,#1
3038  00bb bf0a          	ldw	L7671_rcBitCount,x
3039                     ; 73 		if (rcBitCount >= 32)
3041  00bd 9c            	rvf
3042  00be be0a          	ldw	x,L7671_rcBitCount
3043  00c0 a30020        	cpw	x,#32
3044  00c3 2f44          	jrslt	L1702
3045                     ; 75 			rcState = 3;
3047  00c5 ae0003        	ldw	x,#3
3048  00c8 bf04          	ldw	L3671_rcState,x
3049  00ca 203d          	jra	L1702
3050  00cc               L7702:
3051                     ; 78 	else if (rcState == 3 && rcTimer > 2000)
3053  00cc be04          	ldw	x,L3671_rcState
3054  00ce a30003        	cpw	x,#3
3055  00d1 2612          	jrne	L7012
3057  00d3 9c            	rvf
3058  00d4 be00          	ldw	x,L7571_rcTimer
3059  00d6 a307d1        	cpw	x,#2001
3060  00d9 2f0a          	jrslt	L7012
3061                     ; 80 		rcTimer = 0;
3063  00db 5f            	clrw	x
3064  00dc bf00          	ldw	L7571_rcTimer,x
3065                     ; 81 		rcState = 4;
3067  00de ae0004        	ldw	x,#4
3068  00e1 bf04          	ldw	L3671_rcState,x
3070  00e3 2024          	jra	L1702
3071  00e5               L7012:
3072                     ; 83 	else if (rcState == 4 && (rcTimer - rcTimerPre) < 250)
3074  00e5 be04          	ldw	x,L3671_rcState
3075  00e7 a30004        	cpw	x,#4
3076  00ea 261a          	jrne	L3112
3078  00ec 9c            	rvf
3079  00ed be00          	ldw	x,L7571_rcTimer
3080  00ef 72b00002      	subw	x,L1671_rcTimerPre
3081  00f3 a300fa        	cpw	x,#250
3082  00f6 2e0e          	jrsge	L3112
3083                     ; 85 		rcState = 3;
3085  00f8 ae0003        	ldw	x,#3
3086  00fb bf04          	ldw	L3671_rcState,x
3087                     ; 86 		rcRepeatCount++;
3089  00fd be0e          	ldw	x,L7771_rcRepeatCount
3090  00ff 1c0001        	addw	x,#1
3091  0102 bf0e          	ldw	L7771_rcRepeatCount,x
3093  0104 2003          	jra	L1702
3094  0106               L3112:
3095                     ; 90 		rcState = 0;
3097  0106 5f            	clrw	x
3098  0107 bf04          	ldw	L3671_rcState,x
3099  0109               L1702:
3100                     ; 92 	rcTimerPre = rcTimer;
3102  0109 be00          	ldw	x,L7571_rcTimer
3103  010b bf02          	ldw	L1671_rcTimerPre,x
3104                     ; 94 	if (rcBitCount >= 32)
3106  010d 9c            	rvf
3107  010e be0a          	ldw	x,L7671_rcBitCount
3108  0110 a30020        	cpw	x,#32
3109  0113 2e04          	jrsge	L21
3110  0115 acb001b0      	jpf	L7112
3111  0119               L21:
3112                     ; 96 		rcTemp[0] = (uchar)((rcData >> 24) & 0xff);
3114  0119 b606          	ld	a,L5671_rcData
3115  011b a4ff          	and	a,#255
3116  011d b700          	ld	L3771_rcTemp,a
3117                     ; 97 		rcTemp[1] = (uchar)((rcData >> 16) & 0xff);
3119  011f b607          	ld	a,L5671_rcData+1
3120  0121 a4ff          	and	a,#255
3121  0123 b701          	ld	L3771_rcTemp+1,a
3122                     ; 98 		rcTemp[2] = (uchar)((rcData >> 8) & 0xff);
3124  0125 b608          	ld	a,L5671_rcData+2
3125  0127 a4ff          	and	a,#255
3126  0129 b702          	ld	L3771_rcTemp+2,a
3127                     ; 99 		rcTemp[3] = (uchar)((rcData >> 0) & 0xff);
3129  012b b609          	ld	a,L5671_rcData+3
3130  012d a4ff          	and	a,#255
3131  012f b703          	ld	L3771_rcTemp+3,a
3132                     ; 101 		rcData = 0;
3134  0131 ae0000        	ldw	x,#0
3135  0134 bf08          	ldw	L5671_rcData+2,x
3136  0136 ae0000        	ldw	x,#0
3137  0139 bf06          	ldw	L5671_rcData,x
3138                     ; 102 		rcBitCount = 0;
3140  013b 5f            	clrw	x
3141  013c bf0a          	ldw	L7671_rcBitCount,x
3142                     ; 103 		rcRepeatCount = 1;
3144  013e ae0001        	ldw	x,#1
3145  0141 bf0e          	ldw	L7771_rcRepeatCount,x
3146                     ; 105 		if (rcTemp[2] == (uchar)(~rcTemp[3]))
3148  0143 b603          	ld	a,L3771_rcTemp+3
3149  0145 43            	cpl	a
3150  0146 b102          	cp	a,L3771_rcTemp+2
3151  0148 2666          	jrne	L7112
3152                     ; 107 			switch(rcTemp[2])
3154  014a b602          	ld	a,L3771_rcTemp+2
3156                     ; 136 					break;
3157  014c 4d            	tnz	a
3158  014d 2747          	jreq	L7402
3159  014f a004          	sub	a,#4
3160  0151 2743          	jreq	L7402
3161  0153 a014          	sub	a,#20
3162  0155 272a          	jreq	L1402
3163  0157 a010          	sub	a,#16
3164  0159 2750          	jreq	L5502
3165  015b a018          	sub	a,#24
3166  015d 273e          	jreq	L1502
3167  015f 4a            	dec	a
3168  0160 271f          	jreq	L1402
3169  0162 a012          	sub	a,#18
3170  0164 2729          	jreq	L5402
3171  0166 a00d          	sub	a,#13
3172  0168 2725          	jreq	L5402
3173  016a a020          	sub	a,#32
3174  016c 271a          	jreq	L3402
3175  016e 4a            	dec	a
3176  016f 2717          	jreq	L3402
3177  0171 a047          	sub	a,#71
3178  0173 272f          	jreq	L3502
3179  0175 a029          	sub	a,#41
3180  0177 2724          	jreq	L1502
3181  0179 4a            	dec	a
3182  017a 2728          	jreq	L3502
3183  017c 4a            	dec	a
3184  017d 272c          	jreq	L5502
3185  017f 202f          	jra	L7112
3186  0181               L1402:
3187                     ; 109 				case 0x41:
3187                     ; 110 				case 0x18:
3187                     ; 111 					rcKeyId = KEY_UP_PRESS;
3189  0181 ae0002        	ldw	x,#2
3190  0184 bf0c          	ldw	L5771_rcKeyId,x
3191                     ; 112 					break;
3193  0186 2028          	jra	L7112
3194  0188               L3402:
3195                     ; 113 				case 0x81:
3195                     ; 114 				case 0x80:
3195                     ; 115 					rcKeyId = KEY_MODE_PRESS;
3197  0188 ae0001        	ldw	x,#1
3198  018b bf0c          	ldw	L5771_rcKeyId,x
3199                     ; 116 					break;
3201  018d 2021          	jra	L7112
3202  018f               L5402:
3203                     ; 117 				case 0x53:
3203                     ; 118 				case 0x60:
3203                     ; 119 					rcKeyId = KEY_DOWN_PRESS;
3205  018f ae0004        	ldw	x,#4
3206  0192 bf0c          	ldw	L5771_rcKeyId,x
3207                     ; 120 					break;
3209  0194 201a          	jra	L7112
3210  0196               L7402:
3211                     ; 121 				case 0x00:
3211                     ; 122 				case 0x04:
3211                     ; 123 					rcKeyId = KEY_STOP_PRESS;
3213  0196 ae0003        	ldw	x,#3
3214  0199 bf0c          	ldw	L5771_rcKeyId,x
3215                     ; 124 					break;
3217  019b 2013          	jra	L7112
3218  019d               L1502:
3219                     ; 125 				case 0xf1:
3219                     ; 126 				case 0x40:
3219                     ; 127 					rcKeyId = KEY_MODE_UP_PRESS;
3221  019d ae0011        	ldw	x,#17
3222  01a0 bf0c          	ldw	L5771_rcKeyId,x
3223                     ; 128 					break;
3225  01a2 200c          	jra	L7112
3226  01a4               L3502:
3227                     ; 129 				case 0xf2:
3227                     ; 130 				case 0xc8:
3227                     ; 131 					rcKeyId = KEY_MODE_STOP_PRESS;
3229  01a4 ae0012        	ldw	x,#18
3230  01a7 bf0c          	ldw	L5771_rcKeyId,x
3231                     ; 132 					break;
3233  01a9 2005          	jra	L7112
3234  01ab               L5502:
3235                     ; 133 				case 0xf3:
3235                     ; 134 				case 0x28:
3235                     ; 135 					rcKeyId = KEY_MODE_DOWN_PRESS;
3237  01ab ae0013        	ldw	x,#19
3238  01ae bf0c          	ldw	L5771_rcKeyId,x
3239                     ; 136 					break;
3241  01b0               L5212:
3242  01b0               L7112:
3243                     ; 154 }
3246  01b0 80            	iret
3273                     ; 156 @far @interrupt void TIM2_OV_isr(void)
3273                     ; 157 {
3274                     	switch	.text
3275  01b1               f_TIM2_OV_isr:
3280                     ; 158 	TIM2_SR1 &= 0xFE; //clear Flag
3282  01b1 72115302      	bres	_TIM2_SR1,#0
3283                     ; 160 	if (rcState > 0)
3285  01b5 9c            	rvf
3286  01b6 be04          	ldw	x,L3671_rcState
3287  01b8 2d07          	jrsle	L7312
3288                     ; 162 		rcTimer++;
3290  01ba be00          	ldw	x,L7571_rcTimer
3291  01bc 1c0001        	addw	x,#1
3292  01bf bf00          	ldw	L7571_rcTimer,x
3293  01c1               L7312:
3294                     ; 165 	if (rcTimer > 2400)
3296  01c1 9c            	rvf
3297  01c2 be00          	ldw	x,L7571_rcTimer
3298  01c4 a30961        	cpw	x,#2401
3299  01c7 2f1a          	jrslt	L1412
3300                     ; 167         if(rcState == 3 || rcState == 4)
3302  01c9 be04          	ldw	x,L3671_rcState
3303  01cb a30003        	cpw	x,#3
3304  01ce 2707          	jreq	L5412
3306  01d0 be04          	ldw	x,L3671_rcState
3307  01d2 a30004        	cpw	x,#4
3308  01d5 2604          	jrne	L3412
3309  01d7               L5412:
3310                     ; 169             rcEnd = 1;
3312  01d7 72100000      	bset	L1771_rcEnd
3313  01db               L3412:
3314                     ; 171 		rcState = 0;
3316  01db 5f            	clrw	x
3317  01dc bf04          	ldw	L3671_rcState,x
3318                     ; 172 		rcTimer = 0;
3320  01de 5f            	clrw	x
3321  01df bf00          	ldw	L7571_rcTimer,x
3322                     ; 173 		rcTemp[2] = 0;
3324  01e1 3f02          	clr	L3771_rcTemp+2
3325  01e3               L1412:
3326                     ; 175 }
3329  01e3 80            	iret
3426                     	xdef	f_TIM2_OV_isr
3427                     	xdef	f_rc_isr
3428                     	xdef	_rcCheck
3429                     	switch	.ubsct
3430  0000               L3771_rcTemp:
3431  0000 00000000      	ds.b	4
3451                     	end
