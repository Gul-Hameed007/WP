   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2765                     	switch	.ubsct
2766  0000               L3771_error_id_last:
2767  0000 00            	ds.b	1
2847                     .const:	section	.text
2848  0000               L6:
2849  0000 00001388      	dc.l	5000
2850  0004               L01:
2851  0004 000493e0      	dc.l	300000
2852                     ; 41 void detect_error(void)
2852                     ; 42 {
2853                     	scross	off
2854                     	switch	.text
2855  0000               _detect_error:
2857  0000 520b          	subw	sp,#11
2858       0000000b      OFST:	set	11
2861                     ; 46     clock_t curr_time = clock();
2863  0002 cd0000        	call	_clock
2865  0005 96            	ldw	x,sp
2866  0006 1c0007        	addw	x,#OFST-4
2867  0009 cd0000        	call	c_rtol
2869                     ; 48     if (error_id == 10 || error_id == 11)
2871  000c b601          	ld	a,_error_id
2872  000e a10a          	cp	a,#10
2873  0010 2706          	jreq	L3302
2875  0012 b601          	ld	a,_error_id
2876  0014 a10b          	cp	a,#11
2877  0016 2667          	jrne	L1302
2878  0018               L3302:
2879                     ; 50         if (curr_time / CLOCKS_PER_SEC + server_time >= error_time + (30 - (error_id - 10) * 20) * 60ul) // 30 minutes
2881  0018 b601          	ld	a,_error_id
2882  001a 97            	ld	xl,a
2883  001b a614          	ld	a,#20
2884  001d 42            	mul	x,a
2885  001e 1f05          	ldw	(OFST-6,sp),x
2886  0020 ae00e6        	ldw	x,#230
2887  0023 72f005        	subw	x,(OFST-6,sp)
2888  0026 cd0000        	call	c_itolx
2890  0029 a63c          	ld	a,#60
2891  002b cd0000        	call	c_smul
2893  002e ae001a        	ldw	x,#_error_time
2894  0031 cd0000        	call	c_ladd
2896  0034 96            	ldw	x,sp
2897  0035 1c0001        	addw	x,#OFST-10
2898  0038 cd0000        	call	c_rtol
2900  003b 96            	ldw	x,sp
2901  003c 1c0007        	addw	x,#OFST-4
2902  003f cd0000        	call	c_ltor
2904  0042 ae0000        	ldw	x,#L6
2905  0045 cd0000        	call	c_ludv
2907  0048 ae0000        	ldw	x,#_server_time
2908  004b cd0000        	call	c_ladd
2910  004e 96            	ldw	x,sp
2911  004f 1c0001        	addw	x,#OFST-10
2912  0052 cd0000        	call	c_lcmp
2914  0055 2403          	jruge	L41
2915  0057 cc01e8        	jp	L7302
2916  005a               L41:
2917                     ; 52             eeprom_wrchar(EEPROM_ADDR_ERROR_ID, 0);
2919  005a 4b00          	push	#0
2920  005c ae4023        	ldw	x,#16419
2921  005f cd0000        	call	_eeprom_wrchar
2923  0062 84            	pop	a
2924                     ; 53             eeprom_write_long(EEPROM_ADDR_ERROR_TIME, 0);
2926  0063 ae0000        	ldw	x,#0
2927  0066 89            	pushw	x
2928  0067 ae0000        	ldw	x,#0
2929  006a 89            	pushw	x
2930  006b ae4024        	ldw	x,#16420
2931  006e cd0000        	call	_eeprom_write_long
2933  0071 5b04          	addw	sp,#4
2934                     ; 54             WWDG->CR |= 0x80;
2936  0073 721e50d1      	bset	20689,#7
2937                     ; 55             WWDG->CR &= (uchar)~0x40;
2939  0077 721d50d1      	bres	20689,#6
2940  007b ace801e8      	jpf	L7302
2941  007f               L1302:
2942                     ; 60         if (curr_time >= error_time + CLOCKS_PER_SEC * 60ul) // 1 minute
2944  007f ae001a        	ldw	x,#_error_time
2945  0082 cd0000        	call	c_ltor
2947  0085 ae0004        	ldw	x,#L01
2948  0088 cd0000        	call	c_ladd
2950  008b 96            	ldw	x,sp
2951  008c 1c0007        	addw	x,#OFST-4
2952  008f cd0000        	call	c_lcmp
2954  0092 2303          	jrule	L61
2955  0094 cc01c3        	jp	L1402
2956  0097               L61:
2957                     ; 62             error_time = curr_time;
2959  0097 1e09          	ldw	x,(OFST-2,sp)
2960  0099 cf001c        	ldw	_error_time+2,x
2961  009c 1e07          	ldw	x,(OFST-4,sp)
2962  009e cf001a        	ldw	_error_time,x
2963                     ; 63             currents[cp_index] = (uchar)(current.accu / cp_count);
2965  00a1 c6000a        	ld	a,L3671_cp_index
2966  00a4 5f            	clrw	x
2967  00a5 97            	ld	xl,a
2968  00a6 89            	pushw	x
2969  00a7 ce0008        	ldw	x,L5671_cp_count
2970  00aa cd0000        	call	c_uitolx
2972  00ad 96            	ldw	x,sp
2973  00ae 1c0005        	addw	x,#OFST-6
2974  00b1 cd0000        	call	c_rtol
2976  00b4 ae0004        	ldw	x,#L7671_current
2977  00b7 cd0000        	call	c_ltor
2979  00ba 96            	ldw	x,sp
2980  00bb 1c0005        	addw	x,#OFST-6
2981  00be cd0000        	call	c_ludv
2983  00c1 b603          	ld	a,c_lreg+3
2984  00c3 85            	popw	x
2985  00c4 d70015        	ld	(L7571_currents,x),a
2986                     ; 64             powers[cp_index] = (uint)(power.accu / cp_count);
2988  00c7 ce0008        	ldw	x,L5671_cp_count
2989  00ca cd0000        	call	c_uitolx
2991  00cd 96            	ldw	x,sp
2992  00ce 1c0003        	addw	x,#OFST-8
2993  00d1 cd0000        	call	c_rtol
2995  00d4 ae0000        	ldw	x,#L1771_power
2996  00d7 cd0000        	call	c_ltor
2998  00da 96            	ldw	x,sp
2999  00db 1c0003        	addw	x,#OFST-8
3000  00de cd0000        	call	c_ludv
3002  00e1 be02          	ldw	x,c_lreg+2
3003  00e3 c6000a        	ld	a,L3671_cp_index
3004  00e6 905f          	clrw	y
3005  00e8 9097          	ld	yl,a
3006  00ea 9058          	sllw	y
3007  00ec 90df000b      	ldw	(L1671_powers,y),x
3008                     ; 65             current.accu = 0;
3010  00f0 ae0000        	ldw	x,#0
3011  00f3 cf0006        	ldw	L7671_current+2,x
3012  00f6 ae0000        	ldw	x,#0
3013  00f9 cf0004        	ldw	L7671_current,x
3014                     ; 66             power.accu = 0;
3016  00fc ae0000        	ldw	x,#0
3017  00ff cf0002        	ldw	L1771_power+2,x
3018  0102 ae0000        	ldw	x,#0
3019  0105 cf0000        	ldw	L1771_power,x
3020                     ; 67             cp_index = (cp_index + 1) % CP_SIZE;
3022  0108 c6000a        	ld	a,L3671_cp_index
3023  010b 5f            	clrw	x
3024  010c 97            	ld	xl,a
3025  010d 5c            	incw	x
3026  010e a605          	ld	a,#5
3027  0110 cd0000        	call	c_smodx
3029  0113 9f            	ld	a,xl
3030  0114 c7000a        	ld	L3671_cp_index,a
3031                     ; 68             for (i = 0; i < CP_SIZE; i++)
3033  0117 0f0b          	clr	(OFST+0,sp)
3034  0119               L3402:
3035                     ; 70                 current.avg += currents[i];
3037  0119 7b0b          	ld	a,(OFST+0,sp)
3038  011b 5f            	clrw	x
3039  011c 97            	ld	xl,a
3040  011d d60015        	ld	a,(L7571_currents,x)
3041  0120 cb0005        	add	a,L7671_current+1
3042  0123 c70005        	ld	L7671_current+1,a
3043  0126 2404          	jrnc	L21
3044  0128 725c0004      	inc	L7671_current
3045  012c               L21:
3046                     ; 71                 power.avg += powers[i];
3048  012c 7b0b          	ld	a,(OFST+0,sp)
3049  012e 5f            	clrw	x
3050  012f 97            	ld	xl,a
3051  0130 58            	sllw	x
3052  0131 de000b        	ldw	x,(L1671_powers,x)
3053  0134 72bb0000      	addw	x,L1771_power
3054  0138 cf0000        	ldw	L1771_power,x
3055                     ; 68             for (i = 0; i < CP_SIZE; i++)
3057  013b 0c0b          	inc	(OFST+0,sp)
3060  013d 7b0b          	ld	a,(OFST+0,sp)
3061  013f a105          	cp	a,#5
3062  0141 25d6          	jrult	L3402
3063                     ; 73             current.avg /= CP_SIZE;
3065  0143 ce0004        	ldw	x,L7671_current
3066  0146 a605          	ld	a,#5
3067  0148 62            	div	x,a
3068  0149 cf0004        	ldw	L7671_current,x
3069                     ; 74             power.avg /= CP_SIZE;
3071  014c ce0000        	ldw	x,L1771_power
3072  014f a605          	ld	a,#5
3073  0151 62            	div	x,a
3074  0152 cf0000        	ldw	L1771_power,x
3075                     ; 82             if ((power.avg > 5000 || current.avg > 30) && user_time_minute >= 120) // 2 hours
3077  0155 ce0000        	ldw	x,L1771_power
3078  0158 a31389        	cpw	x,#5001
3079  015b 2408          	jruge	L3502
3081  015d ce0004        	ldw	x,L7671_current
3082  0160 a3001f        	cpw	x,#31
3083  0163 250c          	jrult	L1502
3084  0165               L3502:
3086  0165 ce0000        	ldw	x,_user_time_minute
3087  0168 a30078        	cpw	x,#120
3088  016b 2504          	jrult	L1502
3089                     ; 84                 error_id = 10;
3091  016d 350a0001      	mov	_error_id,#10
3092  0171               L1502:
3093                     ; 86             if (error_id == 10) // || error_id ==11
3095  0171 b601          	ld	a,_error_id
3096  0173 a10a          	cp	a,#10
3097  0175 2640          	jrne	L5502
3098                     ; 88                 error_time /= CLOCKS_PER_SEC;
3100  0177 ae001a        	ldw	x,#_error_time
3101  017a cd0000        	call	c_ltor
3103  017d ae0000        	ldw	x,#L6
3104  0180 cd0000        	call	c_ludv
3106  0183 ae001a        	ldw	x,#_error_time
3107  0186 cd0000        	call	c_rtol
3109                     ; 89                 if (IS_TIME_SET)
3111  0189 ae0000        	ldw	x,#_server_time
3112  018c cd0000        	call	c_lzmp
3114  018f 2726          	jreq	L5502
3115                     ; 91                     error_time += server_time;
3117  0191 ae0000        	ldw	x,#_server_time
3118  0194 cd0000        	call	c_ltor
3120  0197 ae001a        	ldw	x,#_error_time
3121  019a cd0000        	call	c_lgadd
3123                     ; 92                     eeprom_wrchar(EEPROM_ADDR_ERROR_ID, error_id);
3125  019d 3b0001        	push	_error_id
3126  01a0 ae4023        	ldw	x,#16419
3127  01a3 cd0000        	call	_eeprom_wrchar
3129  01a6 84            	pop	a
3130                     ; 93                     eeprom_write_long(EEPROM_ADDR_ERROR_TIME, error_time);
3132  01a7 ce001c        	ldw	x,_error_time+2
3133  01aa 89            	pushw	x
3134  01ab ce001a        	ldw	x,_error_time
3135  01ae 89            	pushw	x
3136  01af ae4024        	ldw	x,#16420
3137  01b2 cd0000        	call	_eeprom_write_long
3139  01b5 5b04          	addw	sp,#4
3140  01b7               L5502:
3141                     ; 97             current.avg = 0;
3143  01b7 5f            	clrw	x
3144  01b8 cf0004        	ldw	L7671_current,x
3145                     ; 98             power.avg = 0;
3147  01bb 5f            	clrw	x
3148  01bc cf0000        	ldw	L1771_power,x
3149                     ; 99             cp_count = 0;
3151  01bf 5f            	clrw	x
3152  01c0 cf0008        	ldw	L5671_cp_count,x
3153  01c3               L1402:
3154                     ; 101         current.accu += machine_current_motor;
3156  01c3 c60000        	ld	a,_machine_current_motor
3157  01c6 ae0004        	ldw	x,#L7671_current
3158  01c9 88            	push	a
3159  01ca cd0000        	call	c_lgadc
3161  01cd 84            	pop	a
3162                     ; 102         power.accu += machine_volt_motor * machine_current_motor;
3164  01ce c60000        	ld	a,_machine_volt_motor
3165  01d1 97            	ld	xl,a
3166  01d2 c60000        	ld	a,_machine_current_motor
3167  01d5 42            	mul	x,a
3168  01d6 cd0000        	call	c_itolx
3170  01d9 ae0000        	ldw	x,#L1771_power
3171  01dc cd0000        	call	c_lgadd
3173                     ; 103         cp_count++;
3175  01df ce0008        	ldw	x,L5671_cp_count
3176  01e2 1c0001        	addw	x,#1
3177  01e5 cf0008        	ldw	L5671_cp_count,x
3178  01e8               L7302:
3179                     ; 106     if (pcerr_com == 1)
3181                     	btst	_pcerr_com
3182  01ed 2405          	jruge	L1602
3183                     ; 108         error_code = ERROR_COMMUNICATION;
3185  01ef ae0080        	ldw	x,#128
3186  01f2 bf00          	ldw	_error_code,x
3187  01f4               L1602:
3188                     ; 111     if (!skip_error && (error_code != 0 || flag_Gsensor_disconnected > 0) || error_id >= 10)
3190                     	btst	_skip_error
3191  01f9 250a          	jrult	L7602
3193  01fb be00          	ldw	x,_error_code
3194  01fd 260c          	jrne	L5602
3196  01ff 725d0000      	tnz	_flag_Gsensor_disconnected
3197  0203 2606          	jrne	L5602
3198  0205               L7602:
3200  0205 b601          	ld	a,_error_id
3201  0207 a10a          	cp	a,#10
3202  0209 2569          	jrult	L3602
3203  020b               L5602:
3204                     ; 113         if (error_code & ERROR_COMMUNICATION)
3206  020b b601          	ld	a,_error_code+1
3207  020d a580          	bcp	a,#128
3208  020f 2706          	jreq	L1702
3209                     ; 115             error_id = 1;
3211  0211 35010001      	mov	_error_id,#1
3213  0215 2046          	jra	L3702
3214  0217               L1702:
3215                     ; 117         else if (error_code & ERROR_MOSFET)
3217  0217 b601          	ld	a,_error_code+1
3218  0219 a501          	bcp	a,#1
3219  021b 2706          	jreq	L5702
3220                     ; 119             error_id = 2;
3222  021d 35020001      	mov	_error_id,#2
3224  0221 203a          	jra	L3702
3225  0223               L5702:
3226                     ; 121         else if (error_code & ERROR_SPEED_SENSOR)
3228  0223 b601          	ld	a,_error_code+1
3229  0225 a508          	bcp	a,#8
3230  0227 2706          	jreq	L1012
3231                     ; 123             error_id = 3;
3233  0229 35030001      	mov	_error_id,#3
3235  022d 202e          	jra	L3702
3236  022f               L1012:
3237                     ; 125         else if (error_code & ERROR_DCMOTOR_CURRENT)
3239  022f b601          	ld	a,_error_code+1
3240  0231 a504          	bcp	a,#4
3241  0233 2706          	jreq	L5012
3242                     ; 127             error_id = 5;
3244  0235 35050001      	mov	_error_id,#5
3246  0239 2022          	jra	L3702
3247  023b               L5012:
3248                     ; 129         else if (error_code & ERROR_DCMOTOR_ALARM)
3250  023b b601          	ld	a,_error_code+1
3251  023d a502          	bcp	a,#2
3252  023f 2706          	jreq	L1112
3253                     ; 131             error_id = 5;
3255  0241 35050001      	mov	_error_id,#5
3257  0245 2016          	jra	L3702
3258  0247               L1112:
3259                     ; 133         else if (error_code & ERROR_MOTOR_DISCONNECT)
3261  0247 b601          	ld	a,_error_code+1
3262  0249 a510          	bcp	a,#16
3263  024b 2706          	jreq	L5112
3264                     ; 135             error_id = 6;
3266  024d 35060001      	mov	_error_id,#6
3268  0251 200a          	jra	L3702
3269  0253               L5112:
3270                     ; 137         else if (flag_Gsensor_disconnected > 0)
3272  0253 725d0000      	tnz	_flag_Gsensor_disconnected
3273  0257 2704          	jreq	L3702
3274                     ; 139             error_id = 8;
3276  0259 35080001      	mov	_error_id,#8
3277  025d               L3702:
3278                     ; 142         if (error_id != 0 && error_id_last == 0)
3280  025d 3d01          	tnz	_error_id
3281  025f 271d          	jreq	L5212
3283  0261 3d00          	tnz	L3771_error_id_last
3284  0263 2619          	jrne	L5212
3285                     ; 144             set_wifi_flag(FLAG_WIFI_ERROR_ID);
3287  0265 72180000      	bset	_commu_wifi_flag,#4
3288                     ; 145             beep(BEEP_ERROR);
3290  0269 a604          	ld	a,#4
3291  026b cd0000        	call	_beep
3293                     ; 146             SET_LED_ERROR;
3295  026e 7213500a      	bres	_PC_ODR,#1
3296  0272 200a          	jra	L5212
3297  0274               L3602:
3298                     ; 165     else if (error_id_last != 0)
3300  0274 3d00          	tnz	L3771_error_id_last
3301  0276 2706          	jreq	L5212
3302                     ; 167         error_id = 0;
3304  0278 3f01          	clr	_error_id
3305                     ; 168         CLEAR_LED_ERROR;
3307  027a 7212500a      	bset	_PC_ODR,#1
3308  027e               L5212:
3309                     ; 171     error_id_last = error_id;
3311  027e 450100        	mov	L3771_error_id_last,_error_id
3312                     ; 172 }
3315  0281 5b0b          	addw	sp,#11
3316  0283 81            	ret
3438                     	switch	.bss
3439  0000               L1771_power:
3440  0000 00000000      	ds.b	4
3441  0004               L7671_current:
3442  0004 00000000      	ds.b	4
3443  0008               L5671_cp_count:
3444  0008 0000          	ds.b	2
3445  000a               L3671_cp_index:
3446  000a 00            	ds.b	1
3447  000b               L1671_powers:
3448  000b 000000000000  	ds.b	10
3449  0015               L7571_currents:
3450  0015 0000000000    	ds.b	5
3451                     	xref	_eeprom_write_long
3452                     	xref	_eeprom_wrchar
3453                     	xref	_machine_volt_motor
3454                     	xref	_machine_current_motor
3455                     	xbit	_pcerr_com
3456                     	xref.b	_error_code
3457                     	xref	_server_time
3458                     	xref	_commu_wifi_flag
3459                     	xref	_flag_Gsensor_disconnected
3460                     	xref	_beep
3461                     	xdef	_detect_error
3462  001a               _error_time:
3463  001a 00000000      	ds.b	4
3464                     	xdef	_error_time
3465                     .bit:	section	.data,bit
3466  0000               _skip_error:
3467  0000 00            	ds.b	1
3468                     	xdef	_skip_error
3469                     	switch	.ubsct
3470  0001               _error_id:
3471  0001 00            	ds.b	1
3472                     	xdef	_error_id
3473                     	xref	_user_time_minute
3474                     	xref	_clock
3475                     	xref.b	c_lreg
3495                     	xref	c_lgadc
3496                     	xref	c_lgadd
3497                     	xref	c_lzmp
3498                     	xref	c_smodx
3499                     	xref	c_uitoly
3500                     	xref	c_uitolx
3501                     	xref	c_lcmp
3502                     	xref	c_smul
3503                     	xref	c_itolx
3504                     	xref	c_ladd
3505                     	xref	c_ludv
3506                     	xref	c_ltor
3507                     	xref	c_rtol
3508                     	end
