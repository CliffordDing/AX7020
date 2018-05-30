#########################################################################################################
#                                           MICRIUM XSDK REPOSITORY
#                          (c) Copyright 2014-2015; Micrium, Inc.; Weston, FL
#
#               All rights reserved.  Protected by international copyright laws.
#########################################################################################################

source ../../../bsp/data/ucos_tcl_utils.tcl
source ../../../bsp/data/xil_tcl_utils.tcl

proc generate {ucos_handle} {
    ucos_log_put "TRACE" "Generating ucos_fs."
    
    set lib_osiii  [get_libs -filter "NAME==ucos_osiii"]
    set lib_osii   [get_libs -filter "NAME==ucos_osii"]
    
    set ucos_src_base [ucos_get_source_base]
    set fs_src_base [ucos_get_product_source_base fs]
    
    set source_avail 1
    if {[llength $fs_src_base] == 0} {
        set source_avail 0
        set fs_src_base $ucos_src_base
    }
    
    file copy -force "$fs_src_base/uC-FS" "./src/uC-FS"
    file copy -force "$fs_src_base/uC-FS/CFG/Template/fs_cfg.h" "./src"
    file copy -force "$fs_src_base/uC-FS/Dev/NAND/Cfg/Template/fs_dev_nand_cfg.h" "./src"
    
    file mkdir "src/os/os"

    if { [llength $lib_osiii] } {
        file copy -force "$fs_src_base/uC-FS/OS/uCOS-III/fs_os.h" "./src"
    }
    
    if { [llength $lib_osii] } {
        file copy -force "$fs_src_base/uC-FS/OS/uCOS-II/fs_os.h" "./src"
    }
     
    file mkdir "../../include/Source"
    file mkdir "../../include/FAT"
    file mkdir "../../include/Dev"
    file mkdir "../../include/Dev/RAMDisk"
    file mkdir "../../include/Dev/SD"
    file mkdir "../../include/Dev/SD/Card"
    file mkdir "../../include/Dev/NAND"
    file mkdir "../../include/Dev/NAND/Ctrlr"
    file mkdir "../../include/Dev/NAND/Ctrlr/GenExt"
    file mkdir "../../include/Dev/NAND/Part"
    file mkdir "../../include/Dev/NOR/"
    file mkdir "../../include/Dev/MSC/"
    file mkdir "../../include/OS/uCOS-III"
    file mkdir "../../include/OS/uCOS-II"
     
    set_define "./src/fs_cfg.h" "FS_CFG_API_EN"         [expr ([get_property CONFIG.FS_CFG_API_EN          $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"] 
    set_define "./src/fs_cfg.h" "FS_CFG_CACHE_EN"       [expr ([get_property CONFIG.FS_CFG_CACHE_EN        $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"] 
    set_define "./src/fs_cfg.h" "FS_CFG_DIR_EN"         [expr ([get_property CONFIG.FS_CFG_DIR_EN          $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"] 
    set_define "./src/fs_cfg.h" "FS_CFG_FILE_BUF_EN"    [expr ([get_property CONFIG.FS_CFG_FILE_BUF_EN     $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"] 
    set_define "./src/fs_cfg.h" "FS_CFG_FILE_LOCK_EN"   [expr ([get_property CONFIG.FS_CFG_FILE_LOCK_EN    $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"] 
    set_define "./src/fs_cfg.h" "FS_CFG_PARTITION_EN"   [expr ([get_property CONFIG.FS_CFG_PARTITION_EN    $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"] 
    set_define "./src/fs_cfg.h" "FS_CFG_WORKING_DIR_EN" [expr ([get_property CONFIG.FS_CFG_WORKING_DIR_EN  $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"] 
    set_define "./src/fs_cfg.h" "FS_CFG_UTF8_EN"        [expr ([get_property CONFIG.FS_CFG_UTF8_EN         $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"] 
    set_define "./src/fs_cfg.h" "FS_CFG_RD_ONLY_EN"     [expr ([get_property CONFIG.FS_CFG_RD_ONLY_EN      $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    
    set_define "./src/fs_cfg.h" "FS_CFG_MAX_DEV_NAME_LEN"     [format "%u" [get_property CONFIG.FS_CFG_MAX_DEV_NAME_LEN     $ucos_handle]] 
    set_define "./src/fs_cfg.h" "FS_CFG_MAX_DEV_DRV_NAME_LEN" [format "%u" [get_property CONFIG.FS_CFG_MAX_DEV_DRV_NAME_LEN $ucos_handle]] 
    set_define "./src/fs_cfg.h" "FS_CFG_MAX_FILE_NAME_LEN"    [format "%u" [get_property CONFIG.FS_CFG_MAX_FILE_NAME_LEN    $ucos_handle]] 
    set_define "./src/fs_cfg.h" "FS_CFG_MAX_PATH_NAME_LEN"    [format "%u" [get_property CONFIG.FS_CFG_MAX_PATH_NAME_LEN    $ucos_handle]] 
    set_define "./src/fs_cfg.h" "FS_CFG_MAX_VOL_NAME_LEN"     [format "%u" [get_property CONFIG.FS_CFG_MAX_VOL_NAME_LEN     $ucos_handle]] 
    
    set_define "./src/fs_cfg.h" "FS_CFG_DBG_MEM_CLR_EN"     [expr ([get_property CONFIG.FS_CFG_DBG_MEM_CLR_EN     $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    set_define "./src/fs_cfg.h" "FS_CFG_DBG_WR_VERIFY_EN"   [expr ([get_property CONFIG.FS_CFG_DBG_WR_VERIFY_EN   $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    set_define "./src/fs_cfg.h" "FS_CFG_ERR_ARG_CHK_EXT_EN" [expr ([get_property CONFIG.FS_CFG_ERR_ARG_CHK_EXT_EN $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    set_define "./src/fs_cfg.h" "FS_CFG_ERR_ARG_CHK_DBG_EN" [expr ([get_property CONFIG.FS_CFG_ERR_ARG_CHK_DBG_EN $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    
    set_define "./src/fs_cfg.h" "FS_CFG_CTR_STAT_EN" [expr ([get_property CONFIG.FS_CFG_CTR_STAT_EN $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    set_define "./src/fs_cfg.h" "FS_CFG_CTR_ERR_EN"  [expr ([get_property CONFIG.FS_CFG_CTR_ERR_EN  $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    
    set_define "./src/fs_cfg.h" "FS_FAT_CFG_LFN_EN"     [expr ([get_property CONFIG.FS_FAT_CFG_LFN_EN     $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    set_define "./src/fs_cfg.h" "FS_FAT_CFG_FAT12_EN"   [expr ([get_property CONFIG.FS_FAT_CFG_FAT12_EN   $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    set_define "./src/fs_cfg.h" "FS_FAT_CFG_FAT16_EN"   [expr ([get_property CONFIG.FS_FAT_CFG_FAT16_EN   $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    set_define "./src/fs_cfg.h" "FS_FAT_CFG_FAT32_EN"   [expr ([get_property CONFIG.FS_FAT_CFG_FAT32_EN   $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    set_define "./src/fs_cfg.h" "FS_FAT_CFG_JOURNAL_EN" [expr ([get_property CONFIG.FS_FAT_CFG_JOURNAL_EN $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    set_define "./src/fs_cfg.h" "FS_FAT_CFG_VOL_CHK_EN" [expr ([get_property CONFIG.FS_FAT_CFG_VOL_CHK_EN $ucos_handle] == true)?"DEF_ENABLED":"DEF_DISABLED"]
    set_define "./src/fs_cfg.h" "FS_FAT_CFG_VOL_CHK_MAX_LEVELS"     [format "%u" [get_property CONFIG.FS_FAT_CFG_VOL_CHK_MAX_LEVELS     $ucos_handle]]
    
    set_define "./src/fs_cfg.h" "FS_CFG_BUF_ALIGN_OCTETS" "32"

    set_define "./src/fs_cfg.h" "FS_TRACE" "UCOS_Printf"
    set_define "./src/fs_cfg.h" "FS_TRACE_LEVEL" [get_property CONFIG.FS_TRACE_LEVEL $ucos_handle]

    set config_file [open_include_file "xparameters.h"]
    
    set dev_cnt [get_property CONFIG.FS_CFG_MAX_DEV_CNT $ucos_handle]
    set vol_cnt [get_property CONFIG.FS_CFG_MAX_VOL_CNT $ucos_handle]
    set file_cnt [get_property CONFIG.FS_CFG_MAX_FILE_CNT $ucos_handle]
    set dir_cnt [get_property CONFIG.FS_CFG_MAX_DIR_CNT $ucos_handle]
    set buf_cnt [get_property CONFIG.FS_CFG_MAX_BUF_CNT $ucos_handle]
    set drv_cnt [get_property CONFIG.FS_CFG_MAX_DEV_DRV_CNT $ucos_handle]
    set sec_size [get_property CONFIG.FS_CFG_MAX_SEC_SIZE $ucos_handle]
    
    if {$buf_cnt == 0} {
        set buf_cnt [expr $vol_cnt * 3]
    }
    
    if {$drv_cnt == 0} {
        set drv_cnt 2
    }
    
    puts $config_file "#define FS_CFG_MAX_DEV_CNT $dev_cnt"
    puts $config_file "#define FS_CFG_MAX_VOL_CNT $vol_cnt"
    puts $config_file "#define FS_CFG_MAX_FILE_CNT $file_cnt"
    puts $config_file "#define FS_CFG_MAX_DIR_CNT $dir_cnt"
    puts $config_file "#define FS_CFG_MAX_BUF_CNT $buf_cnt"
    puts $config_file "#define FS_CFG_MAX_DEV_DRV_CNT $drv_cnt"
    puts $config_file "#define FS_CFG_MAX_SEC_SIZE $sec_size"
}
