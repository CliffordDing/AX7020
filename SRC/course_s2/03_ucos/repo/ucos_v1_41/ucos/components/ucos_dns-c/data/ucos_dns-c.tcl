#########################################################################################################
#                                           MICRIUM XSDK REPOSITORY
#                            (c) Copyright 2014-2015; Micrium, Inc.; Weston, FL
#
#               All rights reserved.  Protected by international copyright laws.
#########################################################################################################

source ../../../bsp/data/ucos_tcl_utils.tcl
source ../../../bsp/data/xil_tcl_utils.tcl

proc generate {ucos_handle} {
    ucos_log_put "TRACE" "Generating ucos_dns-c."
    
    set ucos_src_base [ucos_get_source_base]
    set dnsc_src_base [ucos_get_product_source_base dnsc]
    
    if {[llength $dnsc_src_base] == 0} {
        set dnsc_src_base $ucos_src_base
    }
    
    file copy -force "$dnsc_src_base/uC-DNSc/Cfg/Template/dns-c_cfg.h" "./src"
    file copy -force "$dnsc_src_base/uC-DNSc/Cfg/Template/dns-c_cfg.c" "./src"
    
    file copy -force "$dnsc_src_base/uC-DNSc" "./src/uC-DNSc"
     
    file mkdir "../../include/Source"
    
    
    set_define "./src/dns-c_cfg.h" "DNSc_CFG_ARG_CHK_EXT_EN" [expr ([get_property CONFIG.DNSc_CFG_ARG_CHK_EXT_EN $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    
    set_define "./src/dns-c_cfg.h" "DNSc_CFG_MODE_ASYNC_EN" [expr ([get_property CONFIG.DNSc_CFG_MODE_ASYNC_EN $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    set_define "./src/dns-c_cfg.h" "DNSc_CFG_MODE_BLOCK_EN" [expr ([get_property CONFIG.DNSc_CFG_MODE_BLOCK_EN $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
}
