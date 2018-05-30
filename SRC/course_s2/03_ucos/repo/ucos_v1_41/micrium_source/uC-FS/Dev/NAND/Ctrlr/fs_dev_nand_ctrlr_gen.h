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
*                                         NAND FLASH DEVICES
*                                   GENERIC CONTROLLER-LAYER DRIVER
*
* Filename      : fs_dev_nand_ctrlr_gen.h
* Version       : v4.07.00.00
* Programmer(s) : EJ
*                 FBJ
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*                                               MODULE
*********************************************************************************************************
*/

#ifndef  FS_NAND_CTRLR_GEN_MODULE_PRESENT
#define  FS_NAND_CTRLR_GEN_MODULE_PRESENT


/*
*********************************************************************************************************
*                                            INCLUDE FILES
*********************************************************************************************************
*/

#include  <cpu.h>
#include  <Source/ecc.h>
#include  "../fs_dev_nand.h"


/*
*********************************************************************************************************
*                                               EXTERNS
*********************************************************************************************************
*/

#ifdef   FS_NAND_CTRLR_GEN_MODULE
#define  FS_NAND_CTRLR_GEN_MOD_EXT
#else
#define  FS_NAND_CTRLR_GEN_MOD_EXT  extern
#endif


/*
*********************************************************************************************************
*                                        DEFAULT CONFIGURATION
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                               DEFINES
*********************************************************************************************************
*/

#define  FS_NAND_CTRLR_GEN_CTRS_TBL_SIZE  2u

/*
*********************************************************************************************************
*                                              DATA TYPES
*********************************************************************************************************
*/



/*
**********************************************************************************************************
*                            NAND FLASH DEVICE CONTROLLER GENERIC BSP API
**********************************************************************************************************
*/


typedef  struct {
    void  (*Open)           (FS_ERR       *p_err);              /* Open BSP.                                            */

    void  (*Close)          (void);                             /* Close BSP.                                           */

    void  (*ChipSelEn)      (void);                             /* Enable chip select.                                  */

    void  (*ChipSelDis)     (void);                             /* Disable chip select.                                 */

    void  (*CmdWr)          (CPU_INT08U   *p_cmd,               /* Write cmd cycle(s).                                  */
                             CPU_SIZE_T    cnt,
                             FS_ERR       *p_err);

    void  (*AddrWr)         (CPU_INT08U   *p_addr,              /* Write addr cycle(s).                                 */
                             CPU_SIZE_T    cnt,
                             FS_ERR       *p_err);

    void  (*DataWr)         (void         *p_src,               /* Write data cycle(s).                                 */
                             CPU_SIZE_T    cnt,
                             CPU_INT08U    width,
                             FS_ERR       *p_err);

    void  (*DataRd)         (void         *p_dest,              /* Read data.                                           */
                             CPU_SIZE_T    cnt,
                             CPU_INT08U    width,
                             FS_ERR       *p_err);

    void  (*WaitWhileBusy)  (void         *poll_fcnt_arg,       /* Wait until ready.                                    */
                             CPU_BOOLEAN (*poll_fcnt)(void  *arg),
                             CPU_INT32U    to_us,
                             FS_ERR       *p_err);
} FS_NAND_CTRLR_GEN_BSP_API;


/*
*********************************************************************************************************
*                                        SPARE SEGMENT INFO STRUCT
*********************************************************************************************************
*/

typedef  struct {
    FS_NAND_PG_SIZE  PgOffset;                                  /* Offset in pg of spare seg.                           */
    FS_NAND_PG_SIZE  Len;                                       /* Len in bytes of spare seg.                           */
} FS_NAND_CTRLR_GEN_SPARE_SEG_INFO;


/*
*********************************************************************************************************
*                          NAND GENERIC CONTROLLER STAT AND ERR CTRS STRUCT
*********************************************************************************************************
*/

#if ((FS_CFG_CTR_STAT_EN == DEF_ENABLED) || \
     (FS_CFG_CTR_ERR_EN  == DEF_ENABLED))
typedef  struct  fs_nand_ctrlr_gen_ctrs {
#if (FS_CFG_CTR_STAT_EN == DEF_ENABLED)                         /* -------------------- STAT CTRS --------------------- */
    FS_CTR                             StatRdCtr;               /* Nbr of sec rd.                                       */
    FS_CTR                             StatWrCtr;               /* Nbr of sec wr.                                       */
    FS_CTR                             StatEraseCtr;            /* Nbr of blk erase.                                    */
    FS_CTR                             StatSpareRdRawCtr;       /* Nbr of raw spare rd.                                 */
    FS_CTR                             StatOOSRdRawCtr;         /* Nbr of raw OOS rd.                                   */
#endif

#if (FS_CFG_CTR_ERR_EN == DEF_ENABLED)                          /* --------------------- ERR CTRS --------------------- */
    FS_CTR                             ErrCorrECC_Ctr;          /* Nbr of correctable ECC rd errs.                      */
    FS_CTR                             ErrCriticalCorrECC_Ctr;  /* Nbr of critical correctable ECC rd errs.             */
    FS_CTR                             ErrUncorrECC_Ctr;        /* Nbr of uncorrectable ECC rd errs.                    */
    FS_CTR                             ErrWrCtr;                /* Nbr of wr failures.                                  */
    FS_CTR                             ErrEraseCtr;             /* Nbr of erase failures.                               */
#endif
} FS_NAND_CTRLR_GEN_CTRS;
#endif


/*
*********************************************************************************************************
*                                         NAND CTRLR DATA STRUCT
*********************************************************************************************************
*/

typedef  struct  fs_nand_ctrlr_gen_ext   FS_NAND_CTRLR_GEN_EXT;
typedef  struct  fs_nand_ctrlr_gen_data  FS_NAND_CTRLR_GEN_DATA;

struct fs_nand_ctrlr_gen_data {
    FS_NAND_PART_API                  *PartPtr;                 /* Ptr to part layer interface.                         */
    FS_NAND_PART_DATA                 *PartDataPtr;             /* Ptr to part layer data.                              */

    FS_NAND_CTRLR_GEN_BSP_API         *BSP_Ptr;                 /* Ptr to ctrlr BSP.                                    */

    CPU_INT08U                         AddrSize;                /* Size in B of addr.                                   */
    CPU_INT08U                         ColAddrSize;             /* Size in B of col addr.                               */
    CPU_INT08U                         RowAddrSize;             /* Size in B of row addr.                               */

    FS_NAND_PG_SIZE                    SecSize;                 /* Size in octets of sec.                               */
    FS_NAND_PG_SIZE                    SpareTotalAvailSize;     /* Nbr of avail spare bytes.                            */

    FS_NAND_PG_SIZE                    OOS_SizePerSec;          /* Size in octets of OOS area per sec.                  */

    FS_NAND_CTRLR_GEN_SPARE_SEG_INFO  *OOS_InfoTbl;             /* OOS segments info tbl.                               */

    void                              *SpareBufPtr;             /* Ptr to OOS buf.                                      */

    void                              *CtrlrExtData;            /* Pointer to ctrlr ext data.                           */
    const  FS_NAND_CTRLR_GEN_EXT      *CtrlrExtPtr;             /* Pointer to ctrlr ext.                                */

#if ((FS_CFG_CTR_STAT_EN == DEF_ENABLED) || \
     (FS_CFG_CTR_ERR_EN == DEF_ENABLED))
    FS_NAND_CTRLR_GEN_CTRS             Ctrs;
#endif

    FS_NAND_CTRLR_GEN_DATA            *NextPtr;
};


/*
*********************************************************************************************************
*                        NAND FLASH DEVICE GENERIC CONTROLLER EXT MOD DATA TYPE
*********************************************************************************************************
*/

struct fs_nand_ctrlr_gen_ext {
    void              (*Init)        (FS_ERR                  *p_err);

    void             *(*Open)        (FS_NAND_CTRLR_GEN_DATA  *p_ctrlr_data,
                                      void                    *p_ext_cfg,
                                      FS_ERR                  *p_err);

    void              (*Close)       (void                    *p_ext_data);

    FS_NAND_PG_SIZE   (*Setup)       (FS_NAND_CTRLR_GEN_DATA  *p_ctrlr_data,
                                      void                    *p_ext_data,
                                      FS_ERR                  *p_err);

    void              (*RdStatusChk) (void                    *p_ext_data,
                                      FS_ERR                  *p_err);

    void              (*ECC_Calc)    (void                    *p_ext_data,
                                      void                    *p_sec_buf,
                                      void                    *p_oos_buf,
                                      FS_NAND_PG_SIZE          oos_size,
                                      FS_ERR                  *p_err);

    void              (*ECC_Verify)  (void                    *p_ext_data,
                                      void                    *p_sec_buf,
                                      void                    *p_oos_buf,
                                      FS_NAND_PG_SIZE          oos_size,
                                      FS_ERR                  *p_err);
};


/*
**********************************************************************************************************
*                      NAND FLASH DEVICE GENERIC CONTROLLER CONFIGURATION DATA TYPE
**********************************************************************************************************
*/

#define  FS_NAND_CTRLR_GEN_CFG_FIELDS                                          \
    FS_NAND_CTRLR_GEN_CFG_FIELD(FS_NAND_CTRLR_GEN_EXT, *CtrlrExt   , DEF_NULL) \
    FS_NAND_CTRLR_GEN_CFG_FIELD(void                 , *CtrlrExtCfg, DEF_NULL)


#define FS_NAND_CTRLR_GEN_CFG_FIELD(type, name, dftl_val) type name;
typedef  struct  fs_nand_ctrlr_gen_cfg {
    FS_NAND_CTRLR_GEN_CFG_FIELDS
} FS_NAND_CTRLR_GEN_CFG;
#undef  FS_NAND_CTRLR_GEN_CFG_FIELD

extern  const  FS_NAND_CTRLR_GEN_CFG  FS_NAND_CtrlrGen_DfltCfg;


/*
*********************************************************************************************************
*                                          GLOBAL VARIABLES
*********************************************************************************************************
*/

extern  const              FS_NAND_CTRLR_API        FS_NAND_CtrlrGen;
FS_NAND_CTRLR_GEN_MOD_EXT  FS_CTR                   FS_NAND_CtrlrGen_UnitCtr;
#if ((FS_CFG_CTR_STAT_EN == DEF_ENABLED) || \
     (FS_CFG_CTR_ERR_EN  == DEF_ENABLED))
FS_NAND_CTRLR_GEN_MOD_EXT  FS_NAND_CTRLR_GEN_CTRS  *FS_NAND_CtrlrGen_CtrsTbl[FS_NAND_CTRLR_GEN_CTRS_TBL_SIZE];
#endif


/*
*********************************************************************************************************
*                                               MACROS
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                         FUNCTION PROTOTYPES
*********************************************************************************************************
*/

CPU_BOOLEAN  FS_NAND_CtrlrGen_PollFnct(void  *p_ctrlr_data);


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

#endif  /* FS_NAND_CTRLR_GEN_MODULE_PRESENT */

