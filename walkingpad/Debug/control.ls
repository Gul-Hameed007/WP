   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2800                     ; 40 static void time_calculation(void)
2800                     ; 41 {
2802                     	switch	.text
2803  0000               L1671_time_calculation:
2807                     ; 42     if (userstate == USER_STATE_RUN
2807                     ; 43         && is_new_second()
2807                     ; 44         && no_current_cnt < STOP_CALC_COUNT)
2809  0000 c60002        	ld	a,_userstate
2810  0003 a101          	cp	a,#1
2811  0005 2636          	jrne	L1002
2813  0007 3d00          	tnz	_state_tick
2814  0009 2632          	jrne	L1002
2816  000b c60000        	ld	a,_no_current_cnt
2817  000e a196          	cp	a,#150
2818  0010 242b          	jruge	L1002
2819                     ; 46         user_time_second++;
2821  0012 725c0003      	inc	_user_time_second
2822                     ; 47         if (user_time_second >= 60)
2824  0016 c60003        	ld	a,_user_time_second
2825  0019 a13c          	cp	a,#60
2826  001b 2520          	jrult	L1002
2827                     ; 49             user_time_second = 0;
2829  001d 725f0003      	clr	_user_time_second
2830                     ; 50             user_time_minute++;
2832  0021 ce0004        	ldw	x,_user_time_minute
2833  0024 1c0001        	addw	x,#1
2834  0027 cf0004        	ldw	_user_time_minute,x
2835                     ; 52             if (user_time_minute >= USER_TIME_MAX)
2837  002a ce0004        	ldw	x,_user_time_minute
2838  002d a30438        	cpw	x,#1080
2839  0030 250b          	jrult	L1002
2840                     ; 54                 beep(BEEP_KEY);
2842  0032 a601          	ld	a,#1
2843  0034 cd0000        	call	_beep
2845                     ; 55                 save_total_distance();
2847  0037 cd0298        	call	_save_total_distance
2849                     ; 56                 reset_data();
2851  003a cd023a        	call	_reset_data
2853  003d               L1002:
2854                     ; 60 }
2857  003d 81            	ret
2906                     ; 62 static void prepare_statistic_data(void)
2906                     ; 63 {
2907                     	switch	.text
2908  003e               L7002_prepare_statistic_data:
2910  003e 89            	pushw	x
2911       00000002      OFST:	set	2
2914                     ; 66     if (user_distance > store_point.dist)
2916  003f be08          	ldw	x,_user_distance
2917  0041 c30000        	cpw	x,_store_point
2918  0044 2203          	jrugt	L41
2919  0046 cc0137        	jp	L7202
2920  0049               L41:
2921                     ; 68         if (!has_wifi_flag(FLAG_WIFI_STORE_POINT) && net_state == NET_STATE_CLOUD && IS_TIME_SET)
2923  0049 c60000        	ld	a,_commu_wifi_flag
2924  004c a504          	bcp	a,#4
2925  004e 2703          	jreq	L61
2926  0050 cc00fe        	jp	L1302
2927  0053               L61:
2929  0053 c60000        	ld	a,_net_state
2930  0056 a103          	cp	a,#3
2931  0058 2703          	jreq	L02
2932  005a cc00fe        	jp	L1302
2933  005d               L02:
2935  005d ae0000        	ldw	x,#_server_time
2936  0060 cd0000        	call	c_lzmp
2938  0063 2603          	jrne	L22
2939  0065 cc00fe        	jp	L1302
2940  0068               L22:
2941                     ; 70             store_point.predist = user_distance - store_point.dist;
2943  0068 be08          	ldw	x,_user_distance
2944  006a 72b00000      	subw	x,_store_point
2945  006e cf0002        	ldw	_store_point+2,x
2946                     ; 71             store_point.dist = user_distance;
2948  0071 be08          	ldw	x,_user_distance
2949  0073 cf0000        	ldw	_store_point,x
2950                     ; 73             store_point.preenergy = user_calories - store_point.energy;
2952  0076 be06          	ldw	x,_user_calories+2
2953  0078 72b00006      	subw	x,_store_point+6
2954  007c cf0008        	ldw	_store_point+8,x
2955                     ; 74             store_point.energy = user_calories;
2957  007f be06          	ldw	x,_user_calories+2
2958  0081 cf0006        	ldw	_store_point+6,x
2959  0084 be04          	ldw	x,_user_calories
2960  0086 cf0004        	ldw	_store_point+4,x
2961                     ; 76             store_point.presteps = user_steps_total - store_point.steps;
2963  0089 ce0000        	ldw	x,_user_steps_total
2964  008c 72b0000a      	subw	x,_store_point+10
2965  0090 cf000c        	ldw	_store_point+12,x
2966                     ; 77             store_point.steps = user_steps_total;
2968  0093 ce0000        	ldw	x,_user_steps_total
2969  0096 cf000a        	ldw	_store_point+10,x
2970                     ; 79             temp16 = user_time_minute * 60 + user_time_second;
2972  0099 ce0004        	ldw	x,_user_time_minute
2973  009c 90ae003c      	ldw	y,#60
2974  00a0 cd0000        	call	c_imul
2976  00a3 01            	rrwa	x,a
2977  00a4 cb0003        	add	a,_user_time_second
2978  00a7 2401          	jrnc	L01
2979  00a9 5c            	incw	x
2980  00aa               L01:
2981  00aa 02            	rlwa	x,a
2982  00ab 1f01          	ldw	(OFST-1,sp),x
2983  00ad 01            	rrwa	x,a
2984                     ; 80             store_point.pretime = temp16 - store_point.time;
2986  00ae 1e01          	ldw	x,(OFST-1,sp)
2987  00b0 72b0000e      	subw	x,_store_point+14
2988  00b4 cf0010        	ldw	_store_point+16,x
2989                     ; 81             store_point.time = temp16;
2991  00b7 1e01          	ldw	x,(OFST-1,sp)
2992  00b9 cf000e        	ldw	_store_point+14,x
2993                     ; 83             store_point.presp = machine_speed_target / 3;
2995  00bc b600          	ld	a,_machine_speed_target
2996  00be ae0003        	ldw	x,#3
2997  00c1 51            	exgw	x,y
2998  00c2 5f            	clrw	x
2999  00c3 97            	ld	xl,a
3000  00c4 65            	divw	x,y
3001  00c5 9f            	ld	a,xl
3002  00c6 c70012        	ld	_store_point+18,a
3003                     ; 85             store_point.state = machine_volt_motor;
3005  00c9 c60000        	ld	a,_machine_volt_motor
3006  00cc 5f            	clrw	x
3007  00cd 97            	ld	xl,a
3008  00ce cf0013        	ldw	_store_point+19,x
3009                     ; 86             store_point.state <<= 8;
3011  00d1 c60014        	ld	a,_store_point+20
3012  00d4 c70013        	ld	_store_point+19,a
3013  00d7 725f0014      	clr	_store_point+20
3014                     ; 87             store_point.state |= machine_current_motor;
3016  00db c60000        	ld	a,_machine_current_motor
3017  00de 5f            	clrw	x
3018  00df 97            	ld	xl,a
3019  00e0 01            	rrwa	x,a
3020  00e1 ca0014        	or	a,_store_point+20
3021  00e4 01            	rrwa	x,a
3022  00e5 ca0013        	or	a,_store_point+19
3023  00e8 01            	rrwa	x,a
3024  00e9 cf0013        	ldw	_store_point+19,x
3025                     ; 88             if (runmode == RUN_MODE_AUTO)
3027  00ec 3d00          	tnz	_runmode
3028  00ee 2606          	jrne	L3302
3029                     ; 89                 store_point.state &= 0xFF7F;
3031  00f0 721f0014      	bres	_store_point+20,#7
3033  00f4 2004          	jra	L5302
3034  00f6               L3302:
3035                     ; 91                 store_point.state |= 0x0080;
3037  00f6 721e0014      	bset	_store_point+20,#7
3038  00fa               L5302:
3039                     ; 93             set_wifi_flag(FLAG_WIFI_STORE_POINT);
3041  00fa 72140000      	bset	_commu_wifi_flag,#2
3042  00fe               L1302:
3043                     ; 96         if (user_distance / 100 > store_mp.km)
3045  00fe be08          	ldw	x,_user_distance
3046  0100 a664          	ld	a,#100
3047  0102 62            	div	x,a
3048  0103 c30002        	cpw	x,_store_mp+2
3049  0106 232f          	jrule	L7202
3050                     ; 98             temp16 = user_time_minute * 60 + user_time_second;
3052  0108 ce0004        	ldw	x,_user_time_minute
3053  010b 90ae003c      	ldw	y,#60
3054  010f cd0000        	call	c_imul
3056  0112 01            	rrwa	x,a
3057  0113 cb0003        	add	a,_user_time_second
3058  0116 2401          	jrnc	L21
3059  0118 5c            	incw	x
3060  0119               L21:
3061  0119 02            	rlwa	x,a
3062  011a 1f01          	ldw	(OFST-1,sp),x
3063  011c 01            	rrwa	x,a
3064                     ; 99             store_mp.dur = temp16 - store_mp.time;
3066  011d 1e01          	ldw	x,(OFST-1,sp)
3067  011f 72b00004      	subw	x,_store_mp+4
3068  0123 cf0000        	ldw	_store_mp,x
3069                     ; 100             store_mp.time = temp16;
3071  0126 1e01          	ldw	x,(OFST-1,sp)
3072  0128 cf0004        	ldw	_store_mp+4,x
3073                     ; 101             store_mp.km = user_distance / 100;
3075  012b be08          	ldw	x,_user_distance
3076  012d a664          	ld	a,#100
3077  012f 62            	div	x,a
3078  0130 cf0002        	ldw	_store_mp+2,x
3079                     ; 103             set_wifi_flag(FLAG_WIFI_STORE_MP);
3081  0133 72120000      	bset	_commu_wifi_flag,#1
3082  0137               L7202:
3083                     ; 106 }
3086  0137 85            	popw	x
3087  0138 81            	ret
3090                     	switch	.ubsct
3091  0000               L3402_user_distance_10m_dist:
3092  0000 0000          	ds.b	2
3139                     .const:	section	.text
3140  0000               L62:
3141  0000 00000019      	dc.l	25
3142  0004               L03:
3143  0004 00001194      	dc.l	4500
3144                     ; 108 static void dist_calculation(void)
3144                     ; 109 {
3145                     	switch	.text
3146  0139               L1402_dist_calculation:
3148  0139 5204          	subw	sp,#4
3149       00000004      OFST:	set	4
3152                     ; 112     if (userstate == USER_STATE_READY)
3154  013b 725d0002      	tnz	_userstate
3155  013f 260e          	jrne	L3602
3156                     ; 114         if (user_distance == 0)
3158  0141 be08          	ldw	x,_user_distance
3159  0143 2703          	jreq	L23
3160  0145 cc01df        	jp	L7602
3161  0148               L23:
3162                     ; 116             user_distance_10m_dist = 0;
3164  0148 5f            	clrw	x
3165  0149 bf00          	ldw	L3402_user_distance_10m_dist,x
3166  014b acdf01df      	jpf	L7602
3167  014f               L3602:
3168                     ; 119     else if (userstate == USER_STATE_RUN
3168                     ; 120         && stepdown_flag == STEPDOWN_NONE
3168                     ; 121         && no_current_cnt < STOP_CALC_COUNT)
3170  014f c60002        	ld	a,_userstate
3171  0152 a101          	cp	a,#1
3172  0154 2703          	jreq	L43
3173  0156 cc01df        	jp	L7602
3174  0159               L43:
3176  0159 725d0000      	tnz	_stepdown_flag
3177  015d 2702          	jreq	L63
3178  015f 207e          	jp	L7602
3179  0161               L63:
3181  0161 c60000        	ld	a,_no_current_cnt
3182  0164 a196          	cp	a,#150
3183  0166 2477          	jruge	L7602
3184                     ; 123         user_steps_total = user_steps_pause + user_steps;
3186  0168 ce0000        	ldw	x,_user_steps_pause
3187  016b 72bb0000      	addw	x,_user_steps
3188  016f cf0000        	ldw	_user_steps_total,x
3189                     ; 124         if (is_new_second())
3191  0172 3d00          	tnz	_state_tick
3192  0174 2669          	jrne	L7602
3193                     ; 126             user_distance_10m_dist += machine_speed_target;
3195  0176 b600          	ld	a,_machine_speed_target
3196  0178 5f            	clrw	x
3197  0179 97            	ld	xl,a
3198  017a 1f03          	ldw	(OFST-1,sp),x
3199  017c be00          	ldw	x,L3402_user_distance_10m_dist
3200  017e 72fb03        	addw	x,(OFST-1,sp)
3201  0181 bf00          	ldw	L3402_user_distance_10m_dist,x
3202                     ; 127             if (user_distance_10m_dist > 1080)
3204  0183 be00          	ldw	x,L3402_user_distance_10m_dist
3205  0185 a30439        	cpw	x,#1081
3206  0188 2520          	jrult	L5702
3207                     ; 129                 user_distance++; // 10m
3209  018a be08          	ldw	x,_user_distance
3210  018c 1c0001        	addw	x,#1
3211  018f bf08          	ldw	_user_distance,x
3212                     ; 130                 user_distance_10m_dist -= 1080;
3214  0191 be00          	ldw	x,L3402_user_distance_10m_dist
3215  0193 1d0438        	subw	x,#1080
3216  0196 bf00          	ldw	L3402_user_distance_10m_dist,x
3217                     ; 132                 if (user_distance > USER_DISTANCE_MAX)
3219  0198 be08          	ldw	x,_user_distance
3220  019a a32710        	cpw	x,#10000
3221  019d 250b          	jrult	L5702
3222                     ; 134                     beep(BEEP_KEY);
3224  019f a601          	ld	a,#1
3225  01a1 cd0000        	call	_beep
3227                     ; 135                     save_total_distance();
3229  01a4 cd0298        	call	_save_total_distance
3231                     ; 136                     reset_data();
3233  01a7 cd023a        	call	_reset_data
3235  01aa               L5702:
3236                     ; 139             user_calories = 1554ul * user_distance / 25ul + user_distance_10m_dist * 259ul / (180ul * 25);
3238  01aa be00          	ldw	x,L3402_user_distance_10m_dist
3239  01ac 90ae0103      	ldw	y,#259
3240  01b0 cd0000        	call	c_umul
3242  01b3 ae0004        	ldw	x,#L03
3243  01b6 cd0000        	call	c_ludv
3245  01b9 96            	ldw	x,sp
3246  01ba 1c0001        	addw	x,#OFST-3
3247  01bd cd0000        	call	c_rtol
3249  01c0 be08          	ldw	x,_user_distance
3250  01c2 90ae0612      	ldw	y,#1554
3251  01c6 cd0000        	call	c_umul
3253  01c9 ae0000        	ldw	x,#L62
3254  01cc cd0000        	call	c_ludv
3256  01cf 96            	ldw	x,sp
3257  01d0 1c0001        	addw	x,#OFST-3
3258  01d3 cd0000        	call	c_ladd
3260  01d6 ae0004        	ldw	x,#_user_calories
3261  01d9 cd0000        	call	c_rtol
3263                     ; 141             prepare_statistic_data();
3265  01dc cd003e        	call	L7002_prepare_statistic_data
3267  01df               L7602:
3268                     ; 144 }
3271  01df 5b04          	addw	sp,#4
3272  01e1 81            	ret
3310                     ; 155 void speed_rpm_convert(void)
3310                     ; 156 {
3311                     	switch	.text
3312  01e2               _speed_rpm_convert:
3314  01e2 89            	pushw	x
3315       00000002      OFST:	set	2
3318                     ; 158     if (user_speed_target > 100)
3320  01e3 b600          	ld	a,_user_speed_target
3321  01e5 a165          	cp	a,#101
3322  01e7 2524          	jrult	L7112
3323                     ; 160         tempi = (user_speed_target - 100);
3325  01e9 b600          	ld	a,_user_speed_target
3326  01eb 5f            	clrw	x
3327  01ec 97            	ld	xl,a
3328  01ed 1d0064        	subw	x,#100
3329  01f0 1f01          	ldw	(OFST-1,sp),x
3330                     ; 161         tempi *= (SPEED_TARGET_SHI - 100);
3332  01f2 1e01          	ldw	x,(OFST-1,sp)
3333  01f4 90ae0050      	ldw	y,#80
3334  01f8 cd0000        	call	c_imul
3336  01fb 1f01          	ldw	(OFST-1,sp),x
3337                     ; 162         tempi /= (SPEED_TARGET_MAX - 100);
3339  01fd 1e01          	ldw	x,(OFST-1,sp)
3340  01ff a650          	ld	a,#80
3341  0201 62            	div	x,a
3342  0202 1f01          	ldw	(OFST-1,sp),x
3343                     ; 163         tempi += 100;
3345  0204 1e01          	ldw	x,(OFST-1,sp)
3346  0206 1c0064        	addw	x,#100
3347  0209 1f01          	ldw	(OFST-1,sp),x
3349  020b 2006          	jra	L1212
3350  020d               L7112:
3351                     ; 167         tempi = user_speed_target;
3353  020d b600          	ld	a,_user_speed_target
3354  020f 5f            	clrw	x
3355  0210 97            	ld	xl,a
3356  0211 1f01          	ldw	(OFST-1,sp),x
3357  0213               L1212:
3358                     ; 170     user_rpm_target = tempi * RPM_TARGET_SCALE / 10;
3360  0213 1e01          	ldw	x,(OFST-1,sp)
3361  0215 90ae0110      	ldw	y,#272
3362  0219 cd0000        	call	c_imul
3364  021c a60a          	ld	a,#10
3365  021e 62            	div	x,a
3366  021f bf00          	ldw	_user_rpm_target,x
3367                     ; 171     tempi = (machine_rpm_target * 10 + RPM_TARGET_SCALE / 2) / RPM_TARGET_SCALE;
3369  0221 be00          	ldw	x,_machine_rpm_target
3370  0223 90ae000a      	ldw	y,#10
3371  0227 cd0000        	call	c_imul
3373  022a 1c0088        	addw	x,#136
3374  022d 90ae0110      	ldw	y,#272
3375  0231 65            	divw	x,y
3376  0232 1f01          	ldw	(OFST-1,sp),x
3377                     ; 172     machine_speed_target = tempi;
3379  0234 7b02          	ld	a,(OFST+0,sp)
3380  0236 b700          	ld	_machine_speed_target,a
3381                     ; 173 }
3384  0238 85            	popw	x
3385  0239 81            	ret
3418                     ; 175 void reset_data(void)
3418                     ; 176 {
3419                     	switch	.text
3420  023a               _reset_data:
3424                     ; 177     user_time_minute = 0;
3426  023a 5f            	clrw	x
3427  023b cf0004        	ldw	_user_time_minute,x
3428                     ; 178     user_time_second = 0;
3430  023e 725f0003      	clr	_user_time_second
3431                     ; 180     user_distance = 0;
3433  0242 5f            	clrw	x
3434  0243 bf08          	ldw	_user_distance,x
3435                     ; 181     user_distance_saved = 0;
3437  0245 5f            	clrw	x
3438  0246 cf0000        	ldw	L7571_user_distance_saved,x
3439                     ; 182     user_calories = 0;
3441  0249 ae0000        	ldw	x,#0
3442  024c bf06          	ldw	_user_calories+2,x
3443  024e ae0000        	ldw	x,#0
3444  0251 bf04          	ldw	_user_calories,x
3445                     ; 184     user_steps_total = 0;
3447  0253 5f            	clrw	x
3448  0254 cf0000        	ldw	_user_steps_total,x
3449                     ; 185     user_steps_pause = 0;
3451  0257 5f            	clrw	x
3452  0258 cf0000        	ldw	_user_steps_pause,x
3453                     ; 187     goal_status = GOAL_ONGOING;
3455  025b 725f0000      	clr	_goal_status
3456                     ; 190     store_mp.dur = 0;
3458  025f 5f            	clrw	x
3459  0260 cf0000        	ldw	_store_mp,x
3460                     ; 191     store_mp.time = 0;
3462  0263 5f            	clrw	x
3463  0264 cf0004        	ldw	_store_mp+4,x
3464                     ; 192     store_mp.km = 0;
3466  0267 5f            	clrw	x
3467  0268 cf0002        	ldw	_store_mp+2,x
3468                     ; 194     store_point.predist = 0;
3470  026b 5f            	clrw	x
3471  026c cf0002        	ldw	_store_point+2,x
3472                     ; 195     store_point.dist = 0;
3474  026f 5f            	clrw	x
3475  0270 cf0000        	ldw	_store_point,x
3476                     ; 196     store_point.preenergy = 0;
3478  0273 5f            	clrw	x
3479  0274 cf0008        	ldw	_store_point+8,x
3480                     ; 197     store_point.energy = 0;
3482  0277 ae0000        	ldw	x,#0
3483  027a cf0006        	ldw	_store_point+6,x
3484  027d ae0000        	ldw	x,#0
3485  0280 cf0004        	ldw	_store_point+4,x
3486                     ; 198     store_point.presteps = 0;
3488  0283 5f            	clrw	x
3489  0284 cf000c        	ldw	_store_point+12,x
3490                     ; 199     store_point.steps = 0;
3492  0287 5f            	clrw	x
3493  0288 cf000a        	ldw	_store_point+10,x
3494                     ; 200     store_point.pretime = 0;
3496  028b 5f            	clrw	x
3497  028c cf0010        	ldw	_store_point+16,x
3498                     ; 201     store_point.time = 0;
3500  028f 5f            	clrw	x
3501  0290 cf000e        	ldw	_store_point+14,x
3502                     ; 202     store_point.presp = 0;
3504  0293 725f0012      	clr	_store_point+18
3505                     ; 203 }
3508  0297 81            	ret
3536                     ; 205 void save_total_distance(void)
3536                     ; 206 {
3537                     	switch	.text
3538  0298               _save_total_distance:
3542                     ; 207     if (user_distance > user_distance_saved)
3544  0298 be08          	ldw	x,_user_distance
3545  029a c30000        	cpw	x,L7571_user_distance_saved
3546  029d 2324          	jrule	L3412
3547                     ; 209         user_total_distance += user_distance - user_distance_saved;
3549  029f be08          	ldw	x,_user_distance
3550  02a1 72b00000      	subw	x,L7571_user_distance_saved
3551  02a5 cd0000        	call	c_uitolx
3553  02a8 ae0000        	ldw	x,#_user_total_distance
3554  02ab cd0000        	call	c_lgadd
3556                     ; 210         user_distance_saved = user_distance;
3558  02ae be08          	ldw	x,_user_distance
3559  02b0 cf0000        	ldw	L7571_user_distance_saved,x
3560                     ; 211         eeprom_write_long(EEPROM_ADDR_TOTAL_DIST, user_total_distance);
3562  02b3 ce0002        	ldw	x,_user_total_distance+2
3563  02b6 89            	pushw	x
3564  02b7 ce0000        	ldw	x,_user_total_distance
3565  02ba 89            	pushw	x
3566  02bb ae4001        	ldw	x,#16385
3567  02be cd0000        	call	_eeprom_write_long
3569  02c1 5b04          	addw	sp,#4
3570  02c3               L3412:
3571                     ; 213 }
3574  02c3 81            	ret
3606                     ; 221 void useroperation(void)
3606                     ; 222 {
3607                     	switch	.text
3608  02c4               _useroperation:
3612                     ; 223     if (runmode == RUN_MODE_AUTO || runmode == RUN_MODE_FIXED || runmode == RUN_MODE_NEW)
3614  02c4 3d00          	tnz	_runmode
3615  02c6 270c          	jreq	L7512
3617  02c8 b600          	ld	a,_runmode
3618  02ca a101          	cp	a,#1
3619  02cc 2706          	jreq	L7512
3621  02ce b600          	ld	a,_runmode
3622  02d0 a103          	cp	a,#3
3623  02d2 2606          	jrne	L5512
3624  02d4               L7512:
3625                     ; 225         time_calculation();
3627  02d4 cd0000        	call	L1671_time_calculation
3629                     ; 226         dist_calculation();
3631  02d7 cd0139        	call	L1402_dist_calculation
3633  02da               L5512:
3634                     ; 229     speed_rpm_convert();
3636  02da cd01e2        	call	_speed_rpm_convert
3638                     ; 230     if (run_in_prog_mode)
3640                     	btst	_run_in_prog_mode
3641  02e2 2405          	jruge	L3612
3642                     ; 232         ProgModeKeys();
3644  02e4 cd0000        	call	_ProgModeKeys
3647  02e7 2003          	jra	L5612
3648  02e9               L3612:
3649                     ; 236         UserConsumerKeys();
3651  02e9 cd0000        	call	_UserConsumerKeys
3653  02ec               L5612:
3654                     ; 238     UserConsumerOperation();
3656  02ec cd0000        	call	_UserConsumerOperation
3658                     ; 239     UserConsumerDisplay(); /* update display */
3660  02ef cd0000        	call	_UserConsumerDisplay
3662                     ; 243 }
3665  02f2 81            	ret
3828                     	switch	.bss
3829  0000               L7571_user_distance_saved:
3830  0000 0000          	ds.b	2
3831                     	switch	.ubsct
3832  0002               _ram_d2:
3833  0002 00            	ds.b	1
3834                     	xdef	_ram_d2
3835  0003               _ram_d1:
3836  0003 00            	ds.b	1
3837                     	xdef	_ram_d1
3838                     	xdef	_useroperation
3839                     	xref	_UserConsumerKeys
3840                     	xref	_UserConsumerDisplay
3841                     	xref	_UserConsumerOperation
3842                     	xref	_ProgModeKeys
3843                     	xdef	_speed_rpm_convert
3844                     	xdef	_save_total_distance
3845                     	xdef	_reset_data
3846                     	xref	_user_total_distance
3847                     	switch	.bss
3848  0002               _userstate:
3849  0002 00            	ds.b	1
3850                     	xdef	_userstate
3851                     	switch	.ubsct
3852  0004               _user_calories:
3853  0004 00000000      	ds.b	4
3854                     	xdef	_user_calories
3855  0008               _user_distance:
3856  0008 0000          	ds.b	2
3857                     	xdef	_user_distance
3858                     	switch	.bss
3859  0003               _user_time_second:
3860  0003 00            	ds.b	1
3861                     	xdef	_user_time_second
3862  0004               _user_time_minute:
3863  0004 0000          	ds.b	2
3864                     	xdef	_user_time_minute
3865  0006               _start_cnt:
3866  0006 00            	ds.b	1
3867                     	xdef	_start_cnt
3868                     .bit:	section	.data,bit
3869  0000               _run_in_prog_mode:
3870  0000 00            	ds.b	1
3871                     	xdef	_run_in_prog_mode
3872                     	xref.b	_state_tick
3873                     	xref	_eeprom_write_long
3874                     	xref	_server_time
3875                     	xref	_store_point
3876                     	xref	_store_mp
3877                     	xref	_net_state
3878                     	xref	_commu_wifi_flag
3879                     	xref	_stepdown_flag
3880                     	xref.b	_runmode
3881                     	xref	_beep
3882                     	xref	_no_current_cnt
3883                     	xref	_goal_status
3884                     	xref	_user_steps_pause
3885                     	xref	_user_steps_total
3886                     	xref	_user_steps
3887                     	xref	_machine_volt_motor
3888                     	xref	_machine_current_motor
3889                     	xref.b	_machine_rpm_target
3890                     	xref.b	_machine_speed_target
3891                     	xref.b	_user_rpm_target
3892                     	xref.b	_user_speed_target
3912                     	xref	c_lgadd
3913                     	xref	c_uitolx
3914                     	xref	c_ladd
3915                     	xref	c_rtol
3916                     	xref	c_ludv
3917                     	xref	c_umul
3918                     	xref	c_imul
3919                     	xref	c_lzmp
3920                     	end
