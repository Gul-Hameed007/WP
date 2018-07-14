   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2765                     	switch	.ubsct
2766  0000               L3671_key_press_timer:
2767  0000 0000          	ds.b	2
2768                     .bit:	section	.data,bit
2769  0000               L7671_key_start_stop:
2770  0000 00            	ds.b	1
2771                     	switch	.ubsct
2772  0002               L5671_key_relse_timer:
2773  0002 00            	ds.b	1
2838                     ; 26 void key_scan(void)
2838                     ; 27 {
2840                     	switch	.text
2841  0000               _key_scan:
2845                     ; 33     if (key_id != KEY_NONE && key_id_done == 0) return;
2847  0000 be07          	ldw	x,_key_id
2848  0002 2708          	jreq	L5202
2850                     	btst	_key_id_done
2851  0009 2501          	jrult	L5202
2855  000b 81            	ret
2856  000c               L5202:
2857                     ; 34     key_input_last = key_input;
2859  000c be05          	ldw	x,L7571_key_input
2860  000e bf03          	ldw	L1671_key_input_last,x
2861                     ; 35     key_input = 0;
2863  0010 5f            	clrw	x
2864  0011 bf05          	ldw	L7571_key_input,x
2865                     ; 45     K5_DDR = 0;
2867  0013 72155011      	bres	_PD_DDR,#2
2868                     ; 46     if (KI5 == 0)
2870  0017 c65010        	ld	a,_PD_IDR
2871  001a a504          	bcp	a,#4
2872  001c 2605          	jrne	L7202
2873                     ; 48         key_input = KEY_MODE_PRESS_BTN;
2875  001e ae1000        	ldw	x,#4096
2876  0021 bf05          	ldw	L7571_key_input,x
2877  0023               L7202:
2878                     ; 52     if (key_input > 0 && key_input_last == key_input)
2880  0023 be05          	ldw	x,L7571_key_input
2881  0025 273e          	jreq	L1302
2883  0027 be03          	ldw	x,L1671_key_input_last
2884  0029 b305          	cpw	x,L7571_key_input
2885  002b 2638          	jrne	L1302
2886                     ; 54         key_press_timer++;
2888  002d be00          	ldw	x,L3671_key_press_timer
2889  002f 1c0001        	addw	x,#1
2890  0032 bf00          	ldw	L3671_key_press_timer,x
2891                     ; 55         key_relse_timer = 0;
2893  0034 3f02          	clr	L5671_key_relse_timer
2894                     ; 56         if (key_press_timer >= 6) //3)
2896  0036 be00          	ldw	x,L3671_key_press_timer
2897  0038 a30006        	cpw	x,#6
2898  003b 2554          	jrult	L5402
2899                     ; 60             if (key_input != KEY_MODE_PRESS_BTN)
2901  003d be05          	ldw	x,L7571_key_input
2902  003f a31000        	cpw	x,#4096
2903  0042 2706          	jreq	L5302
2904                     ; 62                 key_id = key_input;
2906  0044 be05          	ldw	x,L7571_key_input
2907  0046 bf07          	ldw	_key_id,x
2909  0048 2047          	jra	L5402
2910  004a               L5302:
2911                     ; 66                 if (key_press_timer > 450) //3s
2913  004a be00          	ldw	x,L3671_key_press_timer
2914  004c a301c3        	cpw	x,#451
2915  004f 250e          	jrult	L1402
2916                     ; 68                     key_id = KEY_MODE_LONG_PRESS_BTN;
2918  0051 ae1100        	ldw	x,#4352
2919  0054 bf07          	ldw	_key_id,x
2920                     ; 69                     key_press_timer = 0;
2922  0056 5f            	clrw	x
2923  0057 bf00          	ldw	L3671_key_press_timer,x
2924                     ; 70                     key_start_stop = 0;
2926  0059 72110000      	bres	L7671_key_start_stop
2928  005d 2032          	jra	L5402
2929  005f               L1402:
2930                     ; 74                     key_start_stop = 1;
2932  005f 72100000      	bset	L7671_key_start_stop
2933  0063 202c          	jra	L5402
2934  0065               L1302:
2935                     ; 79     else if (key_input == 0)
2937  0065 be05          	ldw	x,L7571_key_input
2938  0067 2628          	jrne	L5402
2939                     ; 81         if (key_start_stop == 1)
2941                     	btst	L7671_key_start_stop
2942  006e 240b          	jruge	L1502
2943                     ; 83             key_id = KEY_MODE_PRESS_BTN;
2945  0070 ae1000        	ldw	x,#4096
2946  0073 bf07          	ldw	_key_id,x
2947                     ; 84             key_start_stop = 0;
2949  0075 72110000      	bres	L7671_key_start_stop
2951  0079 2016          	jra	L5402
2952  007b               L1502:
2953                     ; 88             key_press_timer = 0;
2955  007b 5f            	clrw	x
2956  007c bf00          	ldw	L3671_key_press_timer,x
2957                     ; 89             key_relse_timer++;
2959  007e 3c02          	inc	L5671_key_relse_timer
2960                     ; 90             if (key_relse_timer > 19) //6)//3
2962  0080 b602          	ld	a,L5671_key_relse_timer
2963  0082 a114          	cp	a,#20
2964  0084 250b          	jrult	L5402
2965                     ; 92                 key_relse_timer = 100;
2967  0086 35640002      	mov	L5671_key_relse_timer,#100
2968                     ; 93                 key_id_done = 0;
2970  008a 72110001      	bres	_key_id_done
2971                     ; 94                 key_id = KEY_NONE;
2973  008e 5f            	clrw	x
2974  008f bf07          	ldw	_key_id,x
2975  0091               L5402:
2976                     ; 98 }
2979  0091 81            	ret
3006                     ; 101 void check_key_id(void)
3006                     ; 102 {
3007                     	switch	.text
3008  0092               _check_key_id:
3012                     ; 124     if (key_id == KEY_NONE && key_input == 0)                   
3014  0092 be07          	ldw	x,_key_id
3015  0094 2613          	jrne	L7602
3017  0096 be05          	ldw	x,L7571_key_input
3018  0098 260f          	jrne	L7602
3019                     ; 126         if ((key_id = rcCheck()) != KEY_NONE) 
3021  009a cd0000        	call	_rcCheck
3023  009d bf07          	ldw	_key_id,x
3024  009f be07          	ldw	x,_key_id
3025  00a1 2717          	jreq	L3702
3026                     ; 127             key_id_done = 0;                  
3028  00a3 72110001      	bres	_key_id_done
3029  00a7 2011          	jra	L3702
3030  00a9               L7602:
3031                     ; 131         if (rcCheck() == KEY_STOP_LONG_PRESS) 
3033  00a9 cd0000        	call	_rcCheck
3035  00ac a30103        	cpw	x,#259
3036  00af 2609          	jrne	L3702
3037                     ; 133             key_id_done = 0;
3039  00b1 72110001      	bres	_key_id_done
3040                     ; 134             key_id = KEY_MODE_STOP_LONG_PRESS_BTN;
3042  00b5 ae1101        	ldw	x,#4353
3043  00b8 bf07          	ldw	_key_id,x
3044  00ba               L3702:
3045                     ; 138 }
3048  00ba 81            	ret
3100                     	xref	_rcCheck
3101                     	xdef	_key_scan
3102                     	switch	.ubsct
3103  0003               L1671_key_input_last:
3104  0003 0000          	ds.b	2
3105  0005               L7571_key_input:
3106  0005 0000          	ds.b	2
3107                     	xdef	_check_key_id
3108                     	switch	.bit
3109  0001               _key_id_done:
3110  0001 00            	ds.b	1
3111                     	xdef	_key_id_done
3112                     	switch	.ubsct
3113  0007               _key_id:
3114  0007 0000          	ds.b	2
3115                     	xdef	_key_id
3135                     	end
