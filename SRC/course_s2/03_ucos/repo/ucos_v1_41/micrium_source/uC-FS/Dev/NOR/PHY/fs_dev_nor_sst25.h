/*
*********************************************************************************************************
*                                             uC/FS V4
*                                     The Embedded File System
*
*                         (c) Copyright 2008-2014; Micrium, Inc.; Weston, FL
*
*                  All rights reserved.  Protected by international copyright laws.
*
*                  uC/FS is provided in source form to registered licensees ONLY.  It is
*                  illegal to distribute this source code to any third party unless you receive
*                  written permission by an authorized Micrium representative.  Knowledge of
*                  the source code may NOT be used to develop a similar product.
*
*                  Please help us continue to provide the Embedded community with the finest
*                  software available.  Your honesty is greatly appreciated.
*
*                  You can find our product's user manual, API reference, release notes and
*                  more information at: https://doc.micrium.com
*
*                  You can contact us at: http://www.micrium.com
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*
*                                      FILE SYSTEM DEVICE DRIVER
*
*                                          NOR FLASH DEVICES
*                             SST SST25 SERIAL NOR PHYSICAL-LAYER DRIVER
*
* Filename      : fs_dev_nor_sst25.h
* Version       : v4.07.00.00
* Programmer(s) : BAN
*********************************************************************************************************
* Note(s)       : (1) Supports Numonyx/ST's M29 parallel NOR flash memories, as described in various
*                     datasheets at Numonyx (http://www.numonyx.com).  This driver has been tested with
*                     or should work with the following devices :
*
*                         M29W320EB               M29W640GH  [+]
*                         M29W320ET [=]           M29W640GL  [+]
*                         M29W064FB               M29W128FH  [+]
*                         M29W064FT [=]           M29W128FL  [+]
*                         M29W640FB               M29W128GH  [+]
*                         M29W640FT [=] [*]       M29W128GL  [+]     [*]
*                                                 M29W640GB  [+]
*                                                 M29W640GT  [+] [=]
*
*                               [*} Devices tested
*                               [+] These devices will be accessed more efficiently with the generic AMD
*                                   1x16 driver.
*                               [=] These devices are top boot-block devices, which have several small
*                                   blocks at the top of the memory.  However, the CFI device geometry
*                                   lists the boot block region before the regular block region.  To
*                              reverse the block regions logically, define NOR_REVERSE_CFI in fs_cfg.h.
*
*                 (2) Fast programming command "double word program", supported by these flash devices,
*                     is used in this driver.  For other operations, the standard AMD command set is used.
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                               MODULE
*********************************************************************************************************
*/

#ifndef  FS_DEV_NOR_SST25_PRESENT
#define  FS_DEV_NOR_SST25_PRESENT


/*
*********************************************************************************************************
*                                               EXTERNS
*********************************************************************************************************
*/

#ifdef   FS_DEV_NOR_SST25_MODULE
#define  FS_DEV_NOR_SST25_EXT
#else
#define  FS_DEV_NOR_SST25_EXT  extern
#endif


/*
*********************************************************************************************************
*                                            INCLUDE FILES
*********************************************************************************************************
*/

#include  "../../../Source/fs_dev.h"
#include  "../fs_dev_nor.h"


/*
*********************************************************************************************************
*                                               DEFINES
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                             DATA TYPES
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                          GLOBAL VARIABLES
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                               MACRO'S
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                         FUNCTION PROTOTYPES
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                        CONFIGURATION ERRORS
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                             MODULE END
*********************************************************************************************************
*/

#endif                                                          /* End of NOR SST25 module include.                     */
