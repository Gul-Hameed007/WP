#include "HC89S105xx.h"
#include "xmodem.h"

unsigned char WriteFlash(unsigned char* DataAddress, unsigned char DataCount, unsigned char* Source);

char recv_buffer[134];// uart receive buffer

//发送n字节数据
void _outnbyte(char *c, int n)
{
	int pass = 0;
	while(pass<n)
	{
		//send data
		SBUF=*(c+pass);
		while(!(SCON&0x02)/*TI*/);    //等待一字节数据发送完成
		SCON&=~0x02;				//发送中断请求中断标志位清0
		pass++;
	}
}

//接收n字节数据
int _innbyte(char *ch, int n, unsigned short sec) // sec
{
	long ticks = sec * TICK_PER_SECOND;
	int pass = 0;
		
	while(pass<n && ticks>0)
	{
		ticks--;
		if(!(SCON&0x01)/*RI*/) continue;
		if((SCON&0x40)/*RXROV*/)
      {
         *(ch+pass) = SBUF;
         SCON &= ~0x41; //接收溢出标志位清0，接收中断请求中断标志位清0
         continue;
      }
		*(ch+pass) = SBUF;
      SCON &= ~0x01; //接收中断请求中断标志位清0
		pass++;
	}
	
	return pass;
}

//发送1字节数据
void _outbyte(char c)
{
   //send data
   SBUF = c;
   //wait for transmission complete
   while(!(SCON&0x02)/*TI*/);    //等待一字节数据发送完成
   SCON &=~ 0x02;				//发送中断请求中断标志位清0
}

//接收1字节数据
int _inbyte(char *ch,unsigned short sec) // sec
{
	long ticks = sec * TICK_PER_SECOND;
	
   //wait for Rx full
   while(!(SCON&0x01 /*RI*/) && ticks >0)
	{
		ticks--;
	}
	if(!(SCON&0x01 /*RI*/)) return 0;
	
   //check if overrun
   if(SCON&0x40 /*RXROV*/)
   {
      //receive data to clear error
      *ch = SBUF;
      SCON &= ~0x41; //接收溢出标志位清0，接收中断请求中断标志位清0
      //and return error
      return -1;
   }
   //receive data
   *ch = SBUF;
   SCON &= ~0x01; //接收中断请求中断标志位清0
   //and return no error
   return 1;
}

static void flushinput(void)
{
	char ch;
	while (_inbyte(&ch,1) > 0);
}//flushinput

unsigned short crc16_ccitt( const char *buf, int len )
{
	unsigned short crc = 0;
   int i;
	while( len-- ) {
		crc ^= *buf++ << 8;
		for( i = 0; i < 8; ++i ) {
			if( crc & 0x8000 )
				crc = (crc << 1) ^ 0x1021;
			else
				crc = crc << 1;
		}
	}
	return crc;
}//crc16_ccitt

static int check(int crc, const char *buf, int sz)
{
	if (crc) {
      unsigned short crc = crc16_ccitt(buf, sz);
		unsigned short tcrc = (buf[sz]<<8)+(unsigned char)(buf[sz+1]);
		if (crc == tcrc)
			return 1;
	}
	else {
		int i;
		unsigned char cks = 0;
		for (i = 0; i < sz; ++i) {
			cks += buf[i];
		}
		if (cks == buf[sz])
		return 1;
	}

	return 0;
}//check

int xmodemReceive(char *dest, int destsz)
{
	char *xbuff;
	char *p;
	int bufsz, crc = 0;
	char trychar = 'C';
	unsigned char packetno = 1;
	char c;
	int ret = 0, len = 0;
	int retry, retrans = MAXRETRANS;

	xbuff = recv_buffer; //128B + 3 head chars + 2 crc + nul 
	if(!xbuff)return ret;

	for(;;) {
		for( retry = 0; retry < 16; ++retry) {
			if (trychar) _outbyte(trychar);
			if (_inbyte(&c,2) > 0) {
				switch (c) {
				case SOH:
					bufsz = 128;
					goto start_recv;
				case EOT:
					flushinput();
					_outbyte(ACK);
					ret =  len; // normal end 
					goto SafeExit;
				case CAN:
					if(_inbyte(&c,1)>0)
					{
						if (c == CAN) {
							flushinput();
							_outbyte(ACK);
							ret = -1;
							goto SafeExit; // canceled by remote 
						}
					}
					break;
				default:
					break;
				}
			}
		}
		
		if (trychar == 'C') { trychar = NAK; continue; }
		flushinput();
		_outbyte(CAN);
		_outbyte(CAN);
		_outbyte(CAN);
		ret = -2;
		goto SafeExit;		
		// sync error 
        
	start_recv:
		if (trychar == 'C') crc = 1;
		trychar = 0;
		p = xbuff;
		*p++ = c;
	
		if (_innbyte(p, bufsz+(crc?1:0)+3, 2) != bufsz+(crc?1:0)+3) goto reject;
		p += bufsz+(crc?1:0)+3;

		if (xbuff[1] == (unsigned char)(~xbuff[2]) && 
			(xbuff[1] == packetno || xbuff[1] == (unsigned char)packetno-1) &&
			check(crc, &xbuff[3], bufsz)) {
			if (xbuff[1] == packetno)	{
				int count = destsz - len;
				if (count > bufsz) count = bufsz;
				if (count > 0) {
					WriteFlash(dest+len, count,&xbuff[3]);
					len += count;
				}
				++packetno;
				retrans = MAXRETRANS+1;
			}

			if (--retrans <= 0) {
				flushinput();
				_outbyte(CAN);
				_outbyte(CAN);
				_outbyte(CAN);
				ret = -3;
				goto SafeExit;
				// too many retry error 
			}
			_outbyte(ACK);
			continue;
		}
		
	reject:
		flushinput();
		_outbyte(NAK);
		
	}

SafeExit:
	return ret;
	
}//xmodemreceive

