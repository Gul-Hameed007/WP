   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2765                     .const:	section	.text
2766  0000               L7671_lib_start:
2767  0000 09            	dc.b	9
2768  0001 15            	dc.b	21
2769  0002 15            	dc.b	21
2770  0003 12            	dc.b	18
2771  0004 00            	dc.b	0
2772  0005 10            	dc.b	16
2773  0006 7f            	dc.b	127
2774  0007 11            	dc.b	17
2775  0008 00            	dc.b	0
2776  0009 0a            	dc.b	10
2777  000a 15            	dc.b	21
2778  000b 15            	dc.b	21
2779  000c 0f            	dc.b	15
2780  000d 01            	dc.b	1
2781  000e 00            	dc.b	0
2782  000f 11            	dc.b	17
2783  0010 1f            	dc.b	31
2784  0011 09            	dc.b	9
2785  0012 10            	dc.b	16
2786  0013 00            	dc.b	0
2787  0014 10            	dc.b	16
2788  0015 7f            	dc.b	127
2789  0016 11            	dc.b	17
2790  0017               L1771_lib_reset:
2791  0017 11            	dc.b	17
2792  0018 1f            	dc.b	31
2793  0019 09            	dc.b	9
2794  001a 10            	dc.b	16
2795  001b 10            	dc.b	16
2796  001c 0e            	dc.b	14
2797  001d 15            	dc.b	21
2798  001e 15            	dc.b	21
2799  001f 0d            	dc.b	13
2800  0020 00            	dc.b	0
2801  0021 09            	dc.b	9
2802  0022 15            	dc.b	21
2803  0023 15            	dc.b	21
2804  0024 12            	dc.b	18
2805  0025 00            	dc.b	0
2806  0026 0e            	dc.b	14
2807  0027 15            	dc.b	21
2808  0028 15            	dc.b	21
2809  0029 0d            	dc.b	13
2810  002a 10            	dc.b	16
2811  002b 7f            	dc.b	127
2812  002c 11            	dc.b	17
2813  002d 11            	dc.b	17
2814  002e               L3771_lib_press:
2815  002e 3f            	dc.b	63
2816  002f 24            	dc.b	36
2817  0030 24            	dc.b	36
2818  0031 18            	dc.b	24
2819  0032 02            	dc.b	2
2820  0033 3e            	dc.b	62
2821  0034 12            	dc.b	18
2822  0035 20            	dc.b	32
2823  0036 20            	dc.b	32
2824  0037 1c            	dc.b	28
2825  0038 2a            	dc.b	42
2826  0039 2a            	dc.b	42
2827  003a 1a            	dc.b	26
2828  003b 00            	dc.b	0
2829  003c 12            	dc.b	18
2830  003d 2a            	dc.b	42
2831  003e 2a            	dc.b	42
2832  003f 24            	dc.b	36
2833  0040 00            	dc.b	0
2834  0041 12            	dc.b	18
2835  0042 2a            	dc.b	42
2836  0043 2a            	dc.b	42
2837  0044 24            	dc.b	36
2838  0045               L5771_lib_rc_start:
2839  0045 00            	dc.b	0
2840  0046 00            	dc.b	0
2841  0047 00            	dc.b	0
2842  0048 00            	dc.b	0
2843  0049 00            	dc.b	0
2844  004a 00            	dc.b	0
2845  004b 00            	dc.b	0
2846  004c 00            	dc.b	0
2847  004d 00            	dc.b	0
2848  004e 00            	dc.b	0
2849  004f 0c            	dc.b	12
2850  0050 1e            	dc.b	30
2851  0051 1e            	dc.b	30
2852  0052 0c            	dc.b	12
2853  0053 00            	dc.b	0
2854  0054 00            	dc.b	0
2855  0055 00            	dc.b	0
2856  0056 00            	dc.b	0
2857  0057 00            	dc.b	0
2858  0058 00            	dc.b	0
2859  0059 00            	dc.b	0
2860  005a 00            	dc.b	0
2861  005b 00            	dc.b	0
2862  005c 00            	dc.b	0
2863  005d 00            	dc.b	0
2963                     ; 79 static void GOTO_STATE(user_state_t state)
2963                     ; 80 {
2965                     	switch	.text
2966  0000               L7771_GOTO_STATE:
2970                     ; 81     userstate = state;
2972  0000 c70000        	ld	_userstate,a
2973                     ; 82     state_sec = 0;
2975  0003 5f            	clrw	x
2976  0004 bf00          	ldw	_state_sec,x
2977                     ; 83     state_tick = 0;
2979  0006 3f00          	clr	_state_tick
2980                     ; 84     start_cnt = 0;
2982  0008 725f0000      	clr	_start_cnt
2983                     ; 85 }
2986  000c 81            	ret
3013                     ; 87 static void set_runmode_led(void)
3013                     ; 88 {
3014                     	switch	.text
3015  000d               L7402_set_runmode_led:
3019                     ; 89     switch (runmode)
3021  000d b600          	ld	a,_runmode
3023                     ; 109         break;
3024  000f 4d            	tnz	a
3025  0010 270c          	jreq	L1502
3026  0012 4a            	dec	a
3027  0013 2727          	jreq	L3502
3028  0015 4a            	dec	a
3029  0016 2742          	jreq	L5502
3030  0018 4a            	dec	a
3031  0019 274d          	jreq	L7502
3032  001b cc00b0        	jra	L3702
3033  001e               L1502:
3034                     ; 92         SET_LED_AUTO;
3036  001e 7214500a      	bset	_PC_ODR,#2
3039  0022 b600          	ld	a,_power_board_version
3040  0024 a16e          	cp	a,#110
3041  0026 250a          	jrult	L5702
3044  0028 7216500a      	bset	_PC_ODR,#3
3047  002c 7219500a      	bres	_PC_ODR,#4
3049  0030 207e          	jra	L3702
3050  0032               L5702:
3053  0032 7217500a      	bres	_PC_ODR,#3
3056  0036 7218500a      	bset	_PC_ODR,#4
3057  003a 2074          	jra	L3702
3058  003c               L3502:
3059                     ; 95         SET_LED_FIXED;
3061  003c 7214500a      	bset	_PC_ODR,#2
3064  0040 b600          	ld	a,_power_board_version
3065  0042 a16e          	cp	a,#110
3066  0044 250a          	jrult	L1012
3069  0046 7217500a      	bres	_PC_ODR,#3
3072  004a 7218500a      	bset	_PC_ODR,#4
3074  004e 2060          	jra	L3702
3075  0050               L1012:
3078  0050 7216500a      	bset	_PC_ODR,#3
3081  0054 7219500a      	bres	_PC_ODR,#4
3082  0058 2056          	jra	L3702
3083  005a               L5502:
3084                     ; 98         SET_LED_STANDBY;
3086  005a 7215500a      	bres	_PC_ODR,#2
3089  005e 7216500a      	bset	_PC_ODR,#3
3092  0062 7218500a      	bset	_PC_ODR,#4
3093                     ; 99         break;
3096  0066 2048          	jra	L3702
3097  0068               L7502:
3098                     ; 100     case RUN_MODE_NEW:
3098                     ; 101         if (tutorial_state >= TUTORIAL_STEP2_END && tutorial_state != TUTORIAL_STOP_FIRST)
3100  0068 c60000        	ld	a,_tutorial_state
3101  006b a104          	cp	a,#4
3102  006d 2525          	jrult	L5012
3104  006f c60000        	ld	a,_tutorial_state
3105  0072 a108          	cp	a,#8
3106  0074 271e          	jreq	L5012
3107                     ; 103             SET_LED_AUTO;
3109  0076 7214500a      	bset	_PC_ODR,#2
3112  007a b600          	ld	a,_power_board_version
3113  007c a16e          	cp	a,#110
3114  007e 250a          	jrult	L7012
3117  0080 7216500a      	bset	_PC_ODR,#3
3120  0084 7219500a      	bres	_PC_ODR,#4
3122  0088 2026          	jra	L3702
3123  008a               L7012:
3126  008a 7217500a      	bres	_PC_ODR,#3
3129  008e 7218500a      	bset	_PC_ODR,#4
3130  0092 201c          	jra	L3702
3131  0094               L5012:
3132                     ; 107             SET_LED_FIXED;
3134  0094 7214500a      	bset	_PC_ODR,#2
3137  0098 b600          	ld	a,_power_board_version
3138  009a a16e          	cp	a,#110
3139  009c 250a          	jrult	L5112
3142  009e 7217500a      	bres	_PC_ODR,#3
3145  00a2 7218500a      	bset	_PC_ODR,#4
3147  00a6 2008          	jra	L3702
3148  00a8               L5112:
3151  00a8 7216500a      	bset	_PC_ODR,#3
3154  00ac 7219500a      	bres	_PC_ODR,#4
3155  00b0               L3702:
3156                     ; 111 }
3159  00b0 81            	ret
3162                     	xref	_FW_VERSION
3269                     	switch	.const
3270  005e               L61:
3271  005e 000186a0      	dc.l	100000
3272  0062               L02:
3273  0062 0000000a      	dc.l	10
3274  0066               L22:
3275  0066 000f4240      	dc.l	1000000
3276  006a               L42:
3277  006a 00000064      	dc.l	100
3278  006e               L23:
3279  006e 00001388      	dc.l	5000
3280                     ; 113 void UserConsumerDisplay(void)
3280                     ; 114 {
3281                     	switch	.text
3282  00b1               _UserConsumerDisplay:
3284  00b1 520c          	subw	sp,#12
3285       0000000c      OFST:	set	12
3288                     ; 119     disp_matrix_all(0x00);
3290  00b3 4f            	clr	a
3291  00b4 cd0000        	call	_disp_matrix_all
3293                     ; 121     if (waiting == 0)
3295                     	btst	_waiting
3296  00bc 2403          	jruge	L24
3297  00be cc062d        	jp	L7612
3298  00c1               L24:
3299                     ; 123         switch (userstate)
3301  00c1 c60000        	ld	a,_userstate
3303                     ; 372             break;
3304  00c4 4d            	tnz	a
3305  00c5 271b          	jreq	L1212
3306  00c7 4a            	dec	a
3307  00c8 2718          	jreq	L1212
3308  00ca 4a            	dec	a
3309  00cb 2715          	jreq	L1212
3310  00cd 4a            	dec	a
3311  00ce 2712          	jreq	L1212
3312  00d0 4a            	dec	a
3313  00d1 2603          	jrne	L44
3314  00d3 cc056e        	jp	L5312
3315  00d6               L44:
3316  00d6 4a            	dec	a
3317  00d7 2603          	jrne	L64
3318  00d9 cc0596        	jp	L7312
3319  00dc               L64:
3320  00dc 4a            	dec	a
3321  00dd 2703          	jreq	L05
3322  00df cc0674        	jp	L7542
3323  00e2               L05:
3324  00e2               L1212:
3325                     ; 125         case USER_STATE_TICK:
3325                     ; 126         case USER_STATE_READY:
3325                     ; 127         case USER_STATE_RUN:
3325                     ; 128         case USER_STATE_PAUSE:
3325                     ; 129         case USER_STATE_STOP:
3325                     ; 130             // case USER_STATE_EOC:
3325                     ; 131 
3325                     ; 132             set_runmode_led();
3327  00e2 cd000d        	call	L7402_set_runmode_led
3329                     ; 133             if (runmode == RUN_MODE_CHECK && userstate != USER_STATE_TICK)
3331  00e5 b600          	ld	a,_runmode
3332  00e7 a104          	cp	a,#4
3333  00e9 2628          	jrne	L5712
3335  00eb c60000        	ld	a,_userstate
3336  00ee a106          	cp	a,#6
3337  00f0 2721          	jreq	L5712
3338                     ; 135                 CLEAR_LED_ALL;
3340  00f2 7212500a      	bset	_PC_ODR,#1
3343  00f6 7214500a      	bset	_PC_ODR,#2
3346  00fa 7216500a      	bset	_PC_ODR,#3
3349  00fe 7218500a      	bset	_PC_ODR,#4
3352  0102 72145000      	bset	_PA_ODR,#2
3353                     ; 136                 disp_text_up("CALI");
3356  0106 4b00          	push	#0
3357  0108 ae00df        	ldw	x,#L7712
3358  010b cd0000        	call	_disp_text
3360  010e 84            	pop	a
3361                     ; 137                 return;
3363  010f ac740674      	jpf	L04
3364  0113               L5712:
3365                     ; 140             switch (net_state)
3367  0113 c60000        	ld	a,_net_state
3369                     ; 158                 break;
3370  0116 4d            	tnz	a
3371  0117 2720          	jreq	L7212
3372  0119 4a            	dec	a
3373  011a 271d          	jreq	L7212
3374  011c 4a            	dec	a
3375  011d 2714          	jreq	L5212
3376  011f 4a            	dec	a
3377  0120 270b          	jreq	L3212
3378  0122 4a            	dec	a
3379  0123 272e          	jreq	L3312
3380  0125 4a            	dec	a
3381  0126 271e          	jreq	L1312
3382  0128 4a            	dec	a
3383  0129 271b          	jreq	L1312
3384  012b 203a          	jra	L3022
3385  012d               L3212:
3386                     ; 142             case NET_STATE_CLOUD:
3386                     ; 143                 CLEAR_LED_NET;
3388  012d 72145000      	bset	_PA_ODR,#2
3389                     ; 144                 break;
3391  0131 2034          	jra	L3022
3392  0133               L5212:
3393                     ; 145             case NET_STATE_LOCAL:
3393                     ; 146                 SET_LED_NET;
3395  0133 72155000      	bres	_PA_ODR,#2
3396                     ; 147                 break;
3398  0137 202e          	jra	L3022
3399  0139               L7212:
3400                     ; 148             case NET_STATE_UNKNOWN:
3400                     ; 149             case NET_STATE_OFFLINE:
3400                     ; 150                 disp_alternant_net(100, 200);
3402  0139 ae00c8        	ldw	x,#200
3403  013c 89            	pushw	x
3404  013d ae0064        	ldw	x,#100
3405  0140 cd0000        	call	_disp_alternant_net
3407  0143 85            	popw	x
3408                     ; 151                 break;
3410  0144 2021          	jra	L3022
3411  0146               L1312:
3412                     ; 152             case NET_STATE_UAP:
3412                     ; 153             case NET_STATE_UNPROV:
3412                     ; 154                 disp_alternant_net(200, 800);
3414  0146 ae0320        	ldw	x,#800
3415  0149 89            	pushw	x
3416  014a ae00c8        	ldw	x,#200
3417  014d cd0000        	call	_disp_alternant_net
3419  0150 85            	popw	x
3420                     ; 155                 break;
3422  0151 2014          	jra	L3022
3423  0153               L3312:
3424                     ; 156             case NET_STATE_UPDATING:
3424                     ; 157                 disp_alternant2_net(100, 200, 100, 800);
3426  0153 ae0320        	ldw	x,#800
3427  0156 89            	pushw	x
3428  0157 ae0064        	ldw	x,#100
3429  015a 89            	pushw	x
3430  015b ae00c8        	ldw	x,#200
3431  015e 89            	pushw	x
3432  015f ae0064        	ldw	x,#100
3433  0162 cd0000        	call	_disp_alternant2_net
3435  0165 5b06          	addw	sp,#6
3436                     ; 158                 break;
3438  0167               L3022:
3439                     ; 161             if (runmode == RUN_MODE_LOCK)
3441  0167 b600          	ld	a,_runmode
3442  0169 a105          	cp	a,#5
3443  016b 2619          	jrne	L5022
3444                     ; 163                 CLEAR_LED_MODE;
3446  016d 7214500a      	bset	_PC_ODR,#2
3449  0171 7216500a      	bset	_PC_ODR,#3
3452  0175 7218500a      	bset	_PC_ODR,#4
3453                     ; 164                 disp_text_up("LOCK");
3456  0179 4b00          	push	#0
3457  017b ae00da        	ldw	x,#L7022
3458  017e cd0000        	call	_disp_text
3460  0181 84            	pop	a
3461                     ; 165                 break;
3463  0182 ac740674      	jpf	L7542
3464  0186               L5022:
3465                     ; 167             if (userstate == USER_STATE_TICK)
3467  0186 c60000        	ld	a,_userstate
3468  0189 a106          	cp	a,#6
3469  018b 261e          	jrne	L1122
3470                     ; 169                 display_cnt = 0;
3472  018d 5f            	clrw	x
3473  018e cf0008        	ldw	_display_cnt,x
3474                     ; 170                 disp_matrix_up(lib_start);
3476  0191 4b00          	push	#0
3477  0193 ae0000        	ldw	x,#L7671_lib_start
3478  0196 cd0000        	call	_disp_matrix
3480  0199 84            	pop	a
3481                     ; 171                 disp_d_down(3 - state_sec);
3483  019a 4b01          	push	#1
3484  019c ae0003        	ldw	x,#3
3485  019f 72b00000      	subw	x,_state_sec
3486  01a3 cd0000        	call	_disp_d
3488  01a6 84            	pop	a
3489                     ; 172                 break;
3491  01a7 ac740674      	jpf	L7542
3492  01ab               L1122:
3493                     ; 174             if (userstate == USER_STATE_STOP || stepdown_flag == STEPDOWN_STOP)
3495  01ab c60000        	ld	a,_userstate
3496  01ae a103          	cp	a,#3
3497  01b0 2707          	jreq	L5122
3499  01b2 c60000        	ld	a,_stepdown_flag
3500  01b5 a102          	cp	a,#2
3501  01b7 260d          	jrne	L3122
3502  01b9               L5122:
3503                     ; 176                 disp_text_up("STOP");
3505  01b9 4b00          	push	#0
3506  01bb ae00d5        	ldw	x,#L7122
3507  01be cd0000        	call	_disp_text
3509  01c1 84            	pop	a
3510                     ; 177                 break;
3512  01c2 ac740674      	jpf	L7542
3513  01c6               L3122:
3514                     ; 179             if (has_wifi_flag(FLAG_WIFI_RESTORE))
3516  01c6 c60000        	ld	a,_commu_wifi_flag
3517  01c9 a501          	bcp	a,#1
3518  01cb 270d          	jreq	L1222
3519                     ; 181                 disp_matrix_up(lib_reset);
3521  01cd 4b00          	push	#0
3522  01cf ae0017        	ldw	x,#L1771_lib_reset
3523  01d2 cd0000        	call	_disp_matrix
3525  01d5 84            	pop	a
3526                     ; 182                 break;
3528  01d6 ac740674      	jpf	L7542
3529  01da               L1222:
3530                     ; 185             if (run_in_prog_mode == 0)
3532                     	btst	_run_in_prog_mode
3533  01df 2403          	jruge	L25
3534  01e1 cc02a2        	jp	L3222
3535  01e4               L25:
3536                     ; 187                 if (display_seg == DISPLAY_START_HINT)
3538  01e4 c60007        	ld	a,_display_seg
3539  01e7 a113          	cp	a,#19
3540  01e9 2624          	jrne	L5222
3541                     ; 189                     disp_matrix_up(lib_press);
3543  01eb 4b00          	push	#0
3544  01ed ae002e        	ldw	x,#L3771_lib_press
3545  01f0 cd0000        	call	_disp_matrix
3547  01f3 84            	pop	a
3548                     ; 190                     if (state_tick < 35)
3550  01f4 b600          	ld	a,_state_tick
3551  01f6 a123          	cp	a,#35
3552  01f8 2409          	jruge	L7222
3553                     ; 191                         disp_matrix_down(lib_rc_start);
3555  01fa 4b01          	push	#1
3556  01fc ae0045        	ldw	x,#L5771_lib_rc_start
3557  01ff cd0000        	call	_disp_matrix
3559  0202 84            	pop	a
3560  0203               L7222:
3561                     ; 192                     display_seg = DISPLAY_STEP;
3563  0203 35040007      	mov	_display_seg,#4
3564                     ; 193                     display_cnt = 0;
3566  0207 5f            	clrw	x
3567  0208 cf0008        	ldw	_display_cnt,x
3568                     ; 194                     break;
3570  020b ac740674      	jpf	L7542
3571  020f               L5222:
3572                     ; 196                 if (runmode == RUN_MODE_NEW)
3574  020f b600          	ld	a,_runmode
3575  0211 a103          	cp	a,#3
3576  0213 261a          	jrne	L1322
3577                     ; 199                     disp_text_up("NEW");
3579  0215 4b00          	push	#0
3580  0217 ae00d1        	ldw	x,#L3322
3581  021a cd0000        	call	_disp_text
3583  021d 84            	pop	a
3584                     ; 200                     disp_1f_down((uint)machine_speed_target / 3);
3586  021e 4b01          	push	#1
3587  0220 b600          	ld	a,_machine_speed_target
3588  0222 5f            	clrw	x
3589  0223 97            	ld	xl,a
3590  0224 a603          	ld	a,#3
3591  0226 62            	div	x,a
3592  0227 cd0000        	call	_disp_1f
3594  022a 84            	pop	a
3595                     ; 201                     break;
3597  022b ac740674      	jpf	L7542
3598  022f               L1322:
3599                     ; 204                 if (show_for_a_while)
3601  022f 725d0000      	tnz	L5671_show_for_a_while
3602  0233 270f          	jreq	L5322
3603                     ; 206                     if (display_cnt == 0)
3605  0235 ce0008        	ldw	x,_display_cnt
3606  0238 261b          	jrne	L1422
3607                     ; 208                         display_seg = DISPLAY_STEP;
3609  023a 35040007      	mov	_display_seg,#4
3610                     ; 209                         show_for_a_while = 0;
3612  023e 725f0000      	clr	L5671_show_for_a_while
3613  0242 2011          	jra	L1422
3614  0244               L5322:
3615                     ; 212                 else if (display_seg > DISPLAY_FOR_A_WHILE)
3617  0244 c60007        	ld	a,_display_seg
3618  0247 a10e          	cp	a,#14
3619  0249 250a          	jrult	L1422
3620                     ; 214                     display_cnt = DISPLAY_INTERVAL * 2;
3622  024b ae01f4        	ldw	x,#500
3623  024e cf0008        	ldw	_display_cnt,x
3624                     ; 215                     show_for_a_while = 1;
3626  0251 35010000      	mov	L5671_show_for_a_while,#1
3627  0255               L1422:
3628                     ; 218                 if (display_seg < DISPLAY_SIZE && display_cnt == 0)
3630  0255 c60007        	ld	a,_display_seg
3631  0258 a105          	cp	a,#5
3632  025a 243d          	jruge	L5422
3634  025c ce0008        	ldw	x,_display_cnt
3635  025f 2638          	jrne	L5422
3636                     ; 220                     DisplayDriverInitializeLED();
3638  0261 cd0000        	call	_DisplayDriverInitializeLED
3640                     ; 221                     display_cnt = DISPLAY_INTERVAL;
3642  0264 ae00fa        	ldw	x,#250
3643  0267 cf0008        	ldw	_display_cnt,x
3644  026a               L7422:
3645                     ; 224                         display_seg = (display_seg + 1) % DISPLAY_SIZE;
3647  026a c60007        	ld	a,_display_seg
3648  026d 5f            	clrw	x
3649  026e 97            	ld	xl,a
3650  026f 5c            	incw	x
3651  0270 a605          	ld	a,#5
3652  0272 cd0000        	call	c_smodx
3654  0275 9f            	ld	a,xl
3655  0276 c70007        	ld	_display_seg,a
3656                     ; 225                     } while (!(flag_disp & (1 << display_seg)));
3658  0279 c60000        	ld	a,_flag_disp
3659  027c 5f            	clrw	x
3660  027d 97            	ld	xl,a
3661  027e 1f07          	ldw	(OFST-5,sp),x
3662  0280 ae0001        	ldw	x,#1
3663  0283 c60007        	ld	a,_display_seg
3664  0286 4d            	tnz	a
3665  0287 2704          	jreq	L21
3666  0289               L41:
3667  0289 58            	sllw	x
3668  028a 4a            	dec	a
3669  028b 26fc          	jrne	L41
3670  028d               L21:
3671  028d 01            	rrwa	x,a
3672  028e 1408          	and	a,(OFST-4,sp)
3673  0290 01            	rrwa	x,a
3674  0291 1407          	and	a,(OFST-5,sp)
3675  0293 01            	rrwa	x,a
3676  0294 a30000        	cpw	x,#0
3677  0297 27d1          	jreq	L7422
3678  0299               L5422:
3679                     ; 228                 display_cnt--;
3681  0299 ce0008        	ldw	x,_display_cnt
3682  029c 1d0001        	subw	x,#1
3683  029f cf0008        	ldw	_display_cnt,x
3684  02a2               L3222:
3685                     ; 231             if (display_seg == DISPLAY_TIME)
3687  02a2 725d0007      	tnz	_display_seg
3688  02a6 267c          	jrne	L5522
3689                     ; 233                 disp_text_up("TIME");
3691  02a8 4b00          	push	#0
3692  02aa ae00cc        	ldw	x,#L7522
3693  02ad cd0000        	call	_disp_text
3695  02b0 84            	pop	a
3696                     ; 235                 if (user_time_minute < 60)
3698  02b1 ce0000        	ldw	x,_user_time_minute
3699  02b4 a3003c        	cpw	x,#60
3700  02b7 240c          	jruge	L1622
3701                     ; 237                     digit_left = user_time_minute;
3703  02b9 c60001        	ld	a,_user_time_minute+1
3704  02bc 6b0a          	ld	(OFST-2,sp),a
3705                     ; 238                     digit_right = user_time_second;
3707  02be c60000        	ld	a,_user_time_second
3708  02c1 6b09          	ld	(OFST-3,sp),a
3710  02c3 2015          	jra	L3622
3711  02c5               L1622:
3712                     ; 242                     digit_left = user_time_minute / 60;
3714  02c5 ce0000        	ldw	x,_user_time_minute
3715  02c8 a63c          	ld	a,#60
3716  02ca 62            	div	x,a
3717  02cb 01            	rrwa	x,a
3718  02cc 6b0a          	ld	(OFST-2,sp),a
3719  02ce 02            	rlwa	x,a
3720                     ; 243                     digit_right = user_time_minute % 60;
3722  02cf ce0000        	ldw	x,_user_time_minute
3723  02d2 a63c          	ld	a,#60
3724  02d4 62            	div	x,a
3725  02d5 5f            	clrw	x
3726  02d6 97            	ld	xl,a
3727  02d7 9f            	ld	a,xl
3728  02d8 6b09          	ld	(OFST-3,sp),a
3729  02da               L3622:
3730                     ; 246                 if (digit_left > 99)
3732  02da 7b0a          	ld	a,(OFST-2,sp)
3733  02dc a164          	cp	a,#100
3734  02de 2504          	jrult	L5622
3735                     ; 248                     digit_left = 99; //the largest time is 99 hours
3737  02e0 a663          	ld	a,#99
3738  02e2 6b0a          	ld	(OFST-2,sp),a
3739  02e4               L5622:
3740                     ; 250                 if (user_time_minute > 59 && state_tick > 25)
3742  02e4 ce0000        	ldw	x,_user_time_minute
3743  02e7 a3003c        	cpw	x,#60
3744  02ea 251f          	jrult	L7622
3746  02ec b600          	ld	a,_state_tick
3747  02ee a11a          	cp	a,#26
3748  02f0 2519          	jrult	L7622
3749                     ; 252                     disp_custom(LED_DOWN, "%d %02d", (uint)digit_left, (uint)digit_right);
3751  02f2 7b09          	ld	a,(OFST-3,sp)
3752  02f4 5f            	clrw	x
3753  02f5 97            	ld	xl,a
3754  02f6 89            	pushw	x
3755  02f7 7b0c          	ld	a,(OFST+0,sp)
3756  02f9 5f            	clrw	x
3757  02fa 97            	ld	xl,a
3758  02fb 89            	pushw	x
3759  02fc ae00c4        	ldw	x,#L1722
3760  02ff 89            	pushw	x
3761  0300 a601          	ld	a,#1
3762  0302 cd0000        	call	_disp_custom
3764  0305 5b06          	addw	sp,#6
3766  0307 ac740674      	jpf	L7542
3767  030b               L7622:
3768                     ; 256                     disp_custom(LED_DOWN, "%d:%02d", (uint)digit_left, (uint)digit_right);
3770  030b 7b09          	ld	a,(OFST-3,sp)
3771  030d 5f            	clrw	x
3772  030e 97            	ld	xl,a
3773  030f 89            	pushw	x
3774  0310 7b0c          	ld	a,(OFST+0,sp)
3775  0312 5f            	clrw	x
3776  0313 97            	ld	xl,a
3777  0314 89            	pushw	x
3778  0315 ae00bc        	ldw	x,#L5722
3779  0318 89            	pushw	x
3780  0319 a601          	ld	a,#1
3781  031b cd0000        	call	_disp_custom
3783  031e 5b06          	addw	sp,#6
3784  0320 ac740674      	jpf	L7542
3785  0324               L5522:
3786                     ; 259             else if (display_seg == DISPLAY_SPEED || display_seg == DISPLAY_SPEED_TEMP)
3788  0324 c60007        	ld	a,_display_seg
3789  0327 a101          	cp	a,#1
3790  0329 2707          	jreq	L3032
3792  032b c60007        	ld	a,_display_seg
3793  032e a112          	cp	a,#18
3794  0330 2634          	jrne	L1032
3795  0332               L3032:
3796                     ; 261                 disp_text_up("SPD");
3798  0332 4b00          	push	#0
3799  0334 ae00b8        	ldw	x,#L5032
3800  0337 cd0000        	call	_disp_text
3802  033a 84            	pop	a
3803                     ; 263                 if (runmode == RUN_MODE_FIXED && userstate == USER_STATE_RUN)
3805  033b b600          	ld	a,_runmode
3806  033d a101          	cp	a,#1
3807  033f 2610          	jrne	L7032
3809  0341 c60000        	ld	a,_userstate
3810  0344 a101          	cp	a,#1
3811  0346 2609          	jrne	L7032
3812                     ; 265                     digit_int = fixed_mode_speed;
3814  0348 c60000        	ld	a,_fixed_mode_speed
3815  034b 5f            	clrw	x
3816  034c 97            	ld	xl,a
3817  034d 1f0b          	ldw	(OFST-1,sp),x
3819  034f 2006          	jra	L1132
3820  0351               L7032:
3821                     ; 269                     digit_int = machine_speed_target;
3823  0351 b600          	ld	a,_machine_speed_target
3824  0353 5f            	clrw	x
3825  0354 97            	ld	xl,a
3826  0355 1f0b          	ldw	(OFST-1,sp),x
3827  0357               L1132:
3828                     ; 271                 disp_1f_down(digit_int / 3);
3830  0357 4b01          	push	#1
3831  0359 1e0c          	ldw	x,(OFST+0,sp)
3832  035b a603          	ld	a,#3
3833  035d 62            	div	x,a
3834  035e cd0000        	call	_disp_1f
3836  0361 84            	pop	a
3838  0362 ac740674      	jpf	L7542
3839  0366               L1032:
3840                     ; 273             else if (display_seg == DISPLAY_DIST)
3842  0366 c60007        	ld	a,_display_seg
3843  0369 a102          	cp	a,#2
3844  036b 2615          	jrne	L5132
3845                     ; 275                 disp_text_up("KM");
3847  036d 4b00          	push	#0
3848  036f ae00b5        	ldw	x,#L7132
3849  0372 cd0000        	call	_disp_text
3851  0375 84            	pop	a
3852                     ; 276                 disp_2f(user_distance, LED_DOWN);
3854  0376 4b01          	push	#1
3855  0378 be00          	ldw	x,_user_distance
3856  037a cd0000        	call	_disp_2f
3858  037d 84            	pop	a
3860  037e ac740674      	jpf	L7542
3861  0382               L5132:
3862                     ; 278             else if (display_seg == DISPLAY_CAL)
3864  0382 c60007        	ld	a,_display_seg
3865  0385 a103          	cp	a,#3
3866  0387 2658          	jrne	L3232
3867                     ; 280                 disp_text_up("CAL");
3869  0389 4b00          	push	#0
3870  038b ae00b1        	ldw	x,#L5232
3871  038e cd0000        	call	_disp_text
3873  0391 84            	pop	a
3874                     ; 282                 if (user_calories < 100000)
3876  0392 ae0000        	ldw	x,#_user_calories
3877  0395 cd0000        	call	c_ltor
3879  0398 ae005e        	ldw	x,#L61
3880  039b cd0000        	call	c_lcmp
3882  039e 2418          	jruge	L7232
3883                     ; 284                     disp_1f_down((uint)(user_calories / 10));
3885  03a0 4b01          	push	#1
3886  03a2 ae0000        	ldw	x,#_user_calories
3887  03a5 cd0000        	call	c_ltor
3889  03a8 ae0062        	ldw	x,#L02
3890  03ab cd0000        	call	c_ludv
3892  03ae be02          	ldw	x,c_lreg+2
3893  03b0 cd0000        	call	_disp_1f
3895  03b3 84            	pop	a
3897  03b4 ac740674      	jpf	L7542
3898  03b8               L7232:
3899                     ; 286                 else if (user_calories < 1000000)
3901  03b8 ae0000        	ldw	x,#_user_calories
3902  03bb cd0000        	call	c_ltor
3904  03be ae0066        	ldw	x,#L22
3905  03c1 cd0000        	call	c_lcmp
3907  03c4 2503          	jrult	L45
3908  03c6 cc0674        	jp	L7542
3909  03c9               L45:
3910                     ; 288                     disp_d_down((uint)(user_calories / 100));
3912  03c9 4b01          	push	#1
3913  03cb ae0000        	ldw	x,#_user_calories
3914  03ce cd0000        	call	c_ltor
3916  03d1 ae006a        	ldw	x,#L42
3917  03d4 cd0000        	call	c_ludv
3919  03d7 be02          	ldw	x,c_lreg+2
3920  03d9 cd0000        	call	_disp_d
3922  03dc 84            	pop	a
3923  03dd ac740674      	jpf	L7542
3924  03e1               L3232:
3925                     ; 291             else if (display_seg == DISPLAY_STEP)
3927  03e1 c60007        	ld	a,_display_seg
3928  03e4 a104          	cp	a,#4
3929  03e6 2629          	jrne	L7332
3930                     ; 293                 disp_text_up("STEP");
3932  03e8 4b00          	push	#0
3933  03ea ae00ac        	ldw	x,#L1432
3934  03ed cd0000        	call	_disp_text
3936  03f0 84            	pop	a
3937                     ; 294                 disp_d_down(user_steps_total < 10000 ? user_steps_total : user_steps_total % 10000);
3939  03f1 4b01          	push	#1
3940  03f3 ce0000        	ldw	x,_user_steps_total
3941  03f6 a32710        	cpw	x,#10000
3942  03f9 2405          	jruge	L62
3943  03fb ce0000        	ldw	x,_user_steps_total
3944  03fe 2009          	jra	L03
3945  0400               L62:
3946  0400 ce0000        	ldw	x,_user_steps_total
3947  0403 90ae2710      	ldw	y,#10000
3948  0407 65            	divw	x,y
3949  0408 51            	exgw	x,y
3950  0409               L03:
3951  0409 cd0000        	call	_disp_d
3953  040c 84            	pop	a
3955  040d ac740674      	jpf	L7542
3956  0411               L7332:
3957                     ; 296             else if (display_seg == DISPLAY_CUR_VOL)
3959  0411 c60007        	ld	a,_display_seg
3960  0414 a110          	cp	a,#16
3961  0416 261a          	jrne	L5432
3962                     ; 298                 disp_1f_up((uint)machine_current_motor);
3964  0418 4b00          	push	#0
3965  041a c60000        	ld	a,_machine_current_motor
3966  041d 5f            	clrw	x
3967  041e 97            	ld	xl,a
3968  041f cd0000        	call	_disp_1f
3970  0422 84            	pop	a
3971                     ; 299                 disp_d_down((uint)machine_volt_motor);
3973  0423 4b01          	push	#1
3974  0425 c60000        	ld	a,_machine_volt_motor
3975  0428 5f            	clrw	x
3976  0429 97            	ld	xl,a
3977  042a cd0000        	call	_disp_d
3979  042d 84            	pop	a
3981  042e ac740674      	jpf	L7542
3982  0432               L5432:
3983                     ; 301             else if (display_seg == DISPLAY_SENSOR)
3985  0432 c60007        	ld	a,_display_seg
3986  0435 a111          	cp	a,#17
3987  0437 2636          	jrne	L1532
3988                     ; 303                 disp_ld(tension / 100, LED_UP);
3990  0439 4b00          	push	#0
3991  043b ae0000        	ldw	x,#_tension
3992  043e cd0000        	call	c_ltor
3994  0441 ae006a        	ldw	x,#L42
3995  0444 cd0000        	call	c_ludv
3997  0447 be02          	ldw	x,c_lreg+2
3998  0449 89            	pushw	x
3999  044a be00          	ldw	x,c_lreg
4000  044c 89            	pushw	x
4001  044d cd0000        	call	_disp_ld
4003  0450 5b05          	addw	sp,#5
4004                     ; 304                 disp_ld(tension2 / 100, LED_DOWN);
4006  0452 4b01          	push	#1
4007  0454 ae0000        	ldw	x,#_tension2
4008  0457 cd0000        	call	c_ltor
4010  045a ae006a        	ldw	x,#L42
4011  045d cd0000        	call	c_ludv
4013  0460 be02          	ldw	x,c_lreg+2
4014  0462 89            	pushw	x
4015  0463 be00          	ldw	x,c_lreg
4016  0465 89            	pushw	x
4017  0466 cd0000        	call	_disp_ld
4019  0469 5b05          	addw	sp,#5
4021  046b ac740674      	jpf	L7542
4022  046f               L1532:
4023                     ; 306             else if (display_seg == DISPLAY_PROG_F1)
4025  046f c60007        	ld	a,_display_seg
4026  0472 a106          	cp	a,#6
4027  0474 2618          	jrne	L5532
4028                     ; 308                 disp_text_up("F1");
4030  0476 4b00          	push	#0
4031  0478 ae00a9        	ldw	x,#L7532
4032  047b cd0000        	call	_disp_text
4034  047e 84            	pop	a
4035                     ; 309                 disp_d_down((int)dc_motor_rating_f1);
4037  047f 4b01          	push	#1
4038  0481 c60000        	ld	a,_dc_motor_rating_f1
4039  0484 5f            	clrw	x
4040  0485 97            	ld	xl,a
4041  0486 cd0000        	call	_disp_d
4043  0489 84            	pop	a
4045  048a ac740674      	jpf	L7542
4046  048e               L5532:
4047                     ; 311             else if (display_seg == DISPLAY_PROG_F2)
4049  048e c60007        	ld	a,_display_seg
4050  0491 a107          	cp	a,#7
4051  0493 2618          	jrne	L3632
4052                     ; 313                 disp_text_up("F2");
4054  0495 4b00          	push	#0
4055  0497 ae00a6        	ldw	x,#L5632
4056  049a cd0000        	call	_disp_text
4058  049d 84            	pop	a
4059                     ; 314                 disp_d_down((int)dc_motor_startup_volt);
4061  049e 4b01          	push	#1
4062  04a0 c60000        	ld	a,_dc_motor_startup_volt
4063  04a3 5f            	clrw	x
4064  04a4 97            	ld	xl,a
4065  04a5 cd0000        	call	_disp_d
4067  04a8 84            	pop	a
4069  04a9 ac740674      	jpf	L7542
4070  04ad               L3632:
4071                     ; 316             else if (display_seg == DISPLAY_PROG_F3)
4073  04ad c60007        	ld	a,_display_seg
4074  04b0 a108          	cp	a,#8
4075  04b2 2618          	jrne	L1732
4076                     ; 318                 disp_text_up("F3");
4078  04b4 4b00          	push	#0
4079  04b6 ae00a3        	ldw	x,#L3732
4080  04b9 cd0000        	call	_disp_text
4082  04bc 84            	pop	a
4083                     ; 319                 disp_d_down((int)dc_motor_rating_volt);
4085  04bd 4b01          	push	#1
4086  04bf c60000        	ld	a,_dc_motor_rating_volt
4087  04c2 5f            	clrw	x
4088  04c3 97            	ld	xl,a
4089  04c4 cd0000        	call	_disp_d
4091  04c7 84            	pop	a
4093  04c8 ac740674      	jpf	L7542
4094  04cc               L1732:
4095                     ; 321             else if (display_seg == DISPLAY_PROG_MAX || display_seg == DISPLAY_LIMIT)
4097  04cc c60007        	ld	a,_display_seg
4098  04cf a109          	cp	a,#9
4099  04d1 2707          	jreq	L1042
4101  04d3 c60007        	ld	a,_display_seg
4102  04d6 a10f          	cp	a,#15
4103  04d8 261b          	jrne	L7732
4104  04da               L1042:
4105                     ; 323                 disp_text_up("MAX");
4107  04da 4b00          	push	#0
4108  04dc ae009f        	ldw	x,#L3042
4109  04df cd0000        	call	_disp_text
4111  04e2 84            	pop	a
4112                     ; 324                 disp_1f_down((uint)(speed_limit_max / 3));
4114  04e3 4b01          	push	#1
4115  04e5 c60000        	ld	a,_speed_limit_max
4116  04e8 5f            	clrw	x
4117  04e9 97            	ld	xl,a
4118  04ea a603          	ld	a,#3
4119  04ec 62            	div	x,a
4120  04ed cd0000        	call	_disp_1f
4122  04f0 84            	pop	a
4124  04f1 ac740674      	jpf	L7542
4125  04f5               L7732:
4126                     ; 326             else if (display_seg == DISPLAY_PROG_FACT)
4128  04f5 c60007        	ld	a,_display_seg
4129  04f8 a10a          	cp	a,#10
4130  04fa 2634          	jrne	L7042
4131                     ; 328                 disp_text_up("FACT");
4133  04fc 4b00          	push	#0
4134  04fe ae009a        	ldw	x,#L1142
4135  0501 cd0000        	call	_disp_text
4137  0504 84            	pop	a
4138                     ; 329                 if (show_factory_mode == 0)
4140                     	btst	_show_factory_mode
4141  050a 250d          	jrult	L3142
4142                     ; 331                     disp_text_down("OFF");
4144  050c 4b01          	push	#1
4145  050e ae0096        	ldw	x,#L5142
4146  0511 cd0000        	call	_disp_text
4148  0514 84            	pop	a
4150  0515 ac740674      	jpf	L7542
4151  0519               L3142:
4152                     ; 333                 else if (show_factory_mode == 1)
4154                     	btst	_show_factory_mode
4155  051e 2503          	jrult	L65
4156  0520 cc0674        	jp	L7542
4157  0523               L65:
4158                     ; 335                     disp_text_down("ON");
4160  0523 4b01          	push	#1
4161  0525 ae0093        	ldw	x,#L3242
4162  0528 cd0000        	call	_disp_text
4164  052b 84            	pop	a
4165  052c ac740674      	jpf	L7542
4166  0530               L7042:
4167                     ; 339             else if (display_seg == DISPLAY_PROG_VERSION)
4169  0530 c60007        	ld	a,_display_seg
4170  0533 a10b          	cp	a,#11
4171  0535 2617          	jrne	L7242
4172                     ; 341                 disp_d_down((uint)power_board_version);
4174  0537 4b01          	push	#1
4175  0539 b600          	ld	a,_power_board_version
4176  053b 5f            	clrw	x
4177  053c 97            	ld	xl,a
4178  053d cd0000        	call	_disp_d
4180  0540 84            	pop	a
4181                     ; 342                 disp_text_up(FW_VERSION);
4183  0541 4b00          	push	#0
4184  0543 ce0000        	ldw	x,_FW_VERSION
4185  0546 cd0000        	call	_disp_text
4187  0549 84            	pop	a
4189  054a ac740674      	jpf	L7542
4190  054e               L7242:
4191                     ; 344             else if (display_seg == DISPLAY_GOAL)
4193  054e c60007        	ld	a,_display_seg
4194  0551 a10e          	cp	a,#14
4195  0553 2703          	jreq	L06
4196  0555 cc0674        	jp	L7542
4197  0558               L06:
4198                     ; 346                 disp_text_up("GOAL");
4200  0558 4b00          	push	#0
4201  055a ae008e        	ldw	x,#L5342
4202  055d cd0000        	call	_disp_text
4204  0560 84            	pop	a
4205                     ; 347                 disp_text_down("DONE");
4207  0561 4b01          	push	#1
4208  0563 ae0089        	ldw	x,#L7342
4209  0566 cd0000        	call	_disp_text
4211  0569 84            	pop	a
4212  056a ac740674      	jpf	L7542
4213  056e               L5312:
4214                     ; 350         case USER_STATE_SLEEP: //no display
4214                     ; 351             if (runmode == RUN_MODE_STANDBY)
4216  056e b600          	ld	a,_runmode
4217  0570 a102          	cp	a,#2
4218  0572 260c          	jrne	L1442
4219                     ; 353                 SET_LED_STANDBY;
4221  0574 7215500a      	bres	_PC_ODR,#2
4224  0578 7216500a      	bset	_PC_ODR,#3
4227  057c 7218500a      	bset	_PC_ODR,#4
4229  0580               L1442:
4230                     ; 355             if (state_sec == 1)
4232  0580 be00          	ldw	x,_state_sec
4233  0582 a30001        	cpw	x,#1
4234  0585 2703          	jreq	L26
4235  0587 cc0674        	jp	L7542
4236  058a               L26:
4237                     ; 357                 CLEAR_LED_NET;
4239  058a 72145000      	bset	_PA_ODR,#2
4240                     ; 358                 CLEAR_LED_ERROR;
4242  058e 7212500a      	bset	_PC_ODR,#1
4243  0592 ac740674      	jpf	L7542
4244  0596               L7312:
4245                     ; 361         case USER_STATE_FAULT:
4245                     ; 362             disp_custom(LED_UP, "E%02d", (uint)error_id);
4247  0596 b600          	ld	a,_error_id
4248  0598 5f            	clrw	x
4249  0599 97            	ld	xl,a
4250  059a 89            	pushw	x
4251  059b ae0083        	ldw	x,#L5442
4252  059e 89            	pushw	x
4253  059f 4f            	clr	a
4254  05a0 cd0000        	call	_disp_custom
4256  05a3 5b04          	addw	sp,#4
4257                     ; 363             CLEAR_LED_MODE;
4259  05a5 7214500a      	bset	_PC_ODR,#2
4262  05a9 7216500a      	bset	_PC_ODR,#3
4265  05ad 7218500a      	bset	_PC_ODR,#4
4266                     ; 364             SET_LED_ERROR;
4269  05b1 7213500a      	bres	_PC_ODR,#1
4270                     ; 365             if (error_id == 8)
4272  05b5 b600          	ld	a,_error_id
4273  05b7 a108          	cp	a,#8
4274  05b9 2607          	jrne	L7442
4275                     ; 366                 set_runmode_led();
4277  05bb cd000d        	call	L7402_set_runmode_led
4280  05be ac740674      	jpf	L7542
4281  05c2               L7442:
4282                     ; 367             else if (error_id == 10 || error_id == 11)
4284  05c2 b600          	ld	a,_error_id
4285  05c4 a10a          	cp	a,#10
4286  05c6 2709          	jreq	L5542
4288  05c8 b600          	ld	a,_error_id
4289  05ca a10b          	cp	a,#11
4290  05cc 2703          	jreq	L46
4291  05ce cc0674        	jp	L7542
4292  05d1               L46:
4293  05d1               L5542:
4294                     ; 369                 digit_int = (30 - (error_id - 10) * 20) * 60ul + (uint)(error_time - server_time - clock() / CLOCKS_PER_SEC);
4296  05d1 cd0000        	call	_clock
4298  05d4 ae006e        	ldw	x,#L23
4299  05d7 cd0000        	call	c_ludv
4301  05da 96            	ldw	x,sp
4302  05db 1c0005        	addw	x,#OFST-7
4303  05de cd0000        	call	c_rtol
4305  05e1 ce0002        	ldw	x,_error_time+2
4306  05e4 72b00002      	subw	x,_server_time+2
4307  05e8 cd0000        	call	c_uitolx
4309  05eb 96            	ldw	x,sp
4310  05ec 1c0005        	addw	x,#OFST-7
4311  05ef cd0000        	call	c_lsub
4313  05f2 be02          	ldw	x,c_lreg+2
4314  05f4 1f03          	ldw	(OFST-9,sp),x
4315  05f6 b600          	ld	a,_error_id
4316  05f8 97            	ld	xl,a
4317  05f9 a614          	ld	a,#20
4318  05fb 42            	mul	x,a
4319  05fc 1f01          	ldw	(OFST-11,sp),x
4320  05fe ae00e6        	ldw	x,#230
4321  0601 72f001        	subw	x,(OFST-11,sp)
4322  0604 90ae003c      	ldw	y,#60
4323  0608 cd0000        	call	c_imul
4325  060b 72fb03        	addw	x,(OFST-9,sp)
4326  060e 1f0b          	ldw	(OFST-1,sp),x
4327                     ; 370                 disp_custom(LED_DOWN, "%d:%02d", digit_int / 60, digit_int % 60);
4329  0610 1e0b          	ldw	x,(OFST-1,sp)
4330  0612 a63c          	ld	a,#60
4331  0614 62            	div	x,a
4332  0615 5f            	clrw	x
4333  0616 97            	ld	xl,a
4334  0617 89            	pushw	x
4335  0618 1e0d          	ldw	x,(OFST+1,sp)
4336  061a a63c          	ld	a,#60
4337  061c 62            	div	x,a
4338  061d 89            	pushw	x
4339  061e ae00bc        	ldw	x,#L5722
4340  0621 89            	pushw	x
4341  0622 a601          	ld	a,#1
4342  0624 cd0000        	call	_disp_custom
4344  0627 5b06          	addw	sp,#6
4345  0629 2049          	jra	L7542
4346  062b               L3712:
4347                     ; 372             break;
4348  062b 2047          	jra	L7542
4349  062d               L7612:
4350                     ; 378         if (waiting_cnt == DISPLAY_ALL_ON_DELAY)
4352  062d b600          	ld	a,_waiting_cnt
4353  062f a196          	cp	a,#150
4354  0631 2605          	jrne	L1642
4355                     ; 380             beep(BEEP_KEY);
4357  0633 a601          	ld	a,#1
4358  0635 cd0000        	call	_beep
4360  0638               L1642:
4361                     ; 383         disp_text_up("WAIT");
4363  0638 4b00          	push	#0
4364  063a ae007e        	ldw	x,#L3642
4365  063d cd0000        	call	_disp_text
4367  0640 84            	pop	a
4368                     ; 385         if (waiting_cnt > 0) //set with the waiting variable
4370  0641 3d00          	tnz	_waiting_cnt
4371  0643 2704          	jreq	L5642
4372                     ; 387             waiting_cnt--;
4374  0645 3a00          	dec	_waiting_cnt
4376  0647 2004          	jra	L7642
4377  0649               L5642:
4378                     ; 391             waiting = 0;
4380  0649 72110000      	bres	_waiting
4381  064d               L7642:
4382                     ; 394         digit_int = LED_DOWN_SIZE * (uint)(DISPLAY_ALL_ON_DELAY - waiting_cnt) / DISPLAY_ALL_ON_DELAY;
4384  064d a600          	ld	a,#0
4385  064f 97            	ld	xl,a
4386  0650 a696          	ld	a,#150
4387  0652 b000          	sub	a,_waiting_cnt
4388  0654 2401          	jrnc	L43
4389  0656 5a            	decw	x
4390  0657               L43:
4391  0657 02            	rlwa	x,a
4392  0658 90ae0019      	ldw	y,#25
4393  065c cd0000        	call	c_imul
4395  065f a696          	ld	a,#150
4396  0661 62            	div	x,a
4397  0662 1f0b          	ldw	(OFST-1,sp),x
4398                     ; 395         if (digit_int > 0)
4400  0664 1e0b          	ldw	x,(OFST-1,sp)
4401  0666 270c          	jreq	L7542
4402                     ; 396             memset(images[LED_DOWN], (char)0x18, digit_int);
4404  0668 a618          	ld	a,#24
4405  066a 1e0b          	ldw	x,(OFST-1,sp)
4406  066c               L63:
4407  066c 5a            	decw	x
4408  066d 72d70002      	ld	([_images+2.w],x),a
4409  0671 5d            	tnzw	x
4410  0672 26f8          	jrne	L63
4411  0674               L7542:
4412                     ; 399 }
4413  0674               L04:
4416  0674 5b0c          	addw	sp,#12
4417  0676 81            	ret
4459                     ; 401 void UserConsumerKeys(void)
4459                     ; 402 {
4460                     	switch	.text
4461  0677               _UserConsumerKeys:
4465                     ; 406     check_key_id();
4467  0677 cd0000        	call	_check_key_id
4469                     ; 408     if (key_id != KEY_NONE && key_id_done == 0 && waiting == 0) //&& error_id==0
4471  067a be00          	ldw	x,_key_id
4472  067c 2603          	jrne	L27
4473  067e cc08c0        	jp	L3352
4474  0681               L27:
4476                     	btst	_key_id_done
4477  0686 2403          	jruge	L47
4478  0688 cc08c0        	jp	L3352
4479  068b               L47:
4481                     	btst	_waiting
4482  0690 2403          	jruge	L67
4483  0692 cc08c0        	jp	L3352
4484  0695               L67:
4485                     ; 410         key_id_done = 1;
4487  0695 72100000      	bset	_key_id_done
4488                     ; 411         button_id = key_id;
4490  0699 be00          	ldw	x,_key_id
4491  069b cf0000        	ldw	_button_id,x
4492                     ; 412         if (stepdown_flag == STEPDOWN_NONE)
4494  069e 725d0000      	tnz	_stepdown_flag
4495  06a2 2703          	jreq	L001
4496  06a4 cc08c0        	jp	L3352
4497  06a7               L001:
4498                     ; 414             switch (key_id)
4500  06a7 be00          	ldw	x,_key_id
4502                     ; 551                     fixed_mode_speed = 120;
4503  06a9 5a            	decw	x
4504  06aa 2751          	jreq	L3742
4505  06ac 5a            	decw	x
4506  06ad 2603          	jrne	L201
4507  06af cc073c        	jp	L5742
4508  06b2               L201:
4509  06b2 5a            	decw	x
4510  06b3 2603          	jrne	L401
4511  06b5 cc0804        	jp	L1052
4512  06b8               L401:
4513  06b8 5a            	decw	x
4514  06b9 2603          	jrne	L601
4515  06bb cc07a1        	jp	L7742
4516  06be               L601:
4517  06be 1d000d        	subw	x,#13
4518  06c1 2603          	jrne	L011
4519  06c3 cc0885        	jp	L1152
4520  06c6               L011:
4521  06c6 1d0002        	subw	x,#2
4522  06c9 2603          	jrne	L211
4523  06cb cc088b        	jp	L3152
4524  06ce               L211:
4525  06ce 1d00ee        	subw	x,#238
4526  06d1 2603          	jrne	L411
4527  06d3 cc086b        	jp	L7052
4528  06d6               L411:
4529  06d6 1d0002        	subw	x,#2
4530  06d9 2603          	jrne	L611
4531  06db cc0829        	jp	L3052
4532  06de               L611:
4533  06de 1d000e        	subw	x,#14
4534  06e1 2603          	jrne	L021
4535  06e3 cc08a8        	jp	L1252
4536  06e6               L021:
4537  06e6 1d0eef        	subw	x,#3823
4538  06e9 2712          	jreq	L3742
4539  06eb 1d0100        	subw	x,#256
4540  06ee 2603          	jrne	L221
4541  06f0 cc083f        	jp	L5052
4542  06f3               L221:
4543  06f3 5a            	decw	x
4544  06f4 2603          	jrne	L421
4545  06f6 cc0893        	jp	L7152
4546  06f9               L421:
4547  06f9 acc008c0      	jpf	L3352
4548  06fd               L3742:
4549                     ; 416             case KEY_MODE_PRESS:
4549                     ; 417             case KEY_MODE_PRESS_BTN:
4549                     ; 418                 beep(BEEP_KEY);
4551  06fd a601          	ld	a,#1
4552  06ff cd0000        	call	_beep
4554                     ; 420                 if (runmode == RUN_MODE_STANDBY)
4556  0702 b600          	ld	a,_runmode
4557  0704 a102          	cp	a,#2
4558  0706 2611          	jrne	L3452
4559                     ; 422                     start_no_tick = 0;
4561  0708 72110001      	bres	_start_no_tick
4562                     ; 423                     runmode = eeprom_rdchar(EEPROM_ADDR_RUNMODE);
4564  070c 55400b0000    	mov	_runmode,16395
4565                     ; 424                     flag_mode_changed = 1;
4567  0711 72100000      	bset	_flag_mode_changed
4569  0715 acc008c0      	jpf	L3352
4570  0719               L3452:
4571                     ; 427                 else if (runmode == RUN_MODE_AUTO)
4573  0719 3d00          	tnz	_runmode
4574  071b 260c          	jrne	L7452
4575                     ; 429                     runmode = RUN_MODE_FIXED;
4577  071d 35010000      	mov	_runmode,#1
4578                     ; 430                     flag_mode_changed = 1;
4580  0721 72100000      	bset	_flag_mode_changed
4582  0725 acc008c0      	jpf	L3352
4583  0729               L7452:
4584                     ; 432                 else if (runmode == RUN_MODE_FIXED)
4586  0729 b600          	ld	a,_runmode
4587  072b a101          	cp	a,#1
4588  072d 2703          	jreq	L621
4589  072f cc08c0        	jp	L3352
4590  0732               L621:
4591                     ; 434                     runmode = RUN_MODE_AUTO;
4593  0732 3f00          	clr	_runmode
4594                     ; 435                     flag_mode_changed = 1;
4596  0734 72100000      	bset	_flag_mode_changed
4597  0738 acc008c0      	jpf	L3352
4598  073c               L5742:
4599                     ; 439             case KEY_UP_PRESS:
4599                     ; 440                 if (userstate == USER_STATE_SLEEP)
4601  073c c60000        	ld	a,_userstate
4602  073f a104          	cp	a,#4
4603  0741 2603          	jrne	L031
4604  0743 cc08c0        	jp	L3352
4605  0746               L031:
4606                     ; 441                     break;
4608                     ; 442                 beep(BEEP_KEY);
4610  0746 a601          	ld	a,#1
4611  0748 cd0000        	call	_beep
4613                     ; 443                 display_seg = DISPLAY_SPEED_TEMP;
4615  074b 35120007      	mov	_display_seg,#18
4616                     ; 444                 if (machine_speed_target > 0 && (runmode == RUN_MODE_FIXED || runmode == RUN_MODE_NEW))
4618  074f 3d00          	tnz	_machine_speed_target
4619  0751 2747          	jreq	L7552
4621  0753 b600          	ld	a,_runmode
4622  0755 a101          	cp	a,#1
4623  0757 2706          	jreq	L1652
4625  0759 b600          	ld	a,_runmode
4626  075b a103          	cp	a,#3
4627  075d 263b          	jrne	L7552
4628  075f               L1652:
4629                     ; 446                     fixed_mode_speed += SPEED_INC;
4631  075f c60000        	ld	a,_fixed_mode_speed
4632  0762 ab0f          	add	a,#15
4633  0764 c70000        	ld	_fixed_mode_speed,a
4634                     ; 447                     if (fixed_mode_speed > speed_limit_max)
4636  0767 c60000        	ld	a,_fixed_mode_speed
4637  076a c10000        	cp	a,_speed_limit_max
4638  076d 2309          	jrule	L3652
4639                     ; 449                         fixed_mode_speed = speed_limit_max;
4641  076f 5500000000    	mov	_fixed_mode_speed,_speed_limit_max
4642                     ; 450                         display_seg = DISPLAY_LIMIT;
4644  0774 350f0007      	mov	_display_seg,#15
4645  0778               L3652:
4646                     ; 452                     if (fixed_mode_speed % SPEED_INC != 0)
4648  0778 c60000        	ld	a,_fixed_mode_speed
4649  077b 5f            	clrw	x
4650  077c 97            	ld	xl,a
4651  077d a60f          	ld	a,#15
4652  077f cd0000        	call	c_smodx
4654  0782 a30000        	cpw	x,#0
4655  0785 2713          	jreq	L7552
4656                     ; 454                         fixed_mode_speed -= fixed_mode_speed % SPEED_INC;
4658  0787 c60000        	ld	a,_fixed_mode_speed
4659  078a ae000f        	ldw	x,#15
4660  078d 51            	exgw	x,y
4661  078e 5f            	clrw	x
4662  078f 97            	ld	xl,a
4663  0790 65            	divw	x,y
4664  0791 909f          	ld	a,yl
4665  0793 c00000        	sub	a,_fixed_mode_speed
4666  0796 40            	neg	a
4667  0797 c70000        	ld	_fixed_mode_speed,a
4668  079a               L7552:
4669                     ; 458                 key_id = KEY_NONE;
4671  079a 5f            	clrw	x
4672  079b bf00          	ldw	_key_id,x
4673                     ; 459                 break;
4675  079d acc008c0      	jpf	L3352
4676  07a1               L7742:
4677                     ; 460             case KEY_DOWN_PRESS:
4677                     ; 461                 if (userstate == USER_STATE_SLEEP)
4679  07a1 c60000        	ld	a,_userstate
4680  07a4 a104          	cp	a,#4
4681  07a6 2603          	jrne	L231
4682  07a8 cc08c0        	jp	L3352
4683  07ab               L231:
4684                     ; 462                     break;
4686                     ; 463                 beep(BEEP_KEY);
4688  07ab a601          	ld	a,#1
4689  07ad cd0000        	call	_beep
4691                     ; 464                 display_seg = DISPLAY_SPEED_TEMP;
4693  07b0 35120007      	mov	_display_seg,#18
4694                     ; 465                 if (machine_speed_target > 0 && (runmode == RUN_MODE_FIXED || runmode == RUN_MODE_NEW))
4696  07b4 3d00          	tnz	_machine_speed_target
4697  07b6 2745          	jreq	L1752
4699  07b8 b600          	ld	a,_runmode
4700  07ba a101          	cp	a,#1
4701  07bc 2706          	jreq	L3752
4703  07be b600          	ld	a,_runmode
4704  07c0 a103          	cp	a,#3
4705  07c2 2639          	jrne	L1752
4706  07c4               L3752:
4707                     ; 467                     if (fixed_mode_speed < SPEED_INC + SPEED_TARGET_MIN1)
4709  07c4 c60000        	ld	a,_fixed_mode_speed
4710  07c7 a11e          	cp	a,#30
4711  07c9 2406          	jruge	L5752
4712                     ; 469                         stepdown_flag = STEPDOWN_STOP;
4714  07cb 35020000      	mov	_stepdown_flag,#2
4716  07cf 2008          	jra	L7752
4717  07d1               L5752:
4718                     ; 473                         fixed_mode_speed -= SPEED_INC;
4720  07d1 c60000        	ld	a,_fixed_mode_speed
4721  07d4 a00f          	sub	a,#15
4722  07d6 c70000        	ld	_fixed_mode_speed,a
4723  07d9               L7752:
4724                     ; 476                     if (fixed_mode_speed % SPEED_INC != 0)
4726  07d9 c60000        	ld	a,_fixed_mode_speed
4727  07dc 5f            	clrw	x
4728  07dd 97            	ld	xl,a
4729  07de a60f          	ld	a,#15
4730  07e0 cd0000        	call	c_smodx
4732  07e3 a30000        	cpw	x,#0
4733  07e6 2715          	jreq	L1752
4734                     ; 478                         fixed_mode_speed += SPEED_INC - fixed_mode_speed % SPEED_INC;
4736  07e8 c60000        	ld	a,_fixed_mode_speed
4737  07eb ae000f        	ldw	x,#15
4738  07ee 51            	exgw	x,y
4739  07ef 5f            	clrw	x
4740  07f0 97            	ld	xl,a
4741  07f1 65            	divw	x,y
4742  07f2 909f          	ld	a,yl
4743  07f4 a00f          	sub	a,#15
4744  07f6 40            	neg	a
4745  07f7 cb0000        	add	a,_fixed_mode_speed
4746  07fa c70000        	ld	_fixed_mode_speed,a
4747  07fd               L1752:
4748                     ; 482                 key_id = KEY_NONE;
4750  07fd 5f            	clrw	x
4751  07fe bf00          	ldw	_key_id,x
4752                     ; 483                 break;
4754  0800 acc008c0      	jpf	L3352
4755  0804               L1052:
4756                     ; 484             case KEY_STOP_PRESS:
4756                     ; 485                 if (userstate == USER_STATE_SLEEP)
4758  0804 c60000        	ld	a,_userstate
4759  0807 a104          	cp	a,#4
4760  0809 2603          	jrne	L431
4761  080b cc08c0        	jp	L3352
4762  080e               L431:
4763                     ; 486                     break;
4765                     ; 487                 beep(BEEP_KEY);
4767  080e a601          	ld	a,#1
4768  0810 cd0000        	call	_beep
4770                     ; 488                 if (userstate == USER_STATE_READY)
4772  0813 725d0000      	tnz	_userstate
4773  0817 2608          	jrne	L5062
4774                     ; 490                     stepdown_flag = STEPDOWN_START;
4776  0819 35030000      	mov	_stepdown_flag,#3
4778  081d acc008c0      	jpf	L3352
4779  0821               L5062:
4780                     ; 494                     stepdown_flag = STEPDOWN_STOP;
4782  0821 35020000      	mov	_stepdown_flag,#2
4783  0825 acc008c0      	jpf	L3352
4784  0829               L3052:
4785                     ; 497             case KEY_STOP_LONG_PRESS:
4785                     ; 498                 if (userstate == USER_STATE_STOP)
4787  0829 c60000        	ld	a,_userstate
4788  082c a103          	cp	a,#3
4789  082e 2703          	jreq	L631
4790  0830 cc08c0        	jp	L3352
4791  0833               L631:
4792                     ; 500                     beep(BEEP_KEY);
4794  0833 a601          	ld	a,#1
4795  0835 cd0000        	call	_beep
4797                     ; 501                     flag_may_stuck = 1;
4799  0838 72100000      	bset	_flag_may_stuck
4800  083c cc08c0        	jra	L3352
4801  083f               L5052:
4802                     ; 504             case KEY_MODE_LONG_PRESS_BTN:
4802                     ; 505                 if (runmode == RUN_MODE_STANDBY)
4804  083f b600          	ld	a,_runmode
4805  0841 a102          	cp	a,#2
4806  0843 2626          	jrne	L7052
4807                     ; 507                     beep(BEEP_KEY_INVALID);
4809  0845 a602          	ld	a,#2
4810  0847 cd0000        	call	_beep
4812                     ; 508                     set_wifi_flag(FLAG_WIFI_RESTORE);
4814  084a 72100000      	bset	_commu_wifi_flag,#0
4815                     ; 509                     start_no_tick = 0;
4817  084e 72110001      	bres	_start_no_tick
4818                     ; 510                     runmode = eeprom_rdchar(EEPROM_ADDR_RUNMODE);
4820  0852 55400b0000    	mov	_runmode,16395
4821                     ; 511                     if (runmode == RUN_MODE_NEW)
4823  0857 b600          	ld	a,_runmode
4824  0859 a103          	cp	a,#3
4825  085b 2604          	jrne	L5162
4826                     ; 513                         runmode = RUN_MODE_FIXED;
4828  085d 35010000      	mov	_runmode,#1
4829  0861               L5162:
4830                     ; 515                     flag_mode_changed = 1;
4832  0861 72100000      	bset	_flag_mode_changed
4833                     ; 516                     GOTO_STATE(USER_STATE_READY);
4835  0865 4f            	clr	a
4836  0866 cd0000        	call	L7771_GOTO_STATE
4838                     ; 517                     break;
4840  0869 2055          	jra	L3352
4841  086b               L7052:
4842                     ; 519             case KEY_MODE_LONG_PRESS:
4842                     ; 520                 if (userstate == USER_STATE_READY)
4844  086b 725d0000      	tnz	_userstate
4845  086f 264f          	jrne	L3352
4846                     ; 522                     beep(BEEP_KEY);
4848  0871 a601          	ld	a,#1
4849  0873 cd0000        	call	_beep
4851                     ; 523                     GOTO_STATE(USER_STATE_SLEEP);
4853  0876 a604          	ld	a,#4
4854  0878 cd0000        	call	L7771_GOTO_STATE
4856                     ; 524                     runmode = RUN_MODE_STANDBY;
4858  087b 35020000      	mov	_runmode,#2
4859                     ; 525                     flag_mode_changed = 1;
4861  087f 72100000      	bset	_flag_mode_changed
4862  0883 203b          	jra	L3352
4863  0885               L1152:
4864                     ; 528             case KEY_MODE_UP_PRESS:
4864                     ; 529                 display_seg = DISPLAY_SENSOR;
4866  0885 35110007      	mov	_display_seg,#17
4867                     ; 530                 break;
4869  0889 2035          	jra	L3352
4870  088b               L3152:
4871                     ; 531             case KEY_MODE_DOWN_PRESS:
4871                     ; 532                 display_seg = DISPLAY_CUR_VOL;
4873  088b 35100007      	mov	_display_seg,#16
4874                     ; 533                 break;
4876  088f 202f          	jra	L3352
4877  0891               L5152:
4878                     ; 534             case KEY_MODE_STOP_PRESS:
4878                     ; 535                 break;
4880  0891 202d          	jra	L3352
4881  0893               L7152:
4882                     ; 537             case KEY_MODE_STOP_LONG_PRESS_BTN:
4882                     ; 538                 if (runmode < RUN_MODE_STANDBY)
4884  0893 b600          	ld	a,_runmode
4885  0895 a102          	cp	a,#2
4886  0897 2427          	jruge	L3352
4887                     ; 540                     beep(BEEP_KEY);
4889  0899 a601          	ld	a,#1
4890  089b cd0000        	call	_beep
4892                     ; 541                     run_in_prog_mode = 1;
4894  089e 72100000      	bset	_run_in_prog_mode
4895                     ; 542                     display_seg = DISPLAY_PROG_F1;
4897  08a2 35060007      	mov	_display_seg,#6
4898  08a6 2018          	jra	L3352
4899  08a8               L1252:
4900                     ; 545             case KEY_MODE_UP_LONG_PRESS:
4900                     ; 546                 if (runmode != RUN_MODE_CHECK)
4902  08a8 b600          	ld	a,_runmode
4903  08aa a104          	cp	a,#4
4904  08ac 2712          	jreq	L3352
4905                     ; 548                     beep(BEEP_KEY);
4907  08ae a601          	ld	a,#1
4908  08b0 cd0000        	call	_beep
4910                     ; 549                     runmode = RUN_MODE_CHECK;
4912  08b3 35040000      	mov	_runmode,#4
4913                     ; 550                     GOTO_STATE(USER_STATE_TICK);
4915  08b7 a606          	ld	a,#6
4916  08b9 cd0000        	call	L7771_GOTO_STATE
4918                     ; 551                     fixed_mode_speed = 120;
4920  08bc 35780000      	mov	_fixed_mode_speed,#120
4921  08c0               L1452:
4922  08c0               L3352:
4923                     ; 556 }
4926  08c0 81            	ret
5023                     	switch	.const
5024  0072               L241:
5025  0072 00000002      	dc.l	2
5026  0076               L441:
5027  0076 000009c5      	dc.l	2501
5028  007a               L051:
5029  007a 00000258      	dc.l	600
5030                     ; 567 void UserConsumerOperation(void)
5030                     ; 568 {
5031                     	switch	.text
5032  08c1               _UserConsumerOperation:
5034  08c1 520a          	subw	sp,#10
5035       0000000a      OFST:	set	10
5038                     ; 572     bias_abs = (tension_bias + tension2_bias) / 2;
5040  08c3 ae0000        	ldw	x,#_tension_bias
5041  08c6 cd0000        	call	c_ltor
5043  08c9 ae0000        	ldw	x,#_tension2_bias
5044  08cc cd0000        	call	c_ladd
5046  08cf ae0072        	ldw	x,#L241
5047  08d2 cd0000        	call	c_ldiv
5049  08d5 96            	ldw	x,sp
5050  08d6 1c0007        	addw	x,#OFST-3
5051  08d9 cd0000        	call	c_rtol
5053                     ; 574     if (flag_mode_changed == 1)
5055                     	btst	_flag_mode_changed
5056  08e1 242d          	jruge	L5662
5057                     ; 576         if (runmode != RUN_MODE_STANDBY && runmode != RUN_MODE_CHECK)
5059  08e3 b600          	ld	a,_runmode
5060  08e5 a102          	cp	a,#2
5061  08e7 271f          	jreq	L7662
5063  08e9 b600          	ld	a,_runmode
5064  08eb a104          	cp	a,#4
5065  08ed 2719          	jreq	L7662
5066                     ; 578             eeprom_wrchar(EEPROM_ADDR_RUNMODE, runmode);
5068  08ef 3b0000        	push	_runmode
5069  08f2 ae400b        	ldw	x,#16395
5070  08f5 cd0000        	call	_eeprom_wrchar
5072  08f8 84            	pop	a
5073                     ; 579             if (runmode == RUN_MODE_FIXED)
5075  08f9 b600          	ld	a,_runmode
5076  08fb a101          	cp	a,#1
5077  08fd 2609          	jrne	L7662
5078                     ; 581                 if (machine_speed_target > 0)
5080  08ff 3d00          	tnz	_machine_speed_target
5081  0901 2705          	jreq	L7662
5082                     ; 583                     fixed_mode_speed = machine_speed_target;
5084  0903 5500000000    	mov	_fixed_mode_speed,_machine_speed_target
5085  0908               L7662:
5086                     ; 587         no_current_cnt = 0;
5088  0908 725f0000      	clr	_no_current_cnt
5089                     ; 588         flag_mode_changed = 0;
5091  090c 72110000      	bres	_flag_mode_changed
5092  0910               L5662:
5093                     ; 590     ui_state = USER_STATE_READY;
5095  0910 3f00          	clr	L7571_ui_state
5096                     ; 592     if (error_id > 0 && userstate != USER_STATE_FAULT && (error_id != 8 || runmode == RUN_MODE_AUTO || flag_Gsensor_disconnected == 3 && flag_auto))
5098  0912 3d00          	tnz	_error_id
5099  0914 2732          	jreq	L5762
5101  0916 c60000        	ld	a,_userstate
5102  0919 a105          	cp	a,#5
5103  091b 272b          	jreq	L5762
5105  091d b600          	ld	a,_error_id
5106  091f a108          	cp	a,#8
5107  0921 2612          	jrne	L7762
5109  0923 3d00          	tnz	_runmode
5110  0925 270e          	jreq	L7762
5112  0927 c60000        	ld	a,_flag_Gsensor_disconnected
5113  092a a103          	cp	a,#3
5114  092c 261a          	jrne	L5762
5116                     	btst	_flag_auto
5117  0933 2413          	jruge	L5762
5118  0935               L7762:
5119                     ; 594         if (machine_speed_target > 0)
5121  0935 3d00          	tnz	_machine_speed_target
5122  0937 2706          	jreq	L3072
5123                     ; 595             stepdown_flag = STEPDOWN_STOP;
5125  0939 35020000      	mov	_stepdown_flag,#2
5127  093d 2009          	jra	L5762
5128  093f               L3072:
5129                     ; 598             stepdown_flag = STEPDOWN_NONE;
5131  093f 725f0000      	clr	_stepdown_flag
5132                     ; 599             GOTO_STATE(USER_STATE_FAULT);
5134  0943 a605          	ld	a,#5
5135  0945 cd0000        	call	L7771_GOTO_STATE
5137  0948               L5762:
5138                     ; 603     switch (userstate)
5140  0948 c60000        	ld	a,_userstate
5142                     ; 870         break;
5143  094b 4d            	tnz	a
5144  094c 276b          	jreq	L7262
5145  094e 4a            	dec	a
5146  094f 2603          	jrne	L251
5147  0951 cc0c07        	jp	L3362
5148  0954               L251:
5149  0954 4a            	dec	a
5150  0955 2603          	jrne	L451
5151  0957 cc0cb7        	jp	L5362
5152  095a               L451:
5153  095a 4a            	dec	a
5154  095b 2603          	jrne	L651
5155  095d cc0cc3        	jp	L7362
5156  0960               L651:
5157  0960 4a            	dec	a
5158  0961 2710          	jreq	L5262
5159  0963 4a            	dec	a
5160  0964 2603          	jrne	L061
5161  0966 cc0d2f        	jp	L1462
5162  0969               L061:
5163  0969 4a            	dec	a
5164  096a 2603          	jrne	L261
5165  096c cc0bc8        	jp	L1362
5166  096f               L261:
5167  096f ac630d63      	jpf	L1172
5168  0973               L5262:
5169                     ; 605     case USER_STATE_SLEEP:
5169                     ; 606         if (runmode != RUN_MODE_STANDBY)
5171  0973 b600          	ld	a,_runmode
5172  0975 a102          	cp	a,#2
5173  0977 2720          	jreq	L3172
5174                     ; 608             beep(BEEP_KEY);
5176  0979 a601          	ld	a,#1
5177  097b cd0000        	call	_beep
5179                     ; 609             start_no_tick = 0;
5181  097e 72110001      	bres	_start_no_tick
5182                     ; 610             skip_error = 0;
5184  0982 72110000      	bres	_skip_error
5185                     ; 611             if (state_sec > 10)
5187  0986 be00          	ldw	x,_state_sec
5188  0988 a3000b        	cpw	x,#11
5189  098b 2504          	jrult	L5172
5190                     ; 612                 set_wifi_flag(FLAG_WIFI_SET_TIME);
5192  098d 721c0000      	bset	_commu_wifi_flag,#6
5193  0991               L5172:
5194                     ; 613             GOTO_STATE(USER_STATE_READY);
5196  0991 4f            	clr	a
5197  0992 cd0000        	call	L7771_GOTO_STATE
5200  0995 ac630d63      	jpf	L1172
5201  0999               L3172:
5202                     ; 616         else if (state_sec == 1 && state_tick == 0)
5204  0999 be00          	ldw	x,_state_sec
5205  099b a30001        	cpw	x,#1
5206  099e 2703          	jreq	L461
5207  09a0 cc0d63        	jp	L1172
5208  09a3               L461:
5210  09a3 3d00          	tnz	_state_tick
5211  09a5 2703          	jreq	L661
5212  09a7 cc0d63        	jp	L1172
5213  09aa               L661:
5214                     ; 618             reset_data();
5216  09aa cd0000        	call	_reset_data
5218                     ; 619             skip_error = 1;
5220  09ad 72100000      	bset	_skip_error
5221                     ; 621             flag_sensor_may_reverted = 1;
5223  09b1 72100000      	bset	_flag_sensor_may_reverted
5224  09b5 ac630d63      	jpf	L1172
5225  09b9               L7262:
5226                     ; 624     case USER_STATE_READY:
5226                     ; 625         if (stepdown_flag != STEPDOWN_START)
5228  09b9 c60000        	ld	a,_stepdown_flag
5229  09bc a103          	cp	a,#3
5230  09be 2704          	jreq	L3272
5231                     ; 626             stepdown_flag = STEPDOWN_NONE;
5233  09c0 725f0000      	clr	_stepdown_flag
5234  09c4               L3272:
5235                     ; 634         if (state_sec >= TO_SLEEP_CNT_MAX || runmode == RUN_MODE_STANDBY)
5237  09c4 be00          	ldw	x,_state_sec
5238  09c6 a30258        	cpw	x,#600
5239  09c9 2406          	jruge	L7272
5241  09cb b600          	ld	a,_runmode
5242  09cd a102          	cp	a,#2
5243  09cf 2611          	jrne	L5272
5244  09d1               L7272:
5245                     ; 636             runmode = RUN_MODE_STANDBY;
5247  09d1 35020000      	mov	_runmode,#2
5248                     ; 637             flag_mode_changed = 1;
5250  09d5 72100000      	bset	_flag_mode_changed
5251                     ; 638             GOTO_STATE(USER_STATE_SLEEP);
5253  09d9 a604          	ld	a,#4
5254  09db cd0000        	call	L7771_GOTO_STATE
5257  09de ac630d63      	jpf	L1172
5258  09e2               L5272:
5259                     ; 640         else if (runmode == RUN_MODE_LOCK)
5261  09e2 b600          	ld	a,_runmode
5262  09e4 a105          	cp	a,#5
5263  09e6 2608          	jrne	L3372
5264                     ; 642             stepdown_flag = STEPDOWN_NONE;
5266  09e8 725f0000      	clr	_stepdown_flag
5267                     ; 643             break;
5269  09ec ac630d63      	jpf	L1172
5270  09f0               L3372:
5271                     ; 645         else if (stepdown_flag == STEPDOWN_START)
5273  09f0 c60000        	ld	a,_stepdown_flag
5274  09f3 a103          	cp	a,#3
5275  09f5 262f          	jrne	L7372
5276                     ; 647             stepdown_flag = STEPDOWN_NONE;
5278  09f7 725f0000      	clr	_stepdown_flag
5279                     ; 648             if (runmode == RUN_MODE_FIXED || runmode == RUN_MODE_NEW && tutorial_state < TUTORIAL_STEP3_BEGIN)
5281  09fb b600          	ld	a,_runmode
5282  09fd a101          	cp	a,#1
5283  09ff 2713          	jreq	L3472
5285  0a01 b600          	ld	a,_runmode
5286  0a03 a103          	cp	a,#3
5287  0a05 2703          	jreq	L071
5288  0a07 cc0d63        	jp	L1172
5289  0a0a               L071:
5291  0a0a c60000        	ld	a,_tutorial_state
5292  0a0d a105          	cp	a,#5
5293  0a0f 2503          	jrult	L271
5294  0a11 cc0d63        	jp	L1172
5295  0a14               L271:
5296  0a14               L3472:
5297                     ; 650                 fixed_mode_speed = fixed_start_speed;
5299  0a14 5500000000    	mov	_fixed_mode_speed,_fixed_start_speed
5300                     ; 651                 display_seg = DISPLAY_SPEED_TEMP;
5302  0a19 35120007      	mov	_display_seg,#18
5303                     ; 652                 GOTO_STATE(USER_STATE_TICK);
5305  0a1d a606          	ld	a,#6
5306  0a1f cd0000        	call	L7771_GOTO_STATE
5308  0a22 ac630d63      	jpf	L1172
5309  0a26               L7372:
5310                     ; 666         else if (bias_abs > 2500 && !flag_auto && (runmode == RUN_MODE_FIXED || runmode == RUN_MODE_NEW && tutorial_state < TUTORIAL_STEP3_BEGIN))
5312  0a26 9c            	rvf
5313  0a27 96            	ldw	x,sp
5314  0a28 1c0007        	addw	x,#OFST-3
5315  0a2b cd0000        	call	c_ltor
5317  0a2e ae0076        	ldw	x,#L441
5318  0a31 cd0000        	call	c_lcmp
5320  0a34 2f3b          	jrslt	L7472
5322                     	btst	_flag_auto
5323  0a3b 2534          	jrult	L7472
5325  0a3d b600          	ld	a,_runmode
5326  0a3f a101          	cp	a,#1
5327  0a41 270d          	jreq	L1572
5329  0a43 b600          	ld	a,_runmode
5330  0a45 a103          	cp	a,#3
5331  0a47 2628          	jrne	L7472
5333  0a49 c60000        	ld	a,_tutorial_state
5334  0a4c a105          	cp	a,#5
5335  0a4e 2421          	jruge	L7472
5336  0a50               L1572:
5337                     ; 668             if (run_in_prog_mode == 0) 
5339                     	btst	_run_in_prog_mode
5340  0a55 2403          	jruge	L471
5341  0a57 cc0d63        	jp	L1172
5342  0a5a               L471:
5343                     ; 670                 if (start_cnt > 15)
5345  0a5a c60000        	ld	a,_start_cnt
5346  0a5d a110          	cp	a,#16
5347  0a5f 2508          	jrult	L5572
5348                     ; 671                     display_seg = DISPLAY_START_HINT;
5350  0a61 35130007      	mov	_display_seg,#19
5352  0a65 ac630d63      	jpf	L1172
5353  0a69               L5572:
5354                     ; 673                     start_cnt++;
5356  0a69 725c0000      	inc	_start_cnt
5357  0a6d ac630d63      	jpf	L1172
5358  0a71               L7472:
5359                     ; 676         else if (bias_abs > 2500 // 1000 * 1000
5359                     ; 677                  && waiting == 0 && state_tick > 1 && (runmode == RUN_MODE_AUTO || (runmode == RUN_MODE_NEW && tutorial_state >= TUTORIAL_STEP3_BEGIN) || (flag_auto && runmode != RUN_MODE_NEW)))
5361  0a71 9c            	rvf
5362  0a72 96            	ldw	x,sp
5363  0a73 1c0007        	addw	x,#OFST-3
5364  0a76 cd0000        	call	c_ltor
5366  0a79 ae0076        	ldw	x,#L441
5367  0a7c cd0000        	call	c_lcmp
5369  0a7f 2f60          	jrslt	L3672
5371                     	btst	_waiting
5372  0a86 2559          	jrult	L3672
5374  0a88 b600          	ld	a,_state_tick
5375  0a8a a102          	cp	a,#2
5376  0a8c 2553          	jrult	L3672
5378  0a8e 3d00          	tnz	_runmode
5379  0a90 271a          	jreq	L5672
5381  0a92 b600          	ld	a,_runmode
5382  0a94 a103          	cp	a,#3
5383  0a96 2607          	jrne	L1772
5385  0a98 c60000        	ld	a,_tutorial_state
5386  0a9b a105          	cp	a,#5
5387  0a9d 240d          	jruge	L5672
5388  0a9f               L1772:
5390                     	btst	_flag_auto
5391  0aa4 243b          	jruge	L3672
5393  0aa6 b600          	ld	a,_runmode
5394  0aa8 a103          	cp	a,#3
5395  0aaa 2735          	jreq	L3672
5396  0aac               L5672:
5397                     ; 679             if (start_cnt++ < 15)
5399  0aac c60000        	ld	a,_start_cnt
5400  0aaf 725c0000      	inc	_start_cnt
5401  0ab3 a10f          	cp	a,#15
5402  0ab5 2403          	jruge	L671
5403  0ab7 cc0d63        	jp	L1172
5404  0aba               L671:
5405                     ; 680                 break;
5407                     ; 681             if (runmode == RUN_MODE_AUTO)
5409  0aba 3d00          	tnz	_runmode
5410  0abc 2606          	jrne	L5772
5411                     ; 682                 user_speed_target = SPEED_TARGET_MIN1;
5413  0abe 350f0000      	mov	_user_speed_target,#15
5415  0ac2 200b          	jra	L7772
5416  0ac4               L5772:
5417                     ; 683             else if (runmode == RUN_MODE_FIXED)
5419  0ac4 b600          	ld	a,_runmode
5420  0ac6 a101          	cp	a,#1
5421  0ac8 2605          	jrne	L7772
5422                     ; 685                 fixed_mode_speed = fixed_start_speed;
5424  0aca 5500000000    	mov	_fixed_mode_speed,_fixed_start_speed
5425  0acf               L7772:
5426                     ; 687             beep(BEEP_KEY);
5428  0acf a601          	ld	a,#1
5429  0ad1 cd0000        	call	_beep
5431                     ; 689             flag_sensor_may_reverted = 0;
5433  0ad4 72110000      	bres	_flag_sensor_may_reverted
5434                     ; 703             GOTO_STATE(USER_STATE_TICK);
5436  0ad8 a606          	ld	a,#6
5437  0ada cd0000        	call	L7771_GOTO_STATE
5440  0add ac630d63      	jpf	L1172
5441  0ae1               L3672:
5442                     ; 706         else if (runmode == RUN_MODE_NEW && tutorial_state == TUTORIAL_FINISH && flag_Gsensor_disconnected == 0)
5444  0ae1 b600          	ld	a,_runmode
5445  0ae3 a103          	cp	a,#3
5446  0ae5 2614          	jrne	L5003
5448  0ae7 c60000        	ld	a,_tutorial_state
5449  0aea a107          	cp	a,#7
5450  0aec 260d          	jrne	L5003
5452  0aee 725d0000      	tnz	_flag_Gsensor_disconnected
5453  0af2 2607          	jrne	L5003
5454                     ; 708             run_new();
5456  0af4 cd0000        	call	_run_new
5459  0af7 ac630d63      	jpf	L1172
5460  0afb               L5003:
5461                     ; 710         else if (state_sec == 1 && state_tick == 1)
5463  0afb be00          	ldw	x,_state_sec
5464  0afd a30001        	cpw	x,#1
5465  0b00 2703          	jreq	L002
5466  0b02 cc0bc0        	jp	L1103
5467  0b05               L002:
5469  0b05 b600          	ld	a,_state_tick
5470  0b07 a101          	cp	a,#1
5471  0b09 2703          	jreq	L202
5472  0b0b cc0bc0        	jp	L1103
5473  0b0e               L202:
5474                     ; 712             if (user_distance > store_point.dist && net_state < NET_STATE_UAP)
5476  0b0e be00          	ldw	x,_user_distance
5477  0b10 c30000        	cpw	x,_store_point
5478  0b13 2203          	jrugt	L402
5479  0b15 cc0d63        	jp	L1172
5480  0b18               L402:
5482  0b18 c60000        	ld	a,_net_state
5483  0b1b a105          	cp	a,#5
5484  0b1d 2503          	jrult	L602
5485  0b1f cc0d63        	jp	L1172
5486  0b22               L602:
5487                     ; 714                 store_point.offline_dist += user_distance - store_point.dist;
5489  0b22 be00          	ldw	x,_user_distance
5490  0b24 72b00000      	subw	x,_store_point
5491  0b28 72bb0015      	addw	x,_store_point+21
5492  0b2c cf0015        	ldw	_store_point+21,x
5493                     ; 715                 store_point.dist = user_distance;
5495  0b2f be00          	ldw	x,_user_distance
5496  0b31 cf0000        	ldw	_store_point,x
5497                     ; 716                 store_point.offline_energy += user_calories - store_point.energy;
5499  0b34 ae0000        	ldw	x,#_user_calories
5500  0b37 cd0000        	call	c_ltor
5502  0b3a ae0004        	ldw	x,#_store_point+4
5503  0b3d cd0000        	call	c_lsub
5505  0b40 ae0017        	ldw	x,#_store_point+23
5506  0b43 cd0000        	call	c_lgadd
5508                     ; 717                 store_point.energy = user_calories;
5510  0b46 be02          	ldw	x,_user_calories+2
5511  0b48 cf0006        	ldw	_store_point+6,x
5512  0b4b be00          	ldw	x,_user_calories
5513  0b4d cf0004        	ldw	_store_point+4,x
5514                     ; 718                 store_point.offline_steps += user_steps_total - store_point.steps;
5516  0b50 ce0000        	ldw	x,_user_steps_total
5517  0b53 72b0000a      	subw	x,_store_point+10
5518  0b57 72bb001b      	addw	x,_store_point+27
5519  0b5b cf001b        	ldw	_store_point+27,x
5520                     ; 719                 store_point.steps = user_steps_total;
5522  0b5e ce0000        	ldw	x,_user_steps_total
5523  0b61 cf000a        	ldw	_store_point+10,x
5524                     ; 720                 temp16 = user_time_minute * 60 + user_time_second;
5526  0b64 ce0000        	ldw	x,_user_time_minute
5527  0b67 90ae003c      	ldw	y,#60
5528  0b6b cd0000        	call	c_imul
5530  0b6e 01            	rrwa	x,a
5531  0b6f cb0000        	add	a,_user_time_second
5532  0b72 2401          	jrnc	L641
5533  0b74 5c            	incw	x
5534  0b75               L641:
5535  0b75 02            	rlwa	x,a
5536  0b76 1f05          	ldw	(OFST-5,sp),x
5537  0b78 01            	rrwa	x,a
5538                     ; 721                 store_point.offline_time += temp16 - store_point.time;
5540  0b79 1e05          	ldw	x,(OFST-5,sp)
5541  0b7b 72b0000e      	subw	x,_store_point+14
5542  0b7f 72bb001d      	addw	x,_store_point+29
5543  0b83 cf001d        	ldw	_store_point+29,x
5544                     ; 722                 store_point.time = temp16;
5546  0b86 1e05          	ldw	x,(OFST-5,sp)
5547  0b88 cf000e        	ldw	_store_point+14,x
5548                     ; 723                 eeprom_write_int(EEPROM_ADDR_OFFLINE_DIST, store_point.offline_dist);
5550  0b8b ce0015        	ldw	x,_store_point+21
5551  0b8e 89            	pushw	x
5552  0b8f ae4017        	ldw	x,#16407
5553  0b92 cd0000        	call	_eeprom_write_int
5555  0b95 85            	popw	x
5556                     ; 724                 eeprom_write_long(EEPROM_ADDR_OFFLINE_ENERGY, store_point.offline_energy);
5558  0b96 ce0019        	ldw	x,_store_point+25
5559  0b99 89            	pushw	x
5560  0b9a ce0017        	ldw	x,_store_point+23
5561  0b9d 89            	pushw	x
5562  0b9e ae4019        	ldw	x,#16409
5563  0ba1 cd0000        	call	_eeprom_write_long
5565  0ba4 5b04          	addw	sp,#4
5566                     ; 725                 eeprom_write_int(EEPROM_ADDR_OFFLINE_STEPS, store_point.offline_steps);
5568  0ba6 ce001b        	ldw	x,_store_point+27
5569  0ba9 89            	pushw	x
5570  0baa ae401d        	ldw	x,#16413
5571  0bad cd0000        	call	_eeprom_write_int
5573  0bb0 85            	popw	x
5574                     ; 726                 eeprom_write_int(EEPROM_ADDR_OFFLINE_TIME, store_point.offline_time);
5576  0bb1 ce001d        	ldw	x,_store_point+29
5577  0bb4 89            	pushw	x
5578  0bb5 ae401f        	ldw	x,#16415
5579  0bb8 cd0000        	call	_eeprom_write_int
5581  0bbb 85            	popw	x
5582  0bbc ac630d63      	jpf	L1172
5583  0bc0               L1103:
5584                     ; 731             start_cnt = 0;
5586  0bc0 725f0000      	clr	_start_cnt
5587  0bc4 ac630d63      	jpf	L1172
5588  0bc8               L1362:
5589                     ; 734     case USER_STATE_TICK:
5589                     ; 735         if (state_sec >= 3)
5591  0bc8 be00          	ldw	x,_state_sec
5592  0bca a30003        	cpw	x,#3
5593  0bcd 2511          	jrult	L7103
5594                     ; 737             user_request = USER_REQUEST_START;
5596  0bcf 35010000      	mov	_user_request,#1
5597                     ; 738             no_current_cnt = 0;
5599  0bd3 725f0000      	clr	_no_current_cnt
5600                     ; 739             GOTO_STATE(USER_STATE_RUN);
5602  0bd7 a601          	ld	a,#1
5603  0bd9 cd0000        	call	L7771_GOTO_STATE
5606  0bdc ac630d63      	jpf	L1172
5607  0be0               L7103:
5608                     ; 742         else if (stepdown_flag == STEPDOWN_STOP)
5610  0be0 c60000        	ld	a,_stepdown_flag
5611  0be3 a102          	cp	a,#2
5612  0be5 2609          	jrne	L3203
5613                     ; 744             GOTO_STATE(USER_STATE_STOP);
5615  0be7 a603          	ld	a,#3
5616  0be9 cd0000        	call	L7771_GOTO_STATE
5619  0bec ac630d63      	jpf	L1172
5620  0bf0               L3203:
5621                     ; 746         else if (state_tick == 0 && state_sec >= 1)
5623  0bf0 3d00          	tnz	_state_tick
5624  0bf2 2703          	jreq	L012
5625  0bf4 cc0d63        	jp	L1172
5626  0bf7               L012:
5628  0bf7 be00          	ldw	x,_state_sec
5629  0bf9 2603          	jrne	L212
5630  0bfb cc0d63        	jp	L1172
5631  0bfe               L212:
5632                     ; 748             beep(BEEP_KEY);
5634  0bfe a601          	ld	a,#1
5635  0c00 cd0000        	call	_beep
5637  0c03 ac630d63      	jpf	L1172
5638  0c07               L3362:
5639                     ; 751     case USER_STATE_RUN:
5639                     ; 752         ui_state = USER_STATE_RUN;
5641  0c07 35010000      	mov	L7571_ui_state,#1
5642                     ; 753         run();
5644  0c0b cd0000        	call	_run
5646                     ; 754         if (user_request == USER_REQUEST_STOP)
5648  0c0e b600          	ld	a,_user_request
5649  0c10 a102          	cp	a,#2
5650  0c12 2620          	jrne	L1303
5651                     ; 756             save_total_distance();
5653  0c14 cd0000        	call	_save_total_distance
5655                     ; 757             user_steps_pause = user_steps_total;
5657  0c17 ce0000        	ldw	x,_user_steps_total
5658  0c1a cf0000        	ldw	_user_steps_pause,x
5659                     ; 758             if (stepdown_flag == STEPDOWN_PAUSE)
5661  0c1d c60000        	ld	a,_stepdown_flag
5662  0c20 a101          	cp	a,#1
5663  0c22 2607          	jrne	L3303
5664                     ; 760                 GOTO_STATE(USER_STATE_PAUSE);
5666  0c24 a602          	ld	a,#2
5667  0c26 cd0000        	call	L7771_GOTO_STATE
5670  0c29 2005          	jra	L5303
5671  0c2b               L3303:
5672                     ; 764                 GOTO_STATE(USER_STATE_STOP);
5674  0c2b a603          	ld	a,#3
5675  0c2d cd0000        	call	L7771_GOTO_STATE
5677  0c30               L5303:
5678                     ; 766             stepdown_flag = STEPDOWN_NONE;
5680  0c30 725f0000      	clr	_stepdown_flag
5681  0c34               L1303:
5682                     ; 769         if (goal_status != GOAL_ACHIEVED && goal_value > 0)
5684  0c34 c60000        	ld	a,_goal_status
5685  0c37 a101          	cp	a,#1
5686  0c39 2603          	jrne	L412
5687  0c3b cc0d63        	jp	L1172
5688  0c3e               L412:
5690  0c3e ce0000        	ldw	x,_goal_value
5691  0c41 2603          	jrne	L612
5692  0c43 cc0d63        	jp	L1172
5693  0c46               L612:
5694                     ; 771             if ((goal_type == 0 && user_time_minute >= goal_value) || (goal_type == 1 && user_distance / 100 >= goal_value) || (goal_type == 2 && user_calories / 100 >= goal_value))
5696  0c46 725d0000      	tnz	_goal_type
5697  0c4a 2608          	jrne	L5403
5699  0c4c ce0000        	ldw	x,_user_time_minute
5700  0c4f c30000        	cpw	x,_goal_value
5701  0c52 243a          	jruge	L3403
5702  0c54               L5403:
5704  0c54 c60000        	ld	a,_goal_type
5705  0c57 a101          	cp	a,#1
5706  0c59 260a          	jrne	L1503
5708  0c5b be00          	ldw	x,_user_distance
5709  0c5d a664          	ld	a,#100
5710  0c5f 62            	div	x,a
5711  0c60 c30000        	cpw	x,_goal_value
5712  0c63 2429          	jruge	L3403
5713  0c65               L1503:
5715  0c65 c60000        	ld	a,_goal_type
5716  0c68 a102          	cp	a,#2
5717  0c6a 2639          	jrne	L1403
5719  0c6c ce0000        	ldw	x,_goal_value
5720  0c6f cd0000        	call	c_uitolx
5722  0c72 96            	ldw	x,sp
5723  0c73 1c0001        	addw	x,#OFST-9
5724  0c76 cd0000        	call	c_rtol
5726  0c79 ae0000        	ldw	x,#_user_calories
5727  0c7c cd0000        	call	c_ltor
5729  0c7f ae006a        	ldw	x,#L42
5730  0c82 cd0000        	call	c_ludv
5732  0c85 96            	ldw	x,sp
5733  0c86 1c0001        	addw	x,#OFST-9
5734  0c89 cd0000        	call	c_lcmp
5736  0c8c 2517          	jrult	L1403
5737  0c8e               L3403:
5738                     ; 773                 if (goal_status == GOAL_ONGOING)
5740  0c8e 725d0000      	tnz	_goal_status
5741  0c92 2609          	jrne	L3503
5742                     ; 775                     display_seg = DISPLAY_GOAL;
5744  0c94 350e0007      	mov	_display_seg,#14
5745                     ; 776                     beep(BEEP_GOAL);
5747  0c98 a605          	ld	a,#5
5748  0c9a cd0000        	call	_beep
5750  0c9d               L3503:
5751                     ; 778                 goal_status = GOAL_ACHIEVED;
5753  0c9d 35010000      	mov	_goal_status,#1
5755  0ca1 ac630d63      	jpf	L1172
5756  0ca5               L1403:
5757                     ; 780             else if (goal_status == GOAL_CHANGED)
5759  0ca5 c60000        	ld	a,_goal_status
5760  0ca8 a102          	cp	a,#2
5761  0caa 2703          	jreq	L022
5762  0cac cc0d63        	jp	L1172
5763  0caf               L022:
5764                     ; 781                 goal_status = GOAL_ONGOING;
5766  0caf 725f0000      	clr	_goal_status
5767  0cb3 ac630d63      	jpf	L1172
5768  0cb7               L5362:
5769                     ; 785     case USER_STATE_PAUSE:
5769                     ; 786         start_no_tick = 1;
5771  0cb7 72100001      	bset	_start_no_tick
5772                     ; 787         GOTO_STATE(USER_STATE_READY);
5774  0cbb 4f            	clr	a
5775  0cbc cd0000        	call	L7771_GOTO_STATE
5777                     ; 788         break;
5779  0cbf ac630d63      	jpf	L1172
5780  0cc3               L7362:
5781                     ; 789     case USER_STATE_STOP:
5781                     ; 790         if (machine_speed_target == 0)
5783  0cc3 3d00          	tnz	_machine_speed_target
5784  0cc5 2604          	jrne	L1603
5785                     ; 791             stepdown_flag = STEPDOWN_NONE;
5787  0cc7 725f0000      	clr	_stepdown_flag
5788  0ccb               L1603:
5789                     ; 792         if (tension_bias + tension2_bias < 600 || tutorial_state == TUTORIAL_STEP3_BEGIN || tutorial_state == TUTORIAL_STEP1_BEGIN || !flag_auto && runmode == RUN_MODE_FIXED)
5791  0ccb 9c            	rvf
5792  0ccc ae0000        	ldw	x,#_tension_bias
5793  0ccf cd0000        	call	c_ltor
5795  0cd2 ae0000        	ldw	x,#_tension2_bias
5796  0cd5 cd0000        	call	c_ladd
5798  0cd8 ae007a        	ldw	x,#L051
5799  0cdb cd0000        	call	c_lcmp
5801  0cde 2f1b          	jrslt	L5603
5803  0ce0 c60000        	ld	a,_tutorial_state
5804  0ce3 a105          	cp	a,#5
5805  0ce5 2714          	jreq	L5603
5807  0ce7 c60000        	ld	a,_tutorial_state
5808  0cea a101          	cp	a,#1
5809  0cec 270d          	jreq	L5603
5811                     	btst	_flag_auto
5812  0cf3 2534          	jrult	L3603
5814  0cf5 b600          	ld	a,_runmode
5815  0cf7 a101          	cp	a,#1
5816  0cf9 262e          	jrne	L3603
5817  0cfb               L5603:
5818                     ; 794             if (runmode == RUN_MODE_CHECK)
5820  0cfb b600          	ld	a,_runmode
5821  0cfd a104          	cp	a,#4
5822  0cff 260f          	jrne	L3703
5823                     ; 796                 if (machine_speed_target == 0)
5825  0d01 3d00          	tnz	_machine_speed_target
5826  0d03 265e          	jrne	L1172
5827                     ; 798                     runmode = eeprom_rdchar(EEPROM_ADDR_RUNMODE);
5829  0d05 55400b0000    	mov	_runmode,16395
5830                     ; 799                     flag_mode_changed = 1;
5832  0d0a 72100000      	bset	_flag_mode_changed
5833  0d0e 2053          	jra	L1172
5834  0d10               L3703:
5835                     ; 802             else if (start_cnt++ >= 3)
5837  0d10 c60000        	ld	a,_start_cnt
5838  0d13 725c0000      	inc	_start_cnt
5839  0d17 a103          	cp	a,#3
5840  0d19 2548          	jrult	L1172
5841                     ; 804                 start_no_tick = 1;
5843  0d1b 72100001      	bset	_start_no_tick
5844                     ; 805                 flag_may_stuck = 0;
5846  0d1f 72110000      	bres	_flag_may_stuck
5847                     ; 806                 GOTO_STATE(USER_STATE_READY);
5849  0d23 4f            	clr	a
5850  0d24 cd0000        	call	L7771_GOTO_STATE
5852  0d27 203a          	jra	L1172
5853  0d29               L3603:
5854                     ; 811             start_cnt = 0;
5856  0d29 725f0000      	clr	_start_cnt
5857  0d2d 2034          	jra	L1172
5858  0d2f               L1462:
5859                     ; 857     case USER_STATE_FAULT:
5859                     ; 858         stepdown_flag = STEPDOWN_NONE;
5861  0d2f 725f0000      	clr	_stepdown_flag
5862                     ; 859         if (runmode == RUN_MODE_STANDBY)
5864  0d33 b600          	ld	a,_runmode
5865  0d35 a102          	cp	a,#2
5866  0d37 260b          	jrne	L5013
5867                     ; 861             CLEAR_LED_ERROR;
5869  0d39 7212500a      	bset	_PC_ODR,#1
5870                     ; 862             GOTO_STATE(USER_STATE_SLEEP);
5872  0d3d a604          	ld	a,#4
5873  0d3f cd0000        	call	L7771_GOTO_STATE
5876  0d42 201f          	jra	L1172
5877  0d44               L5013:
5878                     ; 864         else if (error_id == 0 || (error_id == 8 && flag_Gsensor_disconnected < 3 && runmode == RUN_MODE_FIXED))
5880  0d44 3d00          	tnz	_error_id
5881  0d46 2713          	jreq	L3113
5883  0d48 b600          	ld	a,_error_id
5884  0d4a a108          	cp	a,#8
5885  0d4c 2615          	jrne	L1172
5887  0d4e c60000        	ld	a,_flag_Gsensor_disconnected
5888  0d51 a103          	cp	a,#3
5889  0d53 240e          	jruge	L1172
5891  0d55 b600          	ld	a,_runmode
5892  0d57 a101          	cp	a,#1
5893  0d59 2608          	jrne	L1172
5894  0d5b               L3113:
5895                     ; 867             start_no_tick = 0;
5897  0d5b 72110001      	bres	_start_no_tick
5898                     ; 868             GOTO_STATE(USER_STATE_READY);
5900  0d5f 4f            	clr	a
5901  0d60 cd0000        	call	L7771_GOTO_STATE
5903  0d63               L1172:
5904                     ; 873     if (pcerr_com == 0 && (ui_state != USER_STATE_RUN) && machine_state == MACHINE_STATE_RUN)
5906                     	btst	_pcerr_com
5907  0d68 2530          	jrult	L5113
5909  0d6a b600          	ld	a,L7571_ui_state
5910  0d6c a101          	cp	a,#1
5911  0d6e 272a          	jreq	L5113
5913                     	btst	_machine_state
5914  0d75 2423          	jruge	L5113
5915                     ; 875         if (user_machine_state_cnt > 3)
5917  0d77 c60002        	ld	a,L1671_user_machine_state_cnt
5918  0d7a a104          	cp	a,#4
5919  0d7c 2512          	jrult	L7113
5920                     ; 877             user_machine_state_cnt = 0;
5922  0d7e 725f0002      	clr	L1671_user_machine_state_cnt
5923                     ; 878             user_request = USER_REQUEST_STOP; //when no match, request send stop command
5925  0d82 35020000      	mov	_user_request,#2
5926                     ; 879             start_no_tick = 1;
5928  0d86 72100001      	bset	_start_no_tick
5929                     ; 880             GOTO_STATE(USER_STATE_READY);
5931  0d8a 4f            	clr	a
5932  0d8b cd0000        	call	L7771_GOTO_STATE
5935  0d8e 200e          	jra	L5213
5936  0d90               L7113:
5937                     ; 882         else if (is_new_second())
5939  0d90 3d00          	tnz	_state_tick
5940  0d92 260a          	jrne	L5213
5941                     ; 884             user_machine_state_cnt++;
5943  0d94 725c0002      	inc	L1671_user_machine_state_cnt
5944  0d98 2004          	jra	L5213
5945  0d9a               L5113:
5946                     ; 889         user_machine_state_cnt = 0;
5948  0d9a 725f0002      	clr	L1671_user_machine_state_cnt
5949  0d9e               L5213:
5950                     ; 892     if (pcerr_com == 0 && ui_state == USER_STATE_RUN && machine_state == MACHINE_STATE_IDLE)
5952                     	btst	_pcerr_com
5953  0da3 2530          	jrult	L7213
5955  0da5 b600          	ld	a,L7571_ui_state
5956  0da7 a101          	cp	a,#1
5957  0da9 262a          	jrne	L7213
5959                     	btst	_machine_state
5960  0db0 2523          	jrult	L7213
5961                     ; 894         if (user_machine_state_cnt1 > 10)
5963  0db2 c60001        	ld	a,L3671_user_machine_state_cnt1
5964  0db5 a10b          	cp	a,#11
5965  0db7 2512          	jrult	L1313
5966                     ; 896             user_machine_state_cnt1 = 0;
5968  0db9 725f0001      	clr	L3671_user_machine_state_cnt1
5969                     ; 897             user_request = USER_REQUEST_STOP; //when no match, request send stop command
5971  0dbd 35020000      	mov	_user_request,#2
5972                     ; 898             start_no_tick = 1;
5974  0dc1 72100001      	bset	_start_no_tick
5975                     ; 899             GOTO_STATE(USER_STATE_READY);
5977  0dc5 4f            	clr	a
5978  0dc6 cd0000        	call	L7771_GOTO_STATE
5981  0dc9 200e          	jra	L7313
5982  0dcb               L1313:
5983                     ; 901         else if (is_new_second())
5985  0dcb 3d00          	tnz	_state_tick
5986  0dcd 260a          	jrne	L7313
5987                     ; 903             user_machine_state_cnt1++;
5989  0dcf 725c0001      	inc	L3671_user_machine_state_cnt1
5990  0dd3 2004          	jra	L7313
5991  0dd5               L7213:
5992                     ; 908         user_machine_state_cnt1 = 0;
5994  0dd5 725f0001      	clr	L3671_user_machine_state_cnt1
5995  0dd9               L7313:
5996                     ; 910 }
5999  0dd9 5b0a          	addw	sp,#10
6000  0ddb 81            	ret
6307                     .bit:	section	.data,bit
6308  0000               _flag_may_stuck:
6309  0000 00            	ds.b	1
6310                     	xdef	_flag_may_stuck
6311                     	xbit	_flag_sensor_may_reverted
6312                     	switch	.bss
6313  0000               L5671_show_for_a_while:
6314  0000 00            	ds.b	1
6315  0001               L3671_user_machine_state_cnt1:
6316  0001 00            	ds.b	1
6317  0002               L1671_user_machine_state_cnt:
6318  0002 00            	ds.b	1
6319                     	switch	.ubsct
6320  0000               L7571_ui_state:
6321  0000 00            	ds.b	1
6322                     	xref	_DisplayDriverInitializeLED
6323                     	xref	_no_current_cnt
6324                     	xref	_tension2_bias
6325                     	xref	_tension_bias
6326                     	xref	_tension2
6327                     	xref	_tension
6328                     	xref	_flag_Gsensor_disconnected
6329                     	xref	_run
6330                     	xref	_run_new
6331                     	xref	_tutorial_state
6332                     	xref	_stepdown_flag
6333                     	xref.b	_runmode
6334                     	xref	_server_time
6335                     	xref	_button_id
6336                     	xbit	_flag_mode_changed
6337                     	xref	_store_point
6338                     	xref	_net_state
6339                     	xref	_commu_wifi_flag
6340                     	xref	_check_key_id
6341                     	xbit	_key_id_done
6342                     	xref.b	_key_id
6343                     	xref	_beep
6344                     	xref	_disp_alternant2_net
6345                     	xref	_disp_alternant_net
6346                     	xref	_disp_custom
6347                     	xref	_disp_ld
6348                     	xref	_disp_d
6349                     	xref	_disp_2f
6350                     	xref	_disp_1f
6351                     	xref	_disp_text
6352                     	xref	_disp_matrix
6353                     	xref	_disp_matrix_all
6354                     	xref	_images
6355                     	xref	_eeprom_write_int
6356                     	xref	_eeprom_write_long
6357                     	xref	_eeprom_wrchar
6358                     	xdef	_UserConsumerKeys
6359                     	xdef	_UserConsumerDisplay
6360                     	xdef	_UserConsumerOperation
6361                     	xref	_save_total_distance
6362                     	xref	_reset_data
6363                     	switch	.bss
6364  0003               _user_total_distance:
6365  0003 00000000      	ds.b	4
6366                     	xdef	_user_total_distance
6367                     	xref	_userstate
6368  0007               _display_seg:
6369  0007 00            	ds.b	1
6370                     	xdef	_display_seg
6371  0008               _display_cnt:
6372  0008 0000          	ds.b	2
6373                     	xdef	_display_cnt
6374                     	switch	.bit
6375  0001               _start_no_tick:
6376  0001 00            	ds.b	1
6377                     	xdef	_start_no_tick
6378                     	xref	_error_time
6379                     	xbit	_skip_error
6380                     	xref.b	_error_id
6381                     	xref.b	_user_calories
6382                     	xref.b	_user_distance
6383                     	xref	_user_time_second
6384                     	xref	_user_time_minute
6385  0002               _show_factory_mode:
6386  0002 00            	ds.b	1
6387                     	xdef	_show_factory_mode
6388                     	xref	_start_cnt
6389                     	xbit	_run_in_prog_mode
6390                     	xref.b	_state_tick
6391                     	xref.b	_state_sec
6392                     	xref	_clock
6393                     	xref	_flag_disp
6394                     	xbit	_flag_auto
6395                     	xref	_goal_status
6396                     	xref	_goal_value
6397                     	xref	_goal_type
6398                     	xref	_fixed_start_speed
6399                     	xref	_fixed_mode_speed
6400                     	xref	_speed_limit_max
6401                     	xref	_user_steps_pause
6402                     	xref	_user_steps_total
6403                     	xref	_machine_volt_motor
6404                     	xref	_machine_current_motor
6405                     	xref	_dc_motor_rating_f1
6406                     	xref	_dc_motor_startup_volt
6407                     	xref	_dc_motor_rating_volt
6408                     	xref.b	_machine_speed_target
6409                     	xbit	_machine_state
6410                     	xref.b	_power_board_version
6411                     	xbit	_waiting
6412                     	xref.b	_waiting_cnt
6413                     	xref.b	_user_speed_target
6414                     	xref.b	_user_request
6415                     	xbit	_pcerr_com
6416                     	xref	_memset
6417                     	switch	.const
6418  007e               L3642:
6419  007e 5741495400    	dc.b	"WAIT",0
6420  0083               L5442:
6421  0083 452530326400  	dc.b	"E%02d",0
6422  0089               L7342:
6423  0089 444f4e4500    	dc.b	"DONE",0
6424  008e               L5342:
6425  008e 474f414c00    	dc.b	"GOAL",0
6426  0093               L3242:
6427  0093 4f4e00        	dc.b	"ON",0
6428  0096               L5142:
6429  0096 4f464600      	dc.b	"OFF",0
6430  009a               L1142:
6431  009a 4641435400    	dc.b	"FACT",0
6432  009f               L3042:
6433  009f 4d415800      	dc.b	"MAX",0
6434  00a3               L3732:
6435  00a3 463300        	dc.b	"F3",0
6436  00a6               L5632:
6437  00a6 463200        	dc.b	"F2",0
6438  00a9               L7532:
6439  00a9 463100        	dc.b	"F1",0
6440  00ac               L1432:
6441  00ac 5354455000    	dc.b	"STEP",0
6442  00b1               L5232:
6443  00b1 43414c00      	dc.b	"CAL",0
6444  00b5               L7132:
6445  00b5 4b4d00        	dc.b	"KM",0
6446  00b8               L5032:
6447  00b8 53504400      	dc.b	"SPD",0
6448  00bc               L5722:
6449  00bc 25643a253032  	dc.b	"%d:%02d",0
6450  00c4               L1722:
6451  00c4 256420253032  	dc.b	"%d %02d",0
6452  00cc               L7522:
6453  00cc 54494d4500    	dc.b	"TIME",0
6454  00d1               L3322:
6455  00d1 4e455700      	dc.b	"NEW",0
6456  00d5               L7122:
6457  00d5 53544f5000    	dc.b	"STOP",0
6458  00da               L7022:
6459  00da 4c4f434b00    	dc.b	"LOCK",0
6460  00df               L7712:
6461  00df 43414c4900    	dc.b	"CALI",0
6462                     	xref.b	c_lreg
6482                     	xref	c_lgadd
6483                     	xref	c_ldiv
6484                     	xref	c_ladd
6485                     	xref	c_lsub
6486                     	xref	c_rtol
6487                     	xref	c_uitolx
6488                     	xref	c_uitoly
6489                     	xref	c_imul
6490                     	xref	c_ludv
6491                     	xref	c_lcmp
6492                     	xref	c_ltor
6493                     	xref	c_smodx
6494                     	end
