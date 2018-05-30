/*
*********************************************************************************************************
*                                             uC/USB-Host
*                                       The Embedded USB Stack
*
*                          (c) Copyright 2004-2011; Micrium, Inc.; Weston, FL
*
*               All rights reserved.  Protected by international copyright laws.
*
*               uC/USB is provided in source form to registered licensees ONLY.  It is
*               illegal to distribute this source code to any third party unless you receive
*               written permission by an authorized Micrium representative.  Knowledge of
*               the source code may NOT be used to develop a similar product.
*
*               Please help us continue to provide the Embedded community with the finest
*               software available.  Your honesty is greatly appreciated.
*
*               You can contact us at www.micrium.com.
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*
*                                       USB HOST CLASS OPERATIONS
*
* File           : usbh_class.h
* Version        : V3.41.03
* Programmer(s)  : JFD
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                               MODULE
*********************************************************************************************************
*/

#ifndef  USBH_CLASS_MODULE_PRESENT
#define  USBH_CLASS_MODULE_PRESENT


/*
*********************************************************************************************************
*                                            INCLUDE FILES
*********************************************************************************************************
*/

#include  "usbh_core.h"


/*
*********************************************************************************************************
*                                               EXTERNS
*********************************************************************************************************
*/

#ifdef   USBH_CLASS_MODULE
#define  USBH_CLASS_EXT
#else
#define  USBH_CLASS_EXT  extern
#endif


/*
*********************************************************************************************************
*                                               DEFINES
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*                                         CLASS DEVICE STATE
*********************************************************************************************************
*/

#define  USBH_CLASS_DEV_STATE_NONE                         0u
#define  USBH_CLASS_DEV_STATE_CONN                         1u
#define  USBH_CLASS_DEV_STATE_DISCONN                      2u
#define  USBH_CLASS_DEV_STATE_SUSPEND                      3u


/*
*********************************************************************************************************
*                                          CLASS DRIVER TYPE
*********************************************************************************************************
*/

#define  USBH_CLASS_DRV_TYPE_NONE                         0u
#define  USBH_CLASS_DRV_TYPE_IF_CLASS_DRV                 1u
#define  USBH_CLASS_DRV_TYPE_DEV_CLASS_DRV                2u


/*
*********************************************************************************************************
*                                               DATA TYPES
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*                                     CLASS DRIVER API DATA TYPE
*********************************************************************************************************
*/

struct  usbh_class_drv {
    CPU_INT08U    *NamePtr;                                     /* Name of the class driver.                            */

    void         (*GlobalInit) (USBH_ERR  *p_err);              /* Global initialization function.                      */

    void        *(*ProbeDev  ) (USBH_DEV  *p_dev,               /* Probe device descriptor.                             */
                                USBH_ERR  *p_err);

    void        *(*ProbeIF   ) (USBH_DEV  *p_dev,               /* Probe interface descriptor.                          */
                                USBH_IF   *p_if,
                                USBH_ERR  *p_err);

    void         (*Suspend   ) (void      *p_class_dev);        /* Called when bus suspends.                            */

    void         (*Resume    ) (void      *p_class_dev);        /* Called when bus resumes.                             */

    void         (*Disconn   ) (void      *p_class_dev);        /* Called when device is removed.                       */
};


/*
*********************************************************************************************************
*                                 CLASS DRIVER NOTIFICATION DATA TYPE
*********************************************************************************************************
*/

typedef  void  (*USBH_CLASS_NOTIFY_FNCT)(void        *p_class_dev,
                                         CPU_INT08U   is_conn,
                                         void        *p_ctx);


/*
*********************************************************************************************************
*                                 CLASS DRIVER REGISTRATION DATA TYPE
*********************************************************************************************************
*/

struct  usbh_class_drv_reg {
    USBH_CLASS_DRV          *ClassDrvPtr;                       /* Class driver structure                               */
    USBH_CLASS_NOTIFY_FNCT   NotifyFnctPtr;                     /* Called when device connection status changes         */
    void                    *NotifyArgPtr;                      /* Context of the notification funtion                  */
    CPU_INT08U               InUse;
};


/*
*********************************************************************************************************
*                                           GLOBAL VARIABLES
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*                                  REGISTERED USB CLASS DRIVERS LIST
*********************************************************************************************************
*/

USBH_CLASS_EXT  USBH_CLASS_DRV_REG  USBH_ClassDrvList[USBH_CFG_MAX_NBR_CLASS_DRVS];


/*
*********************************************************************************************************
*                                                MACROS
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                          FUNCTION PROTOTYPES
*********************************************************************************************************
*/

USBH_ERR  USBH_ClassDrvReg    (USBH_CLASS_DRV          *p_class_drv,
                               USBH_CLASS_NOTIFY_FNCT   class_notify_fnct,
                               void                    *p_class_notify_ctx);

USBH_ERR  USBH_ClassDrvUnreg  (USBH_CLASS_DRV          *p_class_drv);

void      USBH_ClassSuspend   (USBH_DEV                *p_dev);

void      USBH_ClassResume    (USBH_DEV                *p_dev);

USBH_ERR  USBH_ClassDrvConn   (USBH_DEV                *p_dev);

void      USBH_ClassDrvDisconn(USBH_DEV                *p_dev);


/*
*********************************************************************************************************
*                                          CONFIGURATION ERRORS
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                               MODULE END
*********************************************************************************************************
*/

#endif
