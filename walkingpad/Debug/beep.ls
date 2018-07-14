   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     .const:	section	.text
   5  0000               L3_beep_setting:
   6  0000 00            	dc.b	0
   7  0001 00            	dc.b	0
   8  0002 00            	dc.b	0
   9  0003 05            	dc.b	5
  10  0004 05            	dc.b	5
  11  0005 00            	dc.b	0
  12  0006 0f            	dc.b	15
  13  0007 0f            	dc.b	15
  14  0008 00            	dc.b	0
  15  0009 03            	dc.b	3
  16  000a 03            	dc.b	3
  17  000b 02            	dc.b	2
  18  000c 0f            	dc.b	15
  19  000d 0f            	dc.b	15
  20  000e 08            	dc.b	8
  21  000f 05            	dc.b	5
  22  0010 05            	dc.b	5
  23  0011 05            	dc.b	5
  65                     ; 44 void beep(uchar beepm)
  65                     ; 45 {
  67                     	switch	.text
  68  0000               _beep:
  72                     ; 46     beepmode = beepm;
  74  0000 b703          	ld	L5_beepmode,a
  75                     ; 47     beep_request = 1;
  77  0002 72100001      	bset	L51_beep_request
  78                     ; 48 }
  81  0006 81            	ret
 111                     ; 59 void buzzcon(void)
 111                     ; 60 {
 112                     	switch	.text
 113  0007               _buzzcon:
 117                     ; 61     if (beep_request)
 119                     	btst	L51_beep_request
 120  000c 2425          	jruge	L35
 121                     ; 63         beep_request = 0;
 123  000e 72110001      	bres	L51_beep_request
 124                     ; 64         beep_on_cnt = beep_setting[beepmode][0];
 126  0012 b603          	ld	a,L5_beepmode
 127  0014 97            	ld	xl,a
 128  0015 a603          	ld	a,#3
 129  0017 42            	mul	x,a
 130  0018 d60000        	ld	a,(L3_beep_setting,x)
 131  001b b702          	ld	L7_beep_on_cnt,a
 132                     ; 65         beep_off_cnt = beep_setting[beepmode][1];
 134  001d b603          	ld	a,L5_beepmode
 135  001f 97            	ld	xl,a
 136  0020 a603          	ld	a,#3
 137  0022 42            	mul	x,a
 138  0023 d60001        	ld	a,(L3_beep_setting+1,x)
 139  0026 b701          	ld	L11_beep_off_cnt,a
 140                     ; 66         beep_number = beep_setting[beepmode][2];
 142  0028 b603          	ld	a,L5_beepmode
 143  002a 97            	ld	xl,a
 144  002b a603          	ld	a,#3
 145  002d 42            	mul	x,a
 146  002e d60002        	ld	a,(L3_beep_setting+2,x)
 147  0031 b700          	ld	L31_beep_number,a
 148  0033               L35:
 149                     ; 68     if (beep_on_cnt > 0)
 151  0033 3d02          	tnz	L7_beep_on_cnt
 152  0035 2708          	jreq	L55
 153                     ; 71         flag_beep = 1;
 155  0037 72100000      	bset	_flag_beep
 156                     ; 75         beep_on_cnt--;
 158  003b 3a02          	dec	L7_beep_on_cnt
 160  003d 202e          	jra	L75
 161  003f               L55:
 162                     ; 80         flag_beep = 0;
 164  003f 72110000      	bres	_flag_beep
 165                     ; 84         if (beep_number > 0)
 167  0043 3d00          	tnz	L31_beep_number
 168  0045 2722          	jreq	L16
 169                     ; 86             if (beep_off_cnt > 0)
 171  0047 3d01          	tnz	L11_beep_off_cnt
 172  0049 2704          	jreq	L36
 173                     ; 88                 beep_off_cnt--;
 175  004b 3a01          	dec	L11_beep_off_cnt
 177  004d 201e          	jra	L75
 178  004f               L36:
 179                     ; 92                 beep_number--;      //beep all the time if safty off
 181  004f 3a00          	dec	L31_beep_number
 182                     ; 93                 beep_on_cnt = beep_setting[beepmode][0];    //reload on time
 184  0051 b603          	ld	a,L5_beepmode
 185  0053 97            	ld	xl,a
 186  0054 a603          	ld	a,#3
 187  0056 42            	mul	x,a
 188  0057 d60000        	ld	a,(L3_beep_setting,x)
 189  005a b702          	ld	L7_beep_on_cnt,a
 190                     ; 94                 beep_off_cnt = beep_setting[beepmode][1];
 192  005c b603          	ld	a,L5_beepmode
 193  005e 97            	ld	xl,a
 194  005f a603          	ld	a,#3
 195  0061 42            	mul	x,a
 196  0062 d60001        	ld	a,(L3_beep_setting+1,x)
 197  0065 b701          	ld	L11_beep_off_cnt,a
 198  0067 2004          	jra	L75
 199  0069               L16:
 200                     ; 99             beep_on_cnt = 0;
 202  0069 3f02          	clr	L7_beep_on_cnt
 203                     ; 100             beep_off_cnt = 0;
 205  006b 3f01          	clr	L11_beep_off_cnt
 206  006d               L75:
 207                     ; 103 }
 210  006d 81            	ret
 292                     .bit:	section	.data,bit
 293  0000               _flag_beep:
 294  0000 00            	ds.b	1
 295                     	xdef	_flag_beep
 296  0001               L51_beep_request:
 297  0001 00            	ds.b	1
 298                     	switch	.ubsct
 299  0000               L31_beep_number:
 300  0000 00            	ds.b	1
 301  0001               L11_beep_off_cnt:
 302  0001 00            	ds.b	1
 303  0002               L7_beep_on_cnt:
 304  0002 00            	ds.b	1
 305  0003               L5_beepmode:
 306  0003 00            	ds.b	1
 307                     	xdef	_buzzcon
 308                     	xdef	_beep
 328                     	end
