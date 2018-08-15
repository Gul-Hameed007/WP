# ifndef XMODEM_H_
# define XMODEM_H_

#define SOH  0x01
#define STX  0x02
#define EOT  0x04
#define ACK  0x06
#define NAK  0x15
#define CAN  0x18
#define CTRLZ 0x1A

#define MAXRETRANS 25
#define TICK_PER_SECOND 320000

int _inbyte(char *ch,unsigned short sec);
void _outbyte(char c);
int _innbyte(char *ch, int n, unsigned short sec);
void _outnbyte(char *c, int n);
unsigned short crc16_ccitt( const char *buf, int len );
static int check(int crc, const char *buf, int sz);
static void flushinput(void);
int xmodemReceive(char *dest, unsigned int destsz);

#endif
