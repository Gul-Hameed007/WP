
/*********************************************************/
/*              USER BOOT CODE Customisation 	     			 */
/*********************************************************/

//user application start
#define MAIN_USER_RESET_ADDR 0x0000

/*********************************************************/
/*              USER BOOT CODE MEMORY PARAMETERS	       */
/*********************************************************/

/* Parameters of this section depend of the used Microcontroler */
/* see microcontroler's data sheet for more information 				*/

//mask for memory block boundary
#define  BLOCK_BYTES          128
#define  ADDRESS_BLOCK_MASK   127 	/*(BLOCK_BYTES - 1)*/
#define  BLOCK_SIZE           0x80  //每个扇区128字节
#define  BLOCK_PER_SECTOR     0x08  //每页1K=8x128字节有8个扇区

#define  FLASH_START          MAIN_USER_RESET_ADDR
#define  FLASH_END            0x6FFF
#define  FLASH_BLOCKS_NUMBER  0xE0 /*((FLASH_END  - FLASH_START  + 1)/BLOCK_SIZE)*/
#define  SECTORS_IN_FLASH     0x1C /*((FLASH_END  - FLASH_START  + 1)/BLOCK_SIZE/BLOCK_PER_SECTOR)*/ 


/* Exported types ------------------------------------------------------------*/

