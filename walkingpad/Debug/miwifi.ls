   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2765                     	switch	.data
2766  0000               L1771_ack_str:
2767  0000 00            	dc.b	0
2768  0001 000000000000  	ds.b	99
2769                     .const:	section	.text
2770  0000               L7002_MODEL:
2771  0000 6d6f64656c00  	dc.b	"model",0
2772  0006               L1102_MODEL_NAME:
2773  0006 6b736d622e77  	dc.b	"ksmb.walkingpad.v1",0
2774  0019               _FW_VERSION:
2775  0019 3030343300    	dc.b	"0043",0
2776  001e               L3102_OK:
2777  001e 6f6b00        	dc.b	"ok",0
2820                     ; 83 static void process_net_state(const char *str)
2820                     ; 84 {
2822                     	switch	.text
2823  0000               L5102_process_net_state:
2825  0000 89            	pushw	x
2826       00000000      OFST:	set	0
2829                     ; 85     if (START_WITH(str, "offline"))
2831  0001 ae0007        	ldw	x,#7
2832  0004 89            	pushw	x
2833  0005 ae03cf        	ldw	x,#L5402
2834  0008 89            	pushw	x
2835  0009 1e05          	ldw	x,(OFST+5,sp)
2836  000b cd0000        	call	_strncmp
2838  000e 5b04          	addw	sp,#4
2839  0010 a30000        	cpw	x,#0
2840  0013 2607          	jrne	L3402
2841                     ; 86         net_state = NET_STATE_OFFLINE;
2843  0015 350100fb      	mov	_net_state,#1
2845  0019 cc009c        	jra	L7402
2846  001c               L3402:
2847                     ; 87     else if (START_WITH(str, "local"))
2849  001c ae0005        	ldw	x,#5
2850  001f 89            	pushw	x
2851  0020 ae03c9        	ldw	x,#L3502
2852  0023 89            	pushw	x
2853  0024 1e05          	ldw	x,(OFST+5,sp)
2854  0026 cd0000        	call	_strncmp
2856  0029 5b04          	addw	sp,#4
2857  002b a30000        	cpw	x,#0
2858  002e 2606          	jrne	L1502
2859                     ; 88         net_state = NET_STATE_LOCAL;
2861  0030 350200fb      	mov	_net_state,#2
2863  0034 2066          	jra	L7402
2864  0036               L1502:
2865                     ; 89     else if (START_WITH(str, "cloud"))
2867  0036 ae0005        	ldw	x,#5
2868  0039 89            	pushw	x
2869  003a ae03c3        	ldw	x,#L1602
2870  003d 89            	pushw	x
2871  003e 1e05          	ldw	x,(OFST+5,sp)
2872  0040 cd0000        	call	_strncmp
2874  0043 5b04          	addw	sp,#4
2875  0045 a30000        	cpw	x,#0
2876  0048 2606          	jrne	L7502
2877                     ; 90         net_state = NET_STATE_CLOUD;
2879  004a 350300fb      	mov	_net_state,#3
2881  004e 204c          	jra	L7402
2882  0050               L7502:
2883                     ; 91     else if (START_WITH(str, "updating"))
2885  0050 ae0008        	ldw	x,#8
2886  0053 89            	pushw	x
2887  0054 ae03ba        	ldw	x,#L7602
2888  0057 89            	pushw	x
2889  0058 1e05          	ldw	x,(OFST+5,sp)
2890  005a cd0000        	call	_strncmp
2892  005d 5b04          	addw	sp,#4
2893  005f a30000        	cpw	x,#0
2894  0062 2606          	jrne	L5602
2895                     ; 92         net_state = NET_STATE_UPDATING;
2897  0064 350400fb      	mov	_net_state,#4
2899  0068 2032          	jra	L7402
2900  006a               L5602:
2901                     ; 93     else if (START_WITH(str, "uap"))
2903  006a ae0003        	ldw	x,#3
2904  006d 89            	pushw	x
2905  006e ae03b6        	ldw	x,#L5702
2906  0071 89            	pushw	x
2907  0072 1e05          	ldw	x,(OFST+5,sp)
2908  0074 cd0000        	call	_strncmp
2910  0077 5b04          	addw	sp,#4
2911  0079 a30000        	cpw	x,#0
2912  007c 2606          	jrne	L3702
2913                     ; 94         net_state = NET_STATE_UAP;
2915  007e 350500fb      	mov	_net_state,#5
2917  0082 2018          	jra	L7402
2918  0084               L3702:
2919                     ; 95     else if (START_WITH(str, "unprov"))
2921  0084 ae0006        	ldw	x,#6
2922  0087 89            	pushw	x
2923  0088 ae03af        	ldw	x,#L3012
2924  008b 89            	pushw	x
2925  008c 1e05          	ldw	x,(OFST+5,sp)
2926  008e cd0000        	call	_strncmp
2928  0091 5b04          	addw	sp,#4
2929  0093 a30000        	cpw	x,#0
2930  0096 2604          	jrne	L7402
2931                     ; 96         net_state = NET_STATE_UNPROV;
2933  0098 350600fb      	mov	_net_state,#6
2934  009c               L7402:
2935                     ; 97 }
2938  009c 85            	popw	x
2939  009d 81            	ret
2985                     ; 99 static uchar parse_speed(uchar *ptr)
2985                     ; 100 {
2986                     	switch	.text
2987  009e               L5012_parse_speed:
2989  009e 89            	pushw	x
2990  009f 89            	pushw	x
2991       00000002      OFST:	set	2
2994                     ; 102     if (ptr[0] == '"')
2996  00a0 f6            	ld	a,(x)
2997  00a1 a122          	cp	a,#34
2998  00a3 2607          	jrne	L1312
2999                     ; 103         ptr += 1;
3001  00a5 1e03          	ldw	x,(OFST+1,sp)
3002  00a7 1c0001        	addw	x,#1
3003  00aa 1f03          	ldw	(OFST+1,sp),x
3004  00ac               L1312:
3005                     ; 105     temp = atoi(ptr);
3007  00ac 1e03          	ldw	x,(OFST+1,sp)
3008  00ae cd0000        	call	_atoi
3010  00b1 1f01          	ldw	(OFST-1,sp),x
3011                     ; 106     temp *= 10;
3013  00b3 1e01          	ldw	x,(OFST-1,sp)
3014  00b5 90ae000a      	ldw	y,#10
3015  00b9 cd0000        	call	c_imul
3017  00bc 1f01          	ldw	(OFST-1,sp),x
3018                     ; 107     ptr = strchr(ptr, '.');
3020  00be 4b2e          	push	#46
3021  00c0 1e04          	ldw	x,(OFST+2,sp)
3022  00c2 cd0000        	call	_strchr
3024  00c5 84            	pop	a
3025  00c6 1f03          	ldw	(OFST+1,sp),x
3026                     ; 108     if (ptr != 0 && isdigit(ptr[1]))
3028  00c8 1e03          	ldw	x,(OFST+1,sp)
3029  00ca 2735          	jreq	L3312
3031  00cc 1e03          	ldw	x,(OFST+1,sp)
3032  00ce e601          	ld	a,(1,x)
3033  00d0 a130          	cp	a,#48
3034  00d2 252d          	jrult	L3312
3036  00d4 1e03          	ldw	x,(OFST+1,sp)
3037  00d6 e601          	ld	a,(1,x)
3038  00d8 a13a          	cp	a,#58
3039  00da 2425          	jruge	L3312
3040                     ; 110         temp += ptr[1] - '0';
3042  00dc 1e03          	ldw	x,(OFST+1,sp)
3043  00de e601          	ld	a,(1,x)
3044  00e0 5f            	clrw	x
3045  00e1 97            	ld	xl,a
3046  00e2 1d0030        	subw	x,#48
3047  00e5 72fb01        	addw	x,(OFST-1,sp)
3048  00e8 1f01          	ldw	(OFST-1,sp),x
3049                     ; 111         if (ptr[2] >= '5' && ptr[2] <= '9')
3051  00ea 1e03          	ldw	x,(OFST+1,sp)
3052  00ec e602          	ld	a,(2,x)
3053  00ee a135          	cp	a,#53
3054  00f0 250f          	jrult	L3312
3056  00f2 1e03          	ldw	x,(OFST+1,sp)
3057  00f4 e602          	ld	a,(2,x)
3058  00f6 a13a          	cp	a,#58
3059  00f8 2407          	jruge	L3312
3060                     ; 112             temp++;
3062  00fa 1e01          	ldw	x,(OFST-1,sp)
3063  00fc 1c0001        	addw	x,#1
3064  00ff 1f01          	ldw	(OFST-1,sp),x
3065  0101               L3312:
3066                     ; 115     if (temp < 0)
3068  0101 9c            	rvf
3069  0102 1e01          	ldw	x,(OFST-1,sp)
3070  0104 2e03          	jrsge	L7312
3071                     ; 116         temp = 0;
3073  0106 5f            	clrw	x
3074  0107 1f01          	ldw	(OFST-1,sp),x
3075  0109               L7312:
3076                     ; 118     return (uchar)(temp * 3);
3078  0109 7b02          	ld	a,(OFST+0,sp)
3079  010b 97            	ld	xl,a
3080  010c a603          	ld	a,#3
3081  010e 42            	mul	x,a
3082  010f 9f            	ld	a,xl
3085  0110 5b04          	addw	sp,#4
3086  0112 81            	ret
3112                     ; 121 static void clear_offline_data(void)
3112                     ; 122 {
3113                     	switch	.text
3114  0113               L1412_clear_offline_data:
3118                     ; 123     store_point.offline_dist = 0;
3120  0113 5f            	clrw	x
3121  0114 cf00eb        	ldw	_store_point+21,x
3122                     ; 124     store_point.offline_energy = 0;
3124  0117 ae0000        	ldw	x,#0
3125  011a cf00ef        	ldw	_store_point+25,x
3126  011d ae0000        	ldw	x,#0
3127  0120 cf00ed        	ldw	_store_point+23,x
3128                     ; 125     store_point.offline_steps = 0;
3130  0123 5f            	clrw	x
3131  0124 cf00f1        	ldw	_store_point+27,x
3132                     ; 126     store_point.offline_time = 0;
3134  0127 5f            	clrw	x
3135  0128 cf00f3        	ldw	_store_point+29,x
3136                     ; 127     eeprom_write_int(EEPROM_ADDR_OFFLINE_DIST, 0);
3138  012b 5f            	clrw	x
3139  012c 89            	pushw	x
3140  012d ae4017        	ldw	x,#16407
3141  0130 cd0000        	call	_eeprom_write_int
3143  0133 85            	popw	x
3144                     ; 128     eeprom_write_long(EEPROM_ADDR_OFFLINE_ENERGY, 0);
3146  0134 ae0000        	ldw	x,#0
3147  0137 89            	pushw	x
3148  0138 ae0000        	ldw	x,#0
3149  013b 89            	pushw	x
3150  013c ae4019        	ldw	x,#16409
3151  013f cd0000        	call	_eeprom_write_long
3153  0142 5b04          	addw	sp,#4
3154                     ; 129     eeprom_write_int(EEPROM_ADDR_OFFLINE_STEPS, 0);
3156  0144 5f            	clrw	x
3157  0145 89            	pushw	x
3158  0146 ae401d        	ldw	x,#16413
3159  0149 cd0000        	call	_eeprom_write_int
3161  014c 85            	popw	x
3162                     ; 130     eeprom_write_int(EEPROM_ADDR_OFFLINE_TIME, 0);
3164  014d 5f            	clrw	x
3165  014e 89            	pushw	x
3166  014f ae401f        	ldw	x,#16415
3167  0152 cd0000        	call	_eeprom_write_int
3169  0155 85            	popw	x
3170                     ; 131 }
3173  0156 81            	ret
3220                     ; 133 static char *append_str(char *ptr, const char *str)
3220                     ; 134 {
3221                     	switch	.text
3222  0157               L3512_append_str:
3224  0157 89            	pushw	x
3225       00000000      OFST:	set	0
3228                     ; 135     return ptr + sprintf(ptr, "\"%s\" ", str);
3230  0158 1e05          	ldw	x,(OFST+5,sp)
3231  015a 89            	pushw	x
3232  015b ae03a9        	ldw	x,#L7712
3233  015e 89            	pushw	x
3234  015f 1e05          	ldw	x,(OFST+5,sp)
3235  0161 cd0000        	call	_sprintf
3237  0164 5b04          	addw	sp,#4
3238  0166 72fb01        	addw	x,(OFST+1,sp)
3241  0169 5b02          	addw	sp,#2
3242  016b 81            	ret
3288                     ; 138 static char *append_int(char *str, const uint n)
3288                     ; 139 {
3289                     	switch	.text
3290  016c               L1022_append_int:
3292  016c 89            	pushw	x
3293       00000000      OFST:	set	0
3296                     ; 140     return str + sprintf(str, "%d ", n);
3298  016d 1e05          	ldw	x,(OFST+5,sp)
3299  016f 89            	pushw	x
3300  0170 ae03a5        	ldw	x,#L5222
3301  0173 89            	pushw	x
3302  0174 1e05          	ldw	x,(OFST+5,sp)
3303  0176 cd0000        	call	_sprintf
3305  0179 5b04          	addw	sp,#4
3306  017b 72fb01        	addw	x,(OFST+1,sp)
3309  017e 5b02          	addw	sp,#2
3310  0180 81            	ret
3356                     ; 143 static char *append_long(char *str, const ulong n)
3356                     ; 144 {
3357                     	switch	.text
3358  0181               L7222_append_long:
3360  0181 89            	pushw	x
3361       00000000      OFST:	set	0
3364                     ; 145     return str + sprintf(str, "%ld ", n);
3366  0182 1e07          	ldw	x,(OFST+7,sp)
3367  0184 89            	pushw	x
3368  0185 1e07          	ldw	x,(OFST+7,sp)
3369  0187 89            	pushw	x
3370  0188 ae03a0        	ldw	x,#L3522
3371  018b 89            	pushw	x
3372  018c 1e07          	ldw	x,(OFST+7,sp)
3373  018e cd0000        	call	_sprintf
3375  0191 5b06          	addw	sp,#6
3376  0193 72fb01        	addw	x,(OFST+1,sp)
3379  0196 5b02          	addw	sp,#2
3380  0198 81            	ret
3426                     ; 148 static char *append_speed(char *str, const uchar sp)
3426                     ; 149 {
3427                     	switch	.text
3428  0199               L5522_append_speed:
3430  0199 89            	pushw	x
3431       00000000      OFST:	set	0
3434                     ; 150     return str + sprintf(str, "%d.%d ", (uint)sp / 30, ((uint)sp % 30) / 3);
3436  019a 7b05          	ld	a,(OFST+5,sp)
3437  019c 5f            	clrw	x
3438  019d 97            	ld	xl,a
3439  019e a61e          	ld	a,#30
3440  01a0 62            	div	x,a
3441  01a1 5f            	clrw	x
3442  01a2 97            	ld	xl,a
3443  01a3 a603          	ld	a,#3
3444  01a5 62            	div	x,a
3445  01a6 89            	pushw	x
3446  01a7 7b07          	ld	a,(OFST+7,sp)
3447  01a9 5f            	clrw	x
3448  01aa 97            	ld	xl,a
3449  01ab a61e          	ld	a,#30
3450  01ad 62            	div	x,a
3451  01ae 89            	pushw	x
3452  01af ae0399        	ldw	x,#L1032
3453  01b2 89            	pushw	x
3454  01b3 1e07          	ldw	x,(OFST+7,sp)
3455  01b5 cd0000        	call	_sprintf
3457  01b8 5b06          	addw	sp,#6
3458  01ba 72fb01        	addw	x,(OFST+1,sp)
3461  01bd 5b02          	addw	sp,#2
3462  01bf 81            	ret
3465                     	switch	.ubsct
3466  0000               L5032_store_time:
3467  0000 00000000      	ds.b	4
3510                     	switch	.const
3511  0021               L42:
3512  0021 00001388      	dc.l	5000
3513                     ; 153 static ulong get_store_time(void)
3513                     ; 154 {
3514                     	switch	.text
3515  01c0               L3032_get_store_time:
3517  01c0 5204          	subw	sp,#4
3518       00000004      OFST:	set	4
3521                     ; 156     ulong temp = server_time + clock() / CLOCKS_PER_SEC;
3523  01c2 cd0000        	call	_clock
3525  01c5 ae0021        	ldw	x,#L42
3526  01c8 cd0000        	call	c_ludv
3528  01cb ae00d0        	ldw	x,#_server_time
3529  01ce cd0000        	call	c_ladd
3531  01d1 96            	ldw	x,sp
3532  01d2 1c0001        	addw	x,#OFST-3
3533  01d5 cd0000        	call	c_rtol
3535                     ; 157     if (temp > store_time)
3537  01d8 96            	ldw	x,sp
3538  01d9 1c0001        	addw	x,#OFST-3
3539  01dc cd0000        	call	c_ltor
3541  01df ae0000        	ldw	x,#L5032_store_time
3542  01e2 cd0000        	call	c_lcmp
3544  01e5 230a          	jrule	L1332
3545                     ; 158         store_time = temp;
3547  01e7 1e03          	ldw	x,(OFST-1,sp)
3548  01e9 bf02          	ldw	L5032_store_time+2,x
3549  01eb 1e01          	ldw	x,(OFST-3,sp)
3550  01ed bf00          	ldw	L5032_store_time,x
3552  01ef 2008          	jra	L3332
3553  01f1               L1332:
3554                     ; 160         store_time++;
3556  01f1 ae0000        	ldw	x,#L5032_store_time
3557  01f4 a601          	ld	a,#1
3558  01f6 cd0000        	call	c_lgadc
3560  01f9               L3332:
3561                     ; 161     return store_time;
3563  01f9 ae0000        	ldw	x,#L5032_store_time
3564  01fc cd0000        	call	c_ltor
3568  01ff 5b04          	addw	sp,#4
3569  0201 81            	ret
3572                     	switch	.ubsct
3573  0004               L7432_error_code:
3574  0004 0000          	ds.b	2
3575                     	xref	_error_id
3576                     	xref	_userstate
3577                     	xref	_display_seg
3578  0006               L1432_props_speed:
3579  0006 00            	ds.b	1
3580  0007               L7332_props_mode:
3581  0007 00            	ds.b	1
3582                     	xref	_user_total_distance
3583  0008               L5332_props_time_second:
3584  0008 00            	ds.b	1
3585  0009               L5432_props_step:
3586  0009 0000          	ds.b	2
3587  000b               L3432_props_dist:
3588  000b 0000          	ds.b	2
3589                     	xref	_error_time
3779                     	switch	.const
3780  0025               L45:
3781  0025 050c          	dc.w	L5632
3782  0027 051b          	dc.w	L7632
3783  0029 0533          	dc.w	L1732
3784  002b 0547          	dc.w	L3732
3785  002d 0330          	dc.w	L5532
3786  002f 0302          	dc.w	L1532
3787  0031 0311          	dc.w	L3532
3788  0033 0555          	dc.w	L5732
3789  0035 057f          	dc.w	L7732
3790  0037 0471          	dc.w	L7532
3791  0039 048d          	dc.w	L1632
3792  003b 04cc          	dc.w	L3632
3793  003d 058c          	dc.w	L1042
3794  003f 0599          	dc.w	L3042
3795  0041 05ad          	dc.w	L5042
3796  0043 05ba          	dc.w	L7042
3797  0045 05cc          	dc.w	L1142
3798  0047               L221:
3799  0047 5a6ed45b      	dc.l	1517212763
3800  004b               L621:
3801  004b 1422          	dc.w	L5242
3802  004d 1447          	dc.w	L7242
3803  004f 146c          	dc.w	L1342
3804  0051 1491          	dc.w	L3342
3805  0053 13f2          	dc.w	L1242
3806  0055 0635          	dc.w	L5142
3807  0057 13f2          	dc.w	L1242
3808  0059 1583          	dc.w	L3672
3809  005b 14be          	dc.w	L5342
3810  005d 13f2          	dc.w	L1242
3811  005f 13ee          	dc.w	L7142
3812  0061 1412          	dc.w	L3242
3813  0063 14c8          	dc.w	L7342
3814  0065 13f2          	dc.w	L1242
3815  0067 14d4          	dc.w	L1442
3816  0069 1508          	dc.w	L3442
3817  006b 1527          	dc.w	L5442
3818                     ; 165 void commu_wifi(void)
3818                     ; 166 {
3819                     	switch	.text
3820  0202               _commu_wifi:
3822  0202 5208          	subw	sp,#8
3823       00000008      OFST:	set	8
3826                     ; 184     if (commu_mcu2wifi_state == COMMU_STATE_MCU2WIFI_TRANSMIT)
3828  0204 c600cf        	ld	a,L7571_commu_mcu2wifi_state
3829  0207 a101          	cp	a,#1
3830  0209 2703          	jreq	L231
3831  020b cc0606        	jp	L3352
3832  020e               L231:
3833                     ; 186         if (has_wifi_flag(FLAG_WIFI_RESTORE))
3835  020e c600fc        	ld	a,_commu_wifi_flag
3836  0211 a501          	bcp	a,#1
3837  0213 2708          	jreq	L5352
3838                     ; 187             mcu2wifi_cmd = MCU_WIFI_RESTORE;
3840  0215 350400ce      	mov	L1671_mcu2wifi_cmd,#4
3842  0219 ace202e2      	jpf	L7352
3843  021d               L5352:
3844                     ; 188         else if (has_wifi_flag(FLAG_WIFI_FACTORY))
3846  021d c600fc        	ld	a,_commu_wifi_flag
3847  0220 a508          	bcp	a,#8
3848  0222 2708          	jreq	L1452
3849                     ; 189             mcu2wifi_cmd = MCU_WIFI_FACTORY;
3851  0224 350d00ce      	mov	L1671_mcu2wifi_cmd,#13
3853  0228 ace202e2      	jpf	L7352
3854  022c               L1452:
3855                     ; 190         else if (mcu2wifi_cmd == MCU_WIFI_NO_COMMAND)
3857  022c 725d00ce      	tnz	L1671_mcu2wifi_cmd
3858  0230 2703          	jreq	L431
3859  0232 cc02de        	jp	L5452
3860  0235               L431:
3861                     ; 192             if (has_wifi_flag(FLAG_WIFI_ERROR_ID))
3863  0235 c600fc        	ld	a,_commu_wifi_flag
3864  0238 a510          	bcp	a,#16
3865  023a 270c          	jreq	L7452
3866                     ; 194                 clear_wifi_flag(FLAG_WIFI_ERROR_ID);
3868  023c 721900fc      	bres	_commu_wifi_flag,#4
3869                     ; 195                 mcu2wifi_cmd = MCU_WIFI_ERROR_ID;
3871  0240 350e00ce      	mov	L1671_mcu2wifi_cmd,#14
3873  0244 ace202e2      	jpf	L7352
3874  0248               L7452:
3875                     ; 197             else if (has_wifi_flag(FLAG_WIFI_STORE_OFFLINE))
3877  0248 c600fc        	ld	a,_commu_wifi_flag
3878  024b a520          	bcp	a,#32
3879  024d 270c          	jreq	L3552
3880                     ; 199                 set_wifi_flag(FLAG_WIFI_STORE_POINT);
3882  024f 721400fc      	bset	_commu_wifi_flag,#2
3883                     ; 200                 mcu2wifi_cmd = MCU_WIFI_STORE_OFFLINE;
3885  0253 350c00ce      	mov	L1671_mcu2wifi_cmd,#12
3887  0257 ace202e2      	jpf	L7352
3888  025b               L3552:
3889                     ; 202             else if (has_wifi_flag(FLAG_WIFI_STORE_POINT))
3891  025b c600fc        	ld	a,_commu_wifi_flag
3892  025e a504          	bcp	a,#4
3893  0260 2706          	jreq	L7552
3894                     ; 205                 mcu2wifi_cmd = MCU_WIFI_STORE_POINT;
3896  0262 350b00ce      	mov	L1671_mcu2wifi_cmd,#11
3898  0266 207a          	jra	L7352
3899  0268               L7552:
3900                     ; 207             else if (has_wifi_flag(FLAG_WIFI_STORE_MP))
3902  0268 c600fc        	ld	a,_commu_wifi_flag
3903  026b a502          	bcp	a,#2
3904  026d 270a          	jreq	L3652
3905                     ; 209                 clear_wifi_flag(FLAG_WIFI_STORE_MP);
3907  026f 721300fc      	bres	_commu_wifi_flag,#1
3908                     ; 210                 mcu2wifi_cmd = MCU_WIFI_STORE_MP;
3910  0273 350a00ce      	mov	L1671_mcu2wifi_cmd,#10
3912  0277 2069          	jra	L7352
3913  0279               L3652:
3914                     ; 212             else if (net_state == NET_STATE_UNKNOWN)
3916  0279 725d00fb      	tnz	_net_state
3917  027d 2606          	jrne	L7652
3918                     ; 214                 mcu2wifi_cmd = MCU_WIFI_NET;
3920  027f 350900ce      	mov	L1671_mcu2wifi_cmd,#9
3922  0283 205d          	jra	L7352
3923  0285               L7652:
3924                     ; 216             else if ((props_time_second != user_time_second || props_speed != machine_speed_target || props_mode != runmode) && net_state == NET_STATE_CLOUD)
3926  0285 b608          	ld	a,L5332_props_time_second
3927  0287 c10000        	cp	a,_user_time_second
3928  028a 260c          	jrne	L5752
3930  028c b606          	ld	a,L1432_props_speed
3931  028e b100          	cp	a,_machine_speed_target
3932  0290 2606          	jrne	L5752
3934  0292 b607          	ld	a,L7332_props_mode
3935  0294 b100          	cp	a,_runmode
3936  0296 270d          	jreq	L3752
3937  0298               L5752:
3939  0298 c600fb        	ld	a,_net_state
3940  029b a103          	cp	a,#3
3941  029d 2606          	jrne	L3752
3942                     ; 218                 mcu2wifi_cmd = MCU_WIFI_PROPS;
3944  029f 350500ce      	mov	L1671_mcu2wifi_cmd,#5
3946  02a3 203d          	jra	L7352
3947  02a5               L3752:
3948                     ; 220             else if (net_state == NET_STATE_CLOUD && (!IS_TIME_SET || has_wifi_flag(FLAG_WIFI_SET_TIME)))
3950  02a5 c600fb        	ld	a,_net_state
3951  02a8 a103          	cp	a,#3
3952  02aa 2619          	jrne	L3062
3954  02ac ae00d0        	ldw	x,#_server_time
3955  02af cd0000        	call	c_lzmp
3957  02b2 2707          	jreq	L5062
3959  02b4 c600fc        	ld	a,_commu_wifi_flag
3960  02b7 a540          	bcp	a,#64
3961  02b9 270a          	jreq	L3062
3962  02bb               L5062:
3963                     ; 222                 clear_wifi_flag(FLAG_WIFI_SET_TIME);
3965  02bb 721d00fc      	bres	_commu_wifi_flag,#6
3966                     ; 223                 mcu2wifi_cmd = MCU_WIFI_TIME;
3968  02bf 351100ce      	mov	L1671_mcu2wifi_cmd,#17
3970  02c3 201d          	jra	L7352
3971  02c5               L3062:
3972                     ; 227                 transmit_delay++;
3974  02c5 725c0000      	inc	L3002_transmit_delay
3975                     ; 228                 if (transmit_delay > 24)
3977  02c9 c60000        	ld	a,L3002_transmit_delay
3978  02cc a119          	cp	a,#25
3979  02ce 250a          	jrult	L1162
3980                     ; 230                     transmit_delay = 0;
3982  02d0 725f0000      	clr	L3002_transmit_delay
3983                     ; 231                     mcu2wifi_cmd = MCU_WIFI_GET_DOWN;
3985  02d4 350600ce      	mov	L1671_mcu2wifi_cmd,#6
3987  02d8 2008          	jra	L7352
3988  02da               L1162:
3989                     ; 234                     return;
3991  02da acc415c4      	jpf	L031
3992  02de               L5452:
3993                     ; 239             transmit_delay = 0;
3995  02de 725f0000      	clr	L3002_transmit_delay
3996  02e2               L7352:
3997                     ; 242         if (wifi2mcu_cmd == MCU_WIFI_NO_COMMAND)
3999  02e2 725d00cd      	tnz	L3671_wifi2mcu_cmd
4000  02e6 2703          	jreq	L631
4001  02e8 cc15c4        	jp	L3572
4002  02eb               L631:
4003                     ; 244             mcu2wifi_txd[0] = '\0';
4005  02eb 725f0069      	clr	L5671_mcu2wifi_txd
4006                     ; 245             switch (mcu2wifi_cmd)
4008  02ef c600ce        	ld	a,L1671_mcu2wifi_cmd
4010                     ; 338             default: //error
4010                     ; 339                 break;
4011  02f2 4a            	dec	a
4012  02f3 a111          	cp	a,#17
4013  02f5 2407          	jruge	L25
4014  02f7 5f            	clrw	x
4015  02f8 97            	ld	xl,a
4016  02f9 58            	sllw	x
4017  02fa de0025        	ldw	x,(L45,x)
4018  02fd fc            	jp	(x)
4019  02fe               L25:
4020  02fe acd705d7      	jpf	L3262
4021  0302               L1532:
4022                     ; 247             case MCU_WIFI_GET_DOWN:
4022                     ; 248                 strcpy(mcu2wifi_txd, "get_down");
4024  0302 ae0390        	ldw	x,#L5262
4025  0305 89            	pushw	x
4026  0306 ae0069        	ldw	x,#L5671_mcu2wifi_txd
4027  0309 cd0000        	call	_strcpy
4029  030c 85            	popw	x
4030                     ; 249                 break;
4032  030d acd705d7      	jpf	L3262
4033  0311               L3532:
4034                     ; 250             case MCU_WIFI_RESULT:
4034                     ; 251                 sprintf(mcu2wifi_txd, "result %s", ack_str[0] == '\0' ? "\"ok\"" : ack_str);
4036  0311 725d0000      	tnz	L1771_ack_str
4037  0315 2605          	jrne	L03
4038  0317 ae0381        	ldw	x,#L1362
4039  031a 2003          	jra	L23
4040  031c               L03:
4041  031c ae0000        	ldw	x,#L1771_ack_str
4042  031f               L23:
4043  031f 89            	pushw	x
4044  0320 ae0386        	ldw	x,#L7262
4045  0323 89            	pushw	x
4046  0324 ae0069        	ldw	x,#L5671_mcu2wifi_txd
4047  0327 cd0000        	call	_sprintf
4049  032a 5b04          	addw	sp,#4
4050                     ; 252                 break;
4052  032c acd705d7      	jpf	L3262
4053  0330               L5532:
4054                     ; 253             case MCU_WIFI_PROPS:
4054                     ; 254                 ptr0 = mcu2wifi_txd + sprintf(mcu2wifi_txd, "props ");
4056  0330 ae037a        	ldw	x,#L3362
4057  0333 89            	pushw	x
4058  0334 ae0069        	ldw	x,#L5671_mcu2wifi_txd
4059  0337 cd0000        	call	_sprintf
4061  033a 5b02          	addw	sp,#2
4062  033c 1c0069        	addw	x,#L5671_mcu2wifi_txd
4063  033f 1f07          	ldw	(OFST-1,sp),x
4064                     ; 255                 if (user_time_second != props_time_second)
4066  0341 c60000        	ld	a,_user_time_second
4067  0344 b108          	cp	a,L5332_props_time_second
4068  0346 2729          	jreq	L5362
4069                     ; 257                     props_time_second = user_time_second;
4071  0348 5500000008    	mov	L5332_props_time_second,_user_time_second
4072                     ; 258                     ptr0 += sprintf(ptr0, "time %d ", user_time_minute * 60 + user_time_second);
4074  034d ce0000        	ldw	x,_user_time_minute
4075  0350 90ae003c      	ldw	y,#60
4076  0354 cd0000        	call	c_imul
4078  0357 01            	rrwa	x,a
4079  0358 cb0000        	add	a,_user_time_second
4080  035b 2401          	jrnc	L43
4081  035d 5c            	incw	x
4082  035e               L43:
4083  035e 02            	rlwa	x,a
4084  035f 89            	pushw	x
4085  0360 01            	rrwa	x,a
4086  0361 ae0371        	ldw	x,#L7362
4087  0364 89            	pushw	x
4088  0365 1e0b          	ldw	x,(OFST+3,sp)
4089  0367 cd0000        	call	_sprintf
4091  036a 5b04          	addw	sp,#4
4092  036c 72fb07        	addw	x,(OFST-1,sp)
4093  036f 1f07          	ldw	(OFST-1,sp),x
4094  0371               L5362:
4095                     ; 260                 if (machine_speed_target != props_speed)
4097  0371 b600          	ld	a,_machine_speed_target
4098  0373 b106          	cp	a,L1432_props_speed
4099  0375 2743          	jreq	L1462
4100                     ; 262                     if (machine_speed_target == 0 || props_speed == 0)
4102  0377 3d00          	tnz	_machine_speed_target
4103  0379 2704          	jreq	L5462
4105  037b 3d06          	tnz	L1432_props_speed
4106  037d 261d          	jrne	L3462
4107  037f               L5462:
4108                     ; 264                         ptr0 += sprintf(ptr0, "state \"%s\" ", machine_speed_target > 0 ? "run" : "stop");
4110  037f 3d00          	tnz	_machine_speed_target
4111  0381 2705          	jreq	L63
4112  0383 ae0361        	ldw	x,#L1562
4113  0386 2003          	jra	L04
4114  0388               L63:
4115  0388 ae035c        	ldw	x,#L3562
4116  038b               L04:
4117  038b 89            	pushw	x
4118  038c ae0365        	ldw	x,#L7462
4119  038f 89            	pushw	x
4120  0390 1e0b          	ldw	x,(OFST+3,sp)
4121  0392 cd0000        	call	_sprintf
4123  0395 5b04          	addw	sp,#4
4124  0397 72fb07        	addw	x,(OFST-1,sp)
4125  039a 1f07          	ldw	(OFST-1,sp),x
4126  039c               L3462:
4127                     ; 266                     props_speed = machine_speed_target;
4129  039c 450006        	mov	L1432_props_speed,_machine_speed_target
4130                     ; 267                     ptr0 += sprintf(ptr0, "speed ");
4132  039f ae0355        	ldw	x,#L5562
4133  03a2 89            	pushw	x
4134  03a3 1e09          	ldw	x,(OFST+1,sp)
4135  03a5 cd0000        	call	_sprintf
4137  03a8 5b02          	addw	sp,#2
4138  03aa 72fb07        	addw	x,(OFST-1,sp)
4139  03ad 1f07          	ldw	(OFST-1,sp),x
4140                     ; 268                     ptr0 = append_speed(ptr0, machine_speed_target);
4142  03af 3b0000        	push	_machine_speed_target
4143  03b2 1e08          	ldw	x,(OFST+0,sp)
4144  03b4 cd0199        	call	L5522_append_speed
4146  03b7 84            	pop	a
4147  03b8 1f07          	ldw	(OFST-1,sp),x
4148  03ba               L1462:
4149                     ; 270                 if (runmode != props_mode)
4151  03ba b600          	ld	a,_runmode
4152  03bc b107          	cp	a,L7332_props_mode
4153  03be 2752          	jreq	L7562
4154                     ; 272                     if (runmode == RUN_MODE_STANDBY || props_mode == RUN_MODE_STANDBY)
4156  03c0 b600          	ld	a,_runmode
4157  03c2 a102          	cp	a,#2
4158  03c4 2706          	jreq	L3662
4160  03c6 b607          	ld	a,L7332_props_mode
4161  03c8 a102          	cp	a,#2
4162  03ca 261f          	jrne	L1662
4163  03cc               L3662:
4164                     ; 274                         ptr0 += sprintf(ptr0, "power \"%s\" ", runmode == RUN_MODE_STANDBY ? "off" : "on");
4166  03cc b600          	ld	a,_runmode
4167  03ce a102          	cp	a,#2
4168  03d0 2605          	jrne	L24
4169  03d2 ae0345        	ldw	x,#L7662
4170  03d5 2003          	jra	L44
4171  03d7               L24:
4172  03d7 ae0342        	ldw	x,#L1762
4173  03da               L44:
4174  03da 89            	pushw	x
4175  03db ae0349        	ldw	x,#L5662
4176  03de 89            	pushw	x
4177  03df 1e0b          	ldw	x,(OFST+3,sp)
4178  03e1 cd0000        	call	_sprintf
4180  03e4 5b04          	addw	sp,#4
4181  03e6 72fb07        	addw	x,(OFST-1,sp)
4182  03e9 1f07          	ldw	(OFST-1,sp),x
4183  03eb               L1662:
4184                     ; 276                     props_mode = runmode;
4186  03eb 450007        	mov	L7332_props_mode,_runmode
4187                     ; 277                     ptr0 += sprintf(ptr0, "mode %d type \"%s\" ", (uint)runmode, runmode == RUN_MODE_FIXED ? "fixed" : "auto");
4189  03ee b600          	ld	a,_runmode
4190  03f0 a101          	cp	a,#1
4191  03f2 2605          	jrne	L64
4192  03f4 ae0329        	ldw	x,#L5762
4193  03f7 2003          	jra	L05
4194  03f9               L64:
4195  03f9 ae0324        	ldw	x,#L7762
4196  03fc               L05:
4197  03fc 89            	pushw	x
4198  03fd b600          	ld	a,_runmode
4199  03ff 5f            	clrw	x
4200  0400 97            	ld	xl,a
4201  0401 89            	pushw	x
4202  0402 ae032f        	ldw	x,#L3762
4203  0405 89            	pushw	x
4204  0406 1e0d          	ldw	x,(OFST+5,sp)
4205  0408 cd0000        	call	_sprintf
4207  040b 5b06          	addw	sp,#6
4208  040d 72fb07        	addw	x,(OFST-1,sp)
4209  0410 1f07          	ldw	(OFST-1,sp),x
4210  0412               L7562:
4211                     ; 279                 if (user_distance != props_dist)
4213  0412 be00          	ldw	x,_user_distance
4214  0414 b30b          	cpw	x,L3432_props_dist
4215  0416 2732          	jreq	L1072
4216                     ; 281                     props_dist = user_distance;
4218  0418 be00          	ldw	x,_user_distance
4219  041a bf0b          	ldw	L3432_props_dist,x
4220                     ; 282                     ptr0 += sprintf(ptr0, "dist %ld cal %ld ", (ulong)user_distance * 10, user_calories * 10);
4222  041c ae0000        	ldw	x,#_user_calories
4223  041f cd0000        	call	c_ltor
4225  0422 a60a          	ld	a,#10
4226  0424 cd0000        	call	c_smul
4228  0427 be02          	ldw	x,c_lreg+2
4229  0429 89            	pushw	x
4230  042a be00          	ldw	x,c_lreg
4231  042c 89            	pushw	x
4232  042d be00          	ldw	x,_user_distance
4233  042f a60a          	ld	a,#10
4234  0431 cd0000        	call	c_cmulx
4236  0434 be02          	ldw	x,c_lreg+2
4237  0436 89            	pushw	x
4238  0437 be00          	ldw	x,c_lreg
4239  0439 89            	pushw	x
4240  043a ae0312        	ldw	x,#L3072
4241  043d 89            	pushw	x
4242  043e 1e11          	ldw	x,(OFST+9,sp)
4243  0440 cd0000        	call	_sprintf
4245  0443 5b0a          	addw	sp,#10
4246  0445 72fb07        	addw	x,(OFST-1,sp)
4247  0448 1f07          	ldw	(OFST-1,sp),x
4248  044a               L1072:
4249                     ; 284                 if (user_steps_total != props_step)
4251  044a ce0000        	ldw	x,_user_steps_total
4252  044d b309          	cpw	x,L5432_props_step
4253  044f 2603          	jrne	L041
4254  0451 cc05d7        	jp	L3262
4255  0454               L041:
4256                     ; 286                     props_step = user_steps_total;
4258  0454 ce0000        	ldw	x,_user_steps_total
4259  0457 bf09          	ldw	L5432_props_step,x
4260                     ; 287                     ptr0 += sprintf(ptr0, "step %d ", user_steps_total);
4262  0459 ce0000        	ldw	x,_user_steps_total
4263  045c 89            	pushw	x
4264  045d ae0309        	ldw	x,#L7072
4265  0460 89            	pushw	x
4266  0461 1e0b          	ldw	x,(OFST+3,sp)
4267  0463 cd0000        	call	_sprintf
4269  0466 5b04          	addw	sp,#4
4270  0468 72fb07        	addw	x,(OFST-1,sp)
4271  046b 1f07          	ldw	(OFST-1,sp),x
4272  046d acd705d7      	jpf	L3262
4273  0471               L7532:
4274                     ; 290             case MCU_WIFI_STORE_MP:
4274                     ; 291                 sprintf(mcu2wifi_txd, "store mp %d %d %d", store_mp.dur, store_mp.km, store_mp.time);
4276  0471 ce00f9        	ldw	x,_store_mp+4
4277  0474 89            	pushw	x
4278  0475 ce00f7        	ldw	x,_store_mp+2
4279  0478 89            	pushw	x
4280  0479 ce00f5        	ldw	x,_store_mp
4281  047c 89            	pushw	x
4282  047d ae02f7        	ldw	x,#L1172
4283  0480 89            	pushw	x
4284  0481 ae0069        	ldw	x,#L5671_mcu2wifi_txd
4285  0484 cd0000        	call	_sprintf
4287  0487 5b08          	addw	sp,#8
4288                     ; 292                 break;
4290  0489 acd705d7      	jpf	L3262
4291  048d               L1632:
4292                     ; 293             case MCU_WIFI_STORE_POINT:
4292                     ; 294                 sprintf(mcu2wifi_txd, "store point \"_override_time\" %ld %d %d %d %d %d %d %d %d %d", get_store_time(), store_point.dist, store_point.predist, store_point.preenergy, store_point.steps, store_point.presteps, store_point.time, store_point.pretime, (uint)store_point.presp, store_point.state);
4294  048d ce00e9        	ldw	x,_store_point+19
4295  0490 89            	pushw	x
4296  0491 c600e8        	ld	a,_store_point+18
4297  0494 5f            	clrw	x
4298  0495 97            	ld	xl,a
4299  0496 89            	pushw	x
4300  0497 ce00e6        	ldw	x,_store_point+16
4301  049a 89            	pushw	x
4302  049b ce00e4        	ldw	x,_store_point+14
4303  049e 89            	pushw	x
4304  049f ce00e2        	ldw	x,_store_point+12
4305  04a2 89            	pushw	x
4306  04a3 ce00e0        	ldw	x,_store_point+10
4307  04a6 89            	pushw	x
4308  04a7 ce00de        	ldw	x,_store_point+8
4309  04aa 89            	pushw	x
4310  04ab ce00d8        	ldw	x,_store_point+2
4311  04ae 89            	pushw	x
4312  04af ce00d6        	ldw	x,_store_point
4313  04b2 89            	pushw	x
4314  04b3 cd01c0        	call	L3032_get_store_time
4316  04b6 be02          	ldw	x,c_lreg+2
4317  04b8 89            	pushw	x
4318  04b9 be00          	ldw	x,c_lreg
4319  04bb 89            	pushw	x
4320  04bc ae02bb        	ldw	x,#L3172
4321  04bf 89            	pushw	x
4322  04c0 ae0069        	ldw	x,#L5671_mcu2wifi_txd
4323  04c3 cd0000        	call	_sprintf
4325  04c6 5b18          	addw	sp,#24
4326                     ; 295                 break;
4328  04c8 acd705d7      	jpf	L3262
4329  04cc               L3632:
4330                     ; 296             case MCU_WIFI_STORE_OFFLINE:
4330                     ; 297                 sprintf(mcu2wifi_txd, "store point \"_override_time\" %ld %d %d %ld %d %d %d %d %d %d", get_store_time(), store_point.offline_dist, store_point.offline_dist, store_point.offline_energy, store_point.offline_steps, store_point.offline_steps, store_point.offline_time, store_point.offline_time, 0, 0);
4332  04cc 5f            	clrw	x
4333  04cd 89            	pushw	x
4334  04ce 5f            	clrw	x
4335  04cf 89            	pushw	x
4336  04d0 ce00f3        	ldw	x,_store_point+29
4337  04d3 89            	pushw	x
4338  04d4 ce00f3        	ldw	x,_store_point+29
4339  04d7 89            	pushw	x
4340  04d8 ce00f1        	ldw	x,_store_point+27
4341  04db 89            	pushw	x
4342  04dc ce00f1        	ldw	x,_store_point+27
4343  04df 89            	pushw	x
4344  04e0 ce00ef        	ldw	x,_store_point+25
4345  04e3 89            	pushw	x
4346  04e4 ce00ed        	ldw	x,_store_point+23
4347  04e7 89            	pushw	x
4348  04e8 ce00eb        	ldw	x,_store_point+21
4349  04eb 89            	pushw	x
4350  04ec ce00eb        	ldw	x,_store_point+21
4351  04ef 89            	pushw	x
4352  04f0 cd01c0        	call	L3032_get_store_time
4354  04f3 be02          	ldw	x,c_lreg+2
4355  04f5 89            	pushw	x
4356  04f6 be00          	ldw	x,c_lreg
4357  04f8 89            	pushw	x
4358  04f9 ae027e        	ldw	x,#L5172
4359  04fc 89            	pushw	x
4360  04fd ae0069        	ldw	x,#L5671_mcu2wifi_txd
4361  0500 cd0000        	call	_sprintf
4363  0503 5b1a          	addw	sp,#26
4364                     ; 298                 clear_offline_data();
4366  0505 cd0113        	call	L1412_clear_offline_data
4368                     ; 299                 break;
4370  0508 acd705d7      	jpf	L3262
4371  050c               L5632:
4372                     ; 300             case MCU_WIFI_MODEL_QUERY:
4372                     ; 301                 strcpy(mcu2wifi_txd, MODEL);
4374  050c ae0000        	ldw	x,#L7002_MODEL
4375  050f 89            	pushw	x
4376  0510 ae0069        	ldw	x,#L5671_mcu2wifi_txd
4377  0513 cd0000        	call	_strcpy
4379  0516 85            	popw	x
4380                     ; 302                 break;
4382  0517 acd705d7      	jpf	L3262
4383  051b               L7632:
4384                     ; 303             case MCU_WIFI_MODEL_SETTING:
4384                     ; 304                 sprintf(mcu2wifi_txd, "%s %s", MODEL, MODEL_NAME);
4386  051b ae0006        	ldw	x,#L1102_MODEL_NAME
4387  051e 89            	pushw	x
4388  051f ae0000        	ldw	x,#L7002_MODEL
4389  0522 89            	pushw	x
4390  0523 ae0278        	ldw	x,#L7172
4391  0526 89            	pushw	x
4392  0527 ae0069        	ldw	x,#L5671_mcu2wifi_txd
4393  052a cd0000        	call	_sprintf
4395  052d 5b06          	addw	sp,#6
4396                     ; 305                 break;
4398  052f acd705d7      	jpf	L3262
4399  0533               L1732:
4400                     ; 306             case MCU_WIFI_VERSION:
4400                     ; 307                 sprintf(mcu2wifi_txd, "mcu_version %s", FW_VERSION);
4402  0533 ae0019        	ldw	x,#_FW_VERSION
4403  0536 89            	pushw	x
4404  0537 ae0269        	ldw	x,#L1272
4405  053a 89            	pushw	x
4406  053b ae0069        	ldw	x,#L5671_mcu2wifi_txd
4407  053e cd0000        	call	_sprintf
4409  0541 5b04          	addw	sp,#4
4410                     ; 308                 break;
4412  0543 acd705d7      	jpf	L3262
4413  0547               L3732:
4414                     ; 309             case MCU_WIFI_RESTORE:
4414                     ; 310                 strcpy(mcu2wifi_txd, "restore");
4416  0547 ae0261        	ldw	x,#L3272
4417  054a 89            	pushw	x
4418  054b ae0069        	ldw	x,#L5671_mcu2wifi_txd
4419  054e cd0000        	call	_strcpy
4421  0551 85            	popw	x
4422                     ; 311                 break;
4424  0552 cc05d7        	jra	L3262
4425  0555               L5732:
4426                     ; 312             case MCU_WIFI_ERROR:
4426                     ; 313                 if (error_code == -5001)
4428  0555 be04          	ldw	x,L7432_error_code
4429  0557 a3ec77        	cpw	x,#60535
4430  055a 2607          	jrne	L5272
4431                     ; 314                     ptr0 = "command";
4433  055c ae0259        	ldw	x,#L7272
4434  055f 1f07          	ldw	(OFST-1,sp),x
4436  0561 2005          	jra	L1372
4437  0563               L5272:
4438                     ; 316                     ptr0 = "error";
4440  0563 ae0253        	ldw	x,#L3372
4441  0566 1f07          	ldw	(OFST-1,sp),x
4442  0568               L1372:
4443                     ; 317                 sprintf(mcu2wifi_txd, "error \"unknown %s\" %d", ptr0, error_code);
4445  0568 be04          	ldw	x,L7432_error_code
4446  056a 89            	pushw	x
4447  056b 1e09          	ldw	x,(OFST+1,sp)
4448  056d 89            	pushw	x
4449  056e ae023d        	ldw	x,#L5372
4450  0571 89            	pushw	x
4451  0572 ae0069        	ldw	x,#L5671_mcu2wifi_txd
4452  0575 cd0000        	call	_sprintf
4454  0578 5b06          	addw	sp,#6
4455                     ; 318                 error_code = 0;
4457  057a 5f            	clrw	x
4458  057b bf04          	ldw	L7432_error_code,x
4459                     ; 319                 break;
4461  057d 2058          	jra	L3262
4462  057f               L7732:
4463                     ; 320             case MCU_WIFI_NET:
4463                     ; 321                 strcpy(mcu2wifi_txd, "net");
4465  057f ae0239        	ldw	x,#L7372
4466  0582 89            	pushw	x
4467  0583 ae0069        	ldw	x,#L5671_mcu2wifi_txd
4468  0586 cd0000        	call	_strcpy
4470  0589 85            	popw	x
4471                     ; 322                 break;
4473  058a 204b          	jra	L3262
4474  058c               L1042:
4475                     ; 323             case MCU_WIFI_FACTORY:
4475                     ; 324                 strcpy(mcu2wifi_txd, "factory");
4477  058c ae0231        	ldw	x,#L1472
4478  058f 89            	pushw	x
4479  0590 ae0069        	ldw	x,#L5671_mcu2wifi_txd
4480  0593 cd0000        	call	_strcpy
4482  0596 85            	popw	x
4483                     ; 325                 break;
4485  0597 203e          	jra	L3262
4486  0599               L3042:
4487                     ; 326             case MCU_WIFI_ERROR_ID:
4487                     ; 327                 sprintf(mcu2wifi_txd, "event error %d", (uint)error_id);
4489  0599 c60000        	ld	a,_error_id
4490  059c 5f            	clrw	x
4491  059d 97            	ld	xl,a
4492  059e 89            	pushw	x
4493  059f ae0222        	ldw	x,#L3472
4494  05a2 89            	pushw	x
4495  05a3 ae0069        	ldw	x,#L5671_mcu2wifi_txd
4496  05a6 cd0000        	call	_sprintf
4498  05a9 5b04          	addw	sp,#4
4499                     ; 328                 break;
4501  05ab 202a          	jra	L3262
4502  05ad               L5042:
4503                     ; 329             case MCU_BLE_CONFIG_DUMP:
4503                     ; 330                 strcpy(mcu2wifi_txd, "ble_config dump");
4505  05ad ae0212        	ldw	x,#L5472
4506  05b0 89            	pushw	x
4507  05b1 ae0069        	ldw	x,#L5671_mcu2wifi_txd
4508  05b4 cd0000        	call	_strcpy
4510  05b7 85            	popw	x
4511                     ; 331                 break;
4513  05b8 201d          	jra	L3262
4514  05ba               L7042:
4515                     ; 332             case MCU_BLE_CONFIG_SET:
4515                     ; 333                 sprintf(mcu2wifi_txd, "ble_config set 331 %s", FW_VERSION);
4517  05ba ae0019        	ldw	x,#_FW_VERSION
4518  05bd 89            	pushw	x
4519  05be ae01fc        	ldw	x,#L7472
4520  05c1 89            	pushw	x
4521  05c2 ae0069        	ldw	x,#L5671_mcu2wifi_txd
4522  05c5 cd0000        	call	_sprintf
4524  05c8 5b04          	addw	sp,#4
4525                     ; 334                 break;
4527  05ca 200b          	jra	L3262
4528  05cc               L1142:
4529                     ; 335             case MCU_WIFI_TIME:
4529                     ; 336                 strcpy(mcu2wifi_txd, "time posix");
4531  05cc ae01f1        	ldw	x,#L1572
4532  05cf 89            	pushw	x
4533  05d0 ae0069        	ldw	x,#L5671_mcu2wifi_txd
4534  05d3 cd0000        	call	_strcpy
4536  05d6 85            	popw	x
4537                     ; 337                 break;
4539  05d7               L3142:
4540                     ; 338             default: //error
4540                     ; 339                 break;
4542  05d7               L3262:
4543                     ; 342             commu_mcu2wifi_state = COMMU_STATE_MCU2WIFI_RECEIVE; //switch to receive
4545  05d7 350200cf      	mov	L7571_commu_mcu2wifi_state,#2
4546                     ; 343             command_mcu2wifi_size = (uchar)strlen(mcu2wifi_txd);
4548  05db ae0069        	ldw	x,#L5671_mcu2wifi_txd
4549  05de cd0000        	call	_strlen
4551  05e1 9f            	ld	a,xl
4552  05e2 c70003        	ld	L5771_command_mcu2wifi_size,a
4553                     ; 344             mcu2wifi_txd[command_mcu2wifi_size++] = '\r';
4555  05e5 c60003        	ld	a,L5771_command_mcu2wifi_size
4556  05e8 97            	ld	xl,a
4557  05e9 725c0003      	inc	L5771_command_mcu2wifi_size
4558  05ed 9f            	ld	a,xl
4559  05ee 5f            	clrw	x
4560  05ef 97            	ld	xl,a
4561  05f0 a60d          	ld	a,#13
4562  05f2 d70069        	ld	(L5671_mcu2wifi_txd,x),a
4563                     ; 345             wifi2mcu_cmd = mcu2wifi_cmd;
4565  05f5 5500ce00cd    	mov	L3671_wifi2mcu_cmd,L1671_mcu2wifi_cmd
4566                     ; 346             mcu2wifi_cmd = MCU_WIFI_NO_COMMAND;
4568  05fa 725f00ce      	clr	L1671_mcu2wifi_cmd
4569                     ; 347             TXEN_FLAG = 1; //txd enable
4571  05fe 72165245      	bset	_UART2_CR2,#3
4572  0602 acc415c4      	jpf	L3572
4573  0606               L3352:
4574                     ; 350     else if (commu_mcu2wifi_state == COMMU_STATE_MCU2WIFI_RECEIVE)
4576  0606 c600cf        	ld	a,L7571_commu_mcu2wifi_state
4577  0609 a102          	cp	a,#2
4578  060b 2703          	jreq	L241
4579  060d cc15b1        	jp	L5572
4580  0610               L241:
4581                     ; 352         if (recvorder == 1)
4583                     	btst	L5002_recvorder
4584  0615 2503          	jrult	L441
4585  0617 cc1591        	jp	L7572
4586  061a               L441:
4587                     ; 354             transmit_delay = 0;
4589  061a 725f0000      	clr	L3002_transmit_delay
4590                     ; 355             recvorder = 0;
4592  061e 72110000      	bres	L5002_recvorder
4593                     ; 356             switch (wifi2mcu_cmd)
4595  0622 c600cd        	ld	a,L3671_wifi2mcu_cmd
4597                     ; 1005             default:
4597                     ; 1006                 break;
4598  0625 4a            	dec	a
4599  0626 a111          	cp	a,#17
4600  0628 2407          	jruge	L421
4601  062a 5f            	clrw	x
4602  062b 97            	ld	xl,a
4603  062c 58            	sllw	x
4604  062d de004b        	ldw	x,(L621,x)
4605  0630 fc            	jp	(x)
4606  0631               L421:
4607  0631 ac831583      	jpf	L3672
4608  0635               L5142:
4609                     ; 358             case MCU_WIFI_GET_DOWN:
4609                     ; 359                 ack_str[0] = '\0';
4611  0635 725f0000      	clr	L1771_ack_str
4612                     ; 360                 if (START_WITH(mcu2wifi_rxd, "down"))
4614  0639 ae0004        	ldw	x,#4
4615  063c 89            	pushw	x
4616  063d ae01ec        	ldw	x,#L7672
4617  0640 89            	pushw	x
4618  0641 ae0005        	ldw	x,#L7671_mcu2wifi_rxd
4619  0644 cd0000        	call	_strncmp
4621  0647 5b04          	addw	sp,#4
4622  0649 a30000        	cpw	x,#0
4623  064c 2703          	jreq	L641
4624  064e cc13d2        	jp	L5672
4625  0651               L641:
4626                     ; 362                     ptr0 = mcu2wifi_rxd + 5;
4628  0651 ae000a        	ldw	x,#L7671_mcu2wifi_rxd+5
4629  0654 1f07          	ldw	(OFST-1,sp),x
4630                     ; 364                     if (START_WITH(ptr0, "none")) //
4632  0656 ae0004        	ldw	x,#4
4633  0659 89            	pushw	x
4634  065a ae01e7        	ldw	x,#L3772
4635  065d 89            	pushw	x
4636  065e ae000a        	ldw	x,#L7671_mcu2wifi_rxd+5
4637  0661 cd0000        	call	_strncmp
4639  0664 5b04          	addw	sp,#4
4640  0666 a30000        	cpw	x,#0
4641  0669 2603          	jrne	L051
4642  066b cc1583        	jp	L3672
4643  066e               L051:
4644                     ; 366                         break;
4646                     ; 368                     else if (START_WITH(ptr0, "get_prop"))
4648  066e ae0008        	ldw	x,#8
4649  0671 89            	pushw	x
4650  0672 ae01de        	ldw	x,#L1003
4651  0675 89            	pushw	x
4652  0676 ae000a        	ldw	x,#L7671_mcu2wifi_rxd+5
4653  0679 cd0000        	call	_strncmp
4655  067c 5b04          	addw	sp,#4
4656  067e a30000        	cpw	x,#0
4657  0681 2703          	jreq	L251
4658  0683 cc0bd9        	jp	L7772
4659  0686               L251:
4660                     ; 370                         for (ptr0 += sizeof("get_prop") - 1 + 2, ptr1 = ack_str, ptr2 = ptr0 + strlen(ptr0); ptr0 < ptr2;)
4662  0686 1e07          	ldw	x,(OFST-1,sp)
4663  0688 1c000a        	addw	x,#10
4664  068b 1f07          	ldw	(OFST-1,sp),x
4665  068d ae0000        	ldw	x,#L1771_ack_str
4666  0690 1f05          	ldw	(OFST-3,sp),x
4667  0692 1e07          	ldw	x,(OFST-1,sp)
4668  0694 cd0000        	call	_strlen
4670  0697 72fb07        	addw	x,(OFST-1,sp)
4671  069a 1f01          	ldw	(OFST-7,sp),x
4673  069c accc0bcc      	jpf	L7003
4674  06a0               L3003:
4675                     ; 372                             if (START_WITH(ptr0, "mode"))
4677  06a0 ae0004        	ldw	x,#4
4678  06a3 89            	pushw	x
4679  06a4 ae01d9        	ldw	x,#L5103
4680  06a7 89            	pushw	x
4681  06a8 1e0b          	ldw	x,(OFST+3,sp)
4682  06aa cd0000        	call	_strncmp
4684  06ad 5b04          	addw	sp,#4
4685  06af a30000        	cpw	x,#0
4686  06b2 2619          	jrne	L3103
4687                     ; 374                                 ptr0 += 7; // strlen("mode\",\"")
4689  06b4 1e07          	ldw	x,(OFST-1,sp)
4690  06b6 1c0007        	addw	x,#7
4691  06b9 1f07          	ldw	(OFST-1,sp),x
4692                     ; 375                                 ptr1 = append_int(ptr1, runmode);
4694  06bb b600          	ld	a,_runmode
4695  06bd 5f            	clrw	x
4696  06be 97            	ld	xl,a
4697  06bf 89            	pushw	x
4698  06c0 1e07          	ldw	x,(OFST-1,sp)
4699  06c2 cd016c        	call	L1022_append_int
4701  06c5 5b02          	addw	sp,#2
4702  06c7 1f05          	ldw	(OFST-3,sp),x
4704  06c9 accc0bcc      	jpf	L7003
4705  06cd               L3103:
4706                     ; 377                             else if (START_WITH(ptr0, "time"))
4708  06cd ae0004        	ldw	x,#4
4709  06d0 89            	pushw	x
4710  06d1 ae01d4        	ldw	x,#L3203
4711  06d4 89            	pushw	x
4712  06d5 1e0b          	ldw	x,(OFST+3,sp)
4713  06d7 cd0000        	call	_strncmp
4715  06da 5b04          	addw	sp,#4
4716  06dc a30000        	cpw	x,#0
4717  06df 2628          	jrne	L1203
4718                     ; 379                                 ptr0 += 7;
4720  06e1 1e07          	ldw	x,(OFST-1,sp)
4721  06e3 1c0007        	addw	x,#7
4722  06e6 1f07          	ldw	(OFST-1,sp),x
4723                     ; 380                                 ptr1 = append_int(ptr1, user_time_minute * 60u + user_time_second);
4725  06e8 ce0000        	ldw	x,_user_time_minute
4726  06eb 90ae003c      	ldw	y,#60
4727  06ef cd0000        	call	c_imul
4729  06f2 01            	rrwa	x,a
4730  06f3 cb0000        	add	a,_user_time_second
4731  06f6 2401          	jrnc	L65
4732  06f8 5c            	incw	x
4733  06f9               L65:
4734  06f9 02            	rlwa	x,a
4735  06fa 89            	pushw	x
4736  06fb 01            	rrwa	x,a
4737  06fc 1e07          	ldw	x,(OFST-1,sp)
4738  06fe cd016c        	call	L1022_append_int
4740  0701 5b02          	addw	sp,#2
4741  0703 1f05          	ldw	(OFST-3,sp),x
4743  0705 accc0bcc      	jpf	L7003
4744  0709               L1203:
4745                     ; 382                             else if (START_WITH(ptr0, "sp"))
4747  0709 ae0002        	ldw	x,#2
4748  070c 89            	pushw	x
4749  070d ae01d1        	ldw	x,#L1303
4750  0710 89            	pushw	x
4751  0711 1e0b          	ldw	x,(OFST+3,sp)
4752  0713 cd0000        	call	_strncmp
4754  0716 5b04          	addw	sp,#4
4755  0718 a30000        	cpw	x,#0
4756  071b 2651          	jrne	L7203
4757                     ; 384                                 if (START_WITH(ptr0, "speed"))
4759  071d ae0005        	ldw	x,#5
4760  0720 89            	pushw	x
4761  0721 ae01cb        	ldw	x,#L5303
4762  0724 89            	pushw	x
4763  0725 1e0b          	ldw	x,(OFST+3,sp)
4764  0727 cd0000        	call	_strncmp
4766  072a 5b04          	addw	sp,#4
4767  072c a30000        	cpw	x,#0
4768  072f 2609          	jrne	L3303
4769                     ; 385                                     ptr0 += 8;
4771  0731 1e07          	ldw	x,(OFST-1,sp)
4772  0733 1c0008        	addw	x,#8
4773  0736 1f07          	ldw	(OFST-1,sp),x
4775  0738 2007          	jra	L7303
4776  073a               L3303:
4777                     ; 387                                     ptr0 += 5;
4779  073a 1e07          	ldw	x,(OFST-1,sp)
4780  073c 1c0005        	addw	x,#5
4781  073f 1f07          	ldw	(OFST-1,sp),x
4782  0741               L7303:
4783                     ; 388                                 if (runmode == RUN_MODE_AUTO || machine_speed_target == 0 || tutorial_state >= TUTORIAL_STEP3_BEGIN)
4785  0741 3d00          	tnz	_runmode
4786  0743 270b          	jreq	L3403
4788  0745 3d00          	tnz	_machine_speed_target
4789  0747 2707          	jreq	L3403
4791  0749 c60000        	ld	a,_tutorial_state
4792  074c a105          	cp	a,#5
4793  074e 2515          	jrult	L1403
4794  0750               L3403:
4795                     ; 390                                     temp = machine_speed_target;
4797  0750 b600          	ld	a,_machine_speed_target
4798  0752 5f            	clrw	x
4799  0753 97            	ld	xl,a
4800  0754 1f03          	ldw	(OFST-5,sp),x
4802  0756               L7403:
4803                     ; 396                                 ptr1 = append_speed(ptr1, temp);
4805  0756 7b04          	ld	a,(OFST-4,sp)
4806  0758 88            	push	a
4807  0759 1e06          	ldw	x,(OFST-2,sp)
4808  075b cd0199        	call	L5522_append_speed
4810  075e 84            	pop	a
4811  075f 1f05          	ldw	(OFST-3,sp),x
4813  0761 accc0bcc      	jpf	L7003
4814  0765               L1403:
4815                     ; 394                                     temp = fixed_mode_speed;
4817  0765 c60000        	ld	a,_fixed_mode_speed
4818  0768 5f            	clrw	x
4819  0769 97            	ld	xl,a
4820  076a 1f03          	ldw	(OFST-5,sp),x
4821  076c 20e8          	jra	L7403
4822  076e               L7203:
4823                     ; 398                             else if (START_WITH(ptr0, "dist"))
4825  076e ae0004        	ldw	x,#4
4826  0771 89            	pushw	x
4827  0772 ae01c6        	ldw	x,#L5503
4828  0775 89            	pushw	x
4829  0776 1e0b          	ldw	x,(OFST+3,sp)
4830  0778 cd0000        	call	_strncmp
4832  077b 5b04          	addw	sp,#4
4833  077d a30000        	cpw	x,#0
4834  0780 2621          	jrne	L3503
4835                     ; 400                                 ptr0 += 7;
4837  0782 1e07          	ldw	x,(OFST-1,sp)
4838  0784 1c0007        	addw	x,#7
4839  0787 1f07          	ldw	(OFST-1,sp),x
4840                     ; 401                                 ptr1 = append_long(ptr1, (ulong)user_distance * 10);
4842  0789 be00          	ldw	x,_user_distance
4843  078b a60a          	ld	a,#10
4844  078d cd0000        	call	c_cmulx
4846  0790 be02          	ldw	x,c_lreg+2
4847  0792 89            	pushw	x
4848  0793 be00          	ldw	x,c_lreg
4849  0795 89            	pushw	x
4850  0796 1e09          	ldw	x,(OFST+1,sp)
4851  0798 cd0181        	call	L7222_append_long
4853  079b 5b04          	addw	sp,#4
4854  079d 1f05          	ldw	(OFST-3,sp),x
4856  079f accc0bcc      	jpf	L7003
4857  07a3               L3503:
4858                     ; 403                             else if (START_WITH(ptr0, "cal"))
4860  07a3 ae0003        	ldw	x,#3
4861  07a6 89            	pushw	x
4862  07a7 ae01c2        	ldw	x,#L3603
4863  07aa 89            	pushw	x
4864  07ab 1e0b          	ldw	x,(OFST+3,sp)
4865  07ad cd0000        	call	_strncmp
4867  07b0 5b04          	addw	sp,#4
4868  07b2 a30000        	cpw	x,#0
4869  07b5 2625          	jrne	L1603
4870                     ; 405                                 ptr0 += 6;
4872  07b7 1e07          	ldw	x,(OFST-1,sp)
4873  07b9 1c0006        	addw	x,#6
4874  07bc 1f07          	ldw	(OFST-1,sp),x
4875                     ; 406                                 ptr1 = append_long(ptr1, user_calories * 10);
4877  07be ae0000        	ldw	x,#_user_calories
4878  07c1 cd0000        	call	c_ltor
4880  07c4 a60a          	ld	a,#10
4881  07c6 cd0000        	call	c_smul
4883  07c9 be02          	ldw	x,c_lreg+2
4884  07cb 89            	pushw	x
4885  07cc be00          	ldw	x,c_lreg
4886  07ce 89            	pushw	x
4887  07cf 1e09          	ldw	x,(OFST+1,sp)
4888  07d1 cd0181        	call	L7222_append_long
4890  07d4 5b04          	addw	sp,#4
4891  07d6 1f05          	ldw	(OFST-3,sp),x
4893  07d8 accc0bcc      	jpf	L7003
4894  07dc               L1603:
4895                     ; 408                             else if (START_WITH(ptr0, "step"))
4897  07dc ae0004        	ldw	x,#4
4898  07df 89            	pushw	x
4899  07e0 ae01bd        	ldw	x,#L1703
4900  07e3 89            	pushw	x
4901  07e4 1e0b          	ldw	x,(OFST+3,sp)
4902  07e6 cd0000        	call	_strncmp
4904  07e9 5b04          	addw	sp,#4
4905  07eb a30000        	cpw	x,#0
4906  07ee 2618          	jrne	L7603
4907                     ; 410                                 ptr0 += 7;
4909  07f0 1e07          	ldw	x,(OFST-1,sp)
4910  07f2 1c0007        	addw	x,#7
4911  07f5 1f07          	ldw	(OFST-1,sp),x
4912                     ; 411                                 ptr1 = append_int(ptr1, user_steps_total);
4914  07f7 ce0000        	ldw	x,_user_steps_total
4915  07fa 89            	pushw	x
4916  07fb 1e07          	ldw	x,(OFST-1,sp)
4917  07fd cd016c        	call	L1022_append_int
4919  0800 5b02          	addw	sp,#2
4920  0802 1f05          	ldw	(OFST-3,sp),x
4922  0804 accc0bcc      	jpf	L7003
4923  0808               L7603:
4924                     ; 413                             else if (START_WITH(ptr0, "all"))
4926  0808 ae0003        	ldw	x,#3
4927  080b 89            	pushw	x
4928  080c ae01b9        	ldw	x,#L7703
4929  080f 89            	pushw	x
4930  0810 1e0b          	ldw	x,(OFST+3,sp)
4931  0812 cd0000        	call	_strncmp
4933  0815 5b04          	addw	sp,#4
4934  0817 a30000        	cpw	x,#0
4935  081a 2660          	jrne	L5703
4936                     ; 415                                 sprintf(ack_str, "\"mode:%d\",\"time:%d\",\"sp:%d.%d\",\"dist:%ld\",\"cal:%ld\",\"step:%d\"",
4936                     ; 416                                         (uint)runmode,
4936                     ; 417                                         user_time_minute * 60 + user_time_second,
4936                     ; 418                                         (uint)machine_speed_target / 30,
4936                     ; 419                                         (uint)(machine_speed_target % 30) / 3,
4936                     ; 420                                         (ulong)user_distance * 10,
4936                     ; 421                                         user_calories * 10,
4936                     ; 422                                         user_steps_total);
4938  081c ce0000        	ldw	x,_user_steps_total
4939  081f 89            	pushw	x
4940  0820 ae0000        	ldw	x,#_user_calories
4941  0823 cd0000        	call	c_ltor
4943  0826 a60a          	ld	a,#10
4944  0828 cd0000        	call	c_smul
4946  082b be02          	ldw	x,c_lreg+2
4947  082d 89            	pushw	x
4948  082e be00          	ldw	x,c_lreg
4949  0830 89            	pushw	x
4950  0831 be00          	ldw	x,_user_distance
4951  0833 a60a          	ld	a,#10
4952  0835 cd0000        	call	c_cmulx
4954  0838 be02          	ldw	x,c_lreg+2
4955  083a 89            	pushw	x
4956  083b be00          	ldw	x,c_lreg
4957  083d 89            	pushw	x
4958  083e b600          	ld	a,_machine_speed_target
4959  0840 5f            	clrw	x
4960  0841 97            	ld	xl,a
4961  0842 a61e          	ld	a,#30
4962  0844 62            	div	x,a
4963  0845 5f            	clrw	x
4964  0846 97            	ld	xl,a
4965  0847 a603          	ld	a,#3
4966  0849 62            	div	x,a
4967  084a 89            	pushw	x
4968  084b b600          	ld	a,_machine_speed_target
4969  084d 5f            	clrw	x
4970  084e 97            	ld	xl,a
4971  084f a61e          	ld	a,#30
4972  0851 62            	div	x,a
4973  0852 89            	pushw	x
4974  0853 ce0000        	ldw	x,_user_time_minute
4975  0856 90ae003c      	ldw	y,#60
4976  085a cd0000        	call	c_imul
4978  085d 01            	rrwa	x,a
4979  085e cb0000        	add	a,_user_time_second
4980  0861 2401          	jrnc	L06
4981  0863 5c            	incw	x
4982  0864               L06:
4983  0864 02            	rlwa	x,a
4984  0865 89            	pushw	x
4985  0866 01            	rrwa	x,a
4986  0867 b600          	ld	a,_runmode
4987  0869 5f            	clrw	x
4988  086a 97            	ld	xl,a
4989  086b 89            	pushw	x
4990  086c ae017b        	ldw	x,#L1013
4991  086f 89            	pushw	x
4992  0870 ae0000        	ldw	x,#L1771_ack_str
4993  0873 cd0000        	call	_sprintf
4995  0876 5b14          	addw	sp,#20
4996                     ; 423                                 break;
4998  0878 acc113c1      	jpf	L5772
4999  087c               L5703:
5000                     ; 425                             else if (START_WITH(ptr0, "button_id"))
5002  087c ae0009        	ldw	x,#9
5003  087f 89            	pushw	x
5004  0880 ae0171        	ldw	x,#L7013
5005  0883 89            	pushw	x
5006  0884 1e0b          	ldw	x,(OFST+3,sp)
5007  0886 cd0000        	call	_strncmp
5009  0889 5b04          	addw	sp,#4
5010  088b a30000        	cpw	x,#0
5011  088e 261c          	jrne	L5013
5012                     ; 427                                 ptr0 += 12;
5014  0890 1e07          	ldw	x,(OFST-1,sp)
5015  0892 1c000c        	addw	x,#12
5016  0895 1f07          	ldw	(OFST-1,sp),x
5017                     ; 428                                 ptr1 = append_int(ptr1, button_id);
5019  0897 ce00d4        	ldw	x,_button_id
5020  089a 89            	pushw	x
5021  089b 1e07          	ldw	x,(OFST-1,sp)
5022  089d cd016c        	call	L1022_append_int
5024  08a0 5b02          	addw	sp,#2
5025  08a2 1f05          	ldw	(OFST-3,sp),x
5026                     ; 429                                 button_id = KEY_NONE;
5028  08a4 5f            	clrw	x
5029  08a5 cf00d4        	ldw	_button_id,x
5031  08a8 accc0bcc      	jpf	L7003
5032  08ac               L5013:
5033                     ; 431                             else if (START_WITH(ptr0, "start_speed"))
5035  08ac ae000b        	ldw	x,#11
5036  08af 89            	pushw	x
5037  08b0 ae0165        	ldw	x,#L5113
5038  08b3 89            	pushw	x
5039  08b4 1e0b          	ldw	x,(OFST+3,sp)
5040  08b6 cd0000        	call	_strncmp
5042  08b9 5b04          	addw	sp,#4
5043  08bb a30000        	cpw	x,#0
5044  08be 2616          	jrne	L3113
5045                     ; 433                                 ptr0 += 14;
5047  08c0 1e07          	ldw	x,(OFST-1,sp)
5048  08c2 1c000e        	addw	x,#14
5049  08c5 1f07          	ldw	(OFST-1,sp),x
5050                     ; 434                                 ptr1 = append_speed(ptr1, fixed_start_speed);
5052  08c7 3b0000        	push	_fixed_start_speed
5053  08ca 1e06          	ldw	x,(OFST-2,sp)
5054  08cc cd0199        	call	L5522_append_speed
5056  08cf 84            	pop	a
5057  08d0 1f05          	ldw	(OFST-3,sp),x
5059  08d2 accc0bcc      	jpf	L7003
5060  08d6               L3113:
5061                     ; 436                             else if (START_WITH(ptr0, "goal"))
5063  08d6 ae0004        	ldw	x,#4
5064  08d9 89            	pushw	x
5065  08da ae0160        	ldw	x,#L3213
5066  08dd 89            	pushw	x
5067  08de 1e0b          	ldw	x,(OFST+3,sp)
5068  08e0 cd0000        	call	_strncmp
5070  08e3 5b04          	addw	sp,#4
5071  08e5 a30000        	cpw	x,#0
5072  08e8 2627          	jrne	L1213
5073                     ; 438                                 ptr0 += 7;
5075  08ea 1e07          	ldw	x,(OFST-1,sp)
5076  08ec 1c0007        	addw	x,#7
5077  08ef 1f07          	ldw	(OFST-1,sp),x
5078                     ; 439                                 ptr1 = append_int(ptr1, goal_type);
5080  08f1 c60000        	ld	a,_goal_type
5081  08f4 5f            	clrw	x
5082  08f5 97            	ld	xl,a
5083  08f6 89            	pushw	x
5084  08f7 1e07          	ldw	x,(OFST-1,sp)
5085  08f9 cd016c        	call	L1022_append_int
5087  08fc 5b02          	addw	sp,#2
5088  08fe 1f05          	ldw	(OFST-3,sp),x
5089                     ; 440                                 ptr1 = append_int(ptr1, goal_value);
5091  0900 ce0000        	ldw	x,_goal_value
5092  0903 89            	pushw	x
5093  0904 1e07          	ldw	x,(OFST-1,sp)
5094  0906 cd016c        	call	L1022_append_int
5096  0909 5b02          	addw	sp,#2
5097  090b 1f05          	ldw	(OFST-3,sp),x
5099  090d accc0bcc      	jpf	L7003
5100  0911               L1213:
5101                     ; 442                             else if (START_WITH(ptr0, "max"))
5103  0911 ae0003        	ldw	x,#3
5104  0914 89            	pushw	x
5105  0915 ae015c        	ldw	x,#L1313
5106  0918 89            	pushw	x
5107  0919 1e0b          	ldw	x,(OFST+3,sp)
5108  091b cd0000        	call	_strncmp
5110  091e 5b04          	addw	sp,#4
5111  0920 a30000        	cpw	x,#0
5112  0923 2616          	jrne	L7213
5113                     ; 444                                 ptr0 += 6;
5115  0925 1e07          	ldw	x,(OFST-1,sp)
5116  0927 1c0006        	addw	x,#6
5117  092a 1f07          	ldw	(OFST-1,sp),x
5118                     ; 445                                 ptr1 = append_speed(ptr1, speed_limit_max);
5120  092c 3b0000        	push	_speed_limit_max
5121  092f 1e06          	ldw	x,(OFST-2,sp)
5122  0931 cd0199        	call	L5522_append_speed
5124  0934 84            	pop	a
5125  0935 1f05          	ldw	(OFST-3,sp),x
5127  0937 accc0bcc      	jpf	L7003
5128  093b               L7213:
5129                     ; 447                             else if (START_WITH(ptr0, "sensitivity"))
5131  093b ae000b        	ldw	x,#11
5132  093e 89            	pushw	x
5133  093f ae0150        	ldw	x,#L7313
5134  0942 89            	pushw	x
5135  0943 1e0b          	ldw	x,(OFST+3,sp)
5136  0945 cd0000        	call	_strncmp
5138  0948 5b04          	addw	sp,#4
5139  094a a30000        	cpw	x,#0
5140  094d 261a          	jrne	L5313
5141                     ; 449                                 ptr0 += 14;
5143  094f 1e07          	ldw	x,(OFST-1,sp)
5144  0951 1c000e        	addw	x,#14
5145  0954 1f07          	ldw	(OFST-1,sp),x
5146                     ; 450                                 ptr1 = append_int(ptr1, acceleration_param);
5148  0956 c60000        	ld	a,_acceleration_param
5149  0959 5f            	clrw	x
5150  095a 97            	ld	xl,a
5151  095b 89            	pushw	x
5152  095c 1e07          	ldw	x,(OFST-1,sp)
5153  095e cd016c        	call	L1022_append_int
5155  0961 5b02          	addw	sp,#2
5156  0963 1f05          	ldw	(OFST-3,sp),x
5158  0965 accc0bcc      	jpf	L7003
5159  0969               L5313:
5160                     ; 452                             else if (START_WITH(ptr0, "error_id"))
5162  0969 ae0008        	ldw	x,#8
5163  096c 89            	pushw	x
5164  096d ae0147        	ldw	x,#L5413
5165  0970 89            	pushw	x
5166  0971 1e0b          	ldw	x,(OFST+3,sp)
5167  0973 cd0000        	call	_strncmp
5169  0976 5b04          	addw	sp,#4
5170  0978 a30000        	cpw	x,#0
5171  097b 261a          	jrne	L3413
5172                     ; 454                                 ptr0 += 11;
5174  097d 1e07          	ldw	x,(OFST-1,sp)
5175  097f 1c000b        	addw	x,#11
5176  0982 1f07          	ldw	(OFST-1,sp),x
5177                     ; 455                                 ptr1 = append_int(ptr1, error_id);
5179  0984 c60000        	ld	a,_error_id
5180  0987 5f            	clrw	x
5181  0988 97            	ld	xl,a
5182  0989 89            	pushw	x
5183  098a 1e07          	ldw	x,(OFST-1,sp)
5184  098c cd016c        	call	L1022_append_int
5186  098f 5b02          	addw	sp,#2
5187  0991 1f05          	ldw	(OFST-3,sp),x
5189  0993 accc0bcc      	jpf	L7003
5190  0997               L3413:
5191                     ; 457                             else if (START_WITH(ptr0, "log"))
5193  0997 ae0003        	ldw	x,#3
5194  099a 89            	pushw	x
5195  099b ae0143        	ldw	x,#L3513
5196  099e 89            	pushw	x
5197  099f 1e0b          	ldw	x,(OFST+3,sp)
5198  09a1 cd0000        	call	_strncmp
5200  09a4 5b04          	addw	sp,#4
5201  09a6 a30000        	cpw	x,#0
5202  09a9 264d          	jrne	L1513
5203                     ; 459                                 sprintf(ack_str, "\"{%d,%d,%ld,%ld,%ld,%ld,%d,%d,%d,%ld}\"\r",
5203                     ; 460                                         (uint)user_speed_target,
5203                     ; 461                                         (uint)machine_speed_target,
5203                     ; 462                                         tension,
5203                     ; 463                                         tension2,
5203                     ; 464                                         tension_bias,
5203                     ; 465                                         tension2_bias,
5203                     ; 466                                         user_request & 0xff,
5203                     ; 467                                         machine_current_motor,
5203                     ; 468                                         machine_volt_motor,
5203                     ; 469                                         user_total_distance);
5205  09ab ce0002        	ldw	x,_user_total_distance+2
5206  09ae 89            	pushw	x
5207  09af ce0000        	ldw	x,_user_total_distance
5208  09b2 89            	pushw	x
5209  09b3 3b0000        	push	_machine_volt_motor
5210  09b6 3b0000        	push	_machine_current_motor
5211  09b9 b600          	ld	a,_user_request
5212  09bb 5f            	clrw	x
5213  09bc 97            	ld	xl,a
5214  09bd 89            	pushw	x
5215  09be ce0002        	ldw	x,_tension2_bias+2
5216  09c1 89            	pushw	x
5217  09c2 ce0000        	ldw	x,_tension2_bias
5218  09c5 89            	pushw	x
5219  09c6 ce0002        	ldw	x,_tension_bias+2
5220  09c9 89            	pushw	x
5221  09ca ce0000        	ldw	x,_tension_bias
5222  09cd 89            	pushw	x
5223  09ce ce0002        	ldw	x,_tension2+2
5224  09d1 89            	pushw	x
5225  09d2 ce0000        	ldw	x,_tension2
5226  09d5 89            	pushw	x
5227  09d6 ce0002        	ldw	x,_tension+2
5228  09d9 89            	pushw	x
5229  09da ce0000        	ldw	x,_tension
5230  09dd 89            	pushw	x
5231  09de b600          	ld	a,_machine_speed_target
5232  09e0 5f            	clrw	x
5233  09e1 97            	ld	xl,a
5234  09e2 89            	pushw	x
5235  09e3 b600          	ld	a,_user_speed_target
5236  09e5 5f            	clrw	x
5237  09e6 97            	ld	xl,a
5238  09e7 89            	pushw	x
5239  09e8 ae011b        	ldw	x,#L5513
5240  09eb 89            	pushw	x
5241  09ec ae0000        	ldw	x,#L1771_ack_str
5242  09ef cd0000        	call	_sprintf
5244  09f2 5b1e          	addw	sp,#30
5245                     ; 470                                 break;
5247  09f4 acc113c1      	jpf	L5772
5248  09f8               L1513:
5249                     ; 512                             else if (START_WITH(ptr0, "auto"))
5251  09f8 ae0004        	ldw	x,#4
5252  09fb 89            	pushw	x
5253  09fc ae0324        	ldw	x,#L7762
5254  09ff 89            	pushw	x
5255  0a00 1e0b          	ldw	x,(OFST+3,sp)
5256  0a02 cd0000        	call	_strncmp
5258  0a05 5b04          	addw	sp,#4
5259  0a07 a30000        	cpw	x,#0
5260  0a0a 261c          	jrne	L1613
5261                     ; 514                                 ptr0 += 7;
5263  0a0c 1e07          	ldw	x,(OFST-1,sp)
5264  0a0e 1c0007        	addw	x,#7
5265  0a11 1f07          	ldw	(OFST-1,sp),x
5266                     ; 515                                 ptr1 = append_int(ptr1, flag_auto);
5268  0a13 5f            	clrw	x
5269                     	btst	_flag_auto
5270  0a19 59            	rlcw	x
5271  0a1a 89            	pushw	x
5272  0a1b 1e07          	ldw	x,(OFST-1,sp)
5273  0a1d cd016c        	call	L1022_append_int
5275  0a20 5b02          	addw	sp,#2
5276  0a22 1f05          	ldw	(OFST-3,sp),x
5278  0a24 accc0bcc      	jpf	L7003
5279  0a28               L1613:
5280                     ; 517                             else if (START_WITH(ptr0, "disp"))
5282  0a28 ae0004        	ldw	x,#4
5283  0a2b 89            	pushw	x
5284  0a2c ae0116        	ldw	x,#L7613
5285  0a2f 89            	pushw	x
5286  0a30 1e0b          	ldw	x,(OFST+3,sp)
5287  0a32 cd0000        	call	_strncmp
5289  0a35 5b04          	addw	sp,#4
5290  0a37 a30000        	cpw	x,#0
5291  0a3a 261a          	jrne	L5613
5292                     ; 519                                 ptr0 += 7;
5294  0a3c 1e07          	ldw	x,(OFST-1,sp)
5295  0a3e 1c0007        	addw	x,#7
5296  0a41 1f07          	ldw	(OFST-1,sp),x
5297                     ; 520                                 ptr1 = append_int(ptr1, flag_disp);
5299  0a43 c60000        	ld	a,_flag_disp
5300  0a46 5f            	clrw	x
5301  0a47 97            	ld	xl,a
5302  0a48 89            	pushw	x
5303  0a49 1e07          	ldw	x,(OFST-1,sp)
5304  0a4b cd016c        	call	L1022_append_int
5306  0a4e 5b02          	addw	sp,#2
5307  0a50 1f05          	ldw	(OFST-3,sp),x
5309  0a52 accc0bcc      	jpf	L7003
5310  0a56               L5613:
5311                     ; 522                             else if (START_WITH(ptr0, "initial"))
5313  0a56 ae0007        	ldw	x,#7
5314  0a59 89            	pushw	x
5315  0a5a ae010e        	ldw	x,#L5713
5316  0a5d 89            	pushw	x
5317  0a5e 1e0b          	ldw	x,(OFST+3,sp)
5318  0a60 cd0000        	call	_strncmp
5320  0a63 5b04          	addw	sp,#4
5321  0a65 a30000        	cpw	x,#0
5322  0a68 2621          	jrne	L3713
5323                     ; 524                                 ptr0 += 10;
5325  0a6a 1e07          	ldw	x,(OFST-1,sp)
5326  0a6c 1c000a        	addw	x,#10
5327  0a6f 1f07          	ldw	(OFST-1,sp),x
5328                     ; 525                                 ptr1 = append_int(ptr1, eeprom_rdchar(EEPROM_ADDR_INSURE_BINDED) | (eeprom_rdchar(EEPROM_ADDR_TUTORIAL_FINISH) << 1));
5330  0a71 c6400e        	ld	a,16398
5331  0a74 5f            	clrw	x
5332  0a75 97            	ld	xl,a
5333  0a76 58            	sllw	x
5334  0a77 01            	rrwa	x,a
5335  0a78 ca407e        	or	a,16510
5336  0a7b 02            	rlwa	x,a
5337  0a7c 89            	pushw	x
5338  0a7d 01            	rrwa	x,a
5339  0a7e 1e07          	ldw	x,(OFST-1,sp)
5340  0a80 cd016c        	call	L1022_append_int
5342  0a83 5b02          	addw	sp,#2
5343  0a85 1f05          	ldw	(OFST-3,sp),x
5345  0a87 accc0bcc      	jpf	L7003
5346  0a8b               L3713:
5347                     ; 527                             else if (START_WITH(ptr0, "lock"))
5349  0a8b ae0004        	ldw	x,#4
5350  0a8e 89            	pushw	x
5351  0a8f ae0109        	ldw	x,#L3023
5352  0a92 89            	pushw	x
5353  0a93 1e0b          	ldw	x,(OFST+3,sp)
5354  0a95 cd0000        	call	_strncmp
5356  0a98 5b04          	addw	sp,#4
5357  0a9a a30000        	cpw	x,#0
5358  0a9d 2622          	jrne	L1023
5359                     ; 529                                 ptr0 += 7;
5361  0a9f 1e07          	ldw	x,(OFST-1,sp)
5362  0aa1 1c0007        	addw	x,#7
5363  0aa4 1f07          	ldw	(OFST-1,sp),x
5364                     ; 530                                 ptr1 = append_int(ptr1, eeprom_rdchar(EEPROM_ADDR_RUNMODE) == RUN_MODE_LOCK);
5366  0aa6 c6400b        	ld	a,16395
5367  0aa9 a105          	cp	a,#5
5368  0aab 2605          	jrne	L26
5369  0aad ae0001        	ldw	x,#1
5370  0ab0 2001          	jra	L46
5371  0ab2               L26:
5372  0ab2 5f            	clrw	x
5373  0ab3               L46:
5374  0ab3 89            	pushw	x
5375  0ab4 1e07          	ldw	x,(OFST-1,sp)
5376  0ab6 cd016c        	call	L1022_append_int
5378  0ab9 5b02          	addw	sp,#2
5379  0abb 1f05          	ldw	(OFST-3,sp),x
5381  0abd accc0bcc      	jpf	L7003
5382  0ac1               L1023:
5383                     ; 532                             else if (START_WITH(ptr0, "offline"))
5385  0ac1 ae0007        	ldw	x,#7
5386  0ac4 89            	pushw	x
5387  0ac5 ae03cf        	ldw	x,#L5402
5388  0ac8 89            	pushw	x
5389  0ac9 1e0b          	ldw	x,(OFST+3,sp)
5390  0acb cd0000        	call	_strncmp
5392  0ace 5b04          	addw	sp,#4
5393  0ad0 a30000        	cpw	x,#0
5394  0ad3 2618          	jrne	L7023
5395                     ; 534                                 ptr0 += 11;
5397  0ad5 1e07          	ldw	x,(OFST-1,sp)
5398  0ad7 1c000b        	addw	x,#11
5399  0ada 1f07          	ldw	(OFST-1,sp),x
5400                     ; 535                                 ptr1 = append_int(ptr1, store_point.offline_dist);
5402  0adc ce00eb        	ldw	x,_store_point+21
5403  0adf 89            	pushw	x
5404  0ae0 1e07          	ldw	x,(OFST-1,sp)
5405  0ae2 cd016c        	call	L1022_append_int
5407  0ae5 5b02          	addw	sp,#2
5408  0ae7 1f05          	ldw	(OFST-3,sp),x
5410  0ae9 accc0bcc      	jpf	L7003
5411  0aed               L7023:
5412                     ; 537                             else if (START_WITH(ptr0, "userstate"))
5414  0aed ae0009        	ldw	x,#9
5415  0af0 89            	pushw	x
5416  0af1 ae00ff        	ldw	x,#L5123
5417  0af4 89            	pushw	x
5418  0af5 1e0b          	ldw	x,(OFST+3,sp)
5419  0af7 cd0000        	call	_strncmp
5421  0afa 5b04          	addw	sp,#4
5422  0afc a30000        	cpw	x,#0
5423  0aff 261a          	jrne	L3123
5424                     ; 539                                 ptr0 += 12;
5426  0b01 1e07          	ldw	x,(OFST-1,sp)
5427  0b03 1c000c        	addw	x,#12
5428  0b06 1f07          	ldw	(OFST-1,sp),x
5429                     ; 540                                 ptr1 = append_int(ptr1, userstate);
5431  0b08 c60000        	ld	a,_userstate
5432  0b0b 5f            	clrw	x
5433  0b0c 97            	ld	xl,a
5434  0b0d 89            	pushw	x
5435  0b0e 1e07          	ldw	x,(OFST-1,sp)
5436  0b10 cd016c        	call	L1022_append_int
5438  0b13 5b02          	addw	sp,#2
5439  0b15 1f05          	ldw	(OFST-3,sp),x
5441  0b17 accc0bcc      	jpf	L7003
5442  0b1b               L3123:
5443                     ; 542                             else if (START_WITH(ptr0, "type"))
5445  0b1b ae0004        	ldw	x,#4
5446  0b1e 89            	pushw	x
5447  0b1f ae00fa        	ldw	x,#L3223
5448  0b22 89            	pushw	x
5449  0b23 1e0b          	ldw	x,(OFST+3,sp)
5450  0b25 cd0000        	call	_strncmp
5452  0b28 5b04          	addw	sp,#4
5453  0b2a a30000        	cpw	x,#0
5454  0b2d 2621          	jrne	L1223
5455                     ; 544                                 ptr0 += 7;
5457  0b2f 1e07          	ldw	x,(OFST-1,sp)
5458  0b31 1c0007        	addw	x,#7
5459  0b34 1f07          	ldw	(OFST-1,sp),x
5460                     ; 545                                 ptr1 = append_str(ptr1, runmode == RUN_MODE_FIXED ? "fixed" : "auto");
5462  0b36 b600          	ld	a,_runmode
5463  0b38 a101          	cp	a,#1
5464  0b3a 2605          	jrne	L66
5465  0b3c ae0329        	ldw	x,#L5762
5466  0b3f 2003          	jra	L07
5467  0b41               L66:
5468  0b41 ae0324        	ldw	x,#L7762
5469  0b44               L07:
5470  0b44 89            	pushw	x
5471  0b45 1e07          	ldw	x,(OFST-1,sp)
5472  0b47 cd0157        	call	L3512_append_str
5474  0b4a 5b02          	addw	sp,#2
5475  0b4c 1f05          	ldw	(OFST-3,sp),x
5477  0b4e 207c          	jra	L7003
5478  0b50               L1223:
5479                     ; 547                             else if (START_WITH(ptr0, "state"))
5481  0b50 ae0005        	ldw	x,#5
5482  0b53 89            	pushw	x
5483  0b54 ae00f4        	ldw	x,#L1323
5484  0b57 89            	pushw	x
5485  0b58 1e0b          	ldw	x,(OFST+3,sp)
5486  0b5a cd0000        	call	_strncmp
5488  0b5d 5b04          	addw	sp,#4
5489  0b5f a30000        	cpw	x,#0
5490  0b62 261f          	jrne	L7223
5491                     ; 549                                 ptr0 += 8;
5493  0b64 1e07          	ldw	x,(OFST-1,sp)
5494  0b66 1c0008        	addw	x,#8
5495  0b69 1f07          	ldw	(OFST-1,sp),x
5496                     ; 550                                 ptr1 = append_str(ptr1, machine_speed_target == 0 ? "stop" : "run");
5498  0b6b 3d00          	tnz	_machine_speed_target
5499  0b6d 2605          	jrne	L27
5500  0b6f ae035c        	ldw	x,#L3562
5501  0b72 2003          	jra	L47
5502  0b74               L27:
5503  0b74 ae0361        	ldw	x,#L1562
5504  0b77               L47:
5505  0b77 89            	pushw	x
5506  0b78 1e07          	ldw	x,(OFST-1,sp)
5507  0b7a cd0157        	call	L3512_append_str
5509  0b7d 5b02          	addw	sp,#2
5510  0b7f 1f05          	ldw	(OFST-3,sp),x
5512  0b81 2049          	jra	L7003
5513  0b83               L7223:
5514                     ; 552                             else if (START_WITH(ptr0, "power"))
5516  0b83 ae0005        	ldw	x,#5
5517  0b86 89            	pushw	x
5518  0b87 ae00ee        	ldw	x,#L7323
5519  0b8a 89            	pushw	x
5520  0b8b 1e0b          	ldw	x,(OFST+3,sp)
5521  0b8d cd0000        	call	_strncmp
5523  0b90 5b04          	addw	sp,#4
5524  0b92 a30000        	cpw	x,#0
5525  0b95 2621          	jrne	L5323
5526                     ; 554                                 ptr0 += 8;
5528  0b97 1e07          	ldw	x,(OFST-1,sp)
5529  0b99 1c0008        	addw	x,#8
5530  0b9c 1f07          	ldw	(OFST-1,sp),x
5531                     ; 555                                 ptr1 = append_str(ptr1, runmode == RUN_MODE_STANDBY ? "off" : "on");
5533  0b9e b600          	ld	a,_runmode
5534  0ba0 a102          	cp	a,#2
5535  0ba2 2605          	jrne	L67
5536  0ba4 ae0345        	ldw	x,#L7662
5537  0ba7 2003          	jra	L001
5538  0ba9               L67:
5539  0ba9 ae0342        	ldw	x,#L1762
5540  0bac               L001:
5541  0bac 89            	pushw	x
5542  0bad 1e07          	ldw	x,(OFST-1,sp)
5543  0baf cd0157        	call	L3512_append_str
5545  0bb2 5b02          	addw	sp,#2
5546  0bb4 1f05          	ldw	(OFST-3,sp),x
5548  0bb6 2014          	jra	L7003
5549  0bb8               L5323:
5550                     ; 559                                 ptr1 += sprintf(ptr1, "-1");
5552  0bb8 ae00eb        	ldw	x,#L3423
5553  0bbb 89            	pushw	x
5554  0bbc 1e07          	ldw	x,(OFST-1,sp)
5555  0bbe cd0000        	call	_sprintf
5557  0bc1 5b02          	addw	sp,#2
5558  0bc3 72fb05        	addw	x,(OFST-3,sp)
5559  0bc6 1f05          	ldw	(OFST-3,sp),x
5560                     ; 560                                 break;
5562  0bc8 acc113c1      	jpf	L5772
5563  0bcc               L7003:
5564                     ; 370                         for (ptr0 += sizeof("get_prop") - 1 + 2, ptr1 = ack_str, ptr2 = ptr0 + strlen(ptr0); ptr0 < ptr2;)
5566  0bcc 1e07          	ldw	x,(OFST-1,sp)
5567  0bce 1301          	cpw	x,(OFST-7,sp)
5568  0bd0 2403          	jruge	L451
5569  0bd2 cc06a0        	jp	L3003
5570  0bd5               L451:
5571  0bd5 acc113c1      	jpf	L5772
5572  0bd9               L7772:
5573                     ; 564                     else if (START_WITH(ptr0, "set_"))
5575  0bd9 ae0004        	ldw	x,#4
5576  0bdc 89            	pushw	x
5577  0bdd ae00e6        	ldw	x,#L1523
5578  0be0 89            	pushw	x
5579  0be1 ae000a        	ldw	x,#L7671_mcu2wifi_rxd+5
5580  0be4 cd0000        	call	_strncmp
5582  0be7 5b04          	addw	sp,#4
5583  0be9 a30000        	cpw	x,#0
5584  0bec 2703          	jreq	L651
5585  0bee cc126e        	jp	L7423
5586  0bf1               L651:
5587                     ; 566                         ptr0 += sizeof("set_") - 1;
5589  0bf1 1e07          	ldw	x,(OFST-1,sp)
5590  0bf3 1c0004        	addw	x,#4
5591  0bf6 1f07          	ldw	(OFST-1,sp),x
5592                     ; 567                         if (START_WITH(ptr0, "mode"))
5594  0bf8 ae0004        	ldw	x,#4
5595  0bfb 89            	pushw	x
5596  0bfc ae01d9        	ldw	x,#L5103
5597  0bff 89            	pushw	x
5598  0c00 1e0b          	ldw	x,(OFST+3,sp)
5599  0c02 cd0000        	call	_strncmp
5601  0c05 5b04          	addw	sp,#4
5602  0c07 a30000        	cpw	x,#0
5603  0c0a 2667          	jrne	L3523
5604                     ; 569                             ptr0 += sizeof("mode") - 1 + 1;
5606  0c0c 1e07          	ldw	x,(OFST-1,sp)
5607  0c0e 1c0005        	addw	x,#5
5608  0c11 1f07          	ldw	(OFST-1,sp),x
5609                     ; 570                             temp = ptr0[0] - '0';
5611  0c13 1e07          	ldw	x,(OFST-1,sp)
5612  0c15 f6            	ld	a,(x)
5613  0c16 5f            	clrw	x
5614  0c17 97            	ld	xl,a
5615  0c18 1d0030        	subw	x,#48
5616  0c1b 1f03          	ldw	(OFST-5,sp),x
5617                     ; 571                             if (temp != runmode &&
5617                     ; 572                                 temp >= RUN_MODE_AUTO &&
5617                     ; 573                                 temp <= RUN_MODE_NEW)
5619  0c1d b600          	ld	a,_runmode
5620  0c1f 5f            	clrw	x
5621  0c20 97            	ld	xl,a
5622  0c21 bf00          	ldw	c_x,x
5623  0c23 1e03          	ldw	x,(OFST-5,sp)
5624  0c25 b300          	cpw	x,c_x
5625  0c27 273a          	jreq	L5523
5627  0c29 9c            	rvf
5628  0c2a 1e03          	ldw	x,(OFST-5,sp)
5629  0c2c 2f35          	jrslt	L5523
5631  0c2e 9c            	rvf
5632  0c2f 1e03          	ldw	x,(OFST-5,sp)
5633  0c31 a30004        	cpw	x,#4
5634  0c34 2e2d          	jrsge	L5523
5635                     ; 575                                 if (eeprom_rdchar(EEPROM_ADDR_RUNMODE) != RUN_MODE_LOCK || temp == RUN_MODE_STANDBY)
5637  0c36 c6400b        	ld	a,16395
5638  0c39 a105          	cp	a,#5
5639  0c3b 2607          	jrne	L1623
5641  0c3d 1e03          	ldw	x,(OFST-5,sp)
5642  0c3f a30002        	cpw	x,#2
5643  0c42 2619          	jrne	L7523
5644  0c44               L1623:
5645                     ; 576                                     runmode = temp;
5647  0c44 7b04          	ld	a,(OFST-4,sp)
5648  0c46 b700          	ld	_runmode,a
5650  0c48               L3623:
5651                     ; 579                                 flag_mode_changed = 1;
5653  0c48 72100001      	bset	_flag_mode_changed
5654                     ; 580                                 beep(BEEP_KEY);
5656  0c4c a601          	ld	a,#1
5657  0c4e cd0000        	call	_beep
5659                     ; 581                                 if (runmode == RUN_MODE_NEW)
5661  0c51 b600          	ld	a,_runmode
5662  0c53 a103          	cp	a,#3
5663  0c55 260c          	jrne	L5523
5664                     ; 582                                     tutorial_state = TUTORIAL_BEGIN;
5666  0c57 725f0000      	clr	_tutorial_state
5667  0c5b 2006          	jra	L5523
5668  0c5d               L7523:
5669                     ; 578                                     runmode = RUN_MODE_LOCK;
5671  0c5d 35050000      	mov	_runmode,#5
5672  0c61 20e5          	jra	L3623
5673  0c63               L5523:
5674                     ; 585                             append_int(ack_str, runmode);
5676  0c63 b600          	ld	a,_runmode
5677  0c65 5f            	clrw	x
5678  0c66 97            	ld	xl,a
5679  0c67 89            	pushw	x
5680  0c68 ae0000        	ldw	x,#L1771_ack_str
5681  0c6b cd016c        	call	L1022_append_int
5683  0c6e 85            	popw	x
5685  0c6f acc113c1      	jpf	L5772
5686  0c73               L3523:
5687                     ; 587                         else if (START_WITH(ptr0, "speed"))
5689  0c73 ae0005        	ldw	x,#5
5690  0c76 89            	pushw	x
5691  0c77 ae01cb        	ldw	x,#L5303
5692  0c7a 89            	pushw	x
5693  0c7b 1e0b          	ldw	x,(OFST+3,sp)
5694  0c7d cd0000        	call	_strncmp
5696  0c80 5b04          	addw	sp,#4
5697  0c82 a30000        	cpw	x,#0
5698  0c85 2647          	jrne	L1723
5699                     ; 589                             display_seg = DISPLAY_SPEED_TEMP;
5701  0c87 35120000      	mov	_display_seg,#18
5702                     ; 591                             ptr0 += sizeof("speed") - 1 + 1;
5704  0c8b 1e07          	ldw	x,(OFST-1,sp)
5705  0c8d 1c0006        	addw	x,#6
5706  0c90 1f07          	ldw	(OFST-1,sp),x
5707                     ; 592                             fixed_mode_speed = parse_speed(ptr0);
5709  0c92 1e07          	ldw	x,(OFST-1,sp)
5710  0c94 cd009e        	call	L5012_parse_speed
5712  0c97 c70000        	ld	_fixed_mode_speed,a
5713                     ; 593                             if (fixed_mode_speed == 0 && runmode == RUN_MODE_AUTO)
5715  0c9a 725d0000      	tnz	_fixed_mode_speed
5716  0c9e 260a          	jrne	L3723
5718  0ca0 3d00          	tnz	_runmode
5719  0ca2 2606          	jrne	L3723
5720                     ; 594                                 stepdown_flag = STEPDOWN_STOP;
5722  0ca4 35020000      	mov	_stepdown_flag,#2
5724  0ca8 2011          	jra	L5723
5725  0caa               L3723:
5726                     ; 595                             else if (fixed_mode_speed > speed_limit_max)
5728  0caa c60000        	ld	a,_fixed_mode_speed
5729  0cad c10000        	cp	a,_speed_limit_max
5730  0cb0 2309          	jrule	L5723
5731                     ; 597                                 fixed_mode_speed = speed_limit_max;
5733  0cb2 5500000000    	mov	_fixed_mode_speed,_speed_limit_max
5734                     ; 598                                 display_seg = DISPLAY_LIMIT;
5736  0cb7 350f0000      	mov	_display_seg,#15
5737  0cbb               L5723:
5738                     ; 603                             append_speed(ack_str, fixed_mode_speed);
5740  0cbb 3b0000        	push	_fixed_mode_speed
5741  0cbe ae0000        	ldw	x,#L1771_ack_str
5742  0cc1 cd0199        	call	L5522_append_speed
5744  0cc4 84            	pop	a
5745                     ; 604                             beep(BEEP_KEY);
5747  0cc5 a601          	ld	a,#1
5748  0cc7 cd0000        	call	_beep
5751  0cca acc113c1      	jpf	L5772
5752  0cce               L1723:
5753                     ; 606                         else if (START_WITH(ptr0, "type"))
5755  0cce ae0004        	ldw	x,#4
5756  0cd1 89            	pushw	x
5757  0cd2 ae00fa        	ldw	x,#L3223
5758  0cd5 89            	pushw	x
5759  0cd6 1e0b          	ldw	x,(OFST+3,sp)
5760  0cd8 cd0000        	call	_strncmp
5762  0cdb 5b04          	addw	sp,#4
5763  0cdd a30000        	cpw	x,#0
5764  0ce0 2703          	jreq	L061
5765  0ce2 cc0d70        	jp	L3033
5766  0ce5               L061:
5767                     ; 608                             ptr0 += sizeof("type") + 1;
5769  0ce5 1e07          	ldw	x,(OFST-1,sp)
5770  0ce7 1c0006        	addw	x,#6
5771  0cea 1f07          	ldw	(OFST-1,sp),x
5772                     ; 609                             if (runmode == RUN_MODE_LOCK)
5774  0cec b600          	ld	a,_runmode
5775  0cee a105          	cp	a,#5
5776  0cf0 2603          	jrne	L261
5777  0cf2 cc13c1        	jp	L5772
5778  0cf5               L261:
5780                     ; 612                             else if (runmode == RUN_MODE_STANDBY && eeprom_rdchar(EEPROM_ADDR_RUNMODE) == RUN_MODE_LOCK)
5782  0cf5 b600          	ld	a,_runmode
5783  0cf7 a102          	cp	a,#2
5784  0cf9 2614          	jrne	L1133
5786  0cfb c6400b        	ld	a,16395
5787  0cfe a105          	cp	a,#5
5788  0d00 260d          	jrne	L1133
5789                     ; 614                                 runmode = RUN_MODE_LOCK;
5791  0d02 35050000      	mov	_runmode,#5
5792                     ; 615                                 beep(BEEP_KEY);
5794  0d06 a601          	ld	a,#1
5795  0d08 cd0000        	call	_beep
5798  0d0b acc113c1      	jpf	L5772
5799  0d0f               L1133:
5800                     ; 617                             else if (START_WITH(ptr0, "auto"))
5802  0d0f ae0004        	ldw	x,#4
5803  0d12 89            	pushw	x
5804  0d13 ae0324        	ldw	x,#L7762
5805  0d16 89            	pushw	x
5806  0d17 1e0b          	ldw	x,(OFST+3,sp)
5807  0d19 cd0000        	call	_strncmp
5809  0d1c 5b04          	addw	sp,#4
5810  0d1e a30000        	cpw	x,#0
5811  0d21 2616          	jrne	L5133
5812                     ; 619                                 if (runmode != RUN_MODE_AUTO)
5814  0d23 3d00          	tnz	_runmode
5815  0d25 2603          	jrne	L461
5816  0d27 cc13c1        	jp	L5772
5817  0d2a               L461:
5818                     ; 621                                     runmode = RUN_MODE_AUTO;
5820  0d2a 3f00          	clr	_runmode
5821                     ; 622                                     flag_mode_changed = 1;
5823  0d2c 72100001      	bset	_flag_mode_changed
5824                     ; 623                                     beep(BEEP_KEY);
5826  0d30 a601          	ld	a,#1
5827  0d32 cd0000        	call	_beep
5829  0d35 acc113c1      	jpf	L5772
5830  0d39               L5133:
5831                     ; 626                             else if (START_WITH(ptr0, "fixed"))
5833  0d39 ae0005        	ldw	x,#5
5834  0d3c 89            	pushw	x
5835  0d3d ae0329        	ldw	x,#L5762
5836  0d40 89            	pushw	x
5837  0d41 1e0b          	ldw	x,(OFST+3,sp)
5838  0d43 cd0000        	call	_strncmp
5840  0d46 5b04          	addw	sp,#4
5841  0d48 a30000        	cpw	x,#0
5842  0d4b 261a          	jrne	L3233
5843                     ; 628                                 if (runmode != RUN_MODE_FIXED)
5845  0d4d b600          	ld	a,_runmode
5846  0d4f a101          	cp	a,#1
5847  0d51 2603          	jrne	L661
5848  0d53 cc13c1        	jp	L5772
5849  0d56               L661:
5850                     ; 630                                     runmode = RUN_MODE_FIXED;
5852  0d56 35010000      	mov	_runmode,#1
5853                     ; 631                                     flag_mode_changed = 1;
5855  0d5a 72100001      	bset	_flag_mode_changed
5856                     ; 632                                     beep(BEEP_KEY);
5858  0d5e a601          	ld	a,#1
5859  0d60 cd0000        	call	_beep
5861  0d63 acc113c1      	jpf	L5772
5862  0d67               L3233:
5863                     ; 636                                 error_code = -5001;
5865  0d67 aeec77        	ldw	x,#60535
5866  0d6a bf04          	ldw	L7432_error_code,x
5867  0d6c acc113c1      	jpf	L5772
5868  0d70               L3033:
5869                     ; 638                         else if (START_WITH(ptr0, "state"))
5871  0d70 ae0005        	ldw	x,#5
5872  0d73 89            	pushw	x
5873  0d74 ae00f4        	ldw	x,#L1323
5874  0d77 89            	pushw	x
5875  0d78 1e0b          	ldw	x,(OFST+3,sp)
5876  0d7a cd0000        	call	_strncmp
5878  0d7d 5b04          	addw	sp,#4
5879  0d7f a30000        	cpw	x,#0
5880  0d82 2665          	jrne	L3333
5881                     ; 640                             ptr0 += sizeof("state") + 1;
5883  0d84 1e07          	ldw	x,(OFST-1,sp)
5884  0d86 1c0007        	addw	x,#7
5885  0d89 1f07          	ldw	(OFST-1,sp),x
5886                     ; 641                             if (START_WITH(ptr0, "stop"))
5888  0d8b ae0004        	ldw	x,#4
5889  0d8e 89            	pushw	x
5890  0d8f ae035c        	ldw	x,#L3562
5891  0d92 89            	pushw	x
5892  0d93 1e0b          	ldw	x,(OFST+3,sp)
5893  0d95 cd0000        	call	_strncmp
5895  0d98 5b04          	addw	sp,#4
5896  0d9a a30000        	cpw	x,#0
5897  0d9d 2617          	jrne	L5333
5898                     ; 643                                 if (userstate != USER_STATE_SLEEP)
5900  0d9f c60000        	ld	a,_userstate
5901  0da2 a104          	cp	a,#4
5902  0da4 2603          	jrne	L071
5903  0da6 cc13c1        	jp	L5772
5904  0da9               L071:
5905                     ; 645                                     stepdown_flag = STEPDOWN_STOP;
5907  0da9 35020000      	mov	_stepdown_flag,#2
5908                     ; 646                                     beep(BEEP_KEY);
5910  0dad a601          	ld	a,#1
5911  0daf cd0000        	call	_beep
5913  0db2 acc113c1      	jpf	L5772
5914  0db6               L5333:
5915                     ; 649                             else if (START_WITH(ptr0, "run"))
5917  0db6 ae0003        	ldw	x,#3
5918  0db9 89            	pushw	x
5919  0dba ae0361        	ldw	x,#L1562
5920  0dbd 89            	pushw	x
5921  0dbe 1e0b          	ldw	x,(OFST+3,sp)
5922  0dc0 cd0000        	call	_strncmp
5924  0dc3 5b04          	addw	sp,#4
5925  0dc5 a30000        	cpw	x,#0
5926  0dc8 2616          	jrne	L3433
5927                     ; 651                                 if (userstate == USER_STATE_READY)
5929  0dca 725d0000      	tnz	_userstate
5930  0dce 2703          	jreq	L271
5931  0dd0 cc13c1        	jp	L5772
5932  0dd3               L271:
5933                     ; 653                                     stepdown_flag = STEPDOWN_START;
5935  0dd3 35030000      	mov	_stepdown_flag,#3
5936                     ; 654                                     beep(BEEP_KEY);
5938  0dd7 a601          	ld	a,#1
5939  0dd9 cd0000        	call	_beep
5941  0ddc acc113c1      	jpf	L5772
5942  0de0               L3433:
5943                     ; 658                                 error_code = -5001;
5945  0de0 aeec77        	ldw	x,#60535
5946  0de3 bf04          	ldw	L7432_error_code,x
5947  0de5 acc113c1      	jpf	L5772
5948  0de9               L3333:
5949                     ; 660                         else if (START_WITH(ptr0, "power"))
5951  0de9 ae0005        	ldw	x,#5
5952  0dec 89            	pushw	x
5953  0ded ae00ee        	ldw	x,#L7323
5954  0df0 89            	pushw	x
5955  0df1 1e0b          	ldw	x,(OFST+3,sp)
5956  0df3 cd0000        	call	_strncmp
5958  0df6 5b04          	addw	sp,#4
5959  0df8 a30000        	cpw	x,#0
5960  0dfb 2664          	jrne	L3533
5961                     ; 662                             ptr0 += sizeof("power") + 1;
5963  0dfd 1e07          	ldw	x,(OFST-1,sp)
5964  0dff 1c0007        	addw	x,#7
5965  0e02 1f07          	ldw	(OFST-1,sp),x
5966                     ; 663                             if (START_WITH(ptr0, "on"))
5968  0e04 ae0002        	ldw	x,#2
5969  0e07 89            	pushw	x
5970  0e08 ae0342        	ldw	x,#L1762
5971  0e0b 89            	pushw	x
5972  0e0c 1e0b          	ldw	x,(OFST+3,sp)
5973  0e0e cd0000        	call	_strncmp
5975  0e11 5b04          	addw	sp,#4
5976  0e13 a30000        	cpw	x,#0
5977  0e16 2616          	jrne	L5533
5978                     ; 665                                 if (runmode == RUN_MODE_STANDBY)
5980  0e18 b600          	ld	a,_runmode
5981  0e1a a102          	cp	a,#2
5982  0e1c 2703          	jreq	L471
5983  0e1e cc13c1        	jp	L5772
5984  0e21               L471:
5985                     ; 667                                     key_id = KEY_MODE_PRESS;
5987  0e21 ae0001        	ldw	x,#1
5988  0e24 bf00          	ldw	_key_id,x
5989                     ; 668                                     key_id_done = 0;
5991  0e26 72110000      	bres	_key_id_done
5992  0e2a acc113c1      	jpf	L5772
5993  0e2e               L5533:
5994                     ; 671                             else if (START_WITH(ptr0, "off"))
5996  0e2e ae0003        	ldw	x,#3
5997  0e31 89            	pushw	x
5998  0e32 ae0345        	ldw	x,#L7662
5999  0e35 89            	pushw	x
6000  0e36 1e0b          	ldw	x,(OFST+3,sp)
6001  0e38 cd0000        	call	_strncmp
6003  0e3b 5b04          	addw	sp,#4
6004  0e3d a30000        	cpw	x,#0
6005  0e40 2616          	jrne	L3633
6006                     ; 673                                 if (runmode != RUN_MODE_STANDBY)
6008  0e42 b600          	ld	a,_runmode
6009  0e44 a102          	cp	a,#2
6010  0e46 2603          	jrne	L671
6011  0e48 cc13c1        	jp	L5772
6012  0e4b               L671:
6013                     ; 675                                     runmode = RUN_MODE_STANDBY;
6015  0e4b 35020000      	mov	_runmode,#2
6016                     ; 676                                     beep(BEEP_KEY);
6018  0e4f a601          	ld	a,#1
6019  0e51 cd0000        	call	_beep
6021  0e54 acc113c1      	jpf	L5772
6022  0e58               L3633:
6023                     ; 680                                 error_code = -5001;
6025  0e58 aeec77        	ldw	x,#60535
6026  0e5b bf04          	ldw	L7432_error_code,x
6027  0e5d acc113c1      	jpf	L5772
6028  0e61               L3533:
6029                     ; 682                         else if (START_WITH(ptr0, "max"))
6031  0e61 ae0003        	ldw	x,#3
6032  0e64 89            	pushw	x
6033  0e65 ae015c        	ldw	x,#L1313
6034  0e68 89            	pushw	x
6035  0e69 1e0b          	ldw	x,(OFST+3,sp)
6036  0e6b cd0000        	call	_strncmp
6038  0e6e 5b04          	addw	sp,#4
6039  0e70 a30000        	cpw	x,#0
6040  0e73 2673          	jrne	L3733
6041                     ; 684                             ptr0 += sizeof("max") - 1 + 1;
6043  0e75 1e07          	ldw	x,(OFST-1,sp)
6044  0e77 1c0004        	addw	x,#4
6045  0e7a 1f07          	ldw	(OFST-1,sp),x
6046                     ; 685                             speed_limit_max = parse_speed(ptr0);
6048  0e7c 1e07          	ldw	x,(OFST-1,sp)
6049  0e7e cd009e        	call	L5012_parse_speed
6051  0e81 c70000        	ld	_speed_limit_max,a
6052                     ; 686                             if (speed_limit_max > SPEED_TARGET_MAX)
6054  0e84 c60000        	ld	a,_speed_limit_max
6055  0e87 a1b5          	cp	a,#181
6056  0e89 2506          	jrult	L5733
6057                     ; 687                                 speed_limit_max = SPEED_TARGET_MAX;
6059  0e8b 35b40000      	mov	_speed_limit_max,#180
6061  0e8f 200b          	jra	L7733
6062  0e91               L5733:
6063                     ; 688                             else if (speed_limit_max < SPEED_TARGET_MIN1)
6065  0e91 c60000        	ld	a,_speed_limit_max
6066  0e94 a10f          	cp	a,#15
6067  0e96 2404          	jruge	L7733
6068                     ; 689                                 speed_limit_max = SPEED_TARGET_MIN1;
6070  0e98 350f0000      	mov	_speed_limit_max,#15
6071  0e9c               L7733:
6072                     ; 690                             append_speed(ack_str, speed_limit_max);
6074  0e9c 3b0000        	push	_speed_limit_max
6075  0e9f ae0000        	ldw	x,#L1771_ack_str
6076  0ea2 cd0199        	call	L5522_append_speed
6078  0ea5 84            	pop	a
6079                     ; 691                             eeprom_wrchar(EEPROM_ADDR_SPEED_LIMIT, speed_limit_max);
6081  0ea6 3b0000        	push	_speed_limit_max
6082  0ea9 ae400d        	ldw	x,#16397
6083  0eac cd0000        	call	_eeprom_wrchar
6085  0eaf 84            	pop	a
6086                     ; 692                             if (fixed_start_speed > speed_limit_max)
6088  0eb0 c60000        	ld	a,_fixed_start_speed
6089  0eb3 c10000        	cp	a,_speed_limit_max
6090  0eb6 230f          	jrule	L3043
6091                     ; 694                                 fixed_start_speed = speed_limit_max;
6093  0eb8 5500000000    	mov	_fixed_start_speed,_speed_limit_max
6094                     ; 695                                 eeprom_wrchar(EEPROM_ADDR_FIXED_SPEED, temp);
6096  0ebd 7b04          	ld	a,(OFST-4,sp)
6097  0ebf 88            	push	a
6098  0ec0 ae400c        	ldw	x,#16396
6099  0ec3 cd0000        	call	_eeprom_wrchar
6101  0ec6 84            	pop	a
6102  0ec7               L3043:
6103                     ; 697                             if (max_speed_unlocked == 0)
6105                     	btst	_max_speed_unlocked
6106  0ecc 250d          	jrult	L5043
6107                     ; 699                                 max_speed_unlocked = 1;
6109  0ece 72100000      	bset	_max_speed_unlocked
6110                     ; 700                                 eeprom_wrchar(EEPROM_ADDR_MAX_SPEED_UNLOCKED, 1);
6112  0ed2 4b01          	push	#1
6113  0ed4 ae4011        	ldw	x,#16401
6114  0ed7 cd0000        	call	_eeprom_wrchar
6116  0eda 84            	pop	a
6117  0edb               L5043:
6118                     ; 702                             display_seg = DISPLAY_LIMIT;
6120  0edb 350f0000      	mov	_display_seg,#15
6121                     ; 703                             beep(BEEP_KEY);
6123  0edf a601          	ld	a,#1
6124  0ee1 cd0000        	call	_beep
6127  0ee4 acc113c1      	jpf	L5772
6128  0ee8               L3733:
6129                     ; 705                         else if (START_WITH(ptr0, "sensitivity"))
6131  0ee8 ae000b        	ldw	x,#11
6132  0eeb 89            	pushw	x
6133  0eec ae0150        	ldw	x,#L7313
6134  0eef 89            	pushw	x
6135  0ef0 1e0b          	ldw	x,(OFST+3,sp)
6136  0ef2 cd0000        	call	_strncmp
6138  0ef5 5b04          	addw	sp,#4
6139  0ef7 a30000        	cpw	x,#0
6140  0efa 2640          	jrne	L1143
6141                     ; 707                             ptr0 += sizeof("sensitivity") - 1 + 1;
6143  0efc 1e07          	ldw	x,(OFST-1,sp)
6144  0efe 1c000c        	addw	x,#12
6145  0f01 1f07          	ldw	(OFST-1,sp),x
6146                     ; 708                             temp = atoi(ptr0);
6148  0f03 1e07          	ldw	x,(OFST-1,sp)
6149  0f05 cd0000        	call	_atoi
6151  0f08 1f03          	ldw	(OFST-5,sp),x
6152                     ; 709                             if (temp >= 1 && temp <= 3)
6154  0f0a 9c            	rvf
6155  0f0b 1e03          	ldw	x,(OFST-5,sp)
6156  0f0d 2d0d          	jrsle	L3143
6158  0f0f 9c            	rvf
6159  0f10 1e03          	ldw	x,(OFST-5,sp)
6160  0f12 a30004        	cpw	x,#4
6161  0f15 2e05          	jrsge	L3143
6162                     ; 711                                 acceleration_param = (uchar)temp;
6164  0f17 7b04          	ld	a,(OFST-4,sp)
6165  0f19 c70000        	ld	_acceleration_param,a
6166  0f1c               L3143:
6167                     ; 713                             append_int(ack_str, acceleration_param);
6169  0f1c c60000        	ld	a,_acceleration_param
6170  0f1f 5f            	clrw	x
6171  0f20 97            	ld	xl,a
6172  0f21 89            	pushw	x
6173  0f22 ae0000        	ldw	x,#L1771_ack_str
6174  0f25 cd016c        	call	L1022_append_int
6176  0f28 85            	popw	x
6177                     ; 714                             eeprom_wrchar(EEPROM_ADDR_ACC_PARAM, acceleration_param);
6179  0f29 3b0000        	push	_acceleration_param
6180  0f2c ae400f        	ldw	x,#16399
6181  0f2f cd0000        	call	_eeprom_wrchar
6183  0f32 84            	pop	a
6184                     ; 715                             beep(BEEP_KEY);
6186  0f33 a601          	ld	a,#1
6187  0f35 cd0000        	call	_beep
6190  0f38 acc113c1      	jpf	L5772
6191  0f3c               L1143:
6192                     ; 717                         else if (START_WITH(ptr0, "cali"))
6194  0f3c ae0004        	ldw	x,#4
6195  0f3f 89            	pushw	x
6196  0f40 ae00e1        	ldw	x,#L1243
6197  0f43 89            	pushw	x
6198  0f44 1e0b          	ldw	x,(OFST+3,sp)
6199  0f46 cd0000        	call	_strncmp
6201  0f49 5b04          	addw	sp,#4
6202  0f4b a30000        	cpw	x,#0
6203  0f4e 2641          	jrne	L7143
6204                     ; 719                             ptr0 += sizeof("cali");
6206  0f50 1e07          	ldw	x,(OFST-1,sp)
6207  0f52 1c0005        	addw	x,#5
6208  0f55 1f07          	ldw	(OFST-1,sp),x
6209                     ; 720                             temp = atoi(ptr0);
6211  0f57 1e07          	ldw	x,(OFST-1,sp)
6212  0f59 cd0000        	call	_atoi
6214  0f5c 1f03          	ldw	(OFST-5,sp),x
6215                     ; 721                             if (temp == 1)
6217  0f5e 1e03          	ldw	x,(OFST-5,sp)
6218  0f60 a30001        	cpw	x,#1
6219  0f63 260b          	jrne	L3243
6220                     ; 723                                 key_id = KEY_MODE_UP_LONG_PRESS;
6222  0f65 ae0111        	ldw	x,#273
6223  0f68 bf00          	ldw	_key_id,x
6224                     ; 724                                 key_id_done = 0;
6226  0f6a 72110000      	bres	_key_id_done
6228  0f6e 2013          	jra	L5243
6229  0f70               L3243:
6230                     ; 726                             else if (temp == 0 && runmode == RUN_MODE_CHECK)
6232  0f70 1e03          	ldw	x,(OFST-5,sp)
6233  0f72 260f          	jrne	L5243
6235  0f74 b600          	ld	a,_runmode
6236  0f76 a104          	cp	a,#4
6237  0f78 2609          	jrne	L5243
6238                     ; 728                                 stepdown_flag = STEPDOWN_STOP;
6240  0f7a 35020000      	mov	_stepdown_flag,#2
6241                     ; 729                                 beep(BEEP_KEY);
6243  0f7e a601          	ld	a,#1
6244  0f80 cd0000        	call	_beep
6246  0f83               L5243:
6247                     ; 731                             append_int(ack_str, temp);
6249  0f83 1e03          	ldw	x,(OFST-5,sp)
6250  0f85 89            	pushw	x
6251  0f86 ae0000        	ldw	x,#L1771_ack_str
6252  0f89 cd016c        	call	L1022_append_int
6254  0f8c 85            	popw	x
6256  0f8d acc113c1      	jpf	L5772
6257  0f91               L7143:
6258                     ; 733                         else if (START_WITH(ptr0, "goal"))
6260  0f91 ae0004        	ldw	x,#4
6261  0f94 89            	pushw	x
6262  0f95 ae0160        	ldw	x,#L3213
6263  0f98 89            	pushw	x
6264  0f99 1e0b          	ldw	x,(OFST+3,sp)
6265  0f9b cd0000        	call	_strncmp
6267  0f9e 5b04          	addw	sp,#4
6268  0fa0 a30000        	cpw	x,#0
6269  0fa3 2703          	jreq	L002
6270  0fa5 cc102e        	jp	L3343
6271  0fa8               L002:
6272                     ; 735                             ptr0 += sizeof("goal");
6274  0fa8 1e07          	ldw	x,(OFST-1,sp)
6275  0faa 1c0005        	addw	x,#5
6276  0fad 1f07          	ldw	(OFST-1,sp),x
6277                     ; 736                             if (ptr0[0] >= '0' && ptr0[0] <= '2' && ptr0[1] == ',')
6279  0faf 1e07          	ldw	x,(OFST-1,sp)
6280  0fb1 f6            	ld	a,(x)
6281  0fb2 a130          	cp	a,#48
6282  0fb4 2559          	jrult	L5343
6284  0fb6 1e07          	ldw	x,(OFST-1,sp)
6285  0fb8 f6            	ld	a,(x)
6286  0fb9 a133          	cp	a,#51
6287  0fbb 2452          	jruge	L5343
6289  0fbd 1e07          	ldw	x,(OFST-1,sp)
6290  0fbf e601          	ld	a,(1,x)
6291  0fc1 a12c          	cp	a,#44
6292  0fc3 264a          	jrne	L5343
6293                     ; 738                                 temp = ptr0[0] - '0';
6295  0fc5 1e07          	ldw	x,(OFST-1,sp)
6296  0fc7 f6            	ld	a,(x)
6297  0fc8 5f            	clrw	x
6298  0fc9 97            	ld	xl,a
6299  0fca 1d0030        	subw	x,#48
6300  0fcd 1f03          	ldw	(OFST-5,sp),x
6301                     ; 739                                 if (goal_type != temp)
6303  0fcf c60000        	ld	a,_goal_type
6304  0fd2 5f            	clrw	x
6305  0fd3 97            	ld	xl,a
6306  0fd4 1303          	cpw	x,(OFST-5,sp)
6307  0fd6 2713          	jreq	L7343
6308                     ; 741                                     goal_type = temp;
6310  0fd8 7b04          	ld	a,(OFST-4,sp)
6311  0fda c70000        	ld	_goal_type,a
6312                     ; 742                                     eeprom_wrchar(EEPROM_ADDR_GOAL_TYPE, goal_type);
6314  0fdd 3b0000        	push	_goal_type
6315  0fe0 ae4014        	ldw	x,#16404
6316  0fe3 cd0000        	call	_eeprom_wrchar
6318  0fe6 84            	pop	a
6319                     ; 743                                     goal_status = GOAL_CHANGED;
6321  0fe7 35020000      	mov	_goal_status,#2
6322  0feb               L7343:
6323                     ; 745                                 temp = atoi(ptr0 + 2);
6325  0feb 1e07          	ldw	x,(OFST-1,sp)
6326  0fed 5c            	incw	x
6327  0fee 5c            	incw	x
6328  0fef cd0000        	call	_atoi
6330  0ff2 1f03          	ldw	(OFST-5,sp),x
6331                     ; 746                                 if (goal_value != temp)
6333  0ff4 ce0000        	ldw	x,_goal_value
6334  0ff7 1303          	cpw	x,(OFST-5,sp)
6335  0ff9 2714          	jreq	L5343
6336                     ; 748                                     goal_value = temp;
6338  0ffb 1e03          	ldw	x,(OFST-5,sp)
6339  0ffd cf0000        	ldw	_goal_value,x
6340                     ; 749                                     eeprom_write_int(EEPROM_ADDR_GOAL_VALUE, goal_value);
6342  1000 ce0000        	ldw	x,_goal_value
6343  1003 89            	pushw	x
6344  1004 ae4015        	ldw	x,#16405
6345  1007 cd0000        	call	_eeprom_write_int
6347  100a 85            	popw	x
6348                     ; 750                                     goal_status = GOAL_CHANGED;
6350  100b 35020000      	mov	_goal_status,#2
6351  100f               L5343:
6352                     ; 753                             sprintf(ack_str, "%d %d", (uint)goal_type, goal_value);
6354  100f ce0000        	ldw	x,_goal_value
6355  1012 89            	pushw	x
6356  1013 c60000        	ld	a,_goal_type
6357  1016 5f            	clrw	x
6358  1017 97            	ld	xl,a
6359  1018 89            	pushw	x
6360  1019 ae00db        	ldw	x,#L3443
6361  101c 89            	pushw	x
6362  101d ae0000        	ldw	x,#L1771_ack_str
6363  1020 cd0000        	call	_sprintf
6365  1023 5b06          	addw	sp,#6
6366                     ; 754                             beep(BEEP_KEY);
6368  1025 a601          	ld	a,#1
6369  1027 cd0000        	call	_beep
6372  102a acc113c1      	jpf	L5772
6373  102e               L3343:
6374                     ; 756                         else if (START_WITH(ptr0, "start_speed"))
6376  102e ae000b        	ldw	x,#11
6377  1031 89            	pushw	x
6378  1032 ae0165        	ldw	x,#L5113
6379  1035 89            	pushw	x
6380  1036 1e0b          	ldw	x,(OFST+3,sp)
6381  1038 cd0000        	call	_strncmp
6383  103b 5b04          	addw	sp,#4
6384  103d a30000        	cpw	x,#0
6385  1040 2668          	jrne	L7443
6386                     ; 758                             ptr0 += sizeof("start_speed");
6388  1042 1e07          	ldw	x,(OFST-1,sp)
6389  1044 1c000c        	addw	x,#12
6390  1047 1f07          	ldw	(OFST-1,sp),x
6391                     ; 759                             temp = parse_speed(ptr0);
6393  1049 1e07          	ldw	x,(OFST-1,sp)
6394  104b cd009e        	call	L5012_parse_speed
6396  104e 5f            	clrw	x
6397  104f 97            	ld	xl,a
6398  1050 1f03          	ldw	(OFST-5,sp),x
6399                     ; 760                             if (temp <= SPEED_TARGET_MAX && temp >= SPEED_TARGET_MIN1 && temp != fixed_start_speed)
6401  1052 9c            	rvf
6402  1053 1e03          	ldw	x,(OFST-5,sp)
6403  1055 a300b5        	cpw	x,#181
6404  1058 2e3d          	jrsge	L1543
6406  105a 9c            	rvf
6407  105b 1e03          	ldw	x,(OFST-5,sp)
6408  105d a3000f        	cpw	x,#15
6409  1060 2f35          	jrslt	L1543
6411  1062 c60000        	ld	a,_fixed_start_speed
6412  1065 5f            	clrw	x
6413  1066 97            	ld	xl,a
6414  1067 bf00          	ldw	c_x,x
6415  1069 1e03          	ldw	x,(OFST-5,sp)
6416  106b b300          	cpw	x,c_x
6417  106d 2728          	jreq	L1543
6418                     ; 762                                 if (temp > speed_limit_max)
6420  106f 9c            	rvf
6421  1070 c60000        	ld	a,_speed_limit_max
6422  1073 5f            	clrw	x
6423  1074 97            	ld	xl,a
6424  1075 bf00          	ldw	c_x,x
6425  1077 1e03          	ldw	x,(OFST-5,sp)
6426  1079 b300          	cpw	x,c_x
6427  107b 2d0b          	jrsle	L3543
6428                     ; 764                                     temp = speed_limit_max;
6430  107d c60000        	ld	a,_speed_limit_max
6431  1080 5f            	clrw	x
6432  1081 97            	ld	xl,a
6433  1082 1f03          	ldw	(OFST-5,sp),x
6434                     ; 765                                     display_seg = DISPLAY_LIMIT;
6436  1084 350f0000      	mov	_display_seg,#15
6437  1088               L3543:
6438                     ; 767                                 fixed_start_speed = temp;
6440  1088 7b04          	ld	a,(OFST-4,sp)
6441  108a c70000        	ld	_fixed_start_speed,a
6442                     ; 768                                 eeprom_wrchar(EEPROM_ADDR_FIXED_SPEED, temp);
6444  108d 7b04          	ld	a,(OFST-4,sp)
6445  108f 88            	push	a
6446  1090 ae400c        	ldw	x,#16396
6447  1093 cd0000        	call	_eeprom_wrchar
6449  1096 84            	pop	a
6450  1097               L1543:
6451                     ; 770                             append_speed(ack_str, fixed_start_speed);
6453  1097 3b0000        	push	_fixed_start_speed
6454  109a ae0000        	ldw	x,#L1771_ack_str
6455  109d cd0199        	call	L5522_append_speed
6457  10a0 84            	pop	a
6458                     ; 771                             beep(BEEP_KEY);
6460  10a1 a601          	ld	a,#1
6461  10a3 cd0000        	call	_beep
6464  10a6 acc113c1      	jpf	L5772
6465  10aa               L7443:
6466                     ; 789                         else if (START_WITH(ptr0, "auto"))
6468  10aa ae0004        	ldw	x,#4
6469  10ad 89            	pushw	x
6470  10ae ae0324        	ldw	x,#L7762
6471  10b1 89            	pushw	x
6472  10b2 1e0b          	ldw	x,(OFST+3,sp)
6473  10b4 cd0000        	call	_strncmp
6475  10b7 5b04          	addw	sp,#4
6476  10b9 a30000        	cpw	x,#0
6477  10bc 265f          	jrne	L7543
6478                     ; 791                             ptr0 += sizeof("auto") - 1 + 1;
6480  10be 1e07          	ldw	x,(OFST-1,sp)
6481  10c0 1c0005        	addw	x,#5
6482  10c3 1f07          	ldw	(OFST-1,sp),x
6483                     ; 792                             temp = ptr0[0] - '0';
6485  10c5 1e07          	ldw	x,(OFST-1,sp)
6486  10c7 f6            	ld	a,(x)
6487  10c8 5f            	clrw	x
6488  10c9 97            	ld	xl,a
6489  10ca 1d0030        	subw	x,#48
6490  10cd 1f03          	ldw	(OFST-5,sp),x
6491                     ; 793                             if (temp >= 0 && temp <= 1 && temp != flag_auto)
6493  10cf 9c            	rvf
6494  10d0 1e03          	ldw	x,(OFST-5,sp)
6495  10d2 2f31          	jrslt	L1643
6497  10d4 9c            	rvf
6498  10d5 1e03          	ldw	x,(OFST-5,sp)
6499  10d7 a30002        	cpw	x,#2
6500  10da 2e29          	jrsge	L1643
6502  10dc 5f            	clrw	x
6503                     	btst	_flag_auto
6504  10e2 59            	rlcw	x
6505  10e3 bf00          	ldw	c_x,x
6506  10e5 1e03          	ldw	x,(OFST-5,sp)
6507  10e7 b300          	cpw	x,c_x
6508  10e9 271a          	jreq	L1643
6509                     ; 795                                 flag_auto = temp;
6511  10eb 1e03          	ldw	x,(OFST-5,sp)
6512  10ed 2602          	jrne	L202
6513  10ef 2006          	jp	L201
6514  10f1               L202:
6515  10f1 72100000      	bset	_flag_auto
6516  10f5 2004          	jra	L401
6517  10f7               L201:
6518  10f7 72110000      	bres	_flag_auto
6519  10fb               L401:
6520                     ; 796                                 eeprom_wrchar(EEPROM_ADDR_AUTO, temp);
6522  10fb 7b04          	ld	a,(OFST-4,sp)
6523  10fd 88            	push	a
6524  10fe ae4012        	ldw	x,#16402
6525  1101 cd0000        	call	_eeprom_wrchar
6527  1104 84            	pop	a
6528  1105               L1643:
6529                     ; 798                             append_int(ack_str, flag_auto);
6531  1105 5f            	clrw	x
6532                     	btst	_flag_auto
6533  110b 59            	rlcw	x
6534  110c 89            	pushw	x
6535  110d ae0000        	ldw	x,#L1771_ack_str
6536  1110 cd016c        	call	L1022_append_int
6538  1113 85            	popw	x
6539                     ; 799                             beep(BEEP_KEY);
6541  1114 a601          	ld	a,#1
6542  1116 cd0000        	call	_beep
6545  1119 acc113c1      	jpf	L5772
6546  111d               L7543:
6547                     ; 801                         else if (START_WITH(ptr0, "disp"))
6549  111d ae0004        	ldw	x,#4
6550  1120 89            	pushw	x
6551  1121 ae0116        	ldw	x,#L7613
6552  1124 89            	pushw	x
6553  1125 1e0b          	ldw	x,(OFST+3,sp)
6554  1127 cd0000        	call	_strncmp
6556  112a 5b04          	addw	sp,#4
6557  112c a30000        	cpw	x,#0
6558  112f 264d          	jrne	L5643
6559                     ; 803                             ptr0 += sizeof("disp") - 1 + 1;
6561  1131 1e07          	ldw	x,(OFST-1,sp)
6562  1133 1c0005        	addw	x,#5
6563  1136 1f07          	ldw	(OFST-1,sp),x
6564                     ; 804                             temp = atoi(ptr0);
6566  1138 1e07          	ldw	x,(OFST-1,sp)
6567  113a cd0000        	call	_atoi
6569  113d 1f03          	ldw	(OFST-5,sp),x
6570                     ; 805                             if (temp > 0 && temp <= 0x1F && temp != flag_disp)
6572  113f 9c            	rvf
6573  1140 1e03          	ldw	x,(OFST-5,sp)
6574  1142 2d24          	jrsle	L7643
6576  1144 9c            	rvf
6577  1145 1e03          	ldw	x,(OFST-5,sp)
6578  1147 a30020        	cpw	x,#32
6579  114a 2e1c          	jrsge	L7643
6581  114c c60000        	ld	a,_flag_disp
6582  114f 5f            	clrw	x
6583  1150 97            	ld	xl,a
6584  1151 bf00          	ldw	c_x,x
6585  1153 1e03          	ldw	x,(OFST-5,sp)
6586  1155 b300          	cpw	x,c_x
6587  1157 270f          	jreq	L7643
6588                     ; 807                                 flag_disp = (uchar)temp;
6590  1159 7b04          	ld	a,(OFST-4,sp)
6591  115b c70000        	ld	_flag_disp,a
6592                     ; 808                                 eeprom_wrchar(EEPROM_ADDR_DISP, flag_disp);
6594  115e 3b0000        	push	_flag_disp
6595  1161 ae4013        	ldw	x,#16403
6596  1164 cd0000        	call	_eeprom_wrchar
6598  1167 84            	pop	a
6599  1168               L7643:
6600                     ; 810                             append_int(ack_str, flag_disp);
6602  1168 c60000        	ld	a,_flag_disp
6603  116b 5f            	clrw	x
6604  116c 97            	ld	xl,a
6605  116d 89            	pushw	x
6606  116e ae0000        	ldw	x,#L1771_ack_str
6607  1171 cd016c        	call	L1022_append_int
6609  1174 85            	popw	x
6610                     ; 811                             beep(BEEP_KEY);
6612  1175 a601          	ld	a,#1
6613  1177 cd0000        	call	_beep
6616  117a acc113c1      	jpf	L5772
6617  117e               L5643:
6618                     ; 813                         else if (START_WITH(ptr0, "insure"))
6620  117e ae0006        	ldw	x,#6
6621  1181 89            	pushw	x
6622  1182 ae00d4        	ldw	x,#L5743
6623  1185 89            	pushw	x
6624  1186 1e0b          	ldw	x,(OFST+3,sp)
6625  1188 cd0000        	call	_strncmp
6627  118b 5b04          	addw	sp,#4
6628  118d a30000        	cpw	x,#0
6629  1190 2630          	jrne	L3743
6630                     ; 815                             ptr0 += sizeof("insure") - 1 + 1;
6632  1192 1e07          	ldw	x,(OFST-1,sp)
6633  1194 1c0007        	addw	x,#7
6634  1197 1f07          	ldw	(OFST-1,sp),x
6635                     ; 816                             temp = ptr0[0] - '0';
6637  1199 1e07          	ldw	x,(OFST-1,sp)
6638  119b f6            	ld	a,(x)
6639  119c 5f            	clrw	x
6640  119d 97            	ld	xl,a
6641  119e 1d0030        	subw	x,#48
6642  11a1 1f03          	ldw	(OFST-5,sp),x
6643                     ; 817                             if (temp == 1)
6645  11a3 1e03          	ldw	x,(OFST-5,sp)
6646  11a5 a30001        	cpw	x,#1
6647  11a8 260a          	jrne	L7743
6648                     ; 819                                 eeprom_wrchar(EEPROM_ADDR_INSURE_BINDED, temp);
6650  11aa 7b04          	ld	a,(OFST-4,sp)
6651  11ac 88            	push	a
6652  11ad ae407e        	ldw	x,#16510
6653  11b0 cd0000        	call	_eeprom_wrchar
6655  11b3 84            	pop	a
6656  11b4               L7743:
6657                     ; 821                             append_int(ack_str, temp);
6659  11b4 1e03          	ldw	x,(OFST-5,sp)
6660  11b6 89            	pushw	x
6661  11b7 ae0000        	ldw	x,#L1771_ack_str
6662  11ba cd016c        	call	L1022_append_int
6664  11bd 85            	popw	x
6666  11be acc113c1      	jpf	L5772
6667  11c2               L3743:
6668                     ; 823                         else if (START_WITH(ptr0, "lock"))
6670  11c2 ae0004        	ldw	x,#4
6671  11c5 89            	pushw	x
6672  11c6 ae0109        	ldw	x,#L3023
6673  11c9 89            	pushw	x
6674  11ca 1e0b          	ldw	x,(OFST+3,sp)
6675  11cc cd0000        	call	_strncmp
6677  11cf 5b04          	addw	sp,#4
6678  11d1 a30000        	cpw	x,#0
6679  11d4 2645          	jrne	L3053
6680                     ; 825                             ptr0 += sizeof("lock") - 1 + 1;
6682  11d6 1e07          	ldw	x,(OFST-1,sp)
6683  11d8 1c0005        	addw	x,#5
6684  11db 1f07          	ldw	(OFST-1,sp),x
6685                     ; 826                             if (machine_speed_target == 0)
6687  11dd 3d00          	tnz	_machine_speed_target
6688  11df 261d          	jrne	L5053
6689                     ; 828                                 temp = ptr0[0] - '0';
6691  11e1 1e07          	ldw	x,(OFST-1,sp)
6692  11e3 f6            	ld	a,(x)
6693  11e4 5f            	clrw	x
6694  11e5 97            	ld	xl,a
6695  11e6 1d0030        	subw	x,#48
6696  11e9 1f03          	ldw	(OFST-5,sp),x
6697                     ; 829                                 runmode = temp == 1 ? RUN_MODE_LOCK : RUN_MODE_FIXED;
6699  11eb 1e03          	ldw	x,(OFST-5,sp)
6700  11ed a30001        	cpw	x,#1
6701  11f0 2604          	jrne	L601
6702  11f2 a605          	ld	a,#5
6703  11f4 2002          	jra	L011
6704  11f6               L601:
6705  11f6 a601          	ld	a,#1
6706  11f8               L011:
6707  11f8 b700          	ld	_runmode,a
6708                     ; 830                                 flag_mode_changed = 1;
6710  11fa 72100001      	bset	_flag_mode_changed
6711  11fe               L5053:
6712                     ; 832                             append_int(ack_str, runmode == RUN_MODE_LOCK);
6714  11fe b600          	ld	a,_runmode
6715  1200 a105          	cp	a,#5
6716  1202 2605          	jrne	L211
6717  1204 ae0001        	ldw	x,#1
6718  1207 2001          	jra	L411
6719  1209               L211:
6720  1209 5f            	clrw	x
6721  120a               L411:
6722  120a 89            	pushw	x
6723  120b ae0000        	ldw	x,#L1771_ack_str
6724  120e cd016c        	call	L1022_append_int
6726  1211 85            	popw	x
6727                     ; 833                             beep(BEEP_KEY);
6729  1212 a601          	ld	a,#1
6730  1214 cd0000        	call	_beep
6733  1217 acc113c1      	jpf	L5772
6734  121b               L3053:
6735                     ; 835                         else if (START_WITH(ptr0, "offline"))
6737  121b ae0007        	ldw	x,#7
6738  121e 89            	pushw	x
6739  121f ae03cf        	ldw	x,#L5402
6740  1222 89            	pushw	x
6741  1223 1e0b          	ldw	x,(OFST+3,sp)
6742  1225 cd0000        	call	_strncmp
6744  1228 5b04          	addw	sp,#4
6745  122a a30000        	cpw	x,#0
6746  122d 2636          	jrne	L1153
6747                     ; 837                             ptr0 += sizeof("offline") - 1 + 1;
6749  122f 1e07          	ldw	x,(OFST-1,sp)
6750  1231 1c0008        	addw	x,#8
6751  1234 1f07          	ldw	(OFST-1,sp),x
6752                     ; 838                             temp = ptr0[0] - '0';
6754  1236 1e07          	ldw	x,(OFST-1,sp)
6755  1238 f6            	ld	a,(x)
6756  1239 5f            	clrw	x
6757  123a 97            	ld	xl,a
6758  123b 1d0030        	subw	x,#48
6759  123e 1f03          	ldw	(OFST-5,sp),x
6760                     ; 839                             if (temp == 0)
6762  1240 1e03          	ldw	x,(OFST-5,sp)
6763  1242 2605          	jrne	L3153
6764                     ; 841                                 clear_offline_data();
6766  1244 cd0113        	call	L1412_clear_offline_data
6769  1247 2009          	jra	L5153
6770  1249               L3153:
6771                     ; 843                             else if (store_point.offline_dist > 0)
6773  1249 ce00eb        	ldw	x,_store_point+21
6774  124c 2704          	jreq	L5153
6775                     ; 845                                 set_wifi_flag(FLAG_WIFI_STORE_OFFLINE);
6777  124e 721a00fc      	bset	_commu_wifi_flag,#5
6778  1252               L5153:
6779                     ; 847                             append_int(ack_str, temp);
6781  1252 1e03          	ldw	x,(OFST-5,sp)
6782  1254 89            	pushw	x
6783  1255 ae0000        	ldw	x,#L1771_ack_str
6784  1258 cd016c        	call	L1022_append_int
6786  125b 85            	popw	x
6787                     ; 848                             beep(BEEP_KEY);
6789  125c a601          	ld	a,#1
6790  125e cd0000        	call	_beep
6793  1261 acc113c1      	jpf	L5772
6794  1265               L1153:
6795                     ; 852                             error_code = -5001;
6797  1265 aeec77        	ldw	x,#60535
6798  1268 bf04          	ldw	L7432_error_code,x
6799  126a acc113c1      	jpf	L5772
6800  126e               L7423:
6801                     ; 855                     else if (START_WITH(ptr0, "speed"))
6803  126e ae0005        	ldw	x,#5
6804  1271 89            	pushw	x
6805  1272 ae01cb        	ldw	x,#L5303
6806  1275 89            	pushw	x
6807  1276 ae000a        	ldw	x,#L7671_mcu2wifi_rxd+5
6808  1279 cd0000        	call	_strncmp
6810  127c 5b04          	addw	sp,#4
6811  127e a30000        	cpw	x,#0
6812  1281 264c          	jrne	L5253
6813                     ; 857                         ptr0 += sizeof("speed"); // speed_up, speed_down
6815  1283 1e07          	ldw	x,(OFST-1,sp)
6816  1285 1c0006        	addw	x,#6
6817  1288 1f07          	ldw	(OFST-1,sp),x
6818                     ; 858                         if (START_WITH(ptr0, "up"))
6820  128a ae0002        	ldw	x,#2
6821  128d 89            	pushw	x
6822  128e ae00d1        	ldw	x,#L1353
6823  1291 89            	pushw	x
6824  1292 1e0b          	ldw	x,(OFST+3,sp)
6825  1294 cd0000        	call	_strncmp
6827  1297 5b04          	addw	sp,#4
6828  1299 a30000        	cpw	x,#0
6829  129c 260d          	jrne	L7253
6830                     ; 860                             key_id = KEY_UP_PRESS;
6832  129e ae0002        	ldw	x,#2
6833  12a1 bf00          	ldw	_key_id,x
6834                     ; 861                             key_id_done = 0;
6836  12a3 72110000      	bres	_key_id_done
6838  12a7 acc113c1      	jpf	L5772
6839  12ab               L7253:
6840                     ; 863                         else if (START_WITH(ptr0, "down"))
6842  12ab ae0004        	ldw	x,#4
6843  12ae 89            	pushw	x
6844  12af ae01ec        	ldw	x,#L7672
6845  12b2 89            	pushw	x
6846  12b3 1e0b          	ldw	x,(OFST+3,sp)
6847  12b5 cd0000        	call	_strncmp
6849  12b8 5b04          	addw	sp,#4
6850  12ba a30000        	cpw	x,#0
6851  12bd 2703          	jreq	L402
6852  12bf cc13c1        	jp	L5772
6853  12c2               L402:
6854                     ; 865                             key_id = KEY_DOWN_PRESS;
6856  12c2 ae0004        	ldw	x,#4
6857  12c5 bf00          	ldw	_key_id,x
6858                     ; 866                             key_id_done = 0;
6860  12c7 72110000      	bres	_key_id_done
6861  12cb acc113c1      	jpf	L5772
6862  12cf               L5253:
6863                     ; 869                     else if (START_WITH(ptr0, "tutorial"))
6865  12cf ae0008        	ldw	x,#8
6866  12d2 89            	pushw	x
6867  12d3 ae00c8        	ldw	x,#L3453
6868  12d6 89            	pushw	x
6869  12d7 ae000a        	ldw	x,#L7671_mcu2wifi_rxd+5
6870  12da cd0000        	call	_strncmp
6872  12dd 5b04          	addw	sp,#4
6873  12df a30000        	cpw	x,#0
6874  12e2 2631          	jrne	L1453
6875                     ; 871                         ptr0 += sizeof("tutorial") - 1 + 1;
6877  12e4 1e07          	ldw	x,(OFST-1,sp)
6878  12e6 1c0009        	addw	x,#9
6879  12e9 1f07          	ldw	(OFST-1,sp),x
6880                     ; 872                         temp = atoi(ptr0);
6882  12eb 1e07          	ldw	x,(OFST-1,sp)
6883  12ed cd0000        	call	_atoi
6885  12f0 1f03          	ldw	(OFST-5,sp),x
6886                     ; 873                         if (temp >= TUTORIAL_BEGIN && temp <= TUTORIAL_FINISH)
6888  12f2 9c            	rvf
6889  12f3 1e03          	ldw	x,(OFST-5,sp)
6890  12f5 2f0d          	jrslt	L5453
6892  12f7 9c            	rvf
6893  12f8 1e03          	ldw	x,(OFST-5,sp)
6894  12fa a30008        	cpw	x,#8
6895  12fd 2e05          	jrsge	L5453
6896                     ; 874                             tutorial_state = temp;
6898  12ff 7b04          	ld	a,(OFST-4,sp)
6899  1301 c70000        	ld	_tutorial_state,a
6900  1304               L5453:
6901                     ; 875                         append_int(ack_str, tutorial_state);
6903  1304 c60000        	ld	a,_tutorial_state
6904  1307 5f            	clrw	x
6905  1308 97            	ld	xl,a
6906  1309 89            	pushw	x
6907  130a ae0000        	ldw	x,#L1771_ack_str
6908  130d cd016c        	call	L1022_append_int
6910  1310 85            	popw	x
6912  1311 acc113c1      	jpf	L5772
6913  1315               L1453:
6914                     ; 877                     else if (START_WITH(ptr0, "MIIO_mcu_version_req"))
6916  1315 ae0014        	ldw	x,#20
6917  1318 89            	pushw	x
6918  1319 ae00b3        	ldw	x,#L3553
6919  131c 89            	pushw	x
6920  131d ae000a        	ldw	x,#L7671_mcu2wifi_rxd+5
6921  1320 cd0000        	call	_strncmp
6923  1323 5b04          	addw	sp,#4
6924  1325 a30000        	cpw	x,#0
6925  1328 2608          	jrne	L1553
6926                     ; 879                         mcu2wifi_cmd = MCU_WIFI_VERSION;
6928  132a 350300ce      	mov	L1671_mcu2wifi_cmd,#3
6929                     ; 880                         break;
6931  132e ac831583      	jpf	L3672
6932  1332               L1553:
6933                     ; 882                     else if (START_WITH(ptr0, "MIIO_model_req"))
6935  1332 ae000e        	ldw	x,#14
6936  1335 89            	pushw	x
6937  1336 ae00a4        	ldw	x,#L1653
6938  1339 89            	pushw	x
6939  133a ae000a        	ldw	x,#L7671_mcu2wifi_rxd+5
6940  133d cd0000        	call	_strncmp
6942  1340 5b04          	addw	sp,#4
6943  1342 a30000        	cpw	x,#0
6944  1345 2608          	jrne	L7553
6945                     ; 884                         mcu2wifi_cmd = MCU_WIFI_MODEL_SETTING;
6947  1347 350200ce      	mov	L1671_mcu2wifi_cmd,#2
6948                     ; 885                         break;
6950  134b ac831583      	jpf	L3672
6951  134f               L7553:
6952                     ; 887                     else if (START_WITH(ptr0, "MIIO_net_change"))
6954  134f ae000f        	ldw	x,#15
6955  1352 89            	pushw	x
6956  1353 ae0094        	ldw	x,#L7653
6957  1356 89            	pushw	x
6958  1357 ae000a        	ldw	x,#L7671_mcu2wifi_rxd+5
6959  135a cd0000        	call	_strncmp
6961  135d 5b04          	addw	sp,#4
6962  135f a30000        	cpw	x,#0
6963  1362 2610          	jrne	L5653
6964                     ; 889                         ptr0 += sizeof("MIIO_net_change") - 1 + 1;
6966  1364 1e07          	ldw	x,(OFST-1,sp)
6967  1366 1c0010        	addw	x,#16
6968  1369 1f07          	ldw	(OFST-1,sp),x
6969                     ; 890                         process_net_state(ptr0);
6971  136b 1e07          	ldw	x,(OFST-1,sp)
6972  136d cd0000        	call	L5102_process_net_state
6974                     ; 891                         break;
6976  1370 ac831583      	jpf	L3672
6977  1374               L5653:
6978                     ; 893                     else if (START_WITH(ptr0, "update_fw"))
6980  1374 ae0009        	ldw	x,#9
6981  1377 89            	pushw	x
6982  1378 ae008a        	ldw	x,#L5753
6983  137b 89            	pushw	x
6984  137c ae000a        	ldw	x,#L7671_mcu2wifi_rxd+5
6985  137f cd0000        	call	_strncmp
6987  1382 5b04          	addw	sp,#4
6988  1384 a30000        	cpw	x,#0
6989  1387 2633          	jrne	L3753
6990                     ; 895                         if (machine_speed_target > 0)
6992  1389 3d00          	tnz	_machine_speed_target
6993  138b 2703          	jreq	L602
6994  138d cc1583        	jp	L3672
6995  1390               L602:
6996                     ; 896                             break;
6998                     ; 897                         eeprom_wrchar(EEPROM_ADDR_FLAG_UPDATE, 1);
7000  1390 4b01          	push	#1
7001  1392 ae407f        	ldw	x,#16511
7002  1395 cd0000        	call	_eeprom_wrchar
7004  1398 84            	pop	a
7005                     ; 898                         disp_matrix_all(0x00);
7007  1399 4f            	clr	a
7008  139a cd0000        	call	_disp_matrix_all
7010                     ; 899                         disp_text_up("UPDA");
7012  139d 4b00          	push	#0
7013  139f ae0085        	ldw	x,#L1063
7014  13a2 cd0000        	call	_disp_text
7016  13a5 84            	pop	a
7017                     ; 900                         disp_text_down("TING");
7019  13a6 4b01          	push	#1
7020  13a8 ae0080        	ldw	x,#L3063
7021  13ab cd0000        	call	_disp_text
7023  13ae 84            	pop	a
7024                     ; 901                         DisplayDriverProcessLED();
7026  13af cd0000        	call	_DisplayDriverProcessLED
7028                     ; 902                         WWDG->CR |= 0x80;
7030  13b2 721e50d1      	bset	20689,#7
7031                     ; 903                         WWDG->CR &= (uchar)~0x40;
7033  13b6 721d50d1      	bres	20689,#6
7035  13ba 2005          	jra	L5772
7036  13bc               L3753:
7037                     ; 907                         error_code = -5001;
7039  13bc aeec77        	ldw	x,#60535
7040  13bf bf04          	ldw	L7432_error_code,x
7041  13c1               L5772:
7042                     ; 909                     mcu2wifi_cmd = error_code == 0 ? MCU_WIFI_RESULT : MCU_WIFI_ERROR;
7044  13c1 be04          	ldw	x,L7432_error_code
7045  13c3 2604          	jrne	L611
7046  13c5 a607          	ld	a,#7
7047  13c7 2002          	jra	L021
7048  13c9               L611:
7049  13c9 a608          	ld	a,#8
7050  13cb               L021:
7051  13cb c700ce        	ld	L1671_mcu2wifi_cmd,a
7053  13ce ac831583      	jpf	L3672
7054  13d2               L5672:
7055                     ; 911                 else if (START_WITH(mcu2wifi_rxd, "error"))
7057  13d2 ae0005        	ldw	x,#5
7058  13d5 89            	pushw	x
7059  13d6 ae0253        	ldw	x,#L3372
7060  13d9 89            	pushw	x
7061  13da ae0005        	ldw	x,#L7671_mcu2wifi_rxd
7062  13dd cd0000        	call	_strncmp
7064  13e0 5b04          	addw	sp,#4
7065  13e2 a30000        	cpw	x,#0
7066  13e5 2703          	jreq	L012
7067  13e7 cc1583        	jp	L3672
7068  13ea               L012:
7069  13ea ac831583      	jpf	L3672
7070  13ee               L7142:
7071                     ; 915             case MCU_WIFI_STORE_POINT:
7071                     ; 916                 clear_wifi_flag(FLAG_WIFI_STORE_POINT);
7073  13ee 721500fc      	bres	_commu_wifi_flag,#2
7074  13f2               L1242:
7075                     ; 917             case MCU_WIFI_RESULT:
7075                     ; 918             case MCU_WIFI_PROPS:
7075                     ; 919             case MCU_WIFI_STORE_MP:
7075                     ; 920             case MCU_WIFI_ERROR_ID:
7075                     ; 921                 if (START_WITH(mcu2wifi_rxd, OK))
7077  13f2 ae0002        	ldw	x,#2
7078  13f5 89            	pushw	x
7079  13f6 ae001e        	ldw	x,#L3102_OK
7080  13f9 89            	pushw	x
7081  13fa ae0005        	ldw	x,#L7671_mcu2wifi_rxd
7082  13fd cd0000        	call	_strncmp
7084  1400 5b04          	addw	sp,#4
7085  1402 a30000        	cpw	x,#0
7086  1405 2703          	jreq	L212
7087  1407 cc1583        	jp	L3672
7088  140a               L212:
7089                     ; 922                     mcu2wifi_cmd = MCU_WIFI_GET_DOWN;
7091  140a 350600ce      	mov	L1671_mcu2wifi_cmd,#6
7092  140e ac831583      	jpf	L3672
7093  1412               L3242:
7094                     ; 924             case MCU_WIFI_STORE_OFFLINE:
7094                     ; 925                 clear_wifi_flag(FLAG_WIFI_STORE_POINT);
7096  1412 721500fc      	bres	_commu_wifi_flag,#2
7097                     ; 926                 clear_wifi_flag(FLAG_WIFI_STORE_OFFLINE);
7099  1416 721b00fc      	bres	_commu_wifi_flag,#5
7100                     ; 927                 mcu2wifi_cmd = MCU_WIFI_GET_DOWN;
7102  141a 350600ce      	mov	L1671_mcu2wifi_cmd,#6
7103                     ; 928                 break;
7105  141e ac831583      	jpf	L3672
7106  1422               L5242:
7107                     ; 929             case MCU_WIFI_MODEL_QUERY:
7107                     ; 930                 if (START_WITH(mcu2wifi_rxd, MODEL_NAME))
7109  1422 ae0012        	ldw	x,#18
7110  1425 89            	pushw	x
7111  1426 ae0006        	ldw	x,#L1102_MODEL_NAME
7112  1429 89            	pushw	x
7113  142a ae0005        	ldw	x,#L7671_mcu2wifi_rxd
7114  142d cd0000        	call	_strncmp
7116  1430 5b04          	addw	sp,#4
7117  1432 a30000        	cpw	x,#0
7118  1435 2608          	jrne	L5163
7119                     ; 931                     mcu2wifi_cmd = MCU_WIFI_VERSION;
7121  1437 350300ce      	mov	L1671_mcu2wifi_cmd,#3
7123  143b ac831583      	jpf	L3672
7124  143f               L5163:
7125                     ; 933                     mcu2wifi_cmd = MCU_WIFI_MODEL_SETTING;
7127  143f 350200ce      	mov	L1671_mcu2wifi_cmd,#2
7128  1443 ac831583      	jpf	L3672
7129  1447               L7242:
7130                     ; 935             case MCU_WIFI_MODEL_SETTING:
7130                     ; 936                 if (START_WITH(mcu2wifi_rxd, OK))
7132  1447 ae0002        	ldw	x,#2
7133  144a 89            	pushw	x
7134  144b ae001e        	ldw	x,#L3102_OK
7135  144e 89            	pushw	x
7136  144f ae0005        	ldw	x,#L7671_mcu2wifi_rxd
7137  1452 cd0000        	call	_strncmp
7139  1455 5b04          	addw	sp,#4
7140  1457 a30000        	cpw	x,#0
7141  145a 2608          	jrne	L1263
7142                     ; 937                     mcu2wifi_cmd = MCU_WIFI_VERSION;
7144  145c 350300ce      	mov	L1671_mcu2wifi_cmd,#3
7146  1460 ac831583      	jpf	L3672
7147  1464               L1263:
7148                     ; 939                     mcu2wifi_cmd = MCU_WIFI_MODEL_SETTING;
7150  1464 350200ce      	mov	L1671_mcu2wifi_cmd,#2
7151  1468 ac831583      	jpf	L3672
7152  146c               L1342:
7153                     ; 941             case MCU_WIFI_VERSION:
7153                     ; 942                 if (START_WITH(mcu2wifi_rxd, OK))
7155  146c ae0002        	ldw	x,#2
7156  146f 89            	pushw	x
7157  1470 ae001e        	ldw	x,#L3102_OK
7158  1473 89            	pushw	x
7159  1474 ae0005        	ldw	x,#L7671_mcu2wifi_rxd
7160  1477 cd0000        	call	_strncmp
7162  147a 5b04          	addw	sp,#4
7163  147c a30000        	cpw	x,#0
7164  147f 2608          	jrne	L5263
7165                     ; 943                     mcu2wifi_cmd = MCU_BLE_CONFIG_DUMP;
7167  1481 350f00ce      	mov	L1671_mcu2wifi_cmd,#15
7169  1485 ac831583      	jpf	L3672
7170  1489               L5263:
7171                     ; 945                     mcu2wifi_cmd = MCU_WIFI_VERSION;
7173  1489 350300ce      	mov	L1671_mcu2wifi_cmd,#3
7174  148d ac831583      	jpf	L3672
7175  1491               L3342:
7176                     ; 947             case MCU_WIFI_RESTORE:
7176                     ; 948                 if (START_WITH(mcu2wifi_rxd, OK))
7178  1491 ae0002        	ldw	x,#2
7179  1494 89            	pushw	x
7180  1495 ae001e        	ldw	x,#L3102_OK
7181  1498 89            	pushw	x
7182  1499 ae0005        	ldw	x,#L7671_mcu2wifi_rxd
7183  149c cd0000        	call	_strncmp
7185  149f 5b04          	addw	sp,#4
7186  14a1 a30000        	cpw	x,#0
7187  14a4 2610          	jrne	L1363
7188                     ; 950                     clear_wifi_flag(FLAG_WIFI_RESTORE);
7190  14a6 721100fc      	bres	_commu_wifi_flag,#0
7191                     ; 951                     net_state = NET_STATE_UNKNOWN;
7193  14aa 725f00fb      	clr	_net_state
7194                     ; 952                     mcu2wifi_cmd = MCU_BLE_CONFIG_DUMP;
7196  14ae 350f00ce      	mov	L1671_mcu2wifi_cmd,#15
7198  14b2 ac831583      	jpf	L3672
7199  14b6               L1363:
7200                     ; 955                     mcu2wifi_cmd = MCU_WIFI_RESTORE;
7202  14b6 350400ce      	mov	L1671_mcu2wifi_cmd,#4
7203  14ba ac831583      	jpf	L3672
7204  14be               L5342:
7205                     ; 957             case MCU_WIFI_NET:
7205                     ; 958                 process_net_state(mcu2wifi_rxd);
7207  14be ae0005        	ldw	x,#L7671_mcu2wifi_rxd
7208  14c1 cd0000        	call	L5102_process_net_state
7210                     ; 959                 break;
7212  14c4 ac831583      	jpf	L3672
7213  14c8               L7342:
7214                     ; 963                     clear_wifi_flag(FLAG_WIFI_FACTORY);
7216  14c8 721700fc      	bres	_commu_wifi_flag,#3
7217                     ; 964                     mcu2wifi_cmd = MCU_WIFI_NET;
7219  14cc 350900ce      	mov	L1671_mcu2wifi_cmd,#9
7220                     ; 966                 break;
7222  14d0 ac831583      	jpf	L3672
7223  14d4               L1442:
7224                     ; 967             case MCU_BLE_CONFIG_DUMP:
7224                     ; 968                 if (START_WITH(mcu2wifi_rxd, "[\"product id\":331,")) // ["product id":331,"version":1.5.1_0015]
7226  14d4 ae0012        	ldw	x,#18
7227  14d7 89            	pushw	x
7228  14d8 ae006d        	ldw	x,#L7363
7229  14db 89            	pushw	x
7230  14dc ae0005        	ldw	x,#L7671_mcu2wifi_rxd
7231  14df cd0000        	call	_strncmp
7233  14e2 5b04          	addw	sp,#4
7234  14e4 a30000        	cpw	x,#0
7235  14e7 2619          	jrne	L5363
7236                     ; 970                     ptr0 = strstr(mcu2wifi_rxd, FW_VERSION);
7238  14e9 ae0019        	ldw	x,#_FW_VERSION
7239  14ec 89            	pushw	x
7240  14ed ae0005        	ldw	x,#L7671_mcu2wifi_rxd
7241  14f0 cd0000        	call	_strstr
7243  14f3 5b02          	addw	sp,#2
7244  14f5 1f07          	ldw	(OFST-1,sp),x
7245                     ; 971                     if (ptr0 != NULL)
7247  14f7 1e07          	ldw	x,(OFST-1,sp)
7248  14f9 2707          	jreq	L5363
7249                     ; 973                         mcu2wifi_cmd = MCU_WIFI_GET_DOWN;
7251  14fb 350600ce      	mov	L1671_mcu2wifi_cmd,#6
7252                     ; 974                         break;
7254  14ff cc1583        	jra	L3672
7255  1502               L5363:
7256                     ; 977                 mcu2wifi_cmd = MCU_BLE_CONFIG_SET;
7258  1502 351000ce      	mov	L1671_mcu2wifi_cmd,#16
7259                     ; 978                 break;
7261  1506 207b          	jra	L3672
7262  1508               L3442:
7263                     ; 979             case MCU_BLE_CONFIG_SET:
7263                     ; 980                 if (START_WITH(mcu2wifi_rxd, OK))
7265  1508 ae0002        	ldw	x,#2
7266  150b 89            	pushw	x
7267  150c ae001e        	ldw	x,#L3102_OK
7268  150f 89            	pushw	x
7269  1510 ae0005        	ldw	x,#L7671_mcu2wifi_rxd
7270  1513 cd0000        	call	_strncmp
7272  1516 5b04          	addw	sp,#4
7273  1518 a30000        	cpw	x,#0
7274  151b 2606          	jrne	L3463
7275                     ; 981                     mcu2wifi_cmd = MCU_WIFI_GET_DOWN;
7277  151d 350600ce      	mov	L1671_mcu2wifi_cmd,#6
7279  1521 2004          	jra	L5442
7280  1523               L3463:
7281                     ; 983                     mcu2wifi_cmd = MCU_BLE_CONFIG_SET;
7283  1523 351000ce      	mov	L1671_mcu2wifi_cmd,#16
7284  1527               L5442:
7285                     ; 984             case MCU_WIFI_TIME:
7285                     ; 985                 server_time = atol(mcu2wifi_rxd);
7287  1527 ae0005        	ldw	x,#L7671_mcu2wifi_rxd
7288  152a cd0000        	call	_atol
7290  152d ae00d0        	ldw	x,#_server_time
7291  1530 cd0000        	call	c_rtol
7293                     ; 986                 if (server_time > 1517212762ul)
7295  1533 ae00d0        	ldw	x,#_server_time
7296  1536 cd0000        	call	c_ltor
7298  1539 ae0047        	ldw	x,#L221
7299  153c cd0000        	call	c_lcmp
7301  153f 2532          	jrult	L7463
7302                     ; 988                     server_time -= clock() / CLOCKS_PER_SEC;
7304  1541 cd0000        	call	_clock
7306  1544 ae0021        	ldw	x,#L42
7307  1547 cd0000        	call	c_ludv
7309  154a ae00d0        	ldw	x,#_server_time
7310  154d cd0000        	call	c_lgsub
7312                     ; 989                     if (error_id == 0)
7314  1550 725d0000      	tnz	_error_id
7315  1554 2629          	jrne	L5563
7316                     ; 991                         error_id = eeprom_rdchar(EEPROM_ADDR_ERROR_ID);
7318  1556 5540230000    	mov	_error_id,16419
7319                     ; 992                         if (error_id > 0)
7321  155b 725d0000      	tnz	_error_id
7322  155f 271e          	jreq	L5563
7323                     ; 994                             error_time = eeprom_read_long(EEPROM_ADDR_ERROR_TIME);
7325  1561 ce4026        	ldw	x,16422
7326  1564 cf0002        	ldw	_error_time+2,x
7327  1567 ce4024        	ldw	x,16420
7328  156a cf0000        	ldw	_error_time,x
7329                     ; 995                             mcu2wifi_cmd = MCU_WIFI_ERROR_ID;
7331  156d 350e00ce      	mov	L1671_mcu2wifi_cmd,#14
7332                     ; 996                             break;
7334  1571 2010          	jra	L3672
7335  1573               L7463:
7336                     ; 1002                     server_time = 0;
7338  1573 ae0000        	ldw	x,#0
7339  1576 cf00d2        	ldw	_server_time+2,x
7340  1579 ae0000        	ldw	x,#0
7341  157c cf00d0        	ldw	_server_time,x
7342  157f               L5563:
7343                     ; 1004                 mcu2wifi_cmd = MCU_WIFI_GET_DOWN;
7345  157f 350600ce      	mov	L1671_mcu2wifi_cmd,#6
7346  1583               L7442:
7347                     ; 1005             default:
7347                     ; 1006                 break;
7349  1583               L3672:
7350                     ; 1009             wifi2mcu_cmd = MCU_WIFI_NO_COMMAND;
7352  1583 725f00cd      	clr	L3671_wifi2mcu_cmd
7353                     ; 1010             commu_mcu2wifi_state = COMMU_STATE_MCU2WIFI_TRANSMIT; //switch to transmit
7355  1587 350100cf      	mov	L7571_commu_mcu2wifi_state,#1
7356                     ; 1011             commu_mcu2wifi_cnt = 0;
7358  158b 725f0004      	clr	L3771_commu_mcu2wifi_cnt
7360  158f 2033          	jra	L3572
7361  1591               L7572:
7362                     ; 1015             if (commu_mcu2wifi_cnt >= WAIT_WIFI_FEEDBACK_TIME) //when no feedback for 0.3s, go to transmit state
7364  1591 c60004        	ld	a,L3771_commu_mcu2wifi_cnt
7365  1594 a1fa          	cp	a,#250
7366  1596 2513          	jrult	L1663
7367                     ; 1017                 commu_mcu2wifi_state = COMMU_STATE_MCU2WIFI_TRANSMIT;
7369  1598 350100cf      	mov	L7571_commu_mcu2wifi_state,#1
7370                     ; 1018                 mcu2wifi_cmd = wifi2mcu_cmd;
7372  159c 5500cd00ce    	mov	L1671_mcu2wifi_cmd,L3671_wifi2mcu_cmd
7373                     ; 1019                 wifi2mcu_cmd = MCU_WIFI_NO_COMMAND;
7375  15a1 725f00cd      	clr	L3671_wifi2mcu_cmd
7376                     ; 1020                 commu_mcu2wifi_cnt = 0;
7378  15a5 725f0004      	clr	L3771_commu_mcu2wifi_cnt
7380  15a9 2019          	jra	L3572
7381  15ab               L1663:
7382                     ; 1024                 commu_mcu2wifi_cnt++; //in 20ms
7384  15ab 725c0004      	inc	L3771_commu_mcu2wifi_cnt
7385  15af 2013          	jra	L3572
7386  15b1               L5572:
7387                     ; 1030         if (waiting == 0)
7389                     	btst	_waiting
7390  15b6 250c          	jrult	L3572
7391                     ; 1032             transmit_delay = 0;
7393  15b8 725f0000      	clr	L3002_transmit_delay
7394                     ; 1033             commu_mcu2wifi_state = COMMU_STATE_MCU2WIFI_TRANSMIT;
7396  15bc 350100cf      	mov	L7571_commu_mcu2wifi_state,#1
7397                     ; 1034             mcu2wifi_cmd = MCU_WIFI_MODEL_QUERY;
7399  15c0 350100ce      	mov	L1671_mcu2wifi_cmd,#1
7400  15c4               L3572:
7401                     ; 1037 }
7402  15c4               L031:
7405  15c4 5b08          	addw	sp,#8
7406  15c6 81            	ret
7435                     ; 1069 @far @interrupt void txd_isr(void)
7435                     ; 1070 {
7437                     	switch	.text
7438  15c7               f_txd_isr:
7443                     ; 1071     if (cnt_mcu2wifi_tra2 < command_mcu2wifi_size)
7445  15c7 c60002        	ld	a,L7771_cnt_mcu2wifi_tra2
7446  15ca c10003        	cp	a,L5771_command_mcu2wifi_size
7447  15cd 2413          	jruge	L1073
7448                     ; 1073         UART2_DR = mcu2wifi_txd[cnt_mcu2wifi_tra2++];
7450  15cf c60002        	ld	a,L7771_cnt_mcu2wifi_tra2
7451  15d2 97            	ld	xl,a
7452  15d3 725c0002      	inc	L7771_cnt_mcu2wifi_tra2
7453  15d7 9f            	ld	a,xl
7454  15d8 5f            	clrw	x
7455  15d9 97            	ld	xl,a
7456  15da d60069        	ld	a,(L5671_mcu2wifi_txd,x)
7457  15dd c75241        	ld	_UART2_DR,a
7459  15e0 2008          	jra	L3073
7460  15e2               L1073:
7461                     ; 1077         cnt_mcu2wifi_tra2 = 0;
7463  15e2 725f0002      	clr	L7771_cnt_mcu2wifi_tra2
7464                     ; 1078         TXEN_FLAG = 0; //txd disable
7466  15e6 72175245      	bres	_UART2_CR2,#3
7467  15ea               L3073:
7468                     ; 1081     TC_FLAG = 0;
7470  15ea 721d5240      	bres	_UART2_SR,#6
7471                     ; 1082 }
7474  15ee 80            	iret
7500                     ; 1084 @far @interrupt void rxd_isr(void)
7500                     ; 1085 {
7501                     	switch	.text
7502  15ef               f_rxd_isr:
7507                     ; 1086     mcu2wifi_rxd[cnt_mcu2wifi_rec2] = UART2_DR;
7509  15ef c60001        	ld	a,L1002_cnt_mcu2wifi_rec2
7510  15f2 5f            	clrw	x
7511  15f3 97            	ld	xl,a
7512  15f4 c65241        	ld	a,_UART2_DR
7513  15f7 d70005        	ld	(L7671_mcu2wifi_rxd,x),a
7514                     ; 1087     if (mcu2wifi_rxd[cnt_mcu2wifi_rec2] == '\r')
7516  15fa c60001        	ld	a,L1002_cnt_mcu2wifi_rec2
7517  15fd 5f            	clrw	x
7518  15fe 97            	ld	xl,a
7519  15ff d60005        	ld	a,(L7671_mcu2wifi_rxd,x)
7520  1602 a10d          	cp	a,#13
7521  1604 2613          	jrne	L5173
7522                     ; 1089         mcu2wifi_rxd[cnt_mcu2wifi_rec2] = '\0';
7524  1606 c60001        	ld	a,L1002_cnt_mcu2wifi_rec2
7525  1609 5f            	clrw	x
7526  160a 97            	ld	xl,a
7527  160b 724f0005      	clr	(L7671_mcu2wifi_rxd,x)
7528                     ; 1090         recvorder = 1;
7530  160f 72100000      	bset	L5002_recvorder
7531                     ; 1091         cnt_mcu2wifi_rec2 = 0;
7533  1613 725f0001      	clr	L1002_cnt_mcu2wifi_rec2
7535  1617 201a          	jra	L7173
7536  1619               L5173:
7537                     ; 1093     else if (mcu2wifi_rxd[cnt_mcu2wifi_rec2] != '\0')
7539  1619 c60001        	ld	a,L1002_cnt_mcu2wifi_rec2
7540  161c 5f            	clrw	x
7541  161d 97            	ld	xl,a
7542  161e 724d0005      	tnz	(L7671_mcu2wifi_rxd,x)
7543  1622 270f          	jreq	L7173
7544                     ; 1095         cnt_mcu2wifi_rec2++;
7546  1624 725c0001      	inc	L1002_cnt_mcu2wifi_rec2
7547                     ; 1096         if (cnt_mcu2wifi_rec2 >= BUFF_LEN)
7549  1628 c60001        	ld	a,L1002_cnt_mcu2wifi_rec2
7550  162b a164          	cp	a,#100
7551  162d 2504          	jrult	L7173
7552                     ; 1098             cnt_mcu2wifi_rec2 = 0;
7554  162f 725f0001      	clr	L1002_cnt_mcu2wifi_rec2
7555  1633               L7173:
7556                     ; 1101 }
7559  1633 80            	iret
8153                     	xdef	f_rxd_isr
8154                     	xdef	f_txd_isr
8155                     	xdef	_FW_VERSION
8156                     	xref.b	_user_calories
8157                     	xref.b	_user_distance
8158                     	xref	_user_time_second
8159                     	xref	_user_time_minute
8160                     .bit:	section	.data,bit
8161  0000               L5002_recvorder:
8162  0000 00            	ds.b	1
8163                     	switch	.bss
8164  0000               L3002_transmit_delay:
8165  0000 00            	ds.b	1
8166  0001               L1002_cnt_mcu2wifi_rec2:
8167  0001 00            	ds.b	1
8168  0002               L7771_cnt_mcu2wifi_tra2:
8169  0002 00            	ds.b	1
8170  0003               L5771_command_mcu2wifi_size:
8171  0003 00            	ds.b	1
8172  0004               L3771_commu_mcu2wifi_cnt:
8173  0004 00            	ds.b	1
8174  0005               L7671_mcu2wifi_rxd:
8175  0005 000000000000  	ds.b	100
8176  0069               L5671_mcu2wifi_txd:
8177  0069 000000000000  	ds.b	100
8178  00cd               L3671_wifi2mcu_cmd:
8179  00cd 00            	ds.b	1
8180  00ce               L1671_mcu2wifi_cmd:
8181  00ce 00            	ds.b	1
8182  00cf               L7571_commu_mcu2wifi_state:
8183  00cf 00            	ds.b	1
8184                     	xref	_clock
8185                     	xbit	_key_id_done
8186                     	xref.b	_key_id
8187                     	xref	_DisplayDriverProcessLED
8188                     	xref	_disp_text
8189                     	xref	_disp_matrix_all
8190                     	xref	_eeprom_write_int
8191                     	xref	_eeprom_write_long
8192                     	xref	_eeprom_wrchar
8193                     	xref	_tutorial_state
8194                     	xref	_stepdown_flag
8195                     	xref.b	_runmode
8196                     	xref	_beep
8197                     	xref	_tension2_bias
8198                     	xref	_tension_bias
8199                     	xref	_tension2
8200                     	xref	_tension
8201                     	xref	_flag_disp
8202                     	xbit	_flag_auto
8203                     	xref	_goal_status
8204                     	xref	_goal_value
8205                     	xref	_goal_type
8206                     	xref	_fixed_start_speed
8207                     	xbit	_max_speed_unlocked
8208                     	xref	_acceleration_param
8209                     	xref	_fixed_mode_speed
8210                     	xref	_speed_limit_max
8211                     	xref	_user_steps_total
8212                     	xref	_machine_volt_motor
8213                     	xref	_machine_current_motor
8214                     	xref.b	_machine_speed_target
8215                     	xbit	_waiting
8216                     	xref.b	_user_speed_target
8217                     	xref.b	_user_request
8218                     	xdef	_commu_wifi
8219  00d0               _server_time:
8220  00d0 00000000      	ds.b	4
8221                     	xdef	_server_time
8222  00d4               _button_id:
8223  00d4 0000          	ds.b	2
8224                     	xdef	_button_id
8225                     	switch	.bit
8226  0001               _flag_mode_changed:
8227  0001 00            	ds.b	1
8228                     	xdef	_flag_mode_changed
8229                     	switch	.bss
8230  00d6               _store_point:
8231  00d6 000000000000  	ds.b	31
8232                     	xdef	_store_point
8233  00f5               _store_mp:
8234  00f5 000000000000  	ds.b	6
8235                     	xdef	_store_mp
8236  00fb               _net_state:
8237  00fb 00            	ds.b	1
8238                     	xdef	_net_state
8239  00fc               _commu_wifi_flag:
8240  00fc 00            	ds.b	1
8241                     	xdef	_commu_wifi_flag
8242                     	xref	_atol
8243                     	xref	_atoi
8244                     	xref	_strlen
8245                     	xref	_strncmp
8246                     	xref	_strstr
8247                     	xref	_strcpy
8248                     	xref	_strchr
8249                     	xref	_sprintf
8250                     	switch	.const
8251  006d               L7363:
8252  006d 5b22          	dc.b	"[",34
8253  006f 70726f647563  	dc.b	"product id",34
8254  007a 3a3333312c00  	dc.b	":331,",0
8255  0080               L3063:
8256  0080 54494e4700    	dc.b	"TING",0
8257  0085               L1063:
8258  0085 5550444100    	dc.b	"UPDA",0
8259  008a               L5753:
8260  008a 757064617465  	dc.b	"update_fw",0
8261  0094               L7653:
8262  0094 4d49494f5f6e  	dc.b	"MIIO_net_change",0
8263  00a4               L1653:
8264  00a4 4d49494f5f6d  	dc.b	"MIIO_model_req",0
8265  00b3               L3553:
8266  00b3 4d49494f5f6d  	dc.b	"MIIO_mcu_version_r"
8267  00c5 657100        	dc.b	"eq",0
8268  00c8               L3453:
8269  00c8 7475746f7269  	dc.b	"tutorial",0
8270  00d1               L1353:
8271  00d1 757000        	dc.b	"up",0
8272  00d4               L5743:
8273  00d4 696e73757265  	dc.b	"insure",0
8274  00db               L3443:
8275  00db 256420256400  	dc.b	"%d %d",0
8276  00e1               L1243:
8277  00e1 63616c6900    	dc.b	"cali",0
8278  00e6               L1523:
8279  00e6 7365745f00    	dc.b	"set_",0
8280  00eb               L3423:
8281  00eb 2d3100        	dc.b	"-1",0
8282  00ee               L7323:
8283  00ee 706f77657200  	dc.b	"power",0
8284  00f4               L1323:
8285  00f4 737461746500  	dc.b	"state",0
8286  00fa               L3223:
8287  00fa 7479706500    	dc.b	"type",0
8288  00ff               L5123:
8289  00ff 757365727374  	dc.b	"userstate",0
8290  0109               L3023:
8291  0109 6c6f636b00    	dc.b	"lock",0
8292  010e               L5713:
8293  010e 696e69746961  	dc.b	"initial",0
8294  0116               L7613:
8295  0116 6469737000    	dc.b	"disp",0
8296  011b               L5513:
8297  011b 227b25642c25  	dc.b	34,123,37,100,44,37
8298  0121 642c256c642c  	dc.b	"d,%ld,%ld,%ld,%ld,"
8299  0133 25642c25642c  	dc.b	"%d,%d,%d,%ld}",34
8300  0141 0d00          	dc.b	13,0
8301  0143               L3513:
8302  0143 6c6f6700      	dc.b	"log",0
8303  0147               L5413:
8304  0147 6572726f725f  	dc.b	"error_id",0
8305  0150               L7313:
8306  0150 73656e736974  	dc.b	"sensitivity",0
8307  015c               L1313:
8308  015c 6d617800      	dc.b	"max",0
8309  0160               L3213:
8310  0160 676f616c00    	dc.b	"goal",0
8311  0165               L5113:
8312  0165 73746172745f  	dc.b	"start_speed",0
8313  0171               L7013:
8314  0171 627574746f6e  	dc.b	"button_id",0
8315  017b               L1013:
8316  017b 226d6f64653a  	dc.b	34,109,111,100,101,58
8317  0181 256422        	dc.b	"%d",34
8318  0184 2c22          	dc.b	",",34
8319  0186 74696d653a25  	dc.b	"time:%d",34
8320  018e 2c22          	dc.b	",",34
8321  0190 73703a25642e  	dc.b	"sp:%d.%d",34
8322  0199 2c22          	dc.b	",",34
8323  019b 646973743a25  	dc.b	"dist:%ld",34
8324  01a4 2c22          	dc.b	",",34
8325  01a6 63616c3a256c  	dc.b	"cal:%ld",34
8326  01ae 2c22          	dc.b	",",34
8327  01b0 737465703a25  	dc.b	"step:%d",34,0
8328  01b9               L7703:
8329  01b9 616c6c00      	dc.b	"all",0
8330  01bd               L1703:
8331  01bd 7374657000    	dc.b	"step",0
8332  01c2               L3603:
8333  01c2 63616c00      	dc.b	"cal",0
8334  01c6               L5503:
8335  01c6 6469737400    	dc.b	"dist",0
8336  01cb               L5303:
8337  01cb 737065656400  	dc.b	"speed",0
8338  01d1               L1303:
8339  01d1 737000        	dc.b	"sp",0
8340  01d4               L3203:
8341  01d4 74696d6500    	dc.b	"time",0
8342  01d9               L5103:
8343  01d9 6d6f646500    	dc.b	"mode",0
8344  01de               L1003:
8345  01de 6765745f7072  	dc.b	"get_prop",0
8346  01e7               L3772:
8347  01e7 6e6f6e6500    	dc.b	"none",0
8348  01ec               L7672:
8349  01ec 646f776e00    	dc.b	"down",0
8350  01f1               L1572:
8351  01f1 74696d652070  	dc.b	"time posix",0
8352  01fc               L7472:
8353  01fc 626c655f636f  	dc.b	"ble_config set 331"
8354  020e 20257300      	dc.b	" %s",0
8355  0212               L5472:
8356  0212 626c655f636f  	dc.b	"ble_config dump",0
8357  0222               L3472:
8358  0222 6576656e7420  	dc.b	"event error %d",0
8359  0231               L1472:
8360  0231 666163746f72  	dc.b	"factory",0
8361  0239               L7372:
8362  0239 6e657400      	dc.b	"net",0
8363  023d               L5372:
8364  023d 6572726f7220  	dc.b	"error ",34
8365  0244 756e6b6e6f77  	dc.b	"unknown %s",34
8366  024f 20256400      	dc.b	" %d",0
8367  0253               L3372:
8368  0253 6572726f7200  	dc.b	"error",0
8369  0259               L7272:
8370  0259 636f6d6d616e  	dc.b	"command",0
8371  0261               L3272:
8372  0261 726573746f72  	dc.b	"restore",0
8373  0269               L1272:
8374  0269 6d63755f7665  	dc.b	"mcu_version %s",0
8375  0278               L7172:
8376  0278 257320257300  	dc.b	"%s %s",0
8377  027e               L5172:
8378  027e 73746f726520  	dc.b	"store point ",34
8379  028b 5f6f76657272  	dc.b	"_override_time",34
8380  029a 20256c642025  	dc.b	" %ld %d %d %ld %d "
8381  02ac 256420256420  	dc.b	"%d %d %d %d %d",0
8382  02bb               L3172:
8383  02bb 73746f726520  	dc.b	"store point ",34
8384  02c8 5f6f76657272  	dc.b	"_override_time",34
8385  02d7 20256c642025  	dc.b	" %ld %d %d %d %d %"
8386  02e9 642025642025  	dc.b	"d %d %d %d %d",0
8387  02f7               L1172:
8388  02f7 73746f726520  	dc.b	"store mp %d %d %d",0
8389  0309               L7072:
8390  0309 737465702025  	dc.b	"step %d ",0
8391  0312               L3072:
8392  0312 646973742025  	dc.b	"dist %ld cal %ld ",0
8393  0324               L7762:
8394  0324 6175746f00    	dc.b	"auto",0
8395  0329               L5762:
8396  0329 666978656400  	dc.b	"fixed",0
8397  032f               L3762:
8398  032f 6d6f64652025  	dc.b	"mode %d type ",34
8399  033d 257322        	dc.b	"%s",34
8400  0340 2000          	dc.b	" ",0
8401  0342               L1762:
8402  0342 6f6e00        	dc.b	"on",0
8403  0345               L7662:
8404  0345 6f666600      	dc.b	"off",0
8405  0349               L5662:
8406  0349 706f77657220  	dc.b	"power ",34
8407  0350 257322        	dc.b	"%s",34
8408  0353 2000          	dc.b	" ",0
8409  0355               L5562:
8410  0355 737065656420  	dc.b	"speed ",0
8411  035c               L3562:
8412  035c 73746f7000    	dc.b	"stop",0
8413  0361               L1562:
8414  0361 72756e00      	dc.b	"run",0
8415  0365               L7462:
8416  0365 737461746520  	dc.b	"state ",34
8417  036c 257322        	dc.b	"%s",34
8418  036f 2000          	dc.b	" ",0
8419  0371               L7362:
8420  0371 74696d652025  	dc.b	"time %d ",0
8421  037a               L3362:
8422  037a 70726f707320  	dc.b	"props ",0
8423  0381               L1362:
8424  0381 226f6b2200    	dc.b	34,111,107,34,0
8425  0386               L7262:
8426  0386 726573756c74  	dc.b	"result %s",0
8427  0390               L5262:
8428  0390 6765745f646f  	dc.b	"get_down",0
8429  0399               L1032:
8430  0399 25642e256420  	dc.b	"%d.%d ",0
8431  03a0               L3522:
8432  03a0 256c642000    	dc.b	"%ld ",0
8433  03a5               L5222:
8434  03a5 25642000      	dc.b	"%d ",0
8435  03a9               L7712:
8436  03a9 222573222000  	dc.b	34,37,115,34,32,0
8437  03af               L3012:
8438  03af 756e70726f76  	dc.b	"unprov",0
8439  03b6               L5702:
8440  03b6 75617000      	dc.b	"uap",0
8441  03ba               L7602:
8442  03ba 757064617469  	dc.b	"updating",0
8443  03c3               L1602:
8444  03c3 636c6f756400  	dc.b	"cloud",0
8445  03c9               L3502:
8446  03c9 6c6f63616c00  	dc.b	"local",0
8447  03cf               L5402:
8448  03cf 6f66666c696e  	dc.b	"offline",0
8449                     	xref.b	c_lreg
8450                     	xref.b	c_x
8470                     	xref	c_lgsub
8471                     	xref	c_cmulx
8472                     	xref	c_smul
8473                     	xref	c_lzmp
8474                     	xref	c_lgadc
8475                     	xref	c_lcmp
8476                     	xref	c_ltor
8477                     	xref	c_rtol
8478                     	xref	c_ladd
8479                     	xref	c_ludv
8480                     	xref	c_imul
8481                     	end
