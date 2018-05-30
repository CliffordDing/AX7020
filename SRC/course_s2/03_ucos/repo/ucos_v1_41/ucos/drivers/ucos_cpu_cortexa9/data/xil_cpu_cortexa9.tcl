###############################################################################
#
# Copyright (C) 2011 - 2014 Xilinx, Inc.  All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# Use of the Software is limited solely to applications:
# (a) running on a Xilinx device, or
# (b) that interact with a Xilinx device through a bus or interconnect.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# XILINX CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
# OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Except as contained in this notice, the name of the Xilinx shall not be used
# in advertising or otherwise to promote the sale, use or other dealings in
# this Software without prior written authorization from Xilinx.
#
###############################################################################
#
# Modification History
#
# Ver   Who  Date     Changes
# ----- ---- -------- -----------------------------------------------
# 1.00a sdm  05/16/10 Updated to support AXI version of the core
# 2.0   adk  10/12/13 Updated as per the New Tcl API's
# 2.1   pkp  06/27/14 Updated the tcl to create empty libxil for IAR support in BSP
#
##############################################################################
#uses "xillib.tcl"

############################################################
# "generate" procedure
############################################################

namespace import ::hsm::utils::*

proc generate {drv_handle} {
    ucos_log_put "TRACE" "Generating ucos_cpu_cortexa9."
    
    xdefine_cortexa9_params $drv_handle
    xdefine_include_file $drv_handle "xparameters.h" "XCPU_CORTEXA9" "C_CPU_CLK_FREQ_HZ"
    xdefine_canonical_xpars $drv_handle "xparameters.h" "CPU_CORTEXA9" "C_CPU_CLK_FREQ_HZ"
    xdefine_addr_params_for_ext_intf $drv_handle "xparameters.h"
}

proc xdefine_cortexa9_params {drvhandle} {

    set sw_proc_handle [hsi::get_sw_processor]
    set hw_proc_handle [hsi::get_cells [common::get_property HW_INSTANCE $sw_proc_handle ]]
    set procdrv [hsi::get_sw_processor]
    set archiver [common::get_property CONFIG.archiver $procdrv]
    if {[string first "iarchive" $archiver] < 0 } {
    } else {
         set libxil_a [file join .. .. lib libxil.a]
     if { ![file exists $libxil_a] } {
     # create empty libxil.a
        set fd [open "test.a" a+]
            close $fd
            exec $archiver --create --output $libxil_a test.a
            file delete -force test.a
        }   
    }
    set periphs [::hsi::utils::get_common_driver_ips $drvhandle]
    set lprocs [hsi::get_cells -filter "IP_NAME==ps7_cortexa9"]
    set lprocs [lsort $lprocs]

    set config_inc [::hsi::utils::open_include_file "xparameters.h"]
    puts $config_inc "/* Definition for CPU ID */"

    foreach periph $periphs {
        set iname [common::get_property NAME $periph]
    
    #-----------
    # Set CPU ID
    #-----------
    set id 0
    foreach processor $lprocs {
        if {[string compare -nocase $processor $iname] == 0} {
        puts $config_inc "#define XPAR_CPU_ID $id"
        }
        incr id
    }
    }
    
    close $config_inc
}

proc xdefine_addr_params_for_ext_intf {drvhandle file_name} {
    set sw_proc_handle [hsi::get_sw_processor]
    set hw_proc_handle [hsi::get_cells [common::get_property HW_INSTANCE $sw_proc_handle ]]
    
 # Open include file
   set file_handle [::hsi::utils::open_include_file $file_name]

   set mem_ranges [hsi::get_mem_ranges -of_objects $hw_proc_handle]
   foreach mem_range $mem_ranges {
       set inst [common::get_property INSTANCE $mem_range]
       if {$inst != ""} {
            continue
       } 
    
        
       set bparam_name [common::get_property BASE_NAME $mem_range]
       set bparam_value [common::get_property BASE_VALUE $mem_range]
       set hparam_name [common::get_property HIGH_NAME $mem_range]
       set hparam_value [common::get_property HIGH_VALUE $mem_range]

       # Print all parameters for all peripherals
           

           set name [string toupper [common::get_property NAME $mem_range]]
       puts $file_handle ""
           puts $file_handle "/* Definitions for interface [string toupper $name] */"
           set name [format "XPAR_%s_" $name]
           

           if {$bparam_value != ""} {
               set value [::hsi::utils::format_addr_string $bparam_value $bparam_name]
                   set param [string toupper $bparam_name]
                   if {[string match C_* $param]} {
                       set name [format "%s%s" $name [string range $param 2 end]]
                   } else {
                       set name [format "%s%s" $name $param]
                   }
               set xparam_name [::hsi::utils::format_xparam_name $name]
           puts $file_handle "#define $xparam_name $value"

           }

       set name [string toupper [common::get_property NAME $mem_range]]
           set name [format "XPAR_%s_" $name]
           if {$hparam_value != ""} {
               set value [::hsi::utils::format_addr_string $hparam_value $hparam_name]
                set param [string toupper $hparam_name]
                   if {[string match C_* $param]} {
                       set name [format "%s%s" $name [string range $param 2 end]]
                   } else {
                       set name [format "%s%s" $name $param]
                   }
               set xparam_name [::hsi::utils::format_xparam_name $name]
           puts $file_handle "#define $xparam_name $value"

           }

           
           puts $file_handle ""
      }     

    close $file_handle
}