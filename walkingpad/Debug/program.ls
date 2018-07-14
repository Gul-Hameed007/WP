   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2807                     ; 9 void ProgModeKeys(void)
2807                     ; 10 {
2809                     	switch	.text
2810  0000               _ProgModeKeys:
2814                     ; 11     check_key_id();
2816  0000 cd0000        	call	_check_key_id
2818                     ; 13     if (key_id != KEY_NONE && key_id_done == 0 && waiting == 0) //&& error_id==0
2820  0003 be00          	ldw	x,_key_id
2821  0005 2603          	jrne	L6
2822  0007 cc01ca        	jp	L5002
2823  000a               L6:
2825                     	btst	_key_id_done
2826  000f 2403          	jruge	L01
2827  0011 cc01ca        	jp	L5002
2828  0014               L01:
2830                     	btst	_waiting
2831  0019 2403          	jruge	L21
2832  001b cc01ca        	jp	L5002
2833  001e               L21:
2834                     ; 15         key_id_done = 1;
2836  001e 72100000      	bset	_key_id_done
2837                     ; 16         switch (key_id)
2839  0022 be00          	ldw	x,_key_id
2841                     ; 115             break;
2842  0024 5a            	decw	x
2843  0025 271f          	jreq	L7571
2844  0027 5a            	decw	x
2845  0028 2737          	jreq	L1671
2846  002a 5a            	decw	x
2847  002b 2603          	jrne	L41
2848  002d cc01b9        	jp	L5671
2849  0030               L41:
2850  0030 5a            	decw	x
2851  0031 2603          	jrne	L61
2852  0033 cc010e        	jp	L3671
2853  0036               L61:
2854  0036 1d010e        	subw	x,#270
2855  0039 2603          	jrne	L02
2856  003b cc01b9        	jp	L5671
2857  003e               L02:
2858  003e 1d0eee        	subw	x,#3822
2859  0041 2703          	jreq	L22
2860  0043 cc01ca        	jp	L5002
2861  0046               L22:
2862  0046               L7571:
2863                     ; 18         case KEY_MODE_PRESS:
2863                     ; 19         case KEY_MODE_PRESS_BTN:
2863                     ; 20             beep(BEEP_KEY);
2865  0046 a601          	ld	a,#1
2866  0048 cd0000        	call	_beep
2868                     ; 21             display_seg++;
2870  004b 725c0000      	inc	_display_seg
2871                     ; 22             if (display_seg == DISPLAY_PROG_END)
2873  004f c60000        	ld	a,_display_seg
2874  0052 a10c          	cp	a,#12
2875  0054 2703          	jreq	L42
2876  0056 cc01ca        	jp	L5002
2877  0059               L42:
2878                     ; 23                 display_seg = DISPLAY_PROG_F1;
2880  0059 35060000      	mov	_display_seg,#6
2881  005d acca01ca      	jpf	L5002
2882  0061               L1671:
2883                     ; 25         case KEY_UP_PRESS:
2883                     ; 26             if (display_seg == DISPLAY_PROG_F1)
2885  0061 c60000        	ld	a,_display_seg
2886  0064 a106          	cp	a,#6
2887  0066 261b          	jrne	L5102
2888                     ; 28                 if (dc_motor_rating_f1 < DC_MOTOR_RATING_F1_MAX)
2890  0068 c60000        	ld	a,_dc_motor_rating_f1
2891  006b a1fa          	cp	a,#250
2892  006d 2503          	jrult	L62
2893  006f cc0106        	jp	L1202
2894  0072               L62:
2895                     ; 30                     dc_motor_rating_f1++;
2897  0072 725c0000      	inc	_dc_motor_rating_f1
2898                     ; 31                     eeprom_wrchar(EEPROM_ADDR_RATING_F1, dc_motor_rating_f1);
2900  0076 3b0000        	push	_dc_motor_rating_f1
2901  0079 ae4007        	ldw	x,#16391
2902  007c cd0000        	call	_eeprom_wrchar
2904  007f 84            	pop	a
2905  0080 cc0106        	jra	L1202
2906  0083               L5102:
2907                     ; 34             else if (display_seg == DISPLAY_PROG_F2)
2909  0083 c60000        	ld	a,_display_seg
2910  0086 a107          	cp	a,#7
2911  0088 2617          	jrne	L3202
2912                     ; 36                 if (dc_motor_startup_volt < DC_MOTOR_STARTUP_VOLT_MAX)
2914  008a c60000        	ld	a,_dc_motor_startup_volt
2915  008d a119          	cp	a,#25
2916  008f 2475          	jruge	L1202
2917                     ; 38                     dc_motor_startup_volt++;
2919  0091 725c0000      	inc	_dc_motor_startup_volt
2920                     ; 39                     eeprom_wrchar(EEPROM_ADDR_STARTUP_VOLT, dc_motor_startup_volt);
2922  0095 3b0000        	push	_dc_motor_startup_volt
2923  0098 ae4008        	ldw	x,#16392
2924  009b cd0000        	call	_eeprom_wrchar
2926  009e 84            	pop	a
2927  009f 2065          	jra	L1202
2928  00a1               L3202:
2929                     ; 42             else if (display_seg == DISPLAY_PROG_F3)
2931  00a1 c60000        	ld	a,_display_seg
2932  00a4 a108          	cp	a,#8
2933  00a6 2617          	jrne	L1302
2934                     ; 44                 if (dc_motor_rating_volt < DC_MOTOR_RATING_VOLT_MAX)
2936  00a8 c60000        	ld	a,_dc_motor_rating_volt
2937  00ab a1aa          	cp	a,#170
2938  00ad 2457          	jruge	L1202
2939                     ; 46                     dc_motor_rating_volt++;
2941  00af 725c0000      	inc	_dc_motor_rating_volt
2942                     ; 47                     eeprom_wrchar(EEPROM_ADDR_RATING_VOLT, dc_motor_rating_volt);
2944  00b3 3b0000        	push	_dc_motor_rating_volt
2945  00b6 ae4006        	ldw	x,#16390
2946  00b9 cd0000        	call	_eeprom_wrchar
2948  00bc 84            	pop	a
2949  00bd 2047          	jra	L1202
2950  00bf               L1302:
2951                     ; 50             else if (display_seg == DISPLAY_PROG_MAX)
2953  00bf c60000        	ld	a,_display_seg
2954  00c2 a109          	cp	a,#9
2955  00c4 2626          	jrne	L7302
2956                     ; 52                 if (speed_limit_max < SPEED_TARGET_MAX)
2958  00c6 c60000        	ld	a,_speed_limit_max
2959  00c9 a1b4          	cp	a,#180
2960  00cb 2439          	jruge	L1202
2961                     ; 54                     speed_limit_max += 3;
2963  00cd c60000        	ld	a,_speed_limit_max
2964  00d0 ab03          	add	a,#3
2965  00d2 c70000        	ld	_speed_limit_max,a
2966                     ; 55                     if (speed_limit_max > SPEED_TARGET_MAX)
2968  00d5 c60000        	ld	a,_speed_limit_max
2969  00d8 a1b5          	cp	a,#181
2970  00da 2504          	jrult	L3402
2971                     ; 56                         speed_limit_max = SPEED_TARGET_MAX;
2973  00dc 35b40000      	mov	_speed_limit_max,#180
2974  00e0               L3402:
2975                     ; 57                     eeprom_wrchar(EEPROM_ADDR_SPEED_LIMIT, speed_limit_max);
2977  00e0 3b0000        	push	_speed_limit_max
2978  00e3 ae400d        	ldw	x,#16397
2979  00e6 cd0000        	call	_eeprom_wrchar
2981  00e9 84            	pop	a
2982  00ea 201a          	jra	L1202
2983  00ec               L7302:
2984                     ; 60             else if (display_seg == DISPLAY_PROG_FACT)
2986  00ec c60000        	ld	a,_display_seg
2987  00ef a10a          	cp	a,#10
2988  00f1 2613          	jrne	L1202
2989                     ; 62                 eeprom_wrchar(EEPROM_ADDR_FACTORY_FINISH, show_factory_mode);
2991  00f3 4f            	clr	a
2992                     	btst	_show_factory_mode
2993  00f9 49            	rlc	a
2994  00fa 88            	push	a
2995  00fb ae4010        	ldw	x,#16400
2996  00fe cd0000        	call	_eeprom_wrchar
2998  0101 84            	pop	a
2999                     ; 63                 show_factory_mode = 1 - show_factory_mode;
3001  0102 90100000      	bcpl	_show_factory_mode
3002  0106               L1202:
3003                     ; 65             flag_motor_params_changed = 1;
3005  0106 72100000      	bset	_flag_motor_params_changed
3006                     ; 66             break;
3008  010a acca01ca      	jpf	L5002
3009  010e               L3671:
3010                     ; 67         case KEY_DOWN_PRESS:
3010                     ; 68             if (display_seg == DISPLAY_PROG_F1)
3012  010e c60000        	ld	a,_display_seg
3013  0111 a106          	cp	a,#6
3014  0113 261b          	jrne	L1502
3015                     ; 70                 if (dc_motor_rating_f1 > DC_MOTOR_RATING_F1_MIN)
3017  0115 c60000        	ld	a,_dc_motor_rating_f1
3018  0118 a106          	cp	a,#6
3019  011a 2403          	jruge	L03
3020  011c cc01b3        	jp	L5502
3021  011f               L03:
3022                     ; 72                     dc_motor_rating_f1--;
3024  011f 725a0000      	dec	_dc_motor_rating_f1
3025                     ; 73                     eeprom_wrchar(EEPROM_ADDR_RATING_F1, dc_motor_rating_f1);
3027  0123 3b0000        	push	_dc_motor_rating_f1
3028  0126 ae4007        	ldw	x,#16391
3029  0129 cd0000        	call	_eeprom_wrchar
3031  012c 84            	pop	a
3032  012d cc01b3        	jra	L5502
3033  0130               L1502:
3034                     ; 76             else if (display_seg == DISPLAY_PROG_F2)
3036  0130 c60000        	ld	a,_display_seg
3037  0133 a107          	cp	a,#7
3038  0135 2617          	jrne	L7502
3039                     ; 78                 if (dc_motor_startup_volt > DC_MOTOR_STARTUP_VOLT_MIN)
3041  0137 c60000        	ld	a,_dc_motor_startup_volt
3042  013a a106          	cp	a,#6
3043  013c 2575          	jrult	L5502
3044                     ; 80                     dc_motor_startup_volt--;
3046  013e 725a0000      	dec	_dc_motor_startup_volt
3047                     ; 81                     eeprom_wrchar(EEPROM_ADDR_STARTUP_VOLT, dc_motor_startup_volt);
3049  0142 3b0000        	push	_dc_motor_startup_volt
3050  0145 ae4008        	ldw	x,#16392
3051  0148 cd0000        	call	_eeprom_wrchar
3053  014b 84            	pop	a
3054  014c 2065          	jra	L5502
3055  014e               L7502:
3056                     ; 84             else if (display_seg == DISPLAY_PROG_F3)
3058  014e c60000        	ld	a,_display_seg
3059  0151 a108          	cp	a,#8
3060  0153 2617          	jrne	L5602
3061                     ; 86                 if (dc_motor_rating_volt > DC_MOTOR_RATING_VOLT_MIN)
3063  0155 c60000        	ld	a,_dc_motor_rating_volt
3064  0158 a183          	cp	a,#131
3065  015a 2557          	jrult	L5502
3066                     ; 88                     dc_motor_rating_volt--;
3068  015c 725a0000      	dec	_dc_motor_rating_volt
3069                     ; 89                     eeprom_wrchar(EEPROM_ADDR_RATING_VOLT, dc_motor_rating_volt);
3071  0160 3b0000        	push	_dc_motor_rating_volt
3072  0163 ae4006        	ldw	x,#16390
3073  0166 cd0000        	call	_eeprom_wrchar
3075  0169 84            	pop	a
3076  016a 2047          	jra	L5502
3077  016c               L5602:
3078                     ; 92             else if (display_seg == DISPLAY_PROG_MAX)
3080  016c c60000        	ld	a,_display_seg
3081  016f a109          	cp	a,#9
3082  0171 2626          	jrne	L3702
3083                     ; 94                 if (speed_limit_max > 60) // 2 kmh
3085  0173 c60000        	ld	a,_speed_limit_max
3086  0176 a13d          	cp	a,#61
3087  0178 2539          	jrult	L5502
3088                     ; 96                     speed_limit_max -= 3;
3090  017a c60000        	ld	a,_speed_limit_max
3091  017d a003          	sub	a,#3
3092  017f c70000        	ld	_speed_limit_max,a
3093                     ; 97                     if (speed_limit_max < 60)
3095  0182 c60000        	ld	a,_speed_limit_max
3096  0185 a13c          	cp	a,#60
3097  0187 2404          	jruge	L7702
3098                     ; 98                         speed_limit_max = 60;
3100  0189 353c0000      	mov	_speed_limit_max,#60
3101  018d               L7702:
3102                     ; 99                     eeprom_wrchar(EEPROM_ADDR_SPEED_LIMIT, speed_limit_max);
3104  018d 3b0000        	push	_speed_limit_max
3105  0190 ae400d        	ldw	x,#16397
3106  0193 cd0000        	call	_eeprom_wrchar
3108  0196 84            	pop	a
3109  0197 201a          	jra	L5502
3110  0199               L3702:
3111                     ; 102             else if (display_seg == DISPLAY_PROG_FACT)
3113  0199 c60000        	ld	a,_display_seg
3114  019c a10a          	cp	a,#10
3115  019e 2613          	jrne	L5502
3116                     ; 104                 eeprom_wrchar(EEPROM_ADDR_FACTORY_FINISH, show_factory_mode);
3118  01a0 4f            	clr	a
3119                     	btst	_show_factory_mode
3120  01a6 49            	rlc	a
3121  01a7 88            	push	a
3122  01a8 ae4010        	ldw	x,#16400
3123  01ab cd0000        	call	_eeprom_wrchar
3125  01ae 84            	pop	a
3126                     ; 105                 show_factory_mode = 1 - show_factory_mode;
3128  01af 90100000      	bcpl	_show_factory_mode
3129  01b3               L5502:
3130                     ; 107             flag_motor_params_changed = 1;
3132  01b3 72100000      	bset	_flag_motor_params_changed
3133                     ; 108             break;
3135  01b7 2011          	jra	L5002
3136  01b9               L5671:
3137                     ; 109         case KEY_MODE_STOP_LONG_PRESS:
3137                     ; 110         case KEY_STOP_PRESS:
3137                     ; 111             beep(BEEP_KEY);
3139  01b9 a601          	ld	a,#1
3140  01bb cd0000        	call	_beep
3142                     ; 112             run_in_prog_mode = 0;
3144  01be 72110000      	bres	_run_in_prog_mode
3145                     ; 113             display_seg = DISPLAY_TIME;
3147  01c2 725f0000      	clr	_display_seg
3148                     ; 114             display_cnt = 0;
3150  01c6 5f            	clrw	x
3151  01c7 cf0000        	ldw	_display_cnt,x
3152                     ; 115             break;
3154  01ca               L1102:
3155  01ca               L5002:
3156                     ; 118 }
3159  01ca 81            	ret
3172                     	xdef	_ProgModeKeys
3173                     	xref	_display_seg
3174                     	xref	_display_cnt
3175                     	xbit	_flag_motor_params_changed
3176                     	xbit	_show_factory_mode
3177                     	xbit	_run_in_prog_mode
3178                     	xref	_eeprom_wrchar
3179                     	xref	_beep
3180                     	xref	_speed_limit_max
3181                     	xref	_dc_motor_rating_f1
3182                     	xref	_dc_motor_startup_volt
3183                     	xref	_dc_motor_rating_volt
3184                     	xbit	_waiting
3185                     	xref	_check_key_id
3186                     	xbit	_key_id_done
3187                     	xref.b	_key_id
3206                     	end
