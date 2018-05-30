/*
*********************************************************************************************************
*                                             uC/TELNETs
*                                           Telnet (server)
*
*                         (c) Copyright 2004-2015; Micrium, Inc.; Weston, FL
*
*                  All rights reserved.  Protected by international copyright laws.
*
*                  uC/TELNETs is provided in source form to registered licensees ONLY.  It is
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
*                                   TELNET SERVER TEST SOURCE CODE
*
* Filename      : telnet-s_shell.h
* Version       : V1.05.01
* Programmer(s) : AA
*                 AL
*********************************************************************************************************
* Note(s)       : (1) Assumes the following versions (or more recent) of software modules are included in
*                     the project build :
*
*                     (a) uC/TCP-IP V3.00.00
*                     (b) uC/OS-II  V2.90.00 or
*                         uC/OS-III V3.03.01
*                     (c) uC/Shell  V1.03.01
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*********************************************************************************************************
*                                               MODULE
*********************************************************************************************************
*********************************************************************************************************
*/

#ifndef  TELNETs_SHELL_MODULE_PRESENT
#define  TELNETs_SHELL_MODULE_PRESENT


/*
*********************************************************************************************************
*********************************************************************************************************
*                                            INCLUDE FILES
*
* Note(s) : (1) The following common software files are located in the following directories :
*
*               (a) \<Custom Library Directory>\lib*.*
*
*               (b) (1) \<CPU-Compiler Directory>\cpu_def.h
*
*                   (2) \<CPU-Compiler Directory>\<cpu>\<compiler>\cpu*.*
*
*                   where
*                   <Custom Library Directory>      directory path for custom   library      software
*                   <CPU-Compiler Directory>        directory path for common   CPU-compiler software
*                   <cpu>                           directory name for specific processor (CPU)
*                   <compiler>                      directory name for specific compiler
*
*           (3) NO compiler-supplied standard library functions SHOULD be used.
*********************************************************************************************************
*********************************************************************************************************
*/

#include <cpu.h>
#include <Source/shell.h>
#include <Source/net.h>


/*
*********************************************************************************************************
*********************************************************************************************************
*                                         FUNCTION PROTOTYPES
*********************************************************************************************************
*********************************************************************************************************
*/

void       TELNETsShell_Init (CPU_CHAR              *user_name,
                              CPU_CHAR              *password);


/*
*********************************************************************************************************
*********************************************************************************************************
*                                             MODULE END
*********************************************************************************************************
*********************************************************************************************************
*/

#endif
