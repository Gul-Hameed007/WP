   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2808                     ; 7 uchar getFanSpeed(void)
2808                     ; 8 {
2810                     	switch	.text
2811  0000               _getFanSpeed:
2813  0000 88            	push	a
2814       00000001      OFST:	set	1
2817                     ; 10     if (error_id == 10 || error_id == 11)
2819  0001 b600          	ld	a,_error_id
2820  0003 a10a          	cp	a,#10
2821  0005 2706          	jreq	L5002
2823  0007 b600          	ld	a,_error_id
2824  0009 a10b          	cp	a,#11
2825  000b 2609          	jrne	L3002
2826  000d               L5002:
2827                     ; 12         sp = 11;
2829  000d a60b          	ld	a,#11
2830  000f 6b01          	ld	(OFST+0,sp),a
2832  0011               L7002:
2833                     ; 41     return sp;
2835  0011 7b01          	ld	a,(OFST+0,sp)
2838  0013 5b01          	addw	sp,#1
2839  0015 81            	ret
2840  0016               L3002:
2841                     ; 14     else if (factory_finish)
2843                     	btst	_factory_finish
2844  001b 2421          	jruge	L1102
2845                     ; 16         if (user_distance < 10 || machine_speed_target < 30)
2847  001d be00          	ldw	x,_user_distance
2848  001f a3000a        	cpw	x,#10
2849  0022 2506          	jrult	L5102
2851  0024 b600          	ld	a,_machine_speed_target
2852  0026 a11e          	cp	a,#30
2853  0028 2404          	jruge	L3102
2854  002a               L5102:
2855                     ; 18             sp = 0;
2857  002a 0f01          	clr	(OFST+0,sp)
2859  002c 20e3          	jra	L7002
2860  002e               L3102:
2861                     ; 22             sp = machine_speed_target / 30 + 5;
2863  002e b600          	ld	a,_machine_speed_target
2864  0030 ae001e        	ldw	x,#30
2865  0033 51            	exgw	x,y
2866  0034 5f            	clrw	x
2867  0035 97            	ld	xl,a
2868  0036 65            	divw	x,y
2869  0037 9f            	ld	a,xl
2870  0038 ab05          	add	a,#5
2871  003a 6b01          	ld	(OFST+0,sp),a
2872  003c 20d3          	jra	L7002
2873  003e               L1102:
2874                     ; 27         if (global_fan_test == 1)
2876                     	btst	_global_fan_test
2877  0043 2406          	jruge	L3202
2878                     ; 29             sp = 11;
2880  0045 a60b          	ld	a,#11
2881  0047 6b01          	ld	(OFST+0,sp),a
2883  0049 20c6          	jra	L7002
2884  004b               L3202:
2885                     ; 31         else if (machine_speed_target < 30)
2887  004b b600          	ld	a,_machine_speed_target
2888  004d a11e          	cp	a,#30
2889  004f 2404          	jruge	L7202
2890                     ; 33             sp = 0;
2892  0051 0f01          	clr	(OFST+0,sp)
2894  0053 20bc          	jra	L7002
2895  0055               L7202:
2896                     ; 37             sp = machine_speed_target / 30 + 5;
2898  0055 b600          	ld	a,_machine_speed_target
2899  0057 ae001e        	ldw	x,#30
2900  005a 51            	exgw	x,y
2901  005b 5f            	clrw	x
2902  005c 97            	ld	xl,a
2903  005d 65            	divw	x,y
2904  005e 9f            	ld	a,xl
2905  005f ab05          	add	a,#5
2906  0061 6b01          	ld	(OFST+0,sp),a
2907  0063 20ac          	jra	L7002
2920                     	xdef	_getFanSpeed
2921                     	xbit	_global_fan_test
2922                     	xref.b	_error_id
2923                     	xref.b	_user_distance
2924                     	xbit	_factory_finish
2925                     	xref.b	_machine_speed_target
2944                     	end
