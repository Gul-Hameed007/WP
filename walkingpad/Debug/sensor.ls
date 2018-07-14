   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2794                     ; 66 static void Delay__hx711_us(void)
2794                     ; 67 {
2796                     	switch	.text
2797  0000               L1302_Delay__hx711_us:
2801                     ; 68     nop();
2804  0000 9d            nop
2806                     ; 69     nop();
2810  0001 9d            nop
2812                     ; 70 }
2816  0002 81            	ret
2862                     ; 99 static ulong HX711_Read1(void)
2862                     ; 100 {
2863                     	switch	.text
2864  0003               L1502_HX711_Read1:
2866  0003 5205          	subw	sp,#5
2867       00000005      OFST:	set	5
2870                     ; 101     READ_HX711(1)
2872  0005 adf9          	call	L1302_Delay__hx711_us
2876  0007 721d500a      	bres	_PC_ODR,#6
2879  000b ae0000        	ldw	x,#0
2880  000e 1f04          	ldw	(OFST-1,sp),x
2881  0010 ae0000        	ldw	x,#0
2882  0013 1f02          	ldw	(OFST-3,sp),x
2885  0015 c6500b        	ld	a,_PC_IDR
2886  0018 a520          	bcp	a,#32
2887  001a 270c          	jreq	L5702
2890  001c aeffff        	ldw	x,#65535
2891  001f bf02          	ldw	c_lreg+2,x
2892  0021 aeffff        	ldw	x,#-1
2893  0024 bf00          	ldw	c_lreg,x
2895  0026 2043          	jra	L01
2896  0028               L5702:
2898  0028 0f01          	clr	(OFST-4,sp)
2899  002a               L7702:
2902  002a 721c500a      	bset	_PC_ODR,#6
2905  002e 0805          	sll	(OFST+0,sp)
2906  0030 0904          	rlc	(OFST-1,sp)
2907  0032 0903          	rlc	(OFST-2,sp)
2908  0034 0902          	rlc	(OFST-3,sp)
2911  0036 adc8          	call	L1302_Delay__hx711_us
2915  0038 721d500a      	bres	_PC_ODR,#6
2918  003c c6500b        	ld	a,_PC_IDR
2919  003f a520          	bcp	a,#32
2920  0041 2709          	jreq	L5012
2923  0043 96            	ldw	x,sp
2924  0044 1c0002        	addw	x,#OFST-3
2925  0047 a601          	ld	a,#1
2926  0049 cd0000        	call	c_lgadc
2928  004c               L5012:
2931  004c 0c01          	inc	(OFST-4,sp)
2934  004e 7b01          	ld	a,(OFST-4,sp)
2935  0050 a118          	cp	a,#24
2936  0052 25d6          	jrult	L7702
2939  0054 721c500a      	bset	_PC_ODR,#6
2942  0058 7b03          	ld	a,(OFST-2,sp)
2943  005a a880          	xor	a,#128
2944  005c 6b03          	ld	(OFST-2,sp),a
2947  005e ada0          	call	L1302_Delay__hx711_us
2951  0060 721d500a      	bres	_PC_ODR,#6
2954  0064 96            	ldw	x,sp
2955  0065 1c0002        	addw	x,#OFST-3
2956  0068 cd0000        	call	c_ltor
2959  006b               L01:
2961  006b 5b05          	addw	sp,#5
2962  006d 81            	ret
3008                     ; 104 static ulong HX711_Read2(void)
3008                     ; 105 {
3009                     	switch	.text
3010  006e               L7012_HX711_Read2:
3012  006e 5205          	subw	sp,#5
3013       00000005      OFST:	set	5
3016                     ; 106     READ_HX711(2)
3018  0070 ad8e          	call	L1302_Delay__hx711_us
3022  0072 7211500f      	bres	_PD_ODR,#0
3025  0076 ae0000        	ldw	x,#0
3026  0079 1f04          	ldw	(OFST-1,sp),x
3027  007b ae0000        	ldw	x,#0
3028  007e 1f02          	ldw	(OFST-3,sp),x
3031  0080 c6500b        	ld	a,_PC_IDR
3032  0083 a580          	bcp	a,#128
3033  0085 270c          	jreq	L3312
3036  0087 aeffff        	ldw	x,#65535
3037  008a bf02          	ldw	c_lreg+2,x
3038  008c aeffff        	ldw	x,#-1
3039  008f bf00          	ldw	c_lreg,x
3041  0091 2045          	jra	L41
3042  0093               L3312:
3044  0093 0f01          	clr	(OFST-4,sp)
3045  0095               L5312:
3048  0095 7210500f      	bset	_PD_ODR,#0
3051  0099 0805          	sll	(OFST+0,sp)
3052  009b 0904          	rlc	(OFST-1,sp)
3053  009d 0903          	rlc	(OFST-2,sp)
3054  009f 0902          	rlc	(OFST-3,sp)
3057  00a1 cd0000        	call	L1302_Delay__hx711_us
3061  00a4 7211500f      	bres	_PD_ODR,#0
3064  00a8 c6500b        	ld	a,_PC_IDR
3065  00ab a580          	bcp	a,#128
3066  00ad 2709          	jreq	L3412
3069  00af 96            	ldw	x,sp
3070  00b0 1c0002        	addw	x,#OFST-3
3071  00b3 a601          	ld	a,#1
3072  00b5 cd0000        	call	c_lgadc
3074  00b8               L3412:
3077  00b8 0c01          	inc	(OFST-4,sp)
3080  00ba 7b01          	ld	a,(OFST-4,sp)
3081  00bc a118          	cp	a,#24
3082  00be 25d5          	jrult	L5312
3085  00c0 7210500f      	bset	_PD_ODR,#0
3088  00c4 7b03          	ld	a,(OFST-2,sp)
3089  00c6 a880          	xor	a,#128
3090  00c8 6b03          	ld	(OFST-2,sp),a
3093  00ca cd0000        	call	L1302_Delay__hx711_us
3097  00cd 7211500f      	bres	_PD_ODR,#0
3100  00d1 96            	ldw	x,sp
3101  00d2 1c0002        	addw	x,#OFST-3
3102  00d5 cd0000        	call	c_ltor
3105  00d8               L41:
3107  00d8 5b05          	addw	sp,#5
3108  00da 81            	ret
3181                     ; 110 static ulong get_median(ulong data_array[])
3181                     ; 111 {
3182                     	switch	.text
3183  00db               L5412_get_median:
3185  00db 89            	pushw	x
3186  00dc 521b          	subw	sp,#27
3187       0000001b      OFST:	set	27
3190                     ; 115     memcpy(data, data_array, sizeof(data));
3192  00de 96            	ldw	x,sp
3193  00df 1c0008        	addw	x,#OFST-19
3194  00e2 bf00          	ldw	c_x,x
3195  00e4 161c          	ldw	y,(OFST+1,sp)
3196  00e6 90bf00        	ldw	c_y,y
3197  00e9 ae0014        	ldw	x,#20
3198  00ec               L02:
3199  00ec 5a            	decw	x
3200  00ed 92d600        	ld	a,([c_y.w],x)
3201  00f0 92d700        	ld	([c_x.w],x),a
3202  00f3 5d            	tnzw	x
3203  00f4 26f6          	jrne	L02
3204                     ; 117     for (k = 0; k < QSIZE / 2 + 1; k++)
3206  00f6 0f07          	clr	(OFST-20,sp)
3207  00f8               L5022:
3208                     ; 119         for (i = k + 1, m = k; i < QSIZE; i++)
3210  00f8 7b07          	ld	a,(OFST-20,sp)
3211  00fa 4c            	inc	a
3212  00fb 6b05          	ld	(OFST-22,sp),a
3213  00fd 7b07          	ld	a,(OFST-20,sp)
3214  00ff 6b06          	ld	(OFST-21,sp),a
3216  0101 202c          	jra	L7122
3217  0103               L3122:
3218                     ; 121             if (data[m] > data[i])
3220  0103 96            	ldw	x,sp
3221  0104 1c0008        	addw	x,#OFST-19
3222  0107 1f03          	ldw	(OFST-24,sp),x
3223  0109 7b06          	ld	a,(OFST-21,sp)
3224  010b 97            	ld	xl,a
3225  010c a604          	ld	a,#4
3226  010e 42            	mul	x,a
3227  010f 72fb03        	addw	x,(OFST-24,sp)
3228  0112 cd0000        	call	c_ltor
3230  0115 96            	ldw	x,sp
3231  0116 1c0008        	addw	x,#OFST-19
3232  0119 1f01          	ldw	(OFST-26,sp),x
3233  011b 7b05          	ld	a,(OFST-22,sp)
3234  011d 97            	ld	xl,a
3235  011e a604          	ld	a,#4
3236  0120 42            	mul	x,a
3237  0121 72fb01        	addw	x,(OFST-26,sp)
3238  0124 cd0000        	call	c_lcmp
3240  0127 2304          	jrule	L3222
3241                     ; 122                 m = i;
3243  0129 7b05          	ld	a,(OFST-22,sp)
3244  012b 6b06          	ld	(OFST-21,sp),a
3245  012d               L3222:
3246                     ; 119         for (i = k + 1, m = k; i < QSIZE; i++)
3248  012d 0c05          	inc	(OFST-22,sp)
3249  012f               L7122:
3252  012f 7b05          	ld	a,(OFST-22,sp)
3253  0131 a105          	cp	a,#5
3254  0133 25ce          	jrult	L3122
3255                     ; 124         if (m != k)
3257  0135 7b06          	ld	a,(OFST-21,sp)
3258  0137 1107          	cp	a,(OFST-20,sp)
3259  0139 2603          	jrne	L22
3260  013b cc01ec        	jp	L5222
3261  013e               L22:
3262                     ; 126             data[m] ^= data[k];
3264  013e 96            	ldw	x,sp
3265  013f 1c0008        	addw	x,#OFST-19
3266  0142 1f03          	ldw	(OFST-24,sp),x
3267  0144 7b06          	ld	a,(OFST-21,sp)
3268  0146 97            	ld	xl,a
3269  0147 a604          	ld	a,#4
3270  0149 42            	mul	x,a
3271  014a 72fb03        	addw	x,(OFST-24,sp)
3272  014d 9096          	ldw	y,sp
3273  014f 72a90008      	addw	y,#OFST-19
3274  0153 1701          	ldw	(OFST-26,sp),y
3275  0155 7b07          	ld	a,(OFST-20,sp)
3276  0157 905f          	clrw	y
3277  0159 9097          	ld	yl,a
3278  015b 9058          	sllw	y
3279  015d 9058          	sllw	y
3280  015f 72f901        	addw	y,(OFST-26,sp)
3281  0162 90e603        	ld	a,(3,y)
3282  0165 b703          	ld	c_lreg+3,a
3283  0167 90e602        	ld	a,(2,y)
3284  016a b702          	ld	c_lreg+2,a
3285  016c 90e601        	ld	a,(1,y)
3286  016f b701          	ld	c_lreg+1,a
3287  0171 90f6          	ld	a,(y)
3288  0173 b700          	ld	c_lreg,a
3289  0175 cd0000        	call	c_lgxor
3291                     ; 127             data[k] ^= data[m];
3293  0178 96            	ldw	x,sp
3294  0179 1c0008        	addw	x,#OFST-19
3295  017c 1f03          	ldw	(OFST-24,sp),x
3296  017e 7b07          	ld	a,(OFST-20,sp)
3297  0180 97            	ld	xl,a
3298  0181 a604          	ld	a,#4
3299  0183 42            	mul	x,a
3300  0184 72fb03        	addw	x,(OFST-24,sp)
3301  0187 9096          	ldw	y,sp
3302  0189 72a90008      	addw	y,#OFST-19
3303  018d 1701          	ldw	(OFST-26,sp),y
3304  018f 7b06          	ld	a,(OFST-21,sp)
3305  0191 905f          	clrw	y
3306  0193 9097          	ld	yl,a
3307  0195 9058          	sllw	y
3308  0197 9058          	sllw	y
3309  0199 72f901        	addw	y,(OFST-26,sp)
3310  019c 90e603        	ld	a,(3,y)
3311  019f b703          	ld	c_lreg+3,a
3312  01a1 90e602        	ld	a,(2,y)
3313  01a4 b702          	ld	c_lreg+2,a
3314  01a6 90e601        	ld	a,(1,y)
3315  01a9 b701          	ld	c_lreg+1,a
3316  01ab 90f6          	ld	a,(y)
3317  01ad b700          	ld	c_lreg,a
3318  01af cd0000        	call	c_lgxor
3320                     ; 128             data[m] ^= data[k];
3322  01b2 96            	ldw	x,sp
3323  01b3 1c0008        	addw	x,#OFST-19
3324  01b6 1f03          	ldw	(OFST-24,sp),x
3325  01b8 7b06          	ld	a,(OFST-21,sp)
3326  01ba 97            	ld	xl,a
3327  01bb a604          	ld	a,#4
3328  01bd 42            	mul	x,a
3329  01be 72fb03        	addw	x,(OFST-24,sp)
3330  01c1 9096          	ldw	y,sp
3331  01c3 72a90008      	addw	y,#OFST-19
3332  01c7 1701          	ldw	(OFST-26,sp),y
3333  01c9 7b07          	ld	a,(OFST-20,sp)
3334  01cb 905f          	clrw	y
3335  01cd 9097          	ld	yl,a
3336  01cf 9058          	sllw	y
3337  01d1 9058          	sllw	y
3338  01d3 72f901        	addw	y,(OFST-26,sp)
3339  01d6 90e603        	ld	a,(3,y)
3340  01d9 b703          	ld	c_lreg+3,a
3341  01db 90e602        	ld	a,(2,y)
3342  01de b702          	ld	c_lreg+2,a
3343  01e0 90e601        	ld	a,(1,y)
3344  01e3 b701          	ld	c_lreg+1,a
3345  01e5 90f6          	ld	a,(y)
3346  01e7 b700          	ld	c_lreg,a
3347  01e9 cd0000        	call	c_lgxor
3349  01ec               L5222:
3350                     ; 117     for (k = 0; k < QSIZE / 2 + 1; k++)
3352  01ec 0c07          	inc	(OFST-20,sp)
3355  01ee 7b07          	ld	a,(OFST-20,sp)
3356  01f0 a103          	cp	a,#3
3357  01f2 2403          	jruge	L42
3358  01f4 cc00f8        	jp	L5022
3359  01f7               L42:
3360                     ; 131     return data[k - 1];
3362  01f7 96            	ldw	x,sp
3363  01f8 1c0008        	addw	x,#OFST-19
3364  01fb 1f03          	ldw	(OFST-24,sp),x
3365  01fd 7b07          	ld	a,(OFST-20,sp)
3366  01ff 97            	ld	xl,a
3367  0200 a604          	ld	a,#4
3368  0202 42            	mul	x,a
3369  0203 1d0004        	subw	x,#4
3370  0206 72fb03        	addw	x,(OFST-24,sp)
3371  0209 cd0000        	call	c_ltor
3375  020c 5b1d          	addw	sp,#29
3376  020e 81            	ret
3443                     .const:	section	.text
3444  0000               L03:
3445  0000 ffffffff      	dc.l	-1
3446  0004               L23:
3447  0004 00000064      	dc.l	100
3448                     ; 159 void HX711_Weight(void)
3448                     ; 160 {
3449                     	switch	.text
3450  020f               _HX711_Weight:
3452  020f 520c          	subw	sp,#12
3453       0000000c      OFST:	set	12
3456                     ; 161     ulong hx711_wt1 = HX711_Read1();
3458  0211 cd0003        	call	L1502_HX711_Read1
3460  0214 96            	ldw	x,sp
3461  0215 1c0005        	addw	x,#OFST-7
3462  0218 cd0000        	call	c_rtol
3464                     ; 162     ulong hx711_wt2 = HX711_Read2();
3466  021b cd006e        	call	L7012_HX711_Read2
3468  021e 96            	ldw	x,sp
3469  021f 1c0009        	addw	x,#OFST-3
3470  0222 cd0000        	call	c_rtol
3472                     ; 163     if (hx711_wt1 == U32_MAX || hx711_wt2 == U32_MAX)
3474  0225 96            	ldw	x,sp
3475  0226 1c0005        	addw	x,#OFST-7
3476  0229 cd0000        	call	c_ltor
3478  022c ae0000        	ldw	x,#L03
3479  022f cd0000        	call	c_lcmp
3481  0232 270f          	jreq	L3522
3483  0234 96            	ldw	x,sp
3484  0235 1c0009        	addw	x,#OFST-3
3485  0238 cd0000        	call	c_ltor
3487  023b ae0000        	ldw	x,#L03
3488  023e cd0000        	call	c_lcmp
3490  0241 2604          	jrne	L1522
3491  0243               L3522:
3492                     ; 166         return;
3494  0243 ace503e5      	jpf	L43
3495  0247               L1522:
3496                     ; 168     hx711_wt1 /= 100;
3498  0247 96            	ldw	x,sp
3499  0248 1c0005        	addw	x,#OFST-7
3500  024b cd0000        	call	c_ltor
3502  024e ae0004        	ldw	x,#L23
3503  0251 cd0000        	call	c_ludv
3505  0254 96            	ldw	x,sp
3506  0255 1c0005        	addw	x,#OFST-7
3507  0258 cd0000        	call	c_rtol
3509                     ; 169     hx711_wt2 /= 100;
3511  025b 96            	ldw	x,sp
3512  025c 1c0009        	addw	x,#OFST-3
3513  025f cd0000        	call	c_ltor
3515  0262 ae0004        	ldw	x,#L23
3516  0265 cd0000        	call	c_ludv
3518  0268 96            	ldw	x,sp
3519  0269 1c0009        	addw	x,#OFST-3
3520  026c cd0000        	call	c_rtol
3522                     ; 171     array[array_idx] = hx711_wt1;
3524  026f c60015        	ld	a,L1002_array_idx
3525  0272 97            	ld	xl,a
3526  0273 a604          	ld	a,#4
3527  0275 42            	mul	x,a
3528  0276 7b08          	ld	a,(OFST-4,sp)
3529  0278 d70048        	ld	(L7571_array+3,x),a
3530  027b 7b07          	ld	a,(OFST-5,sp)
3531  027d d70047        	ld	(L7571_array+2,x),a
3532  0280 7b06          	ld	a,(OFST-6,sp)
3533  0282 d70046        	ld	(L7571_array+1,x),a
3534  0285 7b05          	ld	a,(OFST-7,sp)
3535  0287 d70045        	ld	(L7571_array,x),a
3536                     ; 172     array2[array_idx] = hx711_wt2;
3538  028a c60015        	ld	a,L1002_array_idx
3539  028d 97            	ld	xl,a
3540  028e a604          	ld	a,#4
3541  0290 42            	mul	x,a
3542  0291 7b0c          	ld	a,(OFST+0,sp)
3543  0293 d70034        	ld	(L1671_array2+3,x),a
3544  0296 7b0b          	ld	a,(OFST-1,sp)
3545  0298 d70033        	ld	(L1671_array2+2,x),a
3546  029b 7b0a          	ld	a,(OFST-2,sp)
3547  029d d70032        	ld	(L1671_array2+1,x),a
3548  02a0 7b09          	ld	a,(OFST-3,sp)
3549  02a2 d70031        	ld	(L1671_array2,x),a
3550                     ; 173     array_idx = (array_idx + 1) % QSIZE;
3552  02a5 c60015        	ld	a,L1002_array_idx
3553  02a8 5f            	clrw	x
3554  02a9 97            	ld	xl,a
3555  02aa 5c            	incw	x
3556  02ab a605          	ld	a,#5
3557  02ad cd0000        	call	c_smodx
3559  02b0 9f            	ld	a,xl
3560  02b1 c70015        	ld	L1002_array_idx,a
3561                     ; 174     filter_cnt++;
3563  02b4 725c0030      	inc	L3671_filter_cnt
3564                     ; 175     if (filter_cnt >= QSIZE)
3566  02b8 c60030        	ld	a,L3671_filter_cnt
3567  02bb a105          	cp	a,#5
3568  02bd 2403          	jruge	L63
3569  02bf cc03c3        	jp	L5522
3570  02c2               L63:
3571                     ; 177         filter_cnt = QSIZE;
3573  02c2 35050030      	mov	L3671_filter_cnt,#5
3574                     ; 179         tension_old = tension;
3576  02c6 ce0068        	ldw	x,_tension+2
3577  02c9 cf001c        	ldw	L5771_tension_old+2,x
3578  02cc ce0066        	ldw	x,_tension
3579  02cf cf001a        	ldw	L5771_tension_old,x
3580                     ; 180         tension2_old = tension2;
3582  02d2 ce0064        	ldw	x,_tension2+2
3583  02d5 cf0018        	ldw	L7771_tension2_old+2,x
3584  02d8 ce0062        	ldw	x,_tension2
3585  02db cf0016        	ldw	L7771_tension2_old,x
3586                     ; 184         tension = get_median(array);
3588  02de ae0045        	ldw	x,#L7571_array
3589  02e1 cd00db        	call	L5412_get_median
3591  02e4 ae0066        	ldw	x,#_tension
3592  02e7 cd0000        	call	c_rtol
3594                     ; 185         tension2 = get_median(array2);
3596  02ea ae0031        	ldw	x,#L1671_array2
3597  02ed cd00db        	call	L5412_get_median
3599  02f0 ae0062        	ldw	x,#_tension2
3600  02f3 cd0000        	call	c_rtol
3602                     ; 192         if (waiting_cnt > 0)
3604  02f6 3d00          	tnz	_waiting_cnt
3605  02f8 2720          	jreq	L7522
3606                     ; 194             tension_ini += tension;
3608  02fa ae0066        	ldw	x,#_tension
3609  02fd cd0000        	call	c_ltor
3611  0300 ae0022        	ldw	x,#L1771_tension_ini
3612  0303 cd0000        	call	c_lgadd
3614                     ; 195             tension2_ini += tension2;
3616  0306 ae0062        	ldw	x,#_tension2
3617  0309 cd0000        	call	c_ltor
3619  030c ae001e        	ldw	x,#L3771_tension2_ini
3620  030f cd0000        	call	c_lgadd
3622                     ; 196             filter_cnt2++;
3624  0312 725c002f      	inc	L5671_filter_cnt2
3626  0316 acac03ac      	jpf	L1622
3627  031a               L7522:
3628                     ; 198         else if (waiting_cnt == 0 && all_display_on_cnt_old > 0)
3630  031a 3d00          	tnz	_waiting_cnt
3631  031c 266a          	jrne	L3622
3633  031e 725d002e      	tnz	L7671_all_display_on_cnt_old
3634  0322 2764          	jreq	L3622
3635                     ; 200             tension_ini /= filter_cnt2;
3637  0324 c6002f        	ld	a,L5671_filter_cnt2
3638  0327 b703          	ld	c_lreg+3,a
3639  0329 3f02          	clr	c_lreg+2
3640  032b 3f01          	clr	c_lreg+1
3641  032d 3f00          	clr	c_lreg
3642  032f 96            	ldw	x,sp
3643  0330 1c0001        	addw	x,#OFST-11
3644  0333 cd0000        	call	c_rtol
3646  0336 ae0022        	ldw	x,#L1771_tension_ini
3647  0339 cd0000        	call	c_ltor
3649  033c 96            	ldw	x,sp
3650  033d 1c0001        	addw	x,#OFST-11
3651  0340 cd0000        	call	c_ludv
3653  0343 ae0022        	ldw	x,#L1771_tension_ini
3654  0346 cd0000        	call	c_rtol
3656                     ; 201             tension2_ini /= filter_cnt2;
3658  0349 c6002f        	ld	a,L5671_filter_cnt2
3659  034c b703          	ld	c_lreg+3,a
3660  034e 3f02          	clr	c_lreg+2
3661  0350 3f01          	clr	c_lreg+1
3662  0352 3f00          	clr	c_lreg
3663  0354 96            	ldw	x,sp
3664  0355 1c0001        	addw	x,#OFST-11
3665  0358 cd0000        	call	c_rtol
3667  035b ae001e        	ldw	x,#L3771_tension2_ini
3668  035e cd0000        	call	c_ltor
3670  0361 96            	ldw	x,sp
3671  0362 1c0001        	addw	x,#OFST-11
3672  0365 cd0000        	call	c_ludv
3674  0368 ae001e        	ldw	x,#L3771_tension2_ini
3675  036b cd0000        	call	c_rtol
3677                     ; 203             tension_orig = tension_ini;
3679  036e ce0024        	ldw	x,L1771_tension_ini+2
3680  0371 cf002c        	ldw	_tension_orig+2,x
3681  0374 ce0022        	ldw	x,L1771_tension_ini
3682  0377 cf002a        	ldw	_tension_orig,x
3683                     ; 204             tension2_orig = tension2_ini;
3685  037a ce0020        	ldw	x,L3771_tension2_ini+2
3686  037d cf0028        	ldw	_tension2_orig+2,x
3687  0380 ce001e        	ldw	x,L3771_tension2_ini
3688  0383 cf0026        	ldw	_tension2_orig,x
3690  0386 2024          	jra	L1622
3691  0388               L3622:
3692                     ; 208             tension_bias = tension - tension_ini;
3694  0388 ae0066        	ldw	x,#_tension
3695  038b cd0000        	call	c_ltor
3697  038e ae0022        	ldw	x,#L1771_tension_ini
3698  0391 cd0000        	call	c_lsub
3700  0394 ae005e        	ldw	x,#_tension_bias
3701  0397 cd0000        	call	c_rtol
3703                     ; 209             tension2_bias = tension2 - tension2_ini;
3705  039a ae0062        	ldw	x,#_tension2
3706  039d cd0000        	call	c_ltor
3708  03a0 ae001e        	ldw	x,#L3771_tension2_ini
3709  03a3 cd0000        	call	c_lsub
3711  03a6 ae005a        	ldw	x,#_tension2_bias
3712  03a9 cd0000        	call	c_rtol
3714  03ac               L1622:
3715                     ; 212         all_display_on_cnt_old = waiting_cnt;
3717  03ac 550000002e    	mov	L7671_all_display_on_cnt_old,_waiting_cnt
3718                     ; 214         if (waiting == 0 && userstate != USER_STATE_SLEEP) 
3720                     	btst	_waiting
3721  03b6 2523          	jrult	L1722
3723  03b8 c60000        	ld	a,_userstate
3724  03bb a104          	cp	a,#4
3725  03bd 271c          	jreq	L1722
3726                     ; 216             calc_disconnect();
3728  03bf ad27          	call	_calc_disconnect
3730  03c1 2018          	jra	L1722
3731  03c3               L5522:
3732                     ; 221         tension = 0;
3734  03c3 ae0000        	ldw	x,#0
3735  03c6 cf0068        	ldw	_tension+2,x
3736  03c9 ae0000        	ldw	x,#0
3737  03cc cf0066        	ldw	_tension,x
3738                     ; 222         tension2 = 0;
3740  03cf ae0000        	ldw	x,#0
3741  03d2 cf0064        	ldw	_tension2+2,x
3742  03d5 ae0000        	ldw	x,#0
3743  03d8 cf0062        	ldw	_tension2,x
3744  03db               L1722:
3745                     ; 225     if (waiting == 0)
3747                     	btst	_waiting
3748  03e0 2503          	jrult	L3722
3749                     ; 227         adjust_drift();
3751  03e2 cd0612        	call	L5202_adjust_drift
3753  03e5               L3722:
3754                     ; 229 }
3755  03e5               L43:
3758  03e5 5b0c          	addw	sp,#12
3759  03e7 81            	ret
3791                     	switch	.const
3792  0008               L24:
3793  0008 0001462c      	dc.l	83500
3794  000c               L44:
3795  000c 00014820      	dc.l	84000
3796  0010               L25:
3797  0010 00000003      	dc.l	3
3798  0014               L45:
3799  0014 fffffffe      	dc.l	-2
3800                     ; 231 void calc_disconnect(void) 
3800                     ; 232 {
3801                     	switch	.text
3802  03e8               _calc_disconnect:
3806                     ; 233     if (tension >= TENSION_LOW && tension < TENSION_HIGH &&
3806                     ; 234         (ABSUB(tension, tension_old)) < DISCONNECT_THRESHOLD &&
3806                     ; 235         tension_bias >= -2 && tension_bias <= 2
3806                     ; 236         || tension == 0) 
3808  03e8 ae0066        	ldw	x,#_tension
3809  03eb cd0000        	call	c_ltor
3811  03ee ae0008        	ldw	x,#L24
3812  03f1 cd0000        	call	c_lcmp
3814  03f4 255c          	jrult	L1132
3816  03f6 ae0066        	ldw	x,#_tension
3817  03f9 cd0000        	call	c_ltor
3819  03fc ae000c        	ldw	x,#L44
3820  03ff cd0000        	call	c_lcmp
3822  0402 244e          	jruge	L1132
3824  0404 ae0066        	ldw	x,#_tension
3825  0407 cd0000        	call	c_ltor
3827  040a ae001a        	ldw	x,#L5771_tension_old
3828  040d cd0000        	call	c_lcmp
3830  0410 230e          	jrule	L64
3831  0412 ae0066        	ldw	x,#_tension
3832  0415 cd0000        	call	c_ltor
3834  0418 ae001a        	ldw	x,#L5771_tension_old
3835  041b cd0000        	call	c_lsub
3837  041e 200c          	jra	L05
3838  0420               L64:
3839  0420 ae001a        	ldw	x,#L5771_tension_old
3840  0423 cd0000        	call	c_ltor
3842  0426 ae0066        	ldw	x,#_tension
3843  0429 cd0000        	call	c_lsub
3845  042c               L05:
3846  042c ae0010        	ldw	x,#L25
3847  042f cd0000        	call	c_lcmp
3849  0432 241e          	jruge	L1132
3851  0434 9c            	rvf
3852  0435 ae005e        	ldw	x,#_tension_bias
3853  0438 cd0000        	call	c_ltor
3855  043b ae0014        	ldw	x,#L45
3856  043e cd0000        	call	c_lcmp
3858  0441 2f0f          	jrslt	L1132
3860  0443 9c            	rvf
3861  0444 ae005e        	ldw	x,#_tension_bias
3862  0447 cd0000        	call	c_ltor
3864  044a ae0010        	ldw	x,#L25
3865  044d cd0000        	call	c_lcmp
3867  0450 2f08          	jrslt	L7032
3868  0452               L1132:
3870  0452 ae0066        	ldw	x,#_tension
3871  0455 cd0000        	call	c_lzmp
3873  0458 260d          	jrne	L5032
3874  045a               L7032:
3875                     ; 238         INC_UCHAR(disconnect_cnt1);
3877  045a c60013        	ld	a,L5002_disconnect_cnt1
3878  045d a1ff          	cp	a,#255
3879  045f 240a          	jruge	L3232
3882  0461 725c0013      	inc	L5002_disconnect_cnt1
3883  0465 2004          	jra	L3232
3884  0467               L5032:
3885                     ; 242         disconnect_cnt1 = 0;
3887  0467 725f0013      	clr	L5002_disconnect_cnt1
3888  046b               L3232:
3889                     ; 245     if (tension2 >= TENSION_LOW && tension2 < TENSION_HIGH &&
3889                     ; 246         (ABSUB(tension2, tension2_old)) < DISCONNECT_THRESHOLD &&
3889                     ; 247         tension2_bias >= -2 && tension2_bias <= 2
3889                     ; 248         || tension2 == 0) 
3891  046b ae0062        	ldw	x,#_tension2
3892  046e cd0000        	call	c_ltor
3894  0471 ae0008        	ldw	x,#L24
3895  0474 cd0000        	call	c_lcmp
3897  0477 255c          	jrult	L1332
3899  0479 ae0062        	ldw	x,#_tension2
3900  047c cd0000        	call	c_ltor
3902  047f ae000c        	ldw	x,#L44
3903  0482 cd0000        	call	c_lcmp
3905  0485 244e          	jruge	L1332
3907  0487 ae0062        	ldw	x,#_tension2
3908  048a cd0000        	call	c_ltor
3910  048d ae0016        	ldw	x,#L7771_tension2_old
3911  0490 cd0000        	call	c_lcmp
3913  0493 230e          	jrule	L65
3914  0495 ae0062        	ldw	x,#_tension2
3915  0498 cd0000        	call	c_ltor
3917  049b ae0016        	ldw	x,#L7771_tension2_old
3918  049e cd0000        	call	c_lsub
3920  04a1 200c          	jra	L06
3921  04a3               L65:
3922  04a3 ae0016        	ldw	x,#L7771_tension2_old
3923  04a6 cd0000        	call	c_ltor
3925  04a9 ae0062        	ldw	x,#_tension2
3926  04ac cd0000        	call	c_lsub
3928  04af               L06:
3929  04af ae0010        	ldw	x,#L25
3930  04b2 cd0000        	call	c_lcmp
3932  04b5 241e          	jruge	L1332
3934  04b7 9c            	rvf
3935  04b8 ae005a        	ldw	x,#_tension2_bias
3936  04bb cd0000        	call	c_ltor
3938  04be ae0014        	ldw	x,#L45
3939  04c1 cd0000        	call	c_lcmp
3941  04c4 2f0f          	jrslt	L1332
3943  04c6 9c            	rvf
3944  04c7 ae005a        	ldw	x,#_tension2_bias
3945  04ca cd0000        	call	c_ltor
3947  04cd ae0010        	ldw	x,#L25
3948  04d0 cd0000        	call	c_lcmp
3950  04d3 2f08          	jrslt	L7232
3951  04d5               L1332:
3953  04d5 ae0062        	ldw	x,#_tension2
3954  04d8 cd0000        	call	c_lzmp
3956  04db 260d          	jrne	L5232
3957  04dd               L7232:
3958                     ; 250         INC_UCHAR(disconnect_cnt2);
3960  04dd c60012        	ld	a,L7002_disconnect_cnt2
3961  04e0 a1ff          	cp	a,#255
3962  04e2 240a          	jruge	L3432
3965  04e4 725c0012      	inc	L7002_disconnect_cnt2
3966  04e8 2004          	jra	L3432
3967  04ea               L5232:
3968                     ; 254         disconnect_cnt2 = 0;
3970  04ea 725f0012      	clr	L7002_disconnect_cnt2
3971  04ee               L3432:
3972                     ; 257     flag_Gsensor_disconnected = 0;
3974  04ee 725f006a      	clr	_flag_Gsensor_disconnected
3975                     ; 258     if (disconnect_cnt1 > TIME_5_SECONDS) 
3977  04f2 c60013        	ld	a,L5002_disconnect_cnt1
3978  04f5 a1fb          	cp	a,#251
3979  04f7 2504          	jrult	L5432
3980                     ; 260         flag_Gsensor_disconnected += 1;
3982  04f9 725c006a      	inc	_flag_Gsensor_disconnected
3983  04fd               L5432:
3984                     ; 262     if (disconnect_cnt2 > TIME_5_SECONDS) 
3986  04fd c60012        	ld	a,L7002_disconnect_cnt2
3987  0500 a1fb          	cp	a,#251
3988  0502 2508          	jrult	L7432
3989                     ; 264         flag_Gsensor_disconnected += 2;
3991  0504 725c006a      	inc	_flag_Gsensor_disconnected
3992  0508 725c006a      	inc	_flag_Gsensor_disconnected
3993  050c               L7432:
3994                     ; 266 }
3997  050c 81            	ret
4047                     	switch	.const
4048  0018               L47:
4049  0018 00000032      	dc.l	50
4050                     ; 268 void do_drift(void)
4050                     ; 269 {
4051                     	switch	.text
4052  050d               L7202_do_drift:
4054  050d 88            	push	a
4055       00000001      OFST:	set	1
4058                     ; 272     drift_abs = ABSUB(tension, tension_old);
4060  050e ae0066        	ldw	x,#_tension
4061  0511 cd0000        	call	c_ltor
4063  0514 ae001a        	ldw	x,#L5771_tension_old
4064  0517 cd0000        	call	c_lcmp
4066  051a 230e          	jrule	L46
4067  051c ae0066        	ldw	x,#_tension
4068  051f cd0000        	call	c_ltor
4070  0522 ae001a        	ldw	x,#L5771_tension_old
4071  0525 cd0000        	call	c_lsub
4073  0528 200c          	jra	L66
4074  052a               L46:
4075  052a ae001a        	ldw	x,#L5771_tension_old
4076  052d cd0000        	call	c_ltor
4078  0530 ae0066        	ldw	x,#_tension
4079  0533 cd0000        	call	c_lsub
4081  0536               L66:
4082  0536 ae0006        	ldw	x,#L5102_drift_abs
4083  0539 cd0000        	call	c_rtol
4085                     ; 273     drift2_abs = ABSUB(tension2, tension2_old);
4087  053c ae0062        	ldw	x,#_tension2
4088  053f cd0000        	call	c_ltor
4090  0542 ae0016        	ldw	x,#L7771_tension2_old
4091  0545 cd0000        	call	c_lcmp
4093  0548 230e          	jrule	L07
4094  054a ae0062        	ldw	x,#_tension2
4095  054d cd0000        	call	c_ltor
4097  0550 ae0016        	ldw	x,#L7771_tension2_old
4098  0553 cd0000        	call	c_lsub
4100  0556 200c          	jra	L27
4101  0558               L07:
4102  0558 ae0016        	ldw	x,#L7771_tension2_old
4103  055b cd0000        	call	c_ltor
4105  055e ae0062        	ldw	x,#_tension2
4106  0561 cd0000        	call	c_lsub
4108  0564               L27:
4109  0564 ae0002        	ldw	x,#L7102_drift2_abs
4110  0567 cd0000        	call	c_rtol
4112                     ; 275     if (drift_abs < DRIFT_THRESHOLD_LOW && drift2_abs < DRIFT_THRESHOLD_LOW && userstate != USER_STATE_TICK)
4114  056a ae0006        	ldw	x,#L5102_drift_abs
4115  056d cd0000        	call	c_ltor
4117  0570 ae0018        	ldw	x,#L47
4118  0573 cd0000        	call	c_lcmp
4120  0576 2433          	jruge	L7632
4122  0578 ae0002        	ldw	x,#L7102_drift2_abs
4123  057b cd0000        	call	c_ltor
4125  057e ae0018        	ldw	x,#L47
4126  0581 cd0000        	call	c_lcmp
4128  0584 2425          	jruge	L7632
4130  0586 c60000        	ld	a,_userstate
4131  0589 a106          	cp	a,#6
4132  058b 271e          	jreq	L7632
4133                     ; 277         drift_cnt++;
4135  058d 725c0014      	inc	L3002_drift_cnt
4136                     ; 278         drift += drift_abs;
4138  0591 ae0006        	ldw	x,#L5102_drift_abs
4139  0594 cd0000        	call	c_ltor
4141  0597 ae000e        	ldw	x,#L1102_drift
4142  059a cd0000        	call	c_lgadd
4144                     ; 279         drift2 += drift_abs;
4146  059d ae0006        	ldw	x,#L5102_drift_abs
4147  05a0 cd0000        	call	c_ltor
4149  05a3 ae000a        	ldw	x,#L3102_drift2
4150  05a6 cd0000        	call	c_lgadd
4153  05a9 201c          	jra	L1732
4154  05ab               L7632:
4155                     ; 283         drift_cnt = 0;
4157  05ab 725f0014      	clr	L3002_drift_cnt
4158                     ; 284         drift = 0;
4160  05af ae0000        	ldw	x,#0
4161  05b2 cf0010        	ldw	L1102_drift+2,x
4162  05b5 ae0000        	ldw	x,#0
4163  05b8 cf000e        	ldw	L1102_drift,x
4164                     ; 285         drift2 = 0;
4166  05bb ae0000        	ldw	x,#0
4167  05be cf000c        	ldw	L3102_drift2+2,x
4168  05c1 ae0000        	ldw	x,#0
4169  05c4 cf000a        	ldw	L3102_drift2,x
4170  05c7               L1732:
4171                     ; 288     drift_interval = TIME_2_SECONDS / (1 + machine_speed_target / 20);
4173  05c7 ae0064        	ldw	x,#100
4174  05ca b600          	ld	a,_machine_speed_target
4175  05cc 905f          	clrw	y
4176  05ce 9097          	ld	yl,a
4177  05d0 a614          	ld	a,#20
4178  05d2 cd0000        	call	c_sdivy
4180  05d5 905c          	incw	y
4181  05d7 cd0000        	call	c_idiv
4183  05da 01            	rrwa	x,a
4184  05db 6b01          	ld	(OFST+0,sp),a
4185  05dd 02            	rlwa	x,a
4186                     ; 290     if (drift_cnt > drift_interval && no_current_cnt > TIME_2_SECONDS)
4188  05de c60014        	ld	a,L3002_drift_cnt
4189  05e1 1101          	cp	a,(OFST+0,sp)
4190  05e3 232b          	jrule	L3732
4192  05e5 c60059        	ld	a,_no_current_cnt
4193  05e8 a165          	cp	a,#101
4194  05ea 2524          	jrult	L3732
4195                     ; 292         tension_ini = tension;
4197  05ec ce0068        	ldw	x,_tension+2
4198  05ef cf0024        	ldw	L1771_tension_ini+2,x
4199  05f2 ce0066        	ldw	x,_tension
4200  05f5 cf0022        	ldw	L1771_tension_ini,x
4201                     ; 293         tension2_ini = tension2;
4203  05f8 ce0064        	ldw	x,_tension2+2
4204  05fb cf0020        	ldw	L3771_tension2_ini+2,x
4205  05fe ce0062        	ldw	x,_tension2
4206  0601 cf001e        	ldw	L3771_tension2_ini,x
4207                     ; 294         drift_cnt = 0;
4209  0604 725f0014      	clr	L3002_drift_cnt
4210                     ; 295         sensor_press_cnt = 0;
4212  0608 725f0000      	clr	L3202_sensor_press_cnt
4213                     ; 296         sensor_release_cnt = 0;
4215  060c 725f0001      	clr	L1202_sensor_release_cnt
4216  0610               L3732:
4217                     ; 298 }
4220  0610 84            	pop	a
4221  0611 81            	ret
4224                     	xref.b	_state_sec
4225                     	xbit	_start_no_tick
4265                     	switch	.const
4266  001c               L001:
4267  001c fffff63c      	dc.l	-2500
4268  0020               L201:
4269  0020 000009c5      	dc.l	2501
4270  0024               L401:
4271  0024 00000258      	dc.l	600
4272                     ; 300 void adjust_drift(void)
4272                     ; 301 {
4273                     	switch	.text
4274  0612               L5202_adjust_drift:
4278                     ; 310     if (machine_current_motor >= 0 && machine_current_motor < 20 && user_steps_last == user_steps)
4280  0612 c60000        	ld	a,_machine_current_motor
4281  0615 a114          	cp	a,#20
4282  0617 2415          	jruge	L5042
4284  0619 ce0000        	ldw	x,_user_steps_last
4285  061c c30000        	cpw	x,_user_steps
4286  061f 260d          	jrne	L5042
4287                     ; 321         INC_UCHAR(no_current_cnt);
4289  0621 c60059        	ld	a,_no_current_cnt
4290  0624 a1ff          	cp	a,#255
4291  0626 240a          	jruge	L1142
4294  0628 725c0059      	inc	_no_current_cnt
4295  062c 2004          	jra	L1142
4296  062e               L5042:
4297                     ; 325         no_current_cnt = 0;
4299  062e 725f0059      	clr	_no_current_cnt
4300  0632               L1142:
4301                     ; 328     if (tension_bias + tension2_bias < -SENSOR__THRESHOLD) // Ư�ƺ�ͻ��
4303  0632 9c            	rvf
4304  0633 ae005e        	ldw	x,#_tension_bias
4305  0636 cd0000        	call	c_ltor
4307  0639 ae005a        	ldw	x,#_tension2_bias
4308  063c cd0000        	call	c_ladd
4310  063f ae001c        	ldw	x,#L001
4311  0642 cd0000        	call	c_lcmp
4313  0645 2e0d          	jrsge	L3142
4314                     ; 330         INC_UCHAR(sensor_release_cnt);
4316  0647 c60001        	ld	a,L1202_sensor_release_cnt
4317  064a a1ff          	cp	a,#255
4318  064c 240a          	jruge	L7142
4321  064e 725c0001      	inc	L1202_sensor_release_cnt
4322  0652 2004          	jra	L7142
4323  0654               L3142:
4324                     ; 334         sensor_release_cnt = 0;
4326  0654 725f0001      	clr	L1202_sensor_release_cnt
4327  0658               L7142:
4328                     ; 337     if (userstate == USER_STATE_READY && state_sec == 0 && flag_sensor_may_reverted == 1)
4330  0658 725d0000      	tnz	_userstate
4331  065c 266e          	jrne	L1242
4333  065e be00          	ldw	x,_state_sec
4334  0660 266a          	jrne	L1242
4336                     	btst	_flag_sensor_may_reverted
4337  0667 2463          	jruge	L1242
4338                     ; 339         if (tension_ini + tension2_ini - tension_orig - tension2_orig > SENSOR__THRESHOLD)
4340  0669 ae0022        	ldw	x,#L1771_tension_ini
4341  066c cd0000        	call	c_ltor
4343  066f ae001e        	ldw	x,#L3771_tension2_ini
4344  0672 cd0000        	call	c_ladd
4346  0675 ae002a        	ldw	x,#_tension_orig
4347  0678 cd0000        	call	c_lsub
4349  067b ae0026        	ldw	x,#_tension2_orig
4350  067e cd0000        	call	c_lsub
4352  0681 ae0020        	ldw	x,#L201
4353  0684 cd0000        	call	c_lcmp
4355  0687 250d          	jrult	L3242
4356                     ; 341             INC_UCHAR(sensor_press_cnt);
4358  0689 c60000        	ld	a,L3202_sensor_press_cnt
4359  068c a1ff          	cp	a,#255
4360  068e 240a          	jruge	L7242
4363  0690 725c0000      	inc	L3202_sensor_press_cnt
4364  0694 2004          	jra	L7242
4365  0696               L3242:
4366                     ; 345             sensor_press_cnt = 0;
4368  0696 725f0000      	clr	L3202_sensor_press_cnt
4369  069a               L7242:
4370                     ; 348         if (sensor_press_cnt > 10)
4372  069a c60000        	ld	a,L3202_sensor_press_cnt
4373  069d a10b          	cp	a,#11
4374  069f 2403          	jruge	L601
4375  06a1 cc076f        	jp	L3342
4376  06a4               L601:
4377                     ; 350             tension_ini = tension_orig;
4379  06a4 ce002c        	ldw	x,_tension_orig+2
4380  06a7 cf0024        	ldw	L1771_tension_ini+2,x
4381  06aa ce002a        	ldw	x,_tension_orig
4382  06ad cf0022        	ldw	L1771_tension_ini,x
4383                     ; 351             tension2_ini = tension2_orig;
4385  06b0 ce0028        	ldw	x,_tension2_orig+2
4386  06b3 cf0020        	ldw	L3771_tension2_ini+2,x
4387  06b6 ce0026        	ldw	x,_tension2_orig
4388  06b9 cf001e        	ldw	L3771_tension2_ini,x
4389                     ; 352             flag_sensor_may_reverted = 0;
4391  06bc 72110000      	bres	_flag_sensor_may_reverted
4392                     ; 353             drift_cnt = 0;
4394  06c0 725f0014      	clr	L3002_drift_cnt
4395                     ; 354             sensor_press_cnt = 0;
4397  06c4 725f0000      	clr	L3202_sensor_press_cnt
4398  06c8 ac6f076f      	jpf	L3342
4399  06cc               L1242:
4400                     ; 358     else if (userstate == USER_STATE_STOP)
4402  06cc c60000        	ld	a,_userstate
4403  06cf a103          	cp	a,#3
4404  06d1 2652          	jrne	L5342
4405                     ; 360         if (tension + tension2 - tension_orig - tension2_orig >= 600) // stuck.
4407  06d3 ae0066        	ldw	x,#_tension
4408  06d6 cd0000        	call	c_ltor
4410  06d9 ae0062        	ldw	x,#_tension2
4411  06dc cd0000        	call	c_ladd
4413  06df ae002a        	ldw	x,#_tension_orig
4414  06e2 cd0000        	call	c_lsub
4416  06e5 ae0026        	ldw	x,#_tension2_orig
4417  06e8 cd0000        	call	c_lsub
4419  06eb ae0024        	ldw	x,#L401
4420  06ee cd0000        	call	c_lcmp
4422  06f1 250d          	jrult	L7342
4423                     ; 362             INC_UCHAR(sensor_press_cnt);
4425  06f3 c60000        	ld	a,L3202_sensor_press_cnt
4426  06f6 a1ff          	cp	a,#255
4427  06f8 240a          	jruge	L3442
4430  06fa 725c0000      	inc	L3202_sensor_press_cnt
4431  06fe 2004          	jra	L3442
4432  0700               L7342:
4433                     ; 366             sensor_press_cnt = 0;
4435  0700 725f0000      	clr	L3202_sensor_press_cnt
4436  0704               L3442:
4437                     ; 369         if (sensor_press_cnt > 200 && state_sec > 60 || sensor_release_cnt > 50 || flag_may_stuck)
4439  0704 c60000        	ld	a,L3202_sensor_press_cnt
4440  0707 a1c9          	cp	a,#201
4441  0709 2507          	jrult	L1542
4443  070b be00          	ldw	x,_state_sec
4444  070d a3003d        	cpw	x,#61
4445  0710 240e          	jruge	L7442
4446  0712               L1542:
4448  0712 c60001        	ld	a,L1202_sensor_release_cnt
4449  0715 a133          	cp	a,#51
4450  0717 2407          	jruge	L7442
4452                     	btst	_flag_may_stuck
4453  071e 244f          	jruge	L3342
4454  0720               L7442:
4455                     ; 371             do_drift();
4457  0720 cd050d        	call	L7202_do_drift
4459  0723 204a          	jra	L3342
4460  0725               L5342:
4461                     ; 376         if (sensor_release_cnt < 50 && userstate == USER_STATE_READY && state_sec < 60 && start_no_tick == 1)
4463  0725 c60001        	ld	a,L1202_sensor_release_cnt
4464  0728 a132          	cp	a,#50
4465  072a 2415          	jruge	L7542
4467  072c 725d0000      	tnz	_userstate
4468  0730 260f          	jrne	L7542
4470  0732 be00          	ldw	x,_state_sec
4471  0734 a3003c        	cpw	x,#60
4472  0737 2408          	jruge	L7542
4474                     	btst	_start_no_tick
4475  073e 2401          	jruge	L7542
4476                     ; 377             return;
4479  0740 81            	ret
4480  0741               L7542:
4481                     ; 379         do_drift();
4483  0741 cd050d        	call	L7202_do_drift
4485                     ; 381         if (sensor_release_cnt > 100)
4487  0744 c60001        	ld	a,L1202_sensor_release_cnt
4488  0747 a165          	cp	a,#101
4489  0749 2524          	jrult	L3342
4490                     ; 383             tension_ini = tension;
4492  074b ce0068        	ldw	x,_tension+2
4493  074e cf0024        	ldw	L1771_tension_ini+2,x
4494  0751 ce0066        	ldw	x,_tension
4495  0754 cf0022        	ldw	L1771_tension_ini,x
4496                     ; 384             tension2_ini = tension2;
4498  0757 ce0064        	ldw	x,_tension2+2
4499  075a cf0020        	ldw	L3771_tension2_ini+2,x
4500  075d ce0062        	ldw	x,_tension2
4501  0760 cf001e        	ldw	L3771_tension2_ini,x
4502                     ; 385             drift_cnt = 0;
4504  0763 725f0014      	clr	L3002_drift_cnt
4505                     ; 386             sensor_press_cnt = 0;
4507  0767 725f0000      	clr	L3202_sensor_press_cnt
4508                     ; 387             sensor_release_cnt = 0;
4510  076b 725f0001      	clr	L1202_sensor_release_cnt
4511  076f               L3342:
4512                     ; 390 }
4515  076f 81            	ret
4788                     	xbit	_flag_may_stuck
4789                     	xref	_userstate
4790                     .bit:	section	.data,bit
4791  0000               _flag_sensor_may_reverted:
4792  0000 00            	ds.b	1
4793                     	xdef	_flag_sensor_may_reverted
4794                     	switch	.bss
4795  0000               L3202_sensor_press_cnt:
4796  0000 00            	ds.b	1
4797  0001               L1202_sensor_release_cnt:
4798  0001 00            	ds.b	1
4799  0002               L7102_drift2_abs:
4800  0002 00000000      	ds.b	4
4801  0006               L5102_drift_abs:
4802  0006 00000000      	ds.b	4
4803  000a               L3102_drift2:
4804  000a 00000000      	ds.b	4
4805  000e               L1102_drift:
4806  000e 00000000      	ds.b	4
4807  0012               L7002_disconnect_cnt2:
4808  0012 00            	ds.b	1
4809  0013               L5002_disconnect_cnt1:
4810  0013 00            	ds.b	1
4811  0014               L3002_drift_cnt:
4812  0014 00            	ds.b	1
4813  0015               L1002_array_idx:
4814  0015 00            	ds.b	1
4815  0016               L7771_tension2_old:
4816  0016 00000000      	ds.b	4
4817  001a               L5771_tension_old:
4818  001a 00000000      	ds.b	4
4819  001e               L3771_tension2_ini:
4820  001e 00000000      	ds.b	4
4821  0022               L1771_tension_ini:
4822  0022 00000000      	ds.b	4
4823  0026               _tension2_orig:
4824  0026 00000000      	ds.b	4
4825                     	xdef	_tension2_orig
4826  002a               _tension_orig:
4827  002a 00000000      	ds.b	4
4828                     	xdef	_tension_orig
4829  002e               L7671_all_display_on_cnt_old:
4830  002e 00            	ds.b	1
4831  002f               L5671_filter_cnt2:
4832  002f 00            	ds.b	1
4833  0030               L3671_filter_cnt:
4834  0030 00            	ds.b	1
4835  0031               L1671_array2:
4836  0031 000000000000  	ds.b	20
4837  0045               L7571_array:
4838  0045 000000000000  	ds.b	20
4839                     	xref	_memcpy
4840                     	xref	_user_steps_last
4841                     	xref	_user_steps
4842                     	xref	_machine_current_motor
4843                     	xref.b	_machine_speed_target
4844                     	xbit	_waiting
4845                     	xref.b	_waiting_cnt
4846                     	xdef	_calc_disconnect
4847                     	xdef	_HX711_Weight
4848  0059               _no_current_cnt:
4849  0059 00            	ds.b	1
4850                     	xdef	_no_current_cnt
4851  005a               _tension2_bias:
4852  005a 00000000      	ds.b	4
4853                     	xdef	_tension2_bias
4854  005e               _tension_bias:
4855  005e 00000000      	ds.b	4
4856                     	xdef	_tension_bias
4857  0062               _tension2:
4858  0062 00000000      	ds.b	4
4859                     	xdef	_tension2
4860  0066               _tension:
4861  0066 00000000      	ds.b	4
4862                     	xdef	_tension
4863  006a               _flag_Gsensor_disconnected:
4864  006a 00            	ds.b	1
4865                     	xdef	_flag_Gsensor_disconnected
4866                     	xref.b	c_lreg
4867                     	xref.b	c_x
4868                     	xref.b	c_y
4888                     	xref	c_ladd
4889                     	xref	c_idiv
4890                     	xref	c_sdivy
4891                     	xref	c_lzmp
4892                     	xref	c_lsub
4893                     	xref	c_lgadd
4894                     	xref	c_smodx
4895                     	xref	c_ludv
4896                     	xref	c_rtol
4897                     	xref	c_lgxor
4898                     	xref	c_lcmp
4899                     	xref	c_ltor
4900                     	xref	c_lgadc
4901                     	end
