/*  BASIC INTERRUPT VECTOR TABLE FOR STM8 devices
 *  Copyright (c) 2007 STMicroelectronics
 */

typedef void @far (*interrupt_handler_t)(void);
struct interrupt_vector
{
    unsigned char interrupt_instruction;
    interrupt_handler_t interrupt_handler;
};
@far @interrupt void NonHandledInterrupt (void)
{
    /* in order to detect unexpected events during development,
       it is recommended to set a breakpoint on the following instruction
    */
    return;
}
extern void _stext();     /* startup routine */
extern void main();
extern @far @interrupt void EXTI3_isr();
extern @far @interrupt void ADC1_isr();
extern @far @interrupt void TIM1_OV_isr();
extern @far @interrupt void TIM1_OC_isr();
extern @far @interrupt void TIM2_OV_isr();
extern @far @interrupt void TIM2_OC_isr();
extern @far @interrupt void TIM4_isr();
extern @far @interrupt void rxd_isr();
extern @far @interrupt void txd_isr();
extern @far @interrupt void rc_isr();				// interrupt function for remote control

struct interrupt_vector const _vectab[] =
{
    {0x82, (interrupt_handler_t)_stext}, /* reset */
    //{0x82, (interrupt_handler_t)main}, /* reset */
    {0x82, NonHandledInterrupt}, /* trap  */
    {0x82, NonHandledInterrupt}, /* irq0  */
    {0x82, NonHandledInterrupt}, /* irq1  */
    {0x82, NonHandledInterrupt}, /* irq2  */
    {0x82, NonHandledInterrupt}, /* irq3  */
    {0x82, NonHandledInterrupt}, /* irq4  */
    {0x82, NonHandledInterrupt}, /* irq5  */
    {0x82, NonHandledInterrupt}, /* irq6  */
    {0x82, rc_isr}, /* irq7  */ //Port E external interrupts
    {0x82, NonHandledInterrupt}, /* irq8  */
    {0x82, NonHandledInterrupt}, /* irq9  */
    {0x82, NonHandledInterrupt}, /* irq10 */
    {0x82, TIM1_OV_isr},//NonHandledInterrupt}, /* irq11 */
    {0x82, NonHandledInterrupt}, /* irq12 */
//    {0x82, NonHandledInterrupt}, /* irq13 */
    {0x82, TIM2_OV_isr}, /* irq13 */
    {0x82, NonHandledInterrupt}, /* irq14 */
    {0x82, NonHandledInterrupt}, /* irq15 */
    {0x82, NonHandledInterrupt}, /* irq16 */
    {0x82, NonHandledInterrupt}, /* irq17 */
    {0x82, NonHandledInterrupt}, /* irq18 */
    {0x82, NonHandledInterrupt}, /* irq19 */
    {0x82, txd_isr},                  /* irq20  for stm8s105*/
    {0x82, rxd_isr},                  /* irq21 */
    //{0x82, NonHandledInterrupt},                /* irq20  for stm8s105*/
    //{0x82, NonHandledInterrupt},                /* irq21 */
    {0x82, NonHandledInterrupt}, /* irq22 */
    {0x82, TIM4_isr},             /* irq23 */
    {0x82, NonHandledInterrupt}, /* irq24 */
    {0x82, NonHandledInterrupt}, /* irq25 */
    {0x82, NonHandledInterrupt}, /* irq26 */
    {0x82, NonHandledInterrupt}, /* irq27 */
    {0x82, NonHandledInterrupt}, /* irq28 */
    {0x82, NonHandledInterrupt}, /* irq29 */
};
