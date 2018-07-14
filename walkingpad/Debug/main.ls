   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
 451                     ; 31 void main(void)
 451                     ; 32 {
 453                     	switch	.text
 454  0000               _main:
 458                     ; 33     ini();
 460  0000 cd0000        	call	_ini
 462  0003               L372:
 463                     ; 36         feed_wdg();
 465  0003 cd0000        	call	_feed_wdg
 467                     ; 37         timer_proc();
 469  0006 cd0000        	call	_timer_proc
 471                     ; 38         key_scan();
 473  0009 cd0000        	call	_key_scan
 475                     ; 39         detect_error();
 477  000c cd0000        	call	_detect_error
 479                     ; 40         key_scan();
 481  000f cd0000        	call	_key_scan
 483                     ; 41         HX711_Weight();
 485  0012 cd0000        	call	_HX711_Weight
 487                     ; 43 		if (factory_finish == 0)
 489                     	btst	_factory_finish
 490  001a 2505          	jrult	L772
 491                     ; 45 			FactoryTestOperation();
 493  001c cd0000        	call	_FactoryTestOperation
 496  001f 2003          	jra	L103
 497  0021               L772:
 498                     ; 49            useroperation();
 500  0021 cd0000        	call	_useroperation
 502  0024               L103:
 503                     ; 52         DisplayDriverProcessLED();
 505  0024 cd0000        	call	_DisplayDriverProcessLED
 507                     ; 53         key_scan();
 509  0027 cd0000        	call	_key_scan
 511                     ; 54         commu();
 513  002a cd0000        	call	_commu
 515                     ; 55         key_scan();
 517  002d cd0000        	call	_key_scan
 519                     ; 58         commu_wifi();
 521  0030 cd0000        	call	_commu_wifi
 523                     ; 62         buzzcon();
 525  0033 cd0000        	call	_buzzcon
 527                     ; 63         key_scan();
 529  0036 cd0000        	call	_key_scan
 532  0039 2001          	jra	L503
 533  003b               L303:
 534                     ; 67             nop(); //20ms
 537  003b 9d            nop
 540  003c               L503:
 541                     ; 65         while (timer_1ms < TIME_BASE_MAIN)
 543  003c b600          	ld	a,_timer_1ms
 544  003e a164          	cp	a,#100
 545  0040 25f9          	jrult	L303
 546                     ; 69         timer_1ms = 0;
 548  0042 3f00          	clr	_timer_1ms
 550  0044 20bd          	jra	L372
 583                     	xdef	_main
 584                     	xref	_feed_wdg
 585                     	xref	_buzzcon
 586                     	xref	_key_scan
 587                     	xref	_commu
 588                     	xref	_ini
 589                     	switch	.ubsct
 590  0000               _ram_d5:
 591  0000 00            	ds.b	1
 592                     	xdef	_ram_d5
 593  0001               _ram_d0:
 594  0001 00            	ds.b	1
 595                     	xdef	_ram_d0
 596                     	xref	_commu_wifi
 597                     	xref	_detect_error
 598                     	xref	_useroperation
 599                     	xref	_FactoryTestOperation
 600                     	xref	_timer_proc
 601                     	xref.b	_timer_1ms
 602                     	xref	_DisplayDriverProcessLED
 603                     	xref	_HX711_Weight
 604                     	switch	.bss
 605  0000               _flag_disp:
 606  0000 00            	ds.b	1
 607                     	xdef	_flag_disp
 608                     .bit:	section	.data,bit
 609  0000               _flag_auto:
 610  0000 00            	ds.b	1
 611                     	xdef	_flag_auto
 612                     	switch	.bss
 613  0001               _goal_status:
 614  0001 00            	ds.b	1
 615                     	xdef	_goal_status
 616  0002               _goal_value:
 617  0002 0000          	ds.b	2
 618                     	xdef	_goal_value
 619  0004               _goal_type:
 620  0004 00            	ds.b	1
 621                     	xdef	_goal_type
 622  0005               _fixed_start_speed:
 623  0005 00            	ds.b	1
 624                     	xdef	_fixed_start_speed
 625                     	switch	.bit
 626  0001               _max_speed_unlocked:
 627  0001 00            	ds.b	1
 628                     	xdef	_max_speed_unlocked
 629  0002               _factory_finish:
 630  0002 00            	ds.b	1
 631                     	xdef	_factory_finish
 632                     	switch	.bss
 633  0006               _acceleration_param:
 634  0006 00            	ds.b	1
 635                     	xdef	_acceleration_param
 636                     	switch	.bit
 637  0003               _tutorial_finish:
 638  0003 00            	ds.b	1
 639                     	xdef	_tutorial_finish
 640                     	switch	.bss
 641  0007               _fixed_mode_speed:
 642  0007 00            	ds.b	1
 643                     	xdef	_fixed_mode_speed
 644  0008               _speed_limit_max:
 645  0008 00            	ds.b	1
 646                     	xdef	_speed_limit_max
 647  0009               _user_steps_last:
 648  0009 0000          	ds.b	2
 649                     	xdef	_user_steps_last
 650  000b               _user_steps_pause:
 651  000b 0000          	ds.b	2
 652                     	xdef	_user_steps_pause
 653  000d               _user_steps_total:
 654  000d 0000          	ds.b	2
 655                     	xdef	_user_steps_total
 656  000f               _user_steps:
 657  000f 0000          	ds.b	2
 658                     	xdef	_user_steps
 659  0011               _machine_volt_motor:
 660  0011 00            	ds.b	1
 661                     	xdef	_machine_volt_motor
 662  0012               _machine_current_motor:
 663  0012 00            	ds.b	1
 664                     	xdef	_machine_current_motor
 665  0013               _dc_motor_rating_f1:
 666  0013 00            	ds.b	1
 667                     	xdef	_dc_motor_rating_f1
 668  0014               _dc_motor_startup_volt:
 669  0014 00            	ds.b	1
 670                     	xdef	_dc_motor_startup_volt
 671  0015               _dc_motor_rating_volt:
 672  0015 00            	ds.b	1
 673                     	xdef	_dc_motor_rating_volt
 674                     	switch	.ubsct
 675  0002               _machine_rpm_target:
 676  0002 0000          	ds.b	2
 677                     	xdef	_machine_rpm_target
 678  0004               _machine_speed_target:
 679  0004 00            	ds.b	1
 680                     	xdef	_machine_speed_target
 681                     	switch	.bit
 682  0004               _machine_state:
 683  0004 00            	ds.b	1
 684                     	xdef	_machine_state
 685                     	switch	.ubsct
 686  0005               _power_board_version:
 687  0005 00            	ds.b	1
 688                     	xdef	_power_board_version
 689                     	switch	.bit
 690  0005               _waiting:
 691  0005 00            	ds.b	1
 692                     	xdef	_waiting
 693                     	switch	.ubsct
 694  0006               _waiting_cnt:
 695  0006 00            	ds.b	1
 696                     	xdef	_waiting_cnt
 697  0007               _user_rpm_target:
 698  0007 0000          	ds.b	2
 699                     	xdef	_user_rpm_target
 700  0009               _user_speed_target:
 701  0009 00            	ds.b	1
 702                     	xdef	_user_speed_target
 703  000a               _user_request:
 704  000a 00            	ds.b	1
 705                     	xdef	_user_request
 706                     	switch	.bss
 707  0016               _pctxd:
 708  0016 000000000000  	ds.b	25
 709                     	xdef	_pctxd
 710  002f               _pcrxd:
 711  002f 000000000000  	ds.b	35
 712                     	xdef	_pcrxd
 713                     	switch	.ubsct
 714  000b               _pccom_cnt:
 715  000b 00            	ds.b	1
 716                     	xdef	_pccom_cnt
 717                     	switch	.bit
 718  0006               _pcerr_com:
 719  0006 00            	ds.b	1
 720                     	xdef	_pcerr_com
 721  0007               _pcorder:
 722  0007 00            	ds.b	1
 723                     	xdef	_pcorder
 724                     	switch	.ubsct
 725  000c               _cnt_tra2:
 726  000c 00            	ds.b	1
 727                     	xdef	_cnt_tra2
 728  000d               _cnt_rec2:
 729  000d 00            	ds.b	1
 730                     	xdef	_cnt_rec2
 731  000e               _error_code:
 732  000e 0000          	ds.b	2
 733                     	xdef	_error_code
 753                     	end
