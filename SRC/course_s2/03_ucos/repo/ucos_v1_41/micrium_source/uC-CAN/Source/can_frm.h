/*
****************************************************************************************************
*                                               uC/CAN
*                                       The Embedded CAN suite
*
*                          (c) Copyright 2003-2015; Micrium, Inc.; Weston, FL
*
*               All rights reserved.  Protected by international copyright laws.
*
*               uC/CAN is provided in source form to registered licensees ONLY.  It is 
*               illegal to distribute this source code to any third party unless you receive 
*               written permission by an authorized Micrium representative.  Knowledge of 
*               the source code may NOT be used to develop a similar product.
*
*               Please help us continue to provide the Embedded community with the finest 
*               software available.  Your honesty is greatly appreciated.
*
*               You can contact us at www.micrium.com.
****************************************************************************************************
*/

/*
****************************************************************************************************
* Filename      : can_frm.h
* Version       : V2.42.00
* Programmer(s) : E0
* Purpose       : This include file defines the symbolic constants and function prototypes for
*                 the CAN frame handling.
****************************************************************************************************
*/

#ifndef _CAN_FRM_H_
#define _CAN_FRM_H_

#ifdef __cplusplus
extern "C" {
#endif

/*
****************************************************************************************************
*                                             INCLUDES
****************************************************************************************************
*/
#include "cpu.h"                                      /* CPU configuration                        */


/*
****************************************************************************************************
*                                             DEFINES
****************************************************************************************************
*/

/*------------------------------------------------------------------------------------------------*/
/*!
* \brief                      CODING: BIT MASK
*
*           The position byte is encoded in the following way:
*           - Bit 0..5: BYte position of first byte in payload
*           - Bit 6..7: Encoding of bytes (0=big endian, 1=little endian)
*/
/*------------------------------------------------------------------------------------------------*/
#define CANFRM_CODING_MSK     0xC0u

/*------------------------------------------------------------------------------------------------*/
/*!
* \brief                      CODING: BIG ENDIAN
*
*           Encoding of bytes in big endian format.
*/
/*------------------------------------------------------------------------------------------------*/
#define CANFRM_BIG_ENDIAN     0x00u

/*------------------------------------------------------------------------------------------------*/
/*!
* \brief                      CODING: LITTLE ENDIAN
*
*           Encoding of bytes in little endian format.
*/
/*------------------------------------------------------------------------------------------------*/
#define CANFRM_LITTLE_ENDIAN  0x40u


/*
****************************************************************************************************
*                                            DATA TYPES
****************************************************************************************************
*/

/*------------------------------------------------------------------------------------------------*/
/*!
* \brief                      CAN FRAME
*
*           This structure contains all needed data to handle a single CAN frame
*/
/*------------------------------------------------------------------------------------------------*/
typedef struct {
    /*--------------------------------------------------------------------------------------------*/
    /*!
    * \brief                  CAN IDENTIFIER
    *
    *       This member holds the CAN identifier.
    *
    * \note To differentiate standard and extended identifiers the following addition to the
    *       identifier is implemented:
    *       - bit31: reserved (always 0)
    *       - bit30: marks a remote transmission request (1=rtr, 0=data frame)
    *       - bit29: marks an extended identifier (1=extended, 0=standard)
    *       - bit28-0: the identifier (standard or extended)
    */
    /*--------------------------------------------------------------------------------------------*/
    CPU_INT32U Identifier;
    /*--------------------------------------------------------------------------------------------*/
    /*!
    * \brief                  CAN PAYLOAD
    *
    *       This member holds up to 8 bytes, which can be handled with a single CAN message.
    */
    /*--------------------------------------------------------------------------------------------*/
    CPU_INT08U Data[8];
    /*--------------------------------------------------------------------------------------------*/
    /*!
    * \brief                  CAN DLC
    *
    *       This member holds the number of valid datas in the payload.
    */
    /*--------------------------------------------------------------------------------------------*/
    CPU_INT08U DLC;
    /*--------------------------------------------------------------------------------------------*/
    /*!
    * \brief                  SPARE
    *
    *       These bytes are added to get a frame size of an integral number of pointers.
    */
    /*--------------------------------------------------------------------------------------------*/
    CPU_INT08U Spare[3];

} CANFRM;


/*
****************************************************************************************************
*                                       FUNCTION PROTOTYPES
****************************************************************************************************
*/

void       CanFrmSet(CANFRM *frm, CPU_INT32U value, CPU_INT08U width, CPU_INT08U pos);
CPU_INT32U CanFrmGet(CANFRM *frm, CPU_INT08U width, CPU_INT08U pos);

#ifdef __cplusplus
}
#endif

#endif  /* #ifndef _CAN_FRM_H_ */

