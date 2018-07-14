   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2765                     	switch	.data
2766  0000               _bias_arr:
2767  0000 00000000      	dc.l	0
2768  0004 000000000000  	ds.b	36
2769  0028               _bias_idx:
2770  0028 00            	dc.b	0
2771  0029               _bias_arr_is_full:
2772  0029 00            	dc.b	0
2773  002a               _user_speed_inc:
2774  002a 00            	dc.b	0
2847                     .const:	section	.text
2848  0000               L6:
2849  0000 00000004      	dc.l	4
2850  0004               L21:
2851  0004 007a1200      	dc.l	8000000
2852  0008               L02:
2853  0008 00027101      	dc.l	160001
2854                     ; 37 void run_auto(void)
2854                     ; 38 {
2855                     	scross	off
2856                     	switch	.text
2857  0000               _run_auto:
2859  0000 5207          	subw	sp,#7
2860       00000007      OFST:	set	7
2863                     ; 40     uchar high_count = 0;
2865  0002 7b06          	ld	a,(OFST-1,sp)
2866  0004 97            	ld	xl,a
2867                     ; 41     uchar low_count = 0;
2869  0005 7b05          	ld	a,(OFST-2,sp)
2870  0007 97            	ld	xl,a
2871                     ; 44     if (flag_Gsensor_disconnected == 0)
2873  0008 725d0000      	tnz	_flag_Gsensor_disconnected
2874  000c 2703          	jreq	L62
2875  000e cc01e6        	jp	L3102
2876  0011               L62:
2877                     ; 46         autorun_delay_sec++;
2879  0011 725c0004      	inc	_autorun_delay_sec
2880                     ; 47         if (tension_bias < 0) tension_bias = 0;
2882  0015 9c            	rvf
2883  0016 725d0000      	tnz	_tension_bias
2884  001a 2e0c          	jrsge	L5102
2887  001c ae0000        	ldw	x,#0
2888  001f cf0002        	ldw	_tension_bias+2,x
2889  0022 ae0000        	ldw	x,#0
2890  0025 cf0000        	ldw	_tension_bias,x
2891  0028               L5102:
2892                     ; 48         if (tension2_bias < 0) tension2_bias = 0;
2894  0028 9c            	rvf
2895  0029 725d0000      	tnz	_tension2_bias
2896  002d 2e0c          	jrsge	L7102
2899  002f ae0000        	ldw	x,#0
2900  0032 cf0002        	ldw	_tension2_bias+2,x
2901  0035 ae0000        	ldw	x,#0
2902  0038 cf0000        	ldw	_tension2_bias,x
2903  003b               L7102:
2904                     ; 49         bias = (tension_bias * tension_bias 
2904                     ; 50                 + tension2_bias * tension2_bias) / 4 ;
2906  003b ae0000        	ldw	x,#_tension2_bias
2907  003e cd0000        	call	c_ltor
2909  0041 ae0000        	ldw	x,#_tension2_bias
2910  0044 cd0000        	call	c_lmul
2912  0047 96            	ldw	x,sp
2913  0048 1c0001        	addw	x,#OFST-6
2914  004b cd0000        	call	c_rtol
2916  004e ae0000        	ldw	x,#_tension_bias
2917  0051 cd0000        	call	c_ltor
2919  0054 ae0000        	ldw	x,#_tension_bias
2920  0057 cd0000        	call	c_lmul
2922  005a 96            	ldw	x,sp
2923  005b 1c0001        	addw	x,#OFST-6
2924  005e cd0000        	call	c_ladd
2926  0061 ae0000        	ldw	x,#L6
2927  0064 cd0000        	call	c_ldiv
2929  0067 ae0000        	ldw	x,#_bias
2930  006a cd0000        	call	c_rtol
2932                     ; 51         bias_arr[bias_idx++] = bias;
2934  006d c60028        	ld	a,_bias_idx
2935  0070 725c0028      	inc	_bias_idx
2936  0074 97            	ld	xl,a
2937  0075 a604          	ld	a,#4
2938  0077 42            	mul	x,a
2939  0078 c60003        	ld	a,_bias+3
2940  007b d70003        	ld	(_bias_arr+3,x),a
2941  007e c60002        	ld	a,_bias+2
2942  0081 d70002        	ld	(_bias_arr+2,x),a
2943  0084 c60001        	ld	a,_bias+1
2944  0087 d70001        	ld	(_bias_arr+1,x),a
2945  008a c60000        	ld	a,_bias
2946  008d d70000        	ld	(_bias_arr,x),a
2947                     ; 52         if (bias_idx == QSIZE) 
2949  0090 c60028        	ld	a,_bias_idx
2950  0093 a10a          	cp	a,#10
2951  0095 260e          	jrne	L1202
2952                     ; 54             if (bias_arr_is_full == 0) bias_arr_is_full = 1;
2954  0097 725d0029      	tnz	_bias_arr_is_full
2955  009b 2604          	jrne	L3202
2958  009d 35010029      	mov	_bias_arr_is_full,#1
2959  00a1               L3202:
2960                     ; 55             bias_idx = 0;
2962  00a1 725f0028      	clr	_bias_idx
2963  00a5               L1202:
2964                     ; 58         if (bias_arr_is_full == 0) return;
2966  00a5 725d0029      	tnz	_bias_arr_is_full
2967  00a9 2603          	jrne	L03
2968  00ab cc01fa        	jp	L42
2969  00ae               L03:
2972                     ; 60         high_count = 0;
2974  00ae 0f06          	clr	(OFST-1,sp)
2975                     ; 61         low_count = 0;
2977  00b0 0f05          	clr	(OFST-2,sp)
2978                     ; 62         for (i = bias_idx; i < bias_idx + QSIZE; ++i) 
2980  00b2 c60028        	ld	a,_bias_idx
2981  00b5 6b07          	ld	(OFST+0,sp),a
2983  00b7 2046          	jra	L3302
2984  00b9               L7202:
2985                     ; 64             high_count += (bias_arr[i % QSIZE] >= THRESHOLD_H);
2987  00b9 7b07          	ld	a,(OFST+0,sp)
2988  00bb 5f            	clrw	x
2989  00bc 97            	ld	xl,a
2990  00bd a60a          	ld	a,#10
2991  00bf cd0000        	call	c_smodx
2993  00c2 58            	sllw	x
2994  00c3 58            	sllw	x
2995  00c4 1c0000        	addw	x,#_bias_arr
2996  00c7 cd0000        	call	c_ltor
2998  00ca ae0004        	ldw	x,#L21
2999  00cd cd0000        	call	c_lcmp
3001  00d0 2504          	jrult	L01
3002  00d2 a601          	ld	a,#1
3003  00d4 2001          	jra	L41
3004  00d6               L01:
3005  00d6 4f            	clr	a
3006  00d7               L41:
3007  00d7 1b06          	add	a,(OFST-1,sp)
3008  00d9 6b06          	ld	(OFST-1,sp),a
3009                     ; 65             low_count += (bias_arr[i % QSIZE] <= THRESHOLD_L);
3011  00db 7b07          	ld	a,(OFST+0,sp)
3012  00dd 5f            	clrw	x
3013  00de 97            	ld	xl,a
3014  00df a60a          	ld	a,#10
3015  00e1 cd0000        	call	c_smodx
3017  00e4 58            	sllw	x
3018  00e5 58            	sllw	x
3019  00e6 1c0000        	addw	x,#_bias_arr
3020  00e9 cd0000        	call	c_ltor
3022  00ec ae0008        	ldw	x,#L02
3023  00ef cd0000        	call	c_lcmp
3025  00f2 2404          	jruge	L61
3026  00f4 a601          	ld	a,#1
3027  00f6 2001          	jra	L22
3028  00f8               L61:
3029  00f8 4f            	clr	a
3030  00f9               L22:
3031  00f9 1b05          	add	a,(OFST-2,sp)
3032  00fb 6b05          	ld	(OFST-2,sp),a
3033                     ; 62         for (i = bias_idx; i < bias_idx + QSIZE; ++i) 
3035  00fd 0c07          	inc	(OFST+0,sp)
3036  00ff               L3302:
3039  00ff 9c            	rvf
3040  0100 7b07          	ld	a,(OFST+0,sp)
3041  0102 5f            	clrw	x
3042  0103 97            	ld	xl,a
3043  0104 c60028        	ld	a,_bias_idx
3044  0107 905f          	clrw	y
3045  0109 9097          	ld	yl,a
3046  010b 72a9000a      	addw	y,#10
3047  010f bf01          	ldw	c_x+1,x
3048  0111 90b301        	cpw	y,c_x+1
3049  0114 2ca3          	jrsgt	L7202
3050                     ; 76         if (high_count >=  QSIZE / 2 - 1 || machine_speed_target == 0) 
3052  0116 7b06          	ld	a,(OFST-1,sp)
3053  0118 a104          	cp	a,#4
3054  011a 2404          	jruge	L1402
3056  011c 3d00          	tnz	_machine_speed_target
3057  011e 263d          	jrne	L7302
3058  0120               L1402:
3059                     ; 81             autorun_delay_sec = 0;
3061  0120 725f0004      	clr	_autorun_delay_sec
3062                     ; 84                 user_speed_inc += high_count - low_count;
3064  0124 7b06          	ld	a,(OFST-1,sp)
3065  0126 1005          	sub	a,(OFST-2,sp)
3066  0128 cb002a        	add	a,_user_speed_inc
3067  012b c7002a        	ld	_user_speed_inc,a
3068                     ; 85                 if (user_speed_inc > INC_STEP && low_count <= 1) 
3070  012e c6002a        	ld	a,_user_speed_inc
3071  0131 a115          	cp	a,#21
3072  0133 2403          	jruge	L23
3073  0135 cc01fa        	jp	L1012
3074  0138               L23:
3076  0138 7b05          	ld	a,(OFST-2,sp)
3077  013a a102          	cp	a,#2
3078  013c 2503          	jrult	L43
3079  013e cc01fa        	jp	L1012
3080  0141               L43:
3081                     ; 94                         user_speed_target = machine_speed_target + SPEED_STEP;
3083  0141 b600          	ld	a,_machine_speed_target
3084  0143 ab0a          	add	a,#10
3085  0145 b700          	ld	_user_speed_target,a
3086                     ; 95                         if (user_speed_target > SPEED_TARGET_MAX)
3088  0147 b600          	ld	a,_user_speed_target
3089  0149 a1b5          	cp	a,#181
3090  014b 2504          	jrult	L5402
3091                     ; 97                             user_speed_target = SPEED_TARGET_MAX;
3093  014d 35b40000      	mov	_user_speed_target,#180
3094  0151               L5402:
3095                     ; 100                     user_speed_inc = 0;
3097  0151 725f002a      	clr	_user_speed_inc
3098                     ; 101                     user_request |= USER_REQUEST_NEW_SPEED;
3100  0155 72140000      	bset	_user_request,#2
3101  0159 acfa01fa      	jpf	L1012
3102  015d               L7302:
3103                     ; 107         else if (low_count >= QSIZE / 2 - 1 && machine_speed_target > 0) 
3105  015d 7b05          	ld	a,(OFST-2,sp)
3106  015f a104          	cp	a,#4
3107  0161 2579          	jrult	L1502
3109  0163 3d00          	tnz	_machine_speed_target
3110  0165 2775          	jreq	L1502
3111                     ; 112             autorun_delay_sec = 0;
3113  0167 725f0004      	clr	_autorun_delay_sec
3114                     ; 113             if (machine_speed_target >= SPEED_TARGET_MIN1)
3116  016b b600          	ld	a,_machine_speed_target
3117  016d a10f          	cp	a,#15
3118  016f 254f          	jrult	L3502
3119                     ; 115                 stop_dly_cnt = 0;
3121  0171 725f0005      	clr	_stop_dly_cnt
3122                     ; 117                 user_speed_inc += low_count - high_count;
3124  0175 7b05          	ld	a,(OFST-2,sp)
3125  0177 1006          	sub	a,(OFST-1,sp)
3126  0179 cb002a        	add	a,_user_speed_inc
3127  017c c7002a        	ld	_user_speed_inc,a
3128                     ; 118                 if (user_speed_inc > INC_STEP / 2 && high_count <= 1) 
3130  017f c6002a        	ld	a,_user_speed_inc
3131  0182 a10b          	cp	a,#11
3132  0184 2574          	jrult	L1012
3134  0186 7b06          	ld	a,(OFST-1,sp)
3135  0188 a102          	cp	a,#2
3136  018a 246e          	jruge	L1012
3137                     ; 127                         if (machine_speed_target > SPEED_STEP * 1.5) 
3139  018c 9c            	rvf
3140  018d b600          	ld	a,_machine_speed_target
3141  018f 5f            	clrw	x
3142  0190 97            	ld	xl,a
3143  0191 cd0000        	call	c_itof
3145  0194 ae000c        	ldw	x,#L5602
3146  0197 cd0000        	call	c_fcmp
3148  019a 2d16          	jrsle	L7502
3149                     ; 129                             user_speed_target = machine_speed_target - SPEED_STEP * 1.5;
3151  019c b600          	ld	a,_machine_speed_target
3152  019e 5f            	clrw	x
3153  019f 97            	ld	xl,a
3154  01a0 cd0000        	call	c_itof
3156  01a3 ae000c        	ldw	x,#L5602
3157  01a6 cd0000        	call	c_fsub
3159  01a9 cd0000        	call	c_ftol
3161  01ac b603          	ld	a,c_lreg+3
3162  01ae b700          	ld	_user_speed_target,a
3164  01b0 2004          	jra	L1702
3165  01b2               L7502:
3166                     ; 134                             user_speed_target = SPEED_TARGET_MIN1 - 1;
3168  01b2 350e0000      	mov	_user_speed_target,#14
3169  01b6               L1702:
3170                     ; 136                         user_request |= USER_REQUEST_NEW_SPEED;
3172  01b6 72140000      	bset	_user_request,#2
3173                     ; 139                     user_speed_inc = 0;
3175  01ba 725f002a      	clr	_user_speed_inc
3176  01be 203a          	jra	L1012
3177  01c0               L3502:
3178                     ; 144                 stop_dly_cnt++;
3180  01c0 725c0005      	inc	_stop_dly_cnt
3181                     ; 145                 if (high_count <= 1)
3183  01c4 7b06          	ld	a,(OFST-1,sp)
3184  01c6 a102          	cp	a,#2
3185  01c8 2430          	jruge	L1012
3186                     ; 147                     beep(BEEP_KEY_INVALID);
3188  01ca a602          	ld	a,#2
3189  01cc cd0000        	call	_beep
3191                     ; 148                     user_speed_inc = 0;
3193  01cf 725f002a      	clr	_user_speed_inc
3194                     ; 149                     stepdown_flag = STEPDOWN_PAUSE;
3196  01d3 35010008      	mov	_stepdown_flag,#1
3197                     ; 150                     user_speed_target = machine_speed_target;
3199  01d7 450000        	mov	_user_speed_target,_machine_speed_target
3200  01da 201e          	jra	L1012
3201  01dc               L1502:
3202                     ; 157             autorun_delay_sec = 0;
3204  01dc 725f0004      	clr	_autorun_delay_sec
3205                     ; 158             user_speed_inc = 0;
3207  01e0 725f002a      	clr	_user_speed_inc
3208  01e4 2014          	jra	L1012
3209  01e6               L3102:
3210                     ; 163         beep(BEEP_ERROR);
3212  01e6 a604          	ld	a,#4
3213  01e8 cd0000        	call	_beep
3215                     ; 164         autorun_delay_sec = 0;
3217  01eb 725f0004      	clr	_autorun_delay_sec
3218                     ; 165         stepdown_flag = STEPDOWN_STOP;
3220  01ef 35020008      	mov	_stepdown_flag,#2
3221                     ; 166         user_speed_target = machine_speed_target;
3223  01f3 450000        	mov	_user_speed_target,_machine_speed_target
3224                     ; 167         user_speed_inc = 0;
3226  01f6 725f002a      	clr	_user_speed_inc
3227  01fa               L1012:
3228                     ; 169 }
3229  01fa               L42:
3232  01fa 5b07          	addw	sp,#7
3233  01fc 81            	ret
3268                     ; 171 void run_fixed(void)
3268                     ; 172 {
3269                     	switch	.text
3270  01fd               _run_fixed:
3272  01fd 5204          	subw	sp,#4
3273       00000004      OFST:	set	4
3276                     ; 173     bias = (tension_bias * tension_bias + tension2_bias * tension2_bias) / 4;
3278  01ff ae0000        	ldw	x,#_tension2_bias
3279  0202 cd0000        	call	c_ltor
3281  0205 ae0000        	ldw	x,#_tension2_bias
3282  0208 cd0000        	call	c_lmul
3284  020b 96            	ldw	x,sp
3285  020c 1c0001        	addw	x,#OFST-3
3286  020f cd0000        	call	c_rtol
3288  0212 ae0000        	ldw	x,#_tension_bias
3289  0215 cd0000        	call	c_ltor
3291  0218 ae0000        	ldw	x,#_tension_bias
3292  021b cd0000        	call	c_lmul
3294  021e 96            	ldw	x,sp
3295  021f 1c0001        	addw	x,#OFST-3
3296  0222 cd0000        	call	c_ladd
3298  0225 ae0000        	ldw	x,#L6
3299  0228 cd0000        	call	c_ldiv
3301  022b ae0000        	ldw	x,#_bias
3302  022e cd0000        	call	c_rtol
3304                     ; 174     if(flag_Gsensor_disconnected == 0)
3306  0231 725d0000      	tnz	_flag_Gsensor_disconnected
3307  0235 2703cc02c2    	jrne	L3112
3308                     ; 176         autorun_delay_sec++;
3310  023a 725c0004      	inc	_autorun_delay_sec
3311                     ; 200             if (fixed_mode_speed > machine_speed_target) 
3313  023e c60000        	ld	a,_fixed_mode_speed
3314  0241 b100          	cp	a,_machine_speed_target
3315  0243 2339          	jrule	L5112
3316                     ; 202                 user_speed_inc ++;
3318  0245 725c002a      	inc	_user_speed_inc
3319                     ; 203                 if (user_speed_inc >= FIXED_SPEED_INTERVAL) 
3321  0249 c6002a        	ld	a,_user_speed_inc
3322  024c a10a          	cp	a,#10
3323  024e 256c          	jrult	L5212
3324                     ; 205                     user_speed_inc = 0;
3326  0250 725f002a      	clr	_user_speed_inc
3327                     ; 206                     if (fixed_mode_speed >= machine_speed_target + FIXED_SPEED_STEP) 
3329  0254 9c            	rvf
3330  0255 c60000        	ld	a,_fixed_mode_speed
3331  0258 5f            	clrw	x
3332  0259 97            	ld	xl,a
3333  025a b600          	ld	a,_machine_speed_target
3334  025c 905f          	clrw	y
3335  025e 9097          	ld	yl,a
3336  0260 72a90005      	addw	y,#5
3337  0264 bf01          	ldw	c_x+1,x
3338  0266 90b301        	cpw	y,c_x+1
3339  0269 2c08          	jrsgt	L1212
3340                     ; 208                         user_speed_target = machine_speed_target + FIXED_SPEED_STEP;
3342  026b b600          	ld	a,_machine_speed_target
3343  026d ab05          	add	a,#5
3344  026f b700          	ld	_user_speed_target,a
3346  0271 2005          	jra	L3212
3347  0273               L1212:
3348                     ; 212                         user_speed_target = fixed_mode_speed;
3350  0273 5500000000    	mov	_user_speed_target,_fixed_mode_speed
3351  0278               L3212:
3352                     ; 214                     user_request |= USER_REQUEST_NEW_SPEED;
3354  0278 72140000      	bset	_user_request,#2
3355  027c 203e          	jra	L5212
3356  027e               L5112:
3357                     ; 217             else if (fixed_mode_speed < machine_speed_target)
3359  027e c60000        	ld	a,_fixed_mode_speed
3360  0281 b100          	cp	a,_machine_speed_target
3361  0283 2437          	jruge	L5212
3362                     ; 219                 user_speed_inc ++;
3364  0285 725c002a      	inc	_user_speed_inc
3365                     ; 220                 if (user_speed_inc >= FIXED_SPEED_INTERVAL)
3367  0289 c6002a        	ld	a,_user_speed_inc
3368  028c a10a          	cp	a,#10
3369  028e 252c          	jrult	L5212
3370                     ; 222                     user_speed_inc = 0;
3372  0290 725f002a      	clr	_user_speed_inc
3373                     ; 223                     if (fixed_mode_speed + FIXED_SPEED_STEP <= machine_speed_target)
3375  0294 9c            	rvf
3376  0295 b600          	ld	a,_machine_speed_target
3377  0297 5f            	clrw	x
3378  0298 97            	ld	xl,a
3379  0299 c60000        	ld	a,_fixed_mode_speed
3380  029c 905f          	clrw	y
3381  029e 9097          	ld	yl,a
3382  02a0 72a90005      	addw	y,#5
3383  02a4 bf01          	ldw	c_x+1,x
3384  02a6 90b301        	cpw	y,c_x+1
3385  02a9 2c08          	jrsgt	L3312
3386                     ; 225                         user_speed_target = machine_speed_target - FIXED_SPEED_STEP;
3388  02ab b600          	ld	a,_machine_speed_target
3389  02ad a005          	sub	a,#5
3390  02af b700          	ld	_user_speed_target,a
3392  02b1 2005          	jra	L5312
3393  02b3               L3312:
3394                     ; 229                         user_speed_target = fixed_mode_speed;
3396  02b3 5500000000    	mov	_user_speed_target,_fixed_mode_speed
3397  02b8               L5312:
3398                     ; 231                     user_request |= USER_REQUEST_NEW_SPEED;
3400  02b8 72140000      	bset	_user_request,#2
3401  02bc               L5212:
3402                     ; 235             autorun_delay_sec = 0;
3404  02bc 725f0004      	clr	_autorun_delay_sec
3406  02c0 2010          	jra	L7312
3407  02c2               L3112:
3408                     ; 240         beep(BEEP_KEY);
3410  02c2 a601          	ld	a,#1
3411  02c4 cd0000        	call	_beep
3413                     ; 241         autorun_delay_sec = 0;
3415  02c7 725f0004      	clr	_autorun_delay_sec
3416                     ; 242         stepdown_flag = STEPDOWN_STOP;
3418  02cb 35020008      	mov	_stepdown_flag,#2
3419                     ; 243         user_speed_target = machine_speed_target;
3421  02cf 450000        	mov	_user_speed_target,_machine_speed_target
3422  02d2               L7312:
3423                     ; 245 }
3426  02d2 5b04          	addw	sp,#4
3427  02d4 81            	ret
3461                     ; 249 void run_new(void)
3461                     ; 250 {
3462                     	switch	.text
3463  02d5               _run_new:
3467                     ; 251     switch (tutorial_state)
3469  02d5 c60006        	ld	a,_tutorial_state
3471                     ; 290         break;
3472  02d8 4d            	tnz	a
3473  02d9 2718          	jreq	L1412
3474  02db 4a            	dec	a
3475  02dc 272d          	jreq	L5412
3476  02de a002          	sub	a,#2
3477  02e0 2739          	jreq	L7412
3478  02e2 4a            	dec	a
3479  02e3 273f          	jreq	L1512
3480  02e5 4a            	dec	a
3481  02e6 2742          	jreq	L3512
3482  02e8 4a            	dec	a
3483  02e9 273f          	jreq	L3512
3484  02eb 4a            	dec	a
3485  02ec 2754          	jreq	L5512
3486  02ee 4a            	dec	a
3487  02ef 2710          	jreq	L3412
3488  02f1 205e          	jra	L1712
3489  02f3               L1412:
3490                     ; 253     case TUTORIAL_BEGIN:
3490                     ; 254         speed_limit_max = 120;
3492  02f3 35780000      	mov	_speed_limit_max,#120
3493                     ; 255         acceleration_param = 2;
3495  02f7 35020000      	mov	_acceleration_param,#2
3496                     ; 256         tutorial_state = TUTORIAL_STOP_FIRST;
3498  02fb 35080006      	mov	_tutorial_state,#8
3499                     ; 257         break;
3501  02ff 2050          	jra	L1712
3502  0301               L3412:
3503                     ; 258     case TUTORIAL_STOP_FIRST:
3503                     ; 259         fixed_mode_speed = 0;
3505  0301 725f0000      	clr	_fixed_mode_speed
3506                     ; 260         stepdown_flag = STEPDOWN_STOP;
3508  0305 35020008      	mov	_stepdown_flag,#2
3509                     ; 261         break;
3511  0309 2046          	jra	L1712
3512  030b               L5412:
3513                     ; 262     case TUTORIAL_STEP1_BEGIN:
3513                     ; 263         if (fixed_mode_speed != 90)
3515  030b c60000        	ld	a,_fixed_mode_speed
3516  030e a15a          	cp	a,#90
3517  0310 2704          	jreq	L3712
3518                     ; 265             fixed_mode_speed = 90;
3520  0312 355a0000      	mov	_fixed_mode_speed,#90
3521  0316               L3712:
3522                     ; 267         run_fixed();
3524  0316 cd01fd        	call	_run_fixed
3526                     ; 268         break;
3528  0319 2036          	jra	L1712
3529  031b               L7412:
3530                     ; 269     case TUTORIAL_STEP2_BEGIN:
3530                     ; 270         fixed_mode_speed = 120;
3532  031b 35780000      	mov	_fixed_mode_speed,#120
3533                     ; 271         run_fixed();
3535  031f cd01fd        	call	_run_fixed
3537                     ; 272         break;
3539  0322 202d          	jra	L1712
3540  0324               L1512:
3541                     ; 273     case TUTORIAL_STEP2_END:
3541                     ; 274         tutorial_state = TUTORIAL_STOP_FIRST;
3543  0324 35080006      	mov	_tutorial_state,#8
3544                     ; 275         break;
3546  0328 2027          	jra	L1712
3547  032a               L3512:
3548                     ; 276     case TUTORIAL_STEP3_BEGIN:
3548                     ; 277     case TUTORIAL_STEP3_END:
3548                     ; 278         if (fixed_mode_speed != 120)
3550  032a c60000        	ld	a,_fixed_mode_speed
3551  032d a178          	cp	a,#120
3552  032f 270c          	jreq	L5712
3553                     ; 280             fixed_mode_speed = 120;
3555  0331 35780000      	mov	_fixed_mode_speed,#120
3556                     ; 281             user_speed_target = SPEED_TARGET_MIN1;
3558  0335 350f0000      	mov	_user_speed_target,#15
3559                     ; 282             speed_limit_max = 120;
3561  0339 35780000      	mov	_speed_limit_max,#120
3562  033d               L5712:
3563                     ; 284         run_auto();
3565  033d cd0000        	call	_run_auto
3567                     ; 285         break;
3569  0340 200f          	jra	L1712
3570  0342               L5512:
3571                     ; 286     case TUTORIAL_FINISH:
3571                     ; 287         tutorial_finish = TUTORIAL_FINISH_TAG;
3573  0342 72100000      	bset	_tutorial_finish
3574                     ; 288         eeprom_wrchar(EEPROM_ADDR_TUTORIAL_FINISH, tutorial_finish);
3576  0346 4b01          	push	#1
3577  0348 ae400e        	ldw	x,#16398
3578  034b cd0000        	call	_eeprom_wrchar
3580  034e 84            	pop	a
3581                     ; 289         runmode = RUN_MODE_AUTO;
3583  034f 3f00          	clr	_runmode
3584                     ; 290         break;
3586  0351               L1712:
3587                     ; 292 }
3590  0351 81            	ret
3618                     ; 294 void run_stepdown(void)
3618                     ; 295 {
3619                     	switch	.text
3620  0352               _run_stepdown:
3624                     ; 296     if (machine_speed_target > SPEED_TARGET_MIN1)
3626  0352 b600          	ld	a,_machine_speed_target
3627  0354 a110          	cp	a,#16
3628  0356 252d          	jrult	L7022
3629                     ; 298         if (stepdown_cnt >= 3)
3631  0358 c60007        	ld	a,_stepdown_cnt
3632  035b a103          	cp	a,#3
3633  035d 2520          	jrult	L1122
3634                     ; 300             if (user_speed_target > SPEED_TARGET_MIN1)
3636  035f b600          	ld	a,_user_speed_target
3637  0361 a110          	cp	a,#16
3638  0363 2514          	jrult	L3122
3639                     ; 302                 if (runmode == RUN_MODE_AUTO)
3641  0365 3d00          	tnz	_runmode
3642  0367 2608          	jrne	L5122
3643                     ; 304                     user_speed_target -= 4;
3645  0369 b600          	ld	a,_user_speed_target
3646  036b a004          	sub	a,#4
3647  036d b700          	ld	_user_speed_target,a
3649  036f 2004          	jra	L7122
3650  0371               L5122:
3651                     ; 308                     user_speed_target -= 2;
3653  0371 3a00          	dec	_user_speed_target
3654  0373 3a00          	dec	_user_speed_target
3655  0375               L7122:
3656                     ; 310                 user_request |= USER_REQUEST_NEW_SPEED;
3658  0375 72140000      	bset	_user_request,#2
3659  0379               L3122:
3660                     ; 312             stepdown_cnt = 0;
3662  0379 725f0007      	clr	_stepdown_cnt
3664  037d 2017          	jra	L3222
3665  037f               L1122:
3666                     ; 316             stepdown_cnt++;
3668  037f 725c0007      	inc	_stepdown_cnt
3669  0383 2011          	jra	L3222
3670  0385               L7022:
3671                     ; 321         if (stepdown_cnt >= 10)
3673  0385 c60007        	ld	a,_stepdown_cnt
3674  0388 a10a          	cp	a,#10
3675  038a 2506          	jrult	L5222
3676                     ; 323             user_request = USER_REQUEST_STOP;
3678  038c 35020000      	mov	_user_request,#2
3680  0390 2004          	jra	L3222
3681  0392               L5222:
3682                     ; 327             stepdown_cnt++;
3684  0392 725c0007      	inc	_stepdown_cnt
3685  0396               L3222:
3686                     ; 330 }
3689  0396 81            	ret
3722                     ; 332 void run(void)
3722                     ; 333 {
3723                     	switch	.text
3724  0397               _run:
3728                     ; 334     if (stepdown_flag == STEPDOWN_PAUSE || stepdown_flag == STEPDOWN_STOP)
3730  0397 c60008        	ld	a,_stepdown_flag
3731  039a a101          	cp	a,#1
3732  039c 2707          	jreq	L3422
3734  039e c60008        	ld	a,_stepdown_flag
3735  03a1 a102          	cp	a,#2
3736  03a3 2603          	jrne	L1422
3737  03a5               L3422:
3738                     ; 336         run_stepdown();
3740  03a5 adab          	call	_run_stepdown
3743  03a7               L5422:
3744                     ; 361 }
3747  03a7 81            	ret
3748  03a8               L1422:
3749                     ; 338     else if (runmode == RUN_MODE_AUTO)
3751  03a8 3d00          	tnz	_runmode
3752  03aa 2605          	jrne	L7422
3753                     ; 340         run_auto();
3755  03ac cd0000        	call	_run_auto
3758  03af 20f6          	jra	L5422
3759  03b1               L7422:
3760                     ; 342     else if (runmode == RUN_MODE_FIXED)
3762  03b1 b600          	ld	a,_runmode
3763  03b3 a101          	cp	a,#1
3764  03b5 2605          	jrne	L3522
3765                     ; 344         run_fixed();
3767  03b7 cd01fd        	call	_run_fixed
3770  03ba 20eb          	jra	L5422
3771  03bc               L3522:
3772                     ; 346     else if (runmode == RUN_MODE_STANDBY)
3774  03bc b600          	ld	a,_runmode
3775  03be a102          	cp	a,#2
3776  03c0 2612          	jrne	L7522
3777                     ; 348         beep(BEEP_KEY);
3779  03c2 a601          	ld	a,#1
3780  03c4 cd0000        	call	_beep
3782                     ; 349         stepdown_flag = STEPDOWN_STOP;            //not stop at once, step down
3784  03c7 35020008      	mov	_stepdown_flag,#2
3785                     ; 350         user_speed_target = machine_speed_target; //step down from machine speed
3787  03cb 450000        	mov	_user_speed_target,_machine_speed_target
3788                     ; 351         stepdown_cnt = 6;
3790  03ce 35060007      	mov	_stepdown_cnt,#6
3792  03d2 20d3          	jra	L5422
3793  03d4               L7522:
3794                     ; 353     else if (runmode == RUN_MODE_NEW)
3796  03d4 b600          	ld	a,_runmode
3797  03d6 a103          	cp	a,#3
3798  03d8 2605          	jrne	L3622
3799                     ; 355         run_new();
3801  03da cd02d5        	call	_run_new
3804  03dd 20c8          	jra	L5422
3805  03df               L3622:
3806                     ; 357     else if (runmode == RUN_MODE_CHECK)
3808  03df b600          	ld	a,_runmode
3809  03e1 a104          	cp	a,#4
3810  03e3 26c2          	jrne	L5422
3811                     ; 359         run_fixed();
3813  03e5 cd01fd        	call	_run_fixed
3815  03e8 20bd          	jra	L5422
4095                     	xdef	_run_stepdown
4096                     	switch	.bss
4097  0000               _bias:
4098  0000 00000000      	ds.b	4
4099                     	xdef	_bias
4100                     	xdef	_user_speed_inc
4101                     	xdef	_bias_arr_is_full
4102                     	xdef	_bias_idx
4103                     	xdef	_bias_arr
4104  0004               _autorun_delay_sec:
4105  0004 00            	ds.b	1
4106                     	xdef	_autorun_delay_sec
4107  0005               _stop_dly_cnt:
4108  0005 00            	ds.b	1
4109                     	xdef	_stop_dly_cnt
4110                     	xref	_eeprom_wrchar
4111                     	xref	_beep
4112                     	xref	_tension2_bias
4113                     	xref	_tension_bias
4114                     	xref	_flag_Gsensor_disconnected
4115                     	xref	_acceleration_param
4116                     	xbit	_tutorial_finish
4117                     	xref	_fixed_mode_speed
4118                     	xref	_speed_limit_max
4119                     	xref.b	_machine_speed_target
4120                     	xref.b	_user_speed_target
4121                     	xref.b	_user_request
4122                     	xdef	_run
4123                     	xdef	_run_new
4124                     	xdef	_run_fixed
4125                     	xdef	_run_auto
4126  0006               _tutorial_state:
4127  0006 00            	ds.b	1
4128                     	xdef	_tutorial_state
4129  0007               _stepdown_cnt:
4130  0007 00            	ds.b	1
4131                     	xdef	_stepdown_cnt
4132  0008               _stepdown_flag:
4133  0008 00            	ds.b	1
4134                     	xdef	_stepdown_flag
4135                     	switch	.ubsct
4136  0000               _runmode:
4137  0000 00            	ds.b	1
4138                     	xdef	_runmode
4139                     	switch	.const
4140  000c               L5602:
4141  000c 41700000      	dc.w	16752,0
4142                     	xref.b	c_lreg
4143                     	xref.b	c_x
4163                     	xref	c_ftol
4164                     	xref	c_fsub
4165                     	xref	c_fcmp
4166                     	xref	c_itof
4167                     	xref	c_lcmp
4168                     	xref	c_smodx
4169                     	xref	c_ldiv
4170                     	xref	c_ladd
4171                     	xref	c_rtol
4172                     	xref	c_lmul
4173                     	xref	c_ltor
4174                     	end
