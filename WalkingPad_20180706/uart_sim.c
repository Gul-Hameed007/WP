//--------------------------------------------------------------------------------
// UART.C
//
// Generic software uart written in C, requiring a timer set to 3 times
// the baud rate, and two software read/write pins for the receive and
// transmit functions.
//
// * Received characters are buffered
// * putchar(), getchar(), kbhit() and flush_input_buffer() are available
// * There is a facility for background processing while waiting for input
//
// Colin Gittins, Software Engineer, Halliburton Energy Services
//
// The baud rate can be configured by changing the BAUD_RATE macro as
// follows:
//
// #define BAUD_RATE 19200.0
//
// The function init_uart() must be called before any comms can take place
//
// Interface routines required:
// 1. get_rx_pin_status()
//    Returns 0 or 1 dependent on whether the receive pin is high or low.
// 2. set_tx_pin_high()
//    Sets the transmit pin to the high state.
// 3. set_tx_pin_low()
//    Sets the transmit pin to the low state.
// 4. idle()
//    Background functions to execute while waiting for input.
// 5. timer_set( BAUD_RATE )
//    Sets the timer to 3 times the baud rate.
// 6. set_timer_interrupt( timer_isr )
//    Enables the timer interrupt.
//
// Functions provided:
// 1. void flush_input_buffer( void )
//    Clears the contents of the input buffer.
// 2. char kbhit( void )
//    Tests whether an input character has been received.
// 3. char getchar( void )
//    Reads a character from the input buffer, waiting if necessary.
// 4. void turn_rx_on( void )
//    Turns on the receive function.
// 5. void turn_rx_off( void )
//    Turns off the receive function.
// 6. void putchar( char )
//    Writes a character to the serial port.
#include "declare.h"
#include <processor.h>

#define BAUD_RATE 2400.0

@near static bool flag_rx_waiting_for_stop_bit;
@near static bool flag_rx_off;
@near static uchar rx_mask;
@near static bool flag_rx_ready;
@near static bool flag_tx_ready;
@near static uchar timer_rx_ctr;
@near static uchar timer_tx_ctr;
@near static uchar bits_left_in_rx;
@near static uchar bits_left_in_tx;
#define rx_num_of_bits  8
#define tx_num_of_bits  10
@near static uchar internal_rx_buffer;
@near static uint internal_tx_buffer;
@near static uchar user_tx_buffer;
ebool flag_txd_process;
euchar command_size;
extern void timer1_ini(void);
void init_uart_sim(void)
{
    flag_tx_ready = false;
    flag_rx_ready = false;
    flag_rx_waiting_for_stop_bit = false;
    flag_rx_off = false;
    //set_tx_pin_low();
    TXD = 0;
    //timer_set( BAUD_RATE );
    //set_timer_interrupt( timer_isr );  // Enable timer interrupt
    timer1_ini();
}

void _putchar(char ch)
{
    while (flag_tx_ready)
    {
        ;
    }
    user_tx_buffer = ch;
    // invoke_UART_transmit
    timer_tx_ctr = 3;
    bits_left_in_tx = tx_num_of_bits;
    internal_tx_buffer = (user_tx_buffer << 1) | 0x200;
    flag_tx_ready = true;
}

void turn_rx_on(void)
{
    flag_rx_off = false;
}

void turn_rx_off(void)
{
    flag_rx_off = true;
}

static void timer_isr(void)
{
    // char mask, start_bit, flag_in, stop_bit;
    uchar tempi, tempj;
    // Receiver Section
    if (flag_rx_off == false)
    {
        if (flag_rx_waiting_for_stop_bit)
        {
            if (--timer_rx_ctr <= 0)
            {
                // stop_bit = RXD; //get_rx_pin_status();
                // Test for Stop Bit
                if (RXD) //one byte received
                {
                    if (cnt_rec2 >= RXD_CNT)
                    {
                        cnt_rec2 = 0; //can only rec' 20 bytes for one order
                    }
                    pcrxd[cnt_rec2] = internal_rx_buffer; //UART1_DR;
                    if (cnt_rec2 == 0)
                    {
                        if (pcrxd[0] == 0xf7)
                        {
                            cnt_rec2++;
                        }
                        else
                        {
                            cnt_rec2 = 0;
                        }
                    }
                    else if (cnt_rec2 == 1)
                    {
                        if (pcrxd[1] == 0xf8)
                        {
                            cnt_rec2++;
                        }
                        else
                        {
                            cnt_rec2 = 0;
                        }
                    }
                    else if (cnt_rec2 == 4)
                    {
                        if (pcrxd[3] == 0x01 && pcrxd[4] == 0x02)
                        {
                            cnt_rec2++;
                        }
                        else
                        {
                            cnt_rec2 = 0;
                        }
                    }
                    else if (cnt_rec2 == pcrxd[2] + 3)
                    {
                        if (pcrxd[cnt_rec2] == 0xfd)
                        {
                            tempj = 0;
                            for (tempi = 2; tempi < cnt_rec2 - 1; tempi++)
                                tempj += pcrxd[tempi];
                            if (tempj == pcrxd[cnt_rec2 - 1])
                            {
                                pcorder = 1;
                                turn_rx_off();
                            }
                            else
                            {
                                cnt_rec2=0;
                                // beep(BEEP_SAFETY_OFF);
                            }
                        }
                        else
                        {
                            cnt_rec2 = 0;
                        }
                    }
                    else
                    {
                        if (cnt_rec2 < RXD_CNT)
                        {
                            cnt_rec2++;
                        }
                        else
                        {
                            cnt_rec2 = 0;
                        }
                    }
                }
                flag_rx_waiting_for_stop_bit = false;
                flag_rx_ready = false;
            }
        }
        else // rx_test_busy
        {
            if (flag_rx_ready == false) //start bit, low
            {
                // start_bit = RXD; //get_rx_pin_status();
                // Test for Start Bit
                if (RXD == 0)
                {
                    flag_rx_ready = true;
                    internal_rx_buffer = 0;
                    timer_rx_ctr = 4;
                    bits_left_in_rx = rx_num_of_bits;
                    rx_mask = 1;
                }
            }
            else // rx_busy
            {
                if (--timer_rx_ctr <= 0)
                {
                    // rcv
                    timer_rx_ctr = 3;
                    // flag_in = RXD; //get_rx_pin_status();
                    if (RXD)
                    {
                        internal_rx_buffer |= rx_mask;
                    }
                    rx_mask <<= 1;
                    if (--bits_left_in_rx <= 0)
                    {
                        flag_rx_waiting_for_stop_bit = true;
                    }
                }
            }
        }
    }
    // Transmitter Section
    if (flag_txd_process)
    {
        if (flag_tx_ready)
        {
            if (--timer_tx_ctr <= 0)
            {
                // TXD = internal_tx_buffer & 1;
                internal_tx_buffer >>= 1;
                TXD = carry();
                // if (mask)
                // {
                //     //set_tx_pin_high();
                //     TXD = 1;
                // }
                // else
                // {
                //     //set_tx_pin_low();
                //     TXD = 0;
                // }
                timer_tx_ctr = 3;
                if (--bits_left_in_tx <= 0) //go to next byte
                {
                    flag_tx_ready = false;
                    if (cnt_tra2 < TXD_CNT)
                    {
                        cnt_tra2++;
                    }
                    if (cnt_tra2 < command_size)
                    {
                        _putchar(pctxd[cnt_tra2]);
                    }
                    else
                    {
                        cnt_tra2 = 0;
                        flag_txd_process = 0; //txd end
                        turn_rx_on();
                    }
                }
            }
        }
    }
}

@far @interrupt void TIM1_OV_isr(void)
{
    TIM1_SR1 &= 0xFE;           //clear Flag
    //KO2=1;
    timer_isr();
    //KO2=0;
    return;
}