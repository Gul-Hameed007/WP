   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
2793                     ; 9 clock_t clock(void)
2793                     ; 10 {
2795                     	switch	.text
2796  0000               _clock:
2800                     ; 11     return __clocks;
2802  0000 ae0000        	ldw	x,#___clocks
2803  0003 cd0000        	call	c_ltor
2807  0006 81            	ret
2810                     	xbit	_flag_beep
2835                     ; 18 @far @interrupt void TIM4_isr (void)
2835                     ; 19 {
2837                     	switch	.text
2838  0007               f_TIM4_isr:
2843                     ; 24     TIM4_SR &= 0x7E;            //clear Flag
2845  0007 c65342        	ld	a,_TIM4_SR
2846  000a a47e          	and	a,#126
2847  000c c75342        	ld	_TIM4_SR,a
2848                     ; 26     __clocks ++;
2850  000f ae0000        	ldw	x,#___clocks
2851  0012 a601          	ld	a,#1
2852  0014 cd0000        	call	c_lgadc
2854                     ; 28     if(timer_1ms<250)
2856  0017 b608          	ld	a,_timer_1ms
2857  0019 a1fa          	cp	a,#250
2858  001b 2402          	jruge	L5002
2859                     ; 30         timer_1ms++;
2861  001d 3c08          	inc	_timer_1ms
2862  001f               L5002:
2863                     ; 34     if(flag_beep)
2865                     	btst	_flag_beep
2866  0024 2406          	jruge	L7002
2867                     ; 36         BUZZ^=1;
2869  0026 901e500f      	bcpl	_PD_ODR,#7
2871  002a 2004          	jra	L1102
2872  002c               L7002:
2873                     ; 40         BEEP_OFF;
2875  002c 721f500f      	bres	_PD_ODR,#7
2876  0030               L1102:
2877                     ; 43     return;
2880  0030 80            	iret
2904                     ; 50 void timer_proc(void)
2904                     ; 51 {
2906                     	switch	.text
2907  0031               _timer_proc:
2911                     ; 52     if (state_tick++ >= TIME_BASE_SEC) //one second base timer
2913  0031 b605          	ld	a,_state_tick
2914  0033 3c05          	inc	_state_tick
2915  0035 a131          	cp	a,#49
2916  0037 2509          	jrult	L3202
2917                     ; 54         state_tick = 0;
2919  0039 3f05          	clr	_state_tick
2920                     ; 55         state_sec ++;
2922  003b be06          	ldw	x,_state_sec
2923  003d 1c0001        	addw	x,#1
2924  0040 bf06          	ldw	_state_sec,x
2925  0042               L3202:
2926                     ; 57 }
2929  0042 81            	ret
2989                     	xdef	f_TIM4_isr
2990                     	switch	.ubsct
2991  0000               ___clocks:
2992  0000 00000000      	ds.b	4
2993                     	xdef	___clocks
2994  0004               _ram_d7:
2995  0004 00            	ds.b	1
2996                     	xdef	_ram_d7
2997                     	xdef	_timer_proc
2998  0005               _state_tick:
2999  0005 00            	ds.b	1
3000                     	xdef	_state_tick
3001  0006               _state_sec:
3002  0006 0000          	ds.b	2
3003                     	xdef	_state_sec
3004  0008               _timer_1ms:
3005  0008 00            	ds.b	1
3006                     	xdef	_timer_1ms
3007                     	xdef	_clock
3027                     	xref	c_lgadc
3028                     	xref	c_ltor
3029                     	end
