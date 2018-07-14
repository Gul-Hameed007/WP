   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2799                     ; 33 void show_net_state(void)
2799                     ; 34 {
2801                     	switch	.text
2802  0000               _show_net_state:
2806                     ; 35     switch (net_state)
2808  0000 c60000        	ld	a,_net_state
2810                     ; 55         break;
2811  0003 4d            	tnz	a
2812  0004 2727          	jreq	L3671
2813  0006 4a            	dec	a
2814  0007 272a          	jreq	L5671
2815  0009 4a            	dec	a
2816  000a 270e          	jreq	L1671
2817  000c 4a            	dec	a
2818  000d 270b          	jreq	L1671
2819  000f 4a            	dec	a
2820  0010 272e          	jreq	L7671
2821  0012 4a            	dec	a
2822  0013 271e          	jreq	L5671
2823  0015 4a            	dec	a
2824  0016 273e          	jreq	L1771
2825  0018 2047          	jra	L3102
2826  001a               L1671:
2827                     ; 37     case NET_STATE_CLOUD:
2827                     ; 38     case NET_STATE_LOCAL:
2827                     ; 39         teststate = TEST_STATE_RUN_NET_OK;
2829  001a 35060000      	mov	L7571_teststate,#6
2830                     ; 40         eeprom_wrchar(EEPROM_ADDR_TEST_STATE, teststate);
2832  001e 4b06          	push	#6
2833  0020 ae407d        	ldw	x,#16509
2834  0023 cd0000        	call	_eeprom_wrchar
2836  0026 84            	pop	a
2837                     ; 41         set_wifi_flag(FLAG_WIFI_RESTORE);
2839  0027 72100000      	bset	_commu_wifi_flag,#0
2840                     ; 42         break;
2842  002b 2034          	jra	L3102
2843  002d               L3671:
2844                     ; 43     case NET_STATE_UNKNOWN:
2844                     ; 44         SET_LED_NET;
2846  002d 72155000      	bres	_PA_ODR,#2
2847                     ; 45         break;
2849  0031 202e          	jra	L3102
2850  0033               L5671:
2851                     ; 46     case NET_STATE_OFFLINE:
2851                     ; 47     case NET_STATE_UAP:
2851                     ; 48         disp_alternant_net(100, 200);
2853  0033 ae00c8        	ldw	x,#200
2854  0036 89            	pushw	x
2855  0037 ae0064        	ldw	x,#100
2856  003a cd0000        	call	_disp_alternant_net
2858  003d 85            	popw	x
2859                     ; 49         break;
2861  003e 2021          	jra	L3102
2862  0040               L7671:
2863                     ; 50     case NET_STATE_UPDATING:
2863                     ; 51         disp_alternant2_net(100, 200, 100, 800);
2865  0040 ae0320        	ldw	x,#800
2866  0043 89            	pushw	x
2867  0044 ae0064        	ldw	x,#100
2868  0047 89            	pushw	x
2869  0048 ae00c8        	ldw	x,#200
2870  004b 89            	pushw	x
2871  004c ae0064        	ldw	x,#100
2872  004f cd0000        	call	_disp_alternant2_net
2874  0052 5b06          	addw	sp,#6
2875                     ; 52         break;
2877  0054 200b          	jra	L3102
2878  0056               L1771:
2879                     ; 53     case NET_STATE_UNPROV:
2879                     ; 54         disp_alternant_net(200, 800);
2881  0056 ae0320        	ldw	x,#800
2882  0059 89            	pushw	x
2883  005a ae00c8        	ldw	x,#200
2884  005d cd0000        	call	_disp_alternant_net
2886  0060 85            	popw	x
2887                     ; 55         break;
2889  0061               L3102:
2890                     ; 57 }
2893  0061 81            	ret
2940                     ; 59 static void FactoryTestKeys(void)
2940                     ; 60 {
2941                     	switch	.text
2942  0062               L5102_FactoryTestKeys:
2946                     ; 61     check_key_id();
2948  0062 cd0000        	call	_check_key_id
2950                     ; 63     if (key_id != KEY_NONE && key_id_done == 0)
2952  0065 be00          	ldw	x,_key_id
2953  0067 2603          	jrne	L01
2954  0069 cc016b        	jp	L7302
2955  006c               L01:
2957                     	btst	_key_id_done
2958  0071 2403          	jruge	L21
2959  0073 cc016b        	jp	L7302
2960  0076               L21:
2961                     ; 65         key_id_done = 1;
2963  0076 72100000      	bset	_key_id_done
2964                     ; 67         if (key_id == KEY_MODE_PRESS || key_id == KEY_MODE_PRESS_BTN) // for all state
2966  007a be00          	ldw	x,_key_id
2967  007c a30001        	cpw	x,#1
2968  007f 270a          	jreq	L3402
2970  0081 be00          	ldw	x,_key_id
2971  0083 a31000        	cpw	x,#4096
2972  0086 2703          	jreq	L41
2973  0088 cc0149        	jp	L1402
2974  008b               L41:
2975  008b               L3402:
2976                     ; 69             beep(BEEP_KEY);
2978  008b a601          	ld	a,#1
2979  008d cd0000        	call	_beep
2981                     ; 70             key_id_done = 1;
2983  0090 72100000      	bset	_key_id_done
2984                     ; 71             disp_matrix_all(0x00);
2986  0094 4f            	clr	a
2987  0095 cd0000        	call	_disp_matrix_all
2989                     ; 72             switch (teststate)
2991  0098 c60000        	ld	a,L7571_teststate
2993                     ; 102                 break;
2994  009b a003          	sub	a,#3
2995  009d 270d          	jreq	L7102
2996  009f 4a            	dec	a
2997  00a0 2720          	jreq	L1202
2998  00a2 a004          	sub	a,#4
2999  00a4 2735          	jreq	L3202
3000  00a6 a002          	sub	a,#2
3001  00a8 273b          	jreq	L5202
3002  00aa 205d          	jra	L7402
3003  00ac               L7102:
3004                     ; 75                 CLEAR_LED_ALL;
3006  00ac 7212500a      	bset	_PC_ODR,#1
3009  00b0 7214500a      	bset	_PC_ODR,#2
3012  00b4 7216500a      	bset	_PC_ODR,#3
3015  00b8 7218500a      	bset	_PC_ODR,#4
3018  00bc 72145000      	bset	_PA_ODR,#2
3019                     ; 76                 break;
3022  00c0 2047          	jra	L7402
3023  00c2               L1202:
3024                     ; 77             case TEST_STATE_SENSOR:
3024                     ; 78                 stepdown_flag = STEPDOWN_NONE;
3026  00c2 725f0000      	clr	_stepdown_flag
3027                     ; 79                 user_request = USER_REQUEST_START;
3029  00c6 35010000      	mov	_user_request,#1
3030                     ; 80                 fixed_mode_speed = 180;
3032  00ca 35b40000      	mov	_fixed_mode_speed,#180
3033                     ; 83                 set_wifi_flag(FLAG_WIFI_FACTORY);
3035  00ce 72160000      	bset	_commu_wifi_flag,#3
3036                     ; 84                 net_state = NET_STATE_UNKNOWN;
3038  00d2 725f0000      	clr	_net_state
3039                     ; 85                 state_sec = 0;
3041  00d6 5f            	clrw	x
3042  00d7 bf00          	ldw	_state_sec,x
3043                     ; 86                 break;
3045  00d9 202e          	jra	L7402
3046  00db               L3202:
3047                     ; 87             case TEST_STATE_STOP:
3047                     ; 88                 if (machine_speed_target != 0)
3049  00db 3d00          	tnz	_machine_speed_target
3050  00dd 272a          	jreq	L7402
3051                     ; 90                     user_request = USER_REQUEST_STOP;
3053  00df 35020000      	mov	_user_request,#2
3054  00e3 2024          	jra	L7402
3055  00e5               L5202:
3056                     ; 93             case TEST_STATE_END:
3056                     ; 94                 user_total_distance = 0;
3058  00e5 ae0000        	ldw	x,#0
3059  00e8 cf0002        	ldw	_user_total_distance+2,x
3060  00eb ae0000        	ldw	x,#0
3061  00ee cf0000        	ldw	_user_total_distance,x
3062                     ; 95                 speed_limit_max = 180;
3064  00f1 35b40000      	mov	_speed_limit_max,#180
3065                     ; 96                 acceleration_param = 2;
3067  00f5 35020000      	mov	_acceleration_param,#2
3068                     ; 98                 waiting = 1;
3070  00f9 72100000      	bset	_waiting
3071                     ; 99                 waiting_cnt = DISPLAY_ALL_ON_DELAY;
3073  00fd 35960000      	mov	_waiting_cnt,#150
3074                     ; 100                 display_seg = DISPLAY_TIME;
3076  0101 725f0000      	clr	_display_seg
3077                     ; 101                 display_cnt = 0;
3079  0105 5f            	clrw	x
3080  0106 cf0000        	ldw	_display_cnt,x
3081                     ; 102                 break;
3083  0109               L7402:
3084                     ; 105             if (!run_in_prog_mode && teststate != TEST_STATE_RUN)
3086                     	btst	_run_in_prog_mode
3087  010e 255b          	jrult	L7302
3089  0110 c60000        	ld	a,L7571_teststate
3090  0113 a105          	cp	a,#5
3091  0115 2754          	jreq	L7302
3092                     ; 107                 if (teststate == TEST_STATE_RUN_NET_OK || teststate == TEST_STATE_RUN_NET_ERR)
3094  0117 c60000        	ld	a,L7571_teststate
3095  011a a106          	cp	a,#6
3096  011c 2707          	jreq	L7502
3098  011e c60000        	ld	a,L7571_teststate
3099  0121 a107          	cp	a,#7
3100  0123 2614          	jrne	L5502
3101  0125               L7502:
3102                     ; 109                     if (key_id == KEY_MODE_PRESS_BTN)
3104  0125 be00          	ldw	x,_key_id
3105  0127 a31000        	cpw	x,#4096
3106  012a 2611          	jrne	L3602
3107                     ; 111                         teststate += 1 + TEST_STATE_RUN_NET_ERR - teststate;
3109  012c a608          	ld	a,#8
3110  012e c00000        	sub	a,L7571_teststate
3111  0131 cb0000        	add	a,L7571_teststate
3112  0134 c70000        	ld	L7571_teststate,a
3113  0137 2004          	jra	L3602
3114  0139               L5502:
3115                     ; 116                     teststate += 1;
3117  0139 725c0000      	inc	L7571_teststate
3118  013d               L3602:
3119                     ; 119                 eeprom_wrchar(EEPROM_ADDR_TEST_STATE, teststate);
3121  013d 3b0000        	push	L7571_teststate
3122  0140 ae407d        	ldw	x,#16509
3123  0143 cd0000        	call	_eeprom_wrchar
3125  0146 84            	pop	a
3126  0147 2022          	jra	L7302
3127  0149               L1402:
3128                     ; 122         else if (teststate >= TEST_STATE_RUN && teststate <= TEST_STATE_RUN_NET_ERR)
3130  0149 c60000        	ld	a,L7571_teststate
3131  014c a105          	cp	a,#5
3132  014e 251b          	jrult	L7302
3134  0150 c60000        	ld	a,L7571_teststate
3135  0153 a108          	cp	a,#8
3136  0155 2414          	jruge	L7302
3137                     ; 144             if (key_id == KEY_STOP_LONG_PRESS)
3139  0157 be00          	ldw	x,_key_id
3140  0159 a30103        	cpw	x,#259
3141  015c 260d          	jrne	L7302
3142                     ; 146                 beep(BEEP_KEY);
3144  015e a601          	ld	a,#1
3145  0160 cd0000        	call	_beep
3147                     ; 147                 run_in_prog_mode = 1;
3149  0163 72100000      	bset	_run_in_prog_mode
3150                     ; 148                 display_seg = DISPLAY_PROG_F1;
3152  0167 35060000      	mov	_display_seg,#6
3153  016b               L7302:
3154                     ; 152 }
3157  016b 81            	ret
3160                     	switch	.ubsct
3161  0000               L3702_laststate:
3162  0000 00            	ds.b	1
3233                     .const:	section	.text
3234  0000               L42:
3235  0000 00000064      	dc.l	100
3236  0004               L03:
3237  0004 01e0          	dc.w	L5702
3238  0006 027d          	dc.w	L7702
3239  0008 028e          	dc.w	L1012
3240  000a 02a9          	dc.w	L3012
3241  000c 02c6          	dc.w	L5012
3242  000e 030d          	dc.w	L1112
3243  0010 030d          	dc.w	L1112
3244  0012 030d          	dc.w	L1112
3245  0014 038f          	dc.w	L3112
3246  0016 03a4          	dc.w	L5112
3247  0018 03c3          	dc.w	L7112
3248  001a 0300          	dc.w	L7012
3249                     ; 156 void FactoryTestOperation(void)
3249                     ; 157 {
3250                     	switch	.text
3251  016c               _FactoryTestOperation:
3255                     ; 160     if (error_id != 0)
3257  016c 3d00          	tnz	_error_id
3258  016e 2736          	jreq	L7312
3259                     ; 162         disp_matrix_all(0x00);
3261  0170 4f            	clr	a
3262  0171 cd0000        	call	_disp_matrix_all
3264                     ; 163         disp_custom(LED_UP, "E%02d", (uint)error_id);
3266  0174 b600          	ld	a,_error_id
3267  0176 5f            	clrw	x
3268  0177 97            	ld	xl,a
3269  0178 89            	pushw	x
3270  0179 ae0046        	ldw	x,#L1412
3271  017c 89            	pushw	x
3272  017d 4f            	clr	a
3273  017e cd0000        	call	_disp_custom
3275  0181 5b04          	addw	sp,#4
3276                     ; 164         if (error_id == 8 && flag_Gsensor_disconnected < 3)
3278  0183 b600          	ld	a,_error_id
3279  0185 a108          	cp	a,#8
3280  0187 261c          	jrne	L3412
3282  0189 c60000        	ld	a,_flag_Gsensor_disconnected
3283  018c a103          	cp	a,#3
3284  018e 2415          	jruge	L3412
3285                     ; 166             disp_text_down(flag_Gsensor_disconnected == 1 ? "L" : "R");
3287  0190 4b01          	push	#1
3288  0192 c60000        	ld	a,_flag_Gsensor_disconnected
3289  0195 a101          	cp	a,#1
3290  0197 2605          	jrne	L02
3291  0199 ae0044        	ldw	x,#L5412
3292  019c 2003          	jra	L22
3293  019e               L02:
3294  019e ae0042        	ldw	x,#L7412
3295  01a1               L22:
3296  01a1 cd0000        	call	_disp_text
3298  01a4 84            	pop	a
3299  01a5               L3412:
3300                     ; 168         return;
3303  01a5 81            	ret
3304  01a6               L7312:
3305                     ; 171     if (run_in_prog_mode)
3307                     	btst	_run_in_prog_mode
3308  01ab 2405          	jruge	L1512
3309                     ; 173         ProgModeKeys();
3311  01ad cd0000        	call	_ProgModeKeys
3314  01b0 201c          	jra	L3512
3315  01b2               L1512:
3316                     ; 175     else if (teststate == TEST_STATE_NORMAL)
3318  01b2 c60000        	ld	a,L7571_teststate
3319  01b5 a10b          	cp	a,#11
3320  01b7 2605          	jrne	L5512
3321                     ; 177         UserConsumerKeys();
3323  01b9 cd0000        	call	_UserConsumerKeys
3326  01bc 2010          	jra	L3512
3327  01be               L5512:
3328                     ; 179     else if (teststate != TEST_STATE_BEGIN || state_sec > 3)
3330  01be 725d0000      	tnz	L7571_teststate
3331  01c2 2607          	jrne	L3612
3333  01c4 be00          	ldw	x,_state_sec
3334  01c6 a30004        	cpw	x,#4
3335  01c9 2503          	jrult	L3512
3336  01cb               L3612:
3337                     ; 181         FactoryTestKeys();
3339  01cb cd0062        	call	L5102_FactoryTestKeys
3341  01ce               L3512:
3342                     ; 184     switch (teststate)
3344  01ce c60000        	ld	a,L7571_teststate
3346                     ; 304         break;
3347  01d1 a10c          	cp	a,#12
3348  01d3 2407          	jruge	L62
3349  01d5 5f            	clrw	x
3350  01d6 97            	ld	xl,a
3351  01d7 58            	sllw	x
3352  01d8 de0004        	ldw	x,(L03,x)
3353  01db fc            	jp	(x)
3354  01dc               L62:
3355  01dc acd703d7      	jpf	L7612
3356  01e0               L5702:
3357                     ; 186     case TEST_STATE_BEGIN:
3357                     ; 187         if (state_sec == 0 && state_tick == 1)
3359  01e0 be00          	ldw	x,_state_sec
3360  01e2 2663          	jrne	L1712
3362  01e4 b600          	ld	a,_state_tick
3363  01e6 a101          	cp	a,#1
3364  01e8 265d          	jrne	L1712
3365                     ; 189             waiting = 0;
3367  01ea 72110000      	bres	_waiting
3368                     ; 190             waiting_cnt = 0;
3370  01ee 3f00          	clr	_waiting_cnt
3371                     ; 191             disp_matrix_all(0x00);
3373  01f0 4f            	clr	a
3374  01f1 cd0000        	call	_disp_matrix_all
3376                     ; 192             CLEAR_LED_ALL;
3378  01f4 7212500a      	bset	_PC_ODR,#1
3381  01f8 7214500a      	bset	_PC_ODR,#2
3384  01fc 7216500a      	bset	_PC_ODR,#3
3387  0200 7218500a      	bset	_PC_ODR,#4
3390  0204 72145000      	bset	_PA_ODR,#2
3391                     ; 193             global_fan_test = 0;
3394  0208 72110000      	bres	_global_fan_test
3395                     ; 194             laststate = eeprom_rdchar(EEPROM_ADDR_TEST_STATE);
3397  020c 55407d0000    	mov	L3702_laststate,16509
3398                     ; 195             if (laststate >= TEST_STATE_RUN && laststate <= TEST_STATE_RUN_NET_ERR)
3400  0211 b600          	ld	a,L3702_laststate
3401  0213 a105          	cp	a,#5
3402  0215 251b          	jrult	L3712
3404  0217 b600          	ld	a,L3702_laststate
3405  0219 a108          	cp	a,#8
3406  021b 2415          	jruge	L3712
3407                     ; 198                 if (laststate == TEST_STATE_RUN)
3409  021d b600          	ld	a,L3702_laststate
3410  021f a105          	cp	a,#5
3411  0221 2703          	jreq	L23
3412  0223 cc03d7        	jp	L7612
3413  0226               L23:
3414                     ; 200                     set_wifi_flag(FLAG_WIFI_FACTORY);
3416  0226 72160000      	bset	_commu_wifi_flag,#3
3417                     ; 201                     net_state = NET_STATE_UNKNOWN;
3419  022a 725f0000      	clr	_net_state
3420  022e acd703d7      	jpf	L7612
3421  0232               L3712:
3422                     ; 205             else if (laststate >= TEST_STATE_END)
3424  0232 b600          	ld	a,L3702_laststate
3425  0234 a10a          	cp	a,#10
3426  0236 2507          	jrult	L1022
3427                     ; 207                 eeprom_factory();
3429  0238 cd0000        	call	_eeprom_factory
3431                     ; 208                 init_params();
3433  023b cd0000        	call	_init_params
3435                     ; 209                 return;
3438  023e 81            	ret
3439  023f               L1022:
3440                     ; 213                 teststate = TEST_STATE_RC;
3442  023f 35010000      	mov	L7571_teststate,#1
3443  0243 acd703d7      	jpf	L7612
3444  0247               L1712:
3445                     ; 216         else if (state_sec < 3)
3447  0247 be00          	ldw	x,_state_sec
3448  0249 a30003        	cpw	x,#3
3449  024c 241e          	jruge	L7022
3450                     ; 218             disp_matrix_all(0x00);
3452  024e 4f            	clr	a
3453  024f cd0000        	call	_disp_matrix_all
3455                     ; 219             disp_text_up("WAIT");
3457  0252 4b00          	push	#0
3458  0254 ae003d        	ldw	x,#L1122
3459  0257 cd0000        	call	_disp_text
3461  025a 84            	pop	a
3462                     ; 220             disp_d_down(3 - state_sec);
3464  025b 4b01          	push	#1
3465  025d ae0003        	ldw	x,#3
3466  0260 72b00000      	subw	x,_state_sec
3467  0264 cd0000        	call	_disp_d
3469  0267 84            	pop	a
3471  0268 acd703d7      	jpf	L7612
3472  026c               L7022:
3473                     ; 224             teststate = laststate;
3475  026c 5500000000    	mov	L7571_teststate,L3702_laststate
3476                     ; 225             user_request = USER_REQUEST_START;
3478  0271 35010000      	mov	_user_request,#1
3479                     ; 226             fixed_mode_speed = 180;
3481  0275 35b40000      	mov	_fixed_mode_speed,#180
3482  0279 acd703d7      	jpf	L7612
3483  027d               L7702:
3484                     ; 229     case TEST_STATE_RC:
3484                     ; 230         disp_matrix_all(0x00);
3486  027d 4f            	clr	a
3487  027e cd0000        	call	_disp_matrix_all
3489                     ; 231         disp_text_up("TEST");
3491  0281 4b00          	push	#0
3492  0283 ae0038        	ldw	x,#L5122
3493  0286 cd0000        	call	_disp_text
3495  0289 84            	pop	a
3496                     ; 232         break;
3498  028a acd703d7      	jpf	L7612
3499  028e               L1012:
3500                     ; 233     case TEST_VERSION:
3500                     ; 234         disp_matrix_all(0x00);
3502  028e 4f            	clr	a
3503  028f cd0000        	call	_disp_matrix_all
3505                     ; 235         disp_d_down((uint)power_board_version);
3507  0292 4b01          	push	#1
3508  0294 b600          	ld	a,_power_board_version
3509  0296 5f            	clrw	x
3510  0297 97            	ld	xl,a
3511  0298 cd0000        	call	_disp_d
3513  029b 84            	pop	a
3514                     ; 236         disp_text_up(FW_VERSION);
3516  029c 4b00          	push	#0
3517  029e ce0000        	ldw	x,_FW_VERSION
3518  02a1 cd0000        	call	_disp_text
3520  02a4 84            	pop	a
3521                     ; 237         break;
3523  02a5 acd703d7      	jpf	L7612
3524  02a9               L3012:
3525                     ; 238     case TEST_STATE_LED:
3525                     ; 239         disp_matrix_all(0xff);
3527  02a9 a6ff          	ld	a,#255
3528  02ab cd0000        	call	_disp_matrix_all
3530                     ; 240         SET_LED_ALL;
3532  02ae 7213500a      	bres	_PC_ODR,#1
3535  02b2 7215500a      	bres	_PC_ODR,#2
3538  02b6 7217500a      	bres	_PC_ODR,#3
3541  02ba 7219500a      	bres	_PC_ODR,#4
3544  02be 72155000      	bres	_PA_ODR,#2
3545                     ; 241         break;
3548  02c2 acd703d7      	jpf	L7612
3549  02c6               L5012:
3550                     ; 242     case TEST_STATE_SENSOR:
3550                     ; 243         disp_matrix_all(0x00);
3552  02c6 4f            	clr	a
3553  02c7 cd0000        	call	_disp_matrix_all
3555                     ; 244         disp_ld(tension / 100, LED_UP);
3557  02ca 4b00          	push	#0
3558  02cc ae0000        	ldw	x,#_tension
3559  02cf cd0000        	call	c_ltor
3561  02d2 ae0000        	ldw	x,#L42
3562  02d5 cd0000        	call	c_ludv
3564  02d8 be02          	ldw	x,c_lreg+2
3565  02da 89            	pushw	x
3566  02db be00          	ldw	x,c_lreg
3567  02dd 89            	pushw	x
3568  02de cd0000        	call	_disp_ld
3570  02e1 5b05          	addw	sp,#5
3571                     ; 245         disp_ld(tension2 / 100, LED_DOWN);        
3573  02e3 4b01          	push	#1
3574  02e5 ae0000        	ldw	x,#_tension2
3575  02e8 cd0000        	call	c_ltor
3577  02eb ae0000        	ldw	x,#L42
3578  02ee cd0000        	call	c_ludv
3580  02f1 be02          	ldw	x,c_lreg+2
3581  02f3 89            	pushw	x
3582  02f4 be00          	ldw	x,c_lreg
3583  02f6 89            	pushw	x
3584  02f7 cd0000        	call	_disp_ld
3586  02fa 5b05          	addw	sp,#5
3587                     ; 246         break;
3589  02fc acd703d7      	jpf	L7612
3590  0300               L7012:
3591                     ; 247     case TEST_STATE_NORMAL:
3591                     ; 248         speed_rpm_convert();
3593  0300 cd0000        	call	_speed_rpm_convert
3595                     ; 249         UserConsumerOperation();
3597  0303 cd0000        	call	_UserConsumerOperation
3599                     ; 250         UserConsumerDisplay();
3601  0306 cd0000        	call	_UserConsumerDisplay
3603                     ; 251         break;
3605  0309 acd703d7      	jpf	L7612
3606  030d               L1112:
3607                     ; 252     case TEST_STATE_RUN:
3607                     ; 253     case TEST_STATE_RUN_NET_OK:
3607                     ; 254     case TEST_STATE_RUN_NET_ERR:
3607                     ; 255         speed_rpm_convert();
3609  030d cd0000        	call	_speed_rpm_convert
3611                     ; 256         runmode = RUN_MODE_FIXED;
3613  0310 35010000      	mov	_runmode,#1
3614                     ; 257         run();
3616  0314 cd0000        	call	_run
3618                     ; 258         if (run_in_prog_mode)
3620                     	btst	_run_in_prog_mode
3621  031c 2407          	jruge	L7122
3622                     ; 260             UserConsumerDisplay();
3624  031e cd0000        	call	_UserConsumerDisplay
3627  0321 acd703d7      	jpf	L7612
3628  0325               L7122:
3629                     ; 264             disp_matrix_all(0x0);
3631  0325 4f            	clr	a
3632  0326 cd0000        	call	_disp_matrix_all
3634                     ; 265             if (teststate == TEST_STATE_RUN)
3636  0329 c60000        	ld	a,L7571_teststate
3637  032c a105          	cp	a,#5
3638  032e 2622          	jrne	L3222
3639                     ; 267                 disp_text_up("NET");
3641  0330 4b00          	push	#0
3642  0332 ae0034        	ldw	x,#L5222
3643  0335 cd0000        	call	_disp_text
3645  0338 84            	pop	a
3646                     ; 268                 show_net_state();
3648  0339 cd0000        	call	_show_net_state
3650                     ; 269                 if (state_sec > 60)
3652  033c be00          	ldw	x,_state_sec
3653  033e a3003d        	cpw	x,#61
3654  0341 253c          	jrult	L1322
3655                     ; 271                     teststate = TEST_STATE_RUN_NET_ERR;
3657  0343 35070000      	mov	L7571_teststate,#7
3658                     ; 272                     eeprom_wrchar(EEPROM_ADDR_TEST_STATE, teststate);
3660  0347 4b07          	push	#7
3661  0349 ae407d        	ldw	x,#16509
3662  034c cd0000        	call	_eeprom_wrchar
3664  034f 84            	pop	a
3665  0350 202d          	jra	L1322
3666  0352               L3222:
3667                     ; 275             else if (teststate == TEST_STATE_RUN_NET_OK)
3669  0352 c60000        	ld	a,L7571_teststate
3670  0355 a106          	cp	a,#6
3671  0357 260b          	jrne	L3322
3672                     ; 277                disp_text_up("OK");
3674  0359 4b00          	push	#0
3675  035b ae0031        	ldw	x,#L5322
3676  035e cd0000        	call	_disp_text
3678  0361 84            	pop	a
3680  0362 201b          	jra	L1322
3681  0364               L3322:
3682                     ; 279             else if (teststate == TEST_STATE_RUN_NET_ERR)
3684  0364 c60000        	ld	a,L7571_teststate
3685  0367 a107          	cp	a,#7
3686  0369 260b          	jrne	L1422
3687                     ; 281                 disp_text_up("ERR");
3689  036b 4b00          	push	#0
3690  036d ae002d        	ldw	x,#L3422
3691  0370 cd0000        	call	_disp_text
3693  0373 84            	pop	a
3695  0374 2009          	jra	L1322
3696  0376               L1422:
3697                     ; 285                 disp_text_up("RUN");
3699  0376 4b00          	push	#0
3700  0378 ae0029        	ldw	x,#L7422
3701  037b cd0000        	call	_disp_text
3703  037e 84            	pop	a
3704  037f               L1322:
3705                     ; 287             disp_1f_down((uint)fixed_mode_speed / 3);
3707  037f 4b01          	push	#1
3708  0381 c60000        	ld	a,_fixed_mode_speed
3709  0384 5f            	clrw	x
3710  0385 97            	ld	xl,a
3711  0386 a603          	ld	a,#3
3712  0388 62            	div	x,a
3713  0389 cd0000        	call	_disp_1f
3715  038c 84            	pop	a
3716  038d 2048          	jra	L7612
3717  038f               L3112:
3718                     ; 290     case TEST_STATE_STOP:
3718                     ; 291         disp_text_up("STOP");
3720  038f 4b00          	push	#0
3721  0391 ae0024        	ldw	x,#L1522
3722  0394 cd0000        	call	_disp_text
3724  0397 84            	pop	a
3725                     ; 292         speed_rpm_convert();
3727  0398 cd0000        	call	_speed_rpm_convert
3729                     ; 293         stepdown_flag = STEPDOWN_PAUSE;
3731  039b 35010000      	mov	_stepdown_flag,#1
3732                     ; 294         run();
3734  039f cd0000        	call	_run
3736                     ; 295         break;
3738  03a2 2033          	jra	L7612
3739  03a4               L5112:
3740                     ; 296     case TEST_STATE_FAN_TEST:
3740                     ; 297         disp_text_up("FAN");
3742  03a4 4b00          	push	#0
3743  03a6 ae0020        	ldw	x,#L3522
3744  03a9 cd0000        	call	_disp_text
3746  03ac 84            	pop	a
3747                     ; 298         disp_text_down("TEST");
3749  03ad 4b01          	push	#1
3750  03af ae0038        	ldw	x,#L5122
3751  03b2 cd0000        	call	_disp_text
3753  03b5 84            	pop	a
3754                     ; 299         if (global_fan_test == 0) global_fan_test = 1;
3756                     	btst	_global_fan_test
3757  03bb 251a          	jrult	L7612
3760  03bd 72100000      	bset	_global_fan_test
3761  03c1 2014          	jra	L7612
3762  03c3               L7112:
3763                     ; 301     case TEST_STATE_END:
3763                     ; 302         disp_text_up("END");
3765  03c3 4b00          	push	#0
3766  03c5 ae001c        	ldw	x,#L7522
3767  03c8 cd0000        	call	_disp_text
3769  03cb 84            	pop	a
3770                     ; 303         if (global_fan_test == 1) global_fan_test = 0;
3772                     	btst	_global_fan_test
3773  03d1 2404          	jruge	L7612
3776  03d3 72110000      	bres	_global_fan_test
3777  03d7               L7612:
3778                     ; 306 }
3781  03d7 81            	ret
3909                     	xref	_init_params
3910                     	xdef	_show_net_state
3911                     .bit:	section	.data,bit
3912  0000               _global_fan_test:
3913  0000 00            	ds.b	1
3914                     	xdef	_global_fan_test
3915                     	switch	.bss
3916  0000               L7571_teststate:
3917  0000 00            	ds.b	1
3918                     	xref	_FW_VERSION
3919                     	xref	_UserConsumerKeys
3920                     	xref	_UserConsumerDisplay
3921                     	xref	_UserConsumerOperation
3922                     	xref	_ProgModeKeys
3923                     	xdef	_FactoryTestOperation
3924                     	xref	_speed_rpm_convert
3925                     	xref	_user_total_distance
3926                     	xref	_display_seg
3927                     	xref	_display_cnt
3928                     	xref.b	_error_id
3929                     	xbit	_run_in_prog_mode
3930                     	xref.b	_state_tick
3931                     	xref.b	_state_sec
3932                     	xref	_tension2
3933                     	xref	_tension
3934                     	xref	_flag_Gsensor_disconnected
3935                     	xref	_run
3936                     	xref	_stepdown_flag
3937                     	xref.b	_runmode
3938                     	xref	_net_state
3939                     	xref	_commu_wifi_flag
3940                     	xref	_disp_alternant2_net
3941                     	xref	_disp_alternant_net
3942                     	xref	_disp_custom
3943                     	xref	_disp_ld
3944                     	xref	_disp_d
3945                     	xref	_disp_1f
3946                     	xref	_disp_text
3947                     	xref	_disp_matrix_all
3948                     	xref	_beep
3949                     	xref	_check_key_id
3950                     	xbit	_key_id_done
3951                     	xref.b	_key_id
3952                     	xref	_eeprom_factory
3953                     	xref	_eeprom_wrchar
3954                     	xref	_acceleration_param
3955                     	xref	_fixed_mode_speed
3956                     	xref	_speed_limit_max
3957                     	xref.b	_machine_speed_target
3958                     	xref.b	_power_board_version
3959                     	xbit	_waiting
3960                     	xref.b	_waiting_cnt
3961                     	xref.b	_user_request
3962                     	switch	.const
3963  001c               L7522:
3964  001c 454e4400      	dc.b	"END",0
3965  0020               L3522:
3966  0020 46414e00      	dc.b	"FAN",0
3967  0024               L1522:
3968  0024 53544f5000    	dc.b	"STOP",0
3969  0029               L7422:
3970  0029 52554e00      	dc.b	"RUN",0
3971  002d               L3422:
3972  002d 45525200      	dc.b	"ERR",0
3973  0031               L5322:
3974  0031 4f4b00        	dc.b	"OK",0
3975  0034               L5222:
3976  0034 4e455400      	dc.b	"NET",0
3977  0038               L5122:
3978  0038 5445535400    	dc.b	"TEST",0
3979  003d               L1122:
3980  003d 5741495400    	dc.b	"WAIT",0
3981  0042               L7412:
3982  0042 5200          	dc.b	"R",0
3983  0044               L5412:
3984  0044 4c00          	dc.b	"L",0
3985  0046               L1412:
3986  0046 452530326400  	dc.b	"E%02d",0
3987                     	xref.b	c_lreg
4007                     	xref	c_ludv
4008                     	xref	c_ltor
4009                     	end
