   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2765                     .bit:	section	.data,bit
2766  0000               _flag_motor_params_changed:
2767  0000 00            	dc.b	0
2846                     ; 44 void commu(void)
2846                     ; 45 {
2848                     	switch	.text
2849  0000               _commu:
2851  0000 89            	pushw	x
2852       00000002      OFST:	set	2
2855                     ; 48     if (commu_state == COMMU_STATE_TRANSMIT)
2857  0001 3d01          	tnz	L1671_commu_state
2858  0003 2703          	jreq	L02
2859  0005 cc00ef        	jp	L5302
2860  0008               L02:
2861                     ; 50         if (flag_motor_params_changed)
2863                     	btst	_flag_motor_params_changed
2864  000d 2408          	jruge	L7302
2865                     ; 52             flag_motor_params_changed = 0;
2867  000f 72110000      	bres	_flag_motor_params_changed
2868                     ; 53             command_id = MACHINE_CONTROL;
2870  0013 35020002      	mov	L7571_command_id,#2
2871  0017               L7302:
2872                     ; 55         commu_state = COMMU_STATE_RECEIVE; //switch to receive
2874  0017 35010001      	mov	L1671_commu_state,#1
2875                     ; 56         pctxd[0] = 0xf7;                   //answer basing the order function
2877  001b 35f70000      	mov	_pctxd,#247
2878                     ; 57         pctxd[1] = 0xf8;
2880  001f 35f80001      	mov	_pctxd+1,#248
2881                     ; 58         pctxd[3] = 0x01;
2883  0023 35010003      	mov	_pctxd+3,#1
2884                     ; 59         pctxd[4] = 0x01;
2886  0027 35010004      	mov	_pctxd+4,#1
2887                     ; 60         pctxd[5] = command_id;
2889  002b 5500020005    	mov	_pctxd+5,L7571_command_id
2890                     ; 61         switch (command_id)
2892  0030 b602          	ld	a,L7571_command_id
2894                     ; 98         default: //error
2894                     ; 99             break;
2895  0032 4a            	dec	a
2896  0033 2708          	jreq	L5671
2897  0035 4a            	dec	a
2898  0036 270b          	jreq	L7671
2899  0038 4a            	dec	a
2900  0039 2743          	jreq	L1771
2901  003b 2057          	jra	L3402
2902  003d               L5671:
2903                     ; 63         case MACHINE_INFO_QUERY: //query product information
2903                     ; 64             command_size = 0x08;
2905  003d 35080003      	mov	_command_size,#8
2906                     ; 65             break;
2908  0041 2051          	jra	L3402
2909  0043               L7671:
2910                     ; 66         case MACHINE_CONTROL: //machine control
2910                     ; 67             command_size = 0x16;
2912  0043 35160003      	mov	_command_size,#22
2913                     ; 68             pctxd[6] = user_request;
2915  0047 5500000006    	mov	_pctxd+6,_user_request
2916                     ; 69             user_request = USER_REQUEST_NONE;
2918  004c 3f00          	clr	_user_request
2919                     ; 72             *((uint *)(pctxd + 7)) = user_rpm_target;
2921  004e be00          	ldw	x,_user_rpm_target
2922  0050 cf0007        	ldw	_pctxd+7,x
2923                     ; 73             pctxd[9] = 0; //user_gradient_target;
2925  0053 725f0009      	clr	_pctxd+9
2926                     ; 75             pctxd[10] = dc_motor_startup_volt;
2928  0057 550000000a    	mov	_pctxd+10,_dc_motor_startup_volt
2929                     ; 76             pctxd[11] = dc_motor_rating_volt;
2931  005c 550000000b    	mov	_pctxd+11,_dc_motor_rating_volt
2932                     ; 77             pctxd[12] = 0; //LIFT_MOTOR_GRADIENT_MAX;
2934  0061 725f000c      	clr	_pctxd+12
2935                     ; 83             *((u32 *)(pctxd + 13)) = RPM_MEASURED_SCALE;
2937  0065 aeb735        	ldw	x,#46901
2938  0068 cf000f        	ldw	_pctxd+15,x
2939  006b ae000c        	ldw	x,#12
2940  006e cf000d        	ldw	_pctxd+13,x
2941                     ; 86             *((u16 *)(pctxd + 17)) = DC_MOTOR_RATING_RPM_DEFAULT;
2943  0071 ae1324        	ldw	x,#4900
2944  0074 cf0011        	ldw	_pctxd+17,x
2945                     ; 87             pctxd[19] = dc_motor_rating_f1;
2947  0077 5500000013    	mov	_pctxd+19,_dc_motor_rating_f1
2948                     ; 88             break;
2950  007c 2016          	jra	L3402
2951  007e               L1771:
2952                     ; 89         case MACHINE_CONTROL_NEW:
2952                     ; 90             command_size = 12;
2954  007e 350c0003      	mov	_command_size,#12
2955                     ; 91             pctxd[6] = user_request;
2957  0082 5500000006    	mov	_pctxd+6,_user_request
2958                     ; 92             user_request = USER_REQUEST_NONE;
2960  0087 3f00          	clr	_user_request
2961                     ; 95             *((uint *)(pctxd + 7)) = user_rpm_target;
2963  0089 be00          	ldw	x,_user_rpm_target
2964  008b cf0007        	ldw	_pctxd+7,x
2965                     ; 96             pctxd[9] = getFanSpeed();
2967  008e cd0000        	call	_getFanSpeed
2969  0091 c70009        	ld	_pctxd+9,a
2970                     ; 97             break;
2972  0094               L3771:
2973                     ; 98         default: //error
2973                     ; 99             break;
2975  0094               L3402:
2976                     ; 101         pctxd[2] = command_size - 4; //command size
2978  0094 b603          	ld	a,_command_size
2979  0096 a004          	sub	a,#4
2980  0098 c70002        	ld	_pctxd+2,a
2981                     ; 102         temp8 = pctxd[2];
2983  009b c60002        	ld	a,_pctxd+2
2984  009e 6b01          	ld	(OFST-1,sp),a
2985                     ; 103         for (tempc = 3; tempc < command_size - 2; tempc++)
2987  00a0 a603          	ld	a,#3
2988  00a2 6b02          	ld	(OFST+0,sp),a
2990  00a4 200d          	jra	L1502
2991  00a6               L5402:
2992                     ; 105             temp8 = temp8 + pctxd[tempc];
2994  00a6 7b02          	ld	a,(OFST+0,sp)
2995  00a8 5f            	clrw	x
2996  00a9 97            	ld	xl,a
2997  00aa 7b01          	ld	a,(OFST-1,sp)
2998  00ac db0000        	add	a,(_pctxd,x)
2999  00af 6b01          	ld	(OFST-1,sp),a
3000                     ; 103         for (tempc = 3; tempc < command_size - 2; tempc++)
3002  00b1 0c02          	inc	(OFST+0,sp)
3003  00b3               L1502:
3006  00b3 9c            	rvf
3007  00b4 b603          	ld	a,_command_size
3008  00b6 5f            	clrw	x
3009  00b7 97            	ld	xl,a
3010  00b8 5a            	decw	x
3011  00b9 5a            	decw	x
3012  00ba 7b02          	ld	a,(OFST+0,sp)
3013  00bc 905f          	clrw	y
3014  00be 9097          	ld	yl,a
3015  00c0 90bf01        	ldw	c_y+1,y
3016  00c3 b301          	cpw	x,c_y+1
3017  00c5 2cdf          	jrsgt	L5402
3018                     ; 107         pctxd[command_size - 2] = temp8; //checksum
3020  00c7 b603          	ld	a,_command_size
3021  00c9 5f            	clrw	x
3022  00ca 97            	ld	xl,a
3023  00cb 5a            	decw	x
3024  00cc 5a            	decw	x
3025  00cd 7b01          	ld	a,(OFST-1,sp)
3026  00cf d70000        	ld	(_pctxd,x),a
3027                     ; 108         pctxd[command_size - 1] = 0xfd;  //end code
3029  00d2 b603          	ld	a,_command_size
3030  00d4 5f            	clrw	x
3031  00d5 97            	ld	xl,a
3032  00d6 5a            	decw	x
3033  00d7 a6fd          	ld	a,#253
3034  00d9 d70000        	ld	(_pctxd,x),a
3035                     ; 109         flag_txd_process = 1;
3037  00dc 72100001      	bset	_flag_txd_process
3038                     ; 110         _putchar(pctxd[0]);
3040  00e0 c60000        	ld	a,_pctxd
3041  00e3 cd0000        	call	__putchar
3043                     ; 111         turn_rx_off();
3045  00e6 cd0000        	call	_turn_rx_off
3047                     ; 112         pccom_cnt = 0;
3049  00e9 3f00          	clr	_pccom_cnt
3051  00eb acf801f8      	jpf	L5502
3052  00ef               L5302:
3053                     ; 114     else if (commu_state == COMMU_STATE_RECEIVE)
3055  00ef b601          	ld	a,L1671_commu_state
3056  00f1 a101          	cp	a,#1
3057  00f3 2703          	jreq	L22
3058  00f5 cc01f2        	jp	L7502
3059  00f8               L22:
3060                     ; 116         if (pcorder == 1) //new order coming from Power board
3062                     	btst	_pcorder
3063  00fd 2503          	jrult	L42
3064  00ff cc01c9        	jp	L1602
3065  0102               L42:
3066                     ; 118             pccom_cnt = 0;
3068  0102 3f00          	clr	_pccom_cnt
3069                     ; 119             pccom_fail_cnt = 0;
3071  0104 3f00          	clr	L3671_pccom_fail_cnt
3072                     ; 120             pcerr_com = 0; //reset error
3074  0106 72110000      	bres	_pcerr_com
3075                     ; 121             pcorder = 0;
3077  010a 72110000      	bres	_pcorder
3078                     ; 122             commu_state = COMMU_STATE_TRANSMIT; //swith to transit next period
3080  010e 3f01          	clr	L1671_commu_state
3081                     ; 123             command_id = pcrxd[5];              //pc order function
3083  0110 5500050002    	mov	L7571_command_id,_pcrxd+5
3084                     ; 124             cnt_rec2 = 0;
3086  0115 3f00          	clr	_cnt_rec2
3087                     ; 125             cnt_tra2 = 0;
3089  0117 3f00          	clr	_cnt_tra2
3090                     ; 127             switch (command_id)
3092  0119 b602          	ld	a,L7571_command_id
3094                     ; 162             default:
3094                     ; 163                 command_id = MACHINE_INFO_QUERY;
3095  011b 4a            	dec	a
3096  011c 270e          	jreq	L5771
3097  011e 4a            	dec	a
3098  011f 2718          	jreq	L7771
3099  0121 4a            	dec	a
3100  0122 2764          	jreq	L1002
3101  0124               L3002:
3104  0124 35010002      	mov	L7571_command_id,#1
3105  0128 acf801f8      	jpf	L5502
3106  012c               L5771:
3107                     ; 129             case MACHINE_INFO_QUERY: //inquiring product information
3107                     ; 130                 //power_board_machine_type = pcrxd[7];
3107                     ; 131                 power_board_version = pcrxd[8];
3109  012c 5500080000    	mov	_power_board_version,_pcrxd+8
3110                     ; 135                 command_id = MACHINE_CONTROL;
3112  0131 35020002      	mov	L7571_command_id,#2
3113                     ; 136                 break;
3115  0135 acf801f8      	jpf	L5502
3116  0139               L7771:
3117                     ; 137             case MACHINE_CONTROL:                            //machine control
3117                     ; 138                 machine_rpm_target = *((uint *)(pcrxd + 7)); // pcrxd[7] << 8 | pcrxd[8];
3119  0139 ce0007        	ldw	x,_pcrxd+7
3120  013c bf00          	ldw	_machine_rpm_target,x
3121                     ; 139                 user_steps_last = user_steps;
3123  013e ce0000        	ldw	x,_user_steps
3124  0141 cf0000        	ldw	_user_steps_last,x
3125                     ; 140                 user_steps = *((uint *)(pcrxd + 11)); // pcrxd[11] << 8 | pcrxd[12];
3127  0144 ce000b        	ldw	x,_pcrxd+11
3128  0147 cf0000        	ldw	_user_steps,x
3129                     ; 141                 machine_volt_motor = pcrxd[15];
3131  014a 55000f0000    	mov	_machine_volt_motor,_pcrxd+15
3132                     ; 142                 machine_current_motor = pcrxd[21];
3134  014f 5500150000    	mov	_machine_current_motor,_pcrxd+21
3135                     ; 146                 error_code = pcrxd[19] << 8 | pcrxd[18];
3137  0154 c60013        	ld	a,_pcrxd+19
3138  0157 5f            	clrw	x
3139  0158 97            	ld	xl,a
3140  0159 4f            	clr	a
3141  015a 02            	rlwa	x,a
3142  015b 01            	rrwa	x,a
3143  015c ca0012        	or	a,_pcrxd+18
3144  015f b701          	ld	_error_code+1,a
3145  0161 9f            	ld	a,xl
3146  0162 b700          	ld	_error_code,a
3147                     ; 148                 machine_state = pcrxd[20] & 0x01;
3149  0164 c60014        	ld	a,_pcrxd+20
3150  0167 a501          	bcp	a,#1
3151  0169 2602          	jrne	L62
3152  016b 2006          	jp	L6
3153  016d               L62:
3154  016d 72100000      	bset	_machine_state
3155  0171 2004          	jra	L01
3156  0173               L6:
3157  0173 72110000      	bres	_machine_state
3158  0177               L01:
3159                     ; 149                 machine_current_motor = pcrxd[21];
3161  0177 5500150000    	mov	_machine_current_motor,_pcrxd+21
3162                     ; 150                 if (power_board_version >= 100)
3164  017c b600          	ld	a,_power_board_version
3165  017e a164          	cp	a,#100
3166  0180 2576          	jrult	L5502
3167                     ; 151                     command_id = MACHINE_CONTROL_NEW;
3169  0182 35030002      	mov	L7571_command_id,#3
3170  0186 2070          	jra	L5502
3171  0188               L1002:
3172                     ; 153             case MACHINE_CONTROL_NEW:
3172                     ; 154                 machine_state = pcrxd[6];
3174  0188 725d0006      	tnz	_pcrxd+6
3175  018c 2602          	jrne	L03
3176  018e 2006          	jp	L21
3177  0190               L03:
3178  0190 72100000      	bset	_machine_state
3179  0194 2004          	jra	L41
3180  0196               L21:
3181  0196 72110000      	bres	_machine_state
3182  019a               L41:
3183                     ; 155                 machine_rpm_target = *((uint *)(pcrxd + 7)); // pcrxd[7] << 8 | pcrxd[8];
3185  019a ce0007        	ldw	x,_pcrxd+7
3186  019d bf00          	ldw	_machine_rpm_target,x
3187                     ; 156                 user_steps_last = user_steps;
3189  019f ce0000        	ldw	x,_user_steps
3190  01a2 cf0000        	ldw	_user_steps_last,x
3191                     ; 157                 user_steps = *((uint *)(pcrxd + 9)); // pcrxd[9] << 8 | pcrxd[10];
3193  01a5 ce0009        	ldw	x,_pcrxd+9
3194  01a8 cf0000        	ldw	_user_steps,x
3195                     ; 158                 machine_volt_motor = pcrxd[11];
3197  01ab 55000b0000    	mov	_machine_volt_motor,_pcrxd+11
3198                     ; 159                 machine_current_motor = pcrxd[12];
3200  01b0 55000c0000    	mov	_machine_current_motor,_pcrxd+12
3201                     ; 160                 error_code = pcrxd[14] << 8 | pcrxd[13];
3203  01b5 c6000e        	ld	a,_pcrxd+14
3204  01b8 5f            	clrw	x
3205  01b9 97            	ld	xl,a
3206  01ba 4f            	clr	a
3207  01bb 02            	rlwa	x,a
3208  01bc 01            	rrwa	x,a
3209  01bd ca000d        	or	a,_pcrxd+13
3210  01c0 b701          	ld	_error_code+1,a
3211  01c2 9f            	ld	a,xl
3212  01c3 b700          	ld	_error_code,a
3213                     ; 161                 break;
3215  01c5 2031          	jra	L5502
3216  01c7               L5602:
3217                     ; 162             default:
3217                     ; 163                 command_id = MACHINE_INFO_QUERY;
3218  01c7 202f          	jra	L5502
3219  01c9               L1602:
3220                     ; 168             if (pccom_cnt >= WAIT_FEEDBACK_TIME) //when no feedback for 0.3s, go to transmit state
3222  01c9 b600          	ld	a,_pccom_cnt
3223  01cb a119          	cp	a,#25
3224  01cd 251f          	jrult	L3702
3225                     ; 170                 if (pccom_fail_cnt >= PCCOM_FAIL_CNT_MAX)
3227  01cf b600          	ld	a,L3671_pccom_fail_cnt
3228  01d1 a10f          	cp	a,#15
3229  01d3 2506          	jrult	L5702
3230                     ; 172                     pcerr_com = 1; //alarm
3232  01d5 72100000      	bset	_pcerr_com
3234  01d9 2002          	jra	L7702
3235  01db               L5702:
3236                     ; 176                     pccom_fail_cnt++;
3238  01db 3c00          	inc	L3671_pccom_fail_cnt
3239  01dd               L7702:
3240                     ; 178                 init_uart_sim();
3242  01dd cd0000        	call	_init_uart_sim
3244                     ; 179                 commu_state = COMMU_STATE_TRANSMIT; //go to transmit command
3246  01e0 3f01          	clr	L1671_commu_state
3247                     ; 180                 command_id = MACHINE_INFO_QUERY;
3249  01e2 35010002      	mov	L7571_command_id,#1
3250                     ; 181                 cnt_rec2 = 0;
3252  01e6 3f00          	clr	_cnt_rec2
3253                     ; 182                 cnt_tra2 = 0;
3255  01e8 3f00          	clr	_cnt_tra2
3256                     ; 183                 pccom_cnt = 0;
3258  01ea 3f00          	clr	_pccom_cnt
3260  01ec 200a          	jra	L5502
3261  01ee               L3702:
3262                     ; 187                 pccom_cnt++; //in 20ms
3264  01ee 3c00          	inc	_pccom_cnt
3265  01f0 2006          	jra	L5502
3266  01f2               L7502:
3267                     ; 193         commu_state = COMMU_STATE_TRANSMIT;
3269  01f2 3f01          	clr	L1671_commu_state
3270                     ; 194         command_id = MACHINE_INFO_QUERY; //to setup the communication
3272  01f4 35010002      	mov	L7571_command_id,#1
3273  01f8               L5502:
3274                     ; 196 }
3277  01f8 85            	popw	x
3278  01f9 81            	ret
3359                     	xdef	_commu
3360                     	xdef	_flag_motor_params_changed
3361                     	xref	_getFanSpeed
3362                     	xref	_init_uart_sim
3363                     	xref	_turn_rx_off
3364                     	xref	__putchar
3365                     	switch	.bit
3366  0001               _flag_txd_process:
3367  0001 00            	ds.b	1
3368                     	xdef	_flag_txd_process
3369                     	switch	.ubsct
3370  0000               L3671_pccom_fail_cnt:
3371  0000 00            	ds.b	1
3372  0001               L1671_commu_state:
3373  0001 00            	ds.b	1
3374  0002               L7571_command_id:
3375  0002 00            	ds.b	1
3376  0003               _command_size:
3377  0003 00            	ds.b	1
3378                     	xdef	_command_size
3379  0004               _ram_d3:
3380  0004 00            	ds.b	1
3381                     	xdef	_ram_d3
3382                     	xref	_user_steps_last
3383                     	xref	_user_steps
3384                     	xref	_machine_volt_motor
3385                     	xref	_machine_current_motor
3386                     	xref	_dc_motor_rating_f1
3387                     	xref	_dc_motor_startup_volt
3388                     	xref	_dc_motor_rating_volt
3389                     	xref.b	_machine_rpm_target
3390                     	xbit	_machine_state
3391                     	xref.b	_power_board_version
3392                     	xref.b	_user_rpm_target
3393                     	xref.b	_user_request
3394                     	xref	_pctxd
3395                     	xref	_pcrxd
3396                     	xref.b	_pccom_cnt
3397                     	xbit	_pcerr_com
3398                     	xbit	_pcorder
3399                     	xref.b	_cnt_tra2
3400                     	xref.b	_cnt_rec2
3401                     	xref.b	_error_code
3402                     	xref.b	c_y
3422                     	end
