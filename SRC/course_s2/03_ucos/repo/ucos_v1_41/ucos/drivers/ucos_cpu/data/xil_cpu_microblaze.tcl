##############################################################################
#
# (c) Copyright 2004-2014 Xilinx, Inc. All rights reserved.
#
# This file contains confidential and proprietary information of Xilinx, Inc.
# and is protected under U.S. and international copyright and other
# intellectual property laws.
#
# DISCLAIMER
# This disclaimer is not a license and does not grant any rights to the
# materials distributed herewith. Except as otherwise provided in a valid
# license issued to you by Xilinx, and to the maximum extent permitted by
# applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL
# FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,
# IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
# MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE;
# and (2) Xilinx shall not be liable (whether in contract or tort, including
# negligence, or under any other theory of liability) for any loss or damage
# of any kind or nature related to, arising under or in connection with these
# materials, including for any direct, or any indirect, special, incidental,
# or consequential loss or damage (including loss of data, profits, goodwill,
# or any type of loss or damage suffered as a result of any action brought by
# a third party) even if such damage or loss was reasonably foreseeable or
# Xilinx had been advised of the possibility of the same.
#
# CRITICAL APPLICATIONS
# Xilinx products are not designed or intended to be fail-safe, or for use in
# any application requiring fail-safe performance, such as life-support or
# safety devices or systems, Class III medical devices, nuclear facilities,
# applications related to the deployment of airbags, or any other applications
# that could lead to death, personal injury, or severe property or
# environmental damage (individually and collectively, "Critical
# Applications"). Customer assumes the sole risk and liability of any use of
# Xilinx products in Critical Applications, subject only to applicable laws
# and regulations governing limitations on product liability.
#
# THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE
# AT ALL TIMES.
#
##############################################################################
## @BEGIN_CHANGELOG EDK_L
##    Updated the Tcl to add the bus frequency to xparameters.h
## @END_CHANGELOG
## @BEGIN_CHANGELOG EDK_LS3
##    Updated the Tcl to check for  Extended FPU for pulling in libm compiled 
##    with -mhard-float
## @END_CHANGELOG
## @BEGIN_CHANGELOG EDK_MS3
##    Updated the Tcl to pull appropriate libraries for Little Endian Microblaze
## @END_CHANGELOG
##
## MODIFICATION HISTORY:
##
## Ver   Who  Date   Changes
## ----- ---- -------- -------------------------------------------------------
## 1.04a  asa  07/16/12 Updated the tcl to return 100 MHz for CR 668726 for an 
##          IP integrator design when when cpu is directly connected 
##          to axi slave peripheral
## 2.0     adk 10/12/13 Updated as per the New Tcl API's
## 2.1     bss 04/14/14 Updated to copy libgloss.a and libgcc.a libraries
## 2.1     bss 04/29/14 Updated to copy libgloss.a if exists otherwise libxil.a
##           CR#794205

# uses xillib.tcl

namespace import ::hsm::utils::*

########################################
# Make file writable
########################################
proc make_writable {osname filename} {

    if {[string first "win64" $osname] != -1  || [string first "win" $osname] != -1 } {
        file attributes $filename -readonly no
    } else {
        file attributes $filename -permissions ugo+w 
    }
}

proc generate {drv_handle} {

    ucos_log_put "TRACE" "Generating ucos_dhcp-c."
    
    global env
    global tcl_platform
    
    set osname "[get_hostos_platform]/"
    
    #---------------------------------------------------------------------------
    # Start of mb-gcc specific processing..
    # 1. Copy libc, libm and libxil files..
    # 2. Generate the attribute interrupt_handler for the interrupting source...
    #---------------------------------------------------------------------------
    set compiler [get_property CONFIG.compiler $drv_handle]
    # preserve case
    set temp $compiler
    set compiler [string tolower $compiler]
    if { $compiler == "mb-gcc" || $compiler == "mb-g++" || $compiler == "mb-c++" } {
        # If the user has just specified the compiler without specifying a path,
        # we default to the compiler root being the EDK installation
        if {[string compare "mb-gcc" $compiler] == 0 ||
            [string compare "mb-g++" $compiler] == 0 ||
            [string compare "mb-c++" $compiler] == 0 } {

            set compiler_root ""
            set xilinx_edk_gnu [array get env XILINX_EDK_GNU]
            set gnu_osdir $osname
            if {[string first "win64" $osname] != -1  || [string first "win" $osname] != -1 } {
                set gnu_osdir "nt"
            } elseif {[string first "lnx64" $osname] != -1   || [string first "lnx" $osname] != -1 } {
                set gnu_osdir "lin"
            }
            if { $xilinx_edk_gnu == "" } {
                append compiler_root $env(XILINX_SDK) "/gnu/microblaze/" $gnu_osdir
            } {
                append compiler_root $env(XILINX_EDK_GNU) "/microblaze/" $gnu_osdir
            }
        } else {
            set compiler_root [file dirname $temp]

            ## Big time kludge here. We rely on the compiler toolchain name staying the same forever here.
            set compiler_root [string range $compiler_root 0 [expr [string length $compiler_root] - 4]]
        }
    puts $compiler_root
        # Copy the library files - libc.a, libm.a, libxil.a
        set shifter ""
        set multiplier ""
        set libxil_shifter ""
        set libxil_multiplier ""
        set pattern ""
        set fpu ""

        set libc "libc"
        set libm "libm"
        
        set sw_proc_handle [get_sw_processor]
        set periph [get_cells [get_property HW_INSTANCE $sw_proc_handle]]
        set proctype [get_property IP_NAME $periph]

        set endian [get_property CONFIG.C_ENDIANNESS $periph] 
        if {[string compare -nocase "1" $endian] == 0 } {
            set endian "_le"
                set libxil_endian "le"
            } else {
                set endian ""
                set libxil_endian ""
            }

        set shift [get_property CONFIG.C_USE_BARREL $periph] 
        if {[string compare -nocase "1" $shift] == 0 } {
            set shifter "_bs"
                set libxil_shifter "bs"
        }
        
        set hard_float [get_property CONFIG.C_USE_FPU $periph] 
        if {[string compare -nocase "1" $hard_float] == 0 || [string compare -nocase "2" $hard_float] == 0} {
            set fpu "_fpd"
        }

        set pcmp [get_property CONFIG.C_USE_PCMP_INSTR $periph]
        if {[string compare -nocase "1" $pcmp] == 0 } {
            set pattern "_p"
        }

        #-------------------------------------------------
        # Check if MULTIPLIER PARAMETER is set in MSS file
        # If so, then use it. Else find the C_FAMILY 
        # and set the multiplier accordingly
        #-------------------------------------------------
        set multiply [get_property CONFIG.C_USE_HW_MUL $periph]
        if {[string compare -nocase "" $multiply] == 0 } {  
            set family [string tolower [get_property CONFIG.C_FAMILY $periph] 
            if {[string first "virtex" $family] >= 0 } {        
            if {[string compare -nocase "virtexe" $family] == 0 } {
                set multiplier ""
                set libxil_multiplier ""

            } else {
                set multiplier "_m"
                set libxil_multiplier "m"
            }
        } elseif {[string compare -nocase "spartan3" $family] == 0 } {
            set multiplier "_m"
            set libxil_multiplier "m"
        }
    } elseif {[string compare -nocase "1" $multiply] == 0 } {
        set multiplier "_m"
            set libxil_multiplier "m"
    } 
    
    set libc [format "%s%s%s%s%s%s" $libc $endian $multiplier $shifter $pattern ".a"]
    set libm [format "%s%s%s%s%s%s%s" $libm $endian $multiplier $shifter $pattern $fpu ".a"]
    set libxil "libgloss.a"
    set libgcc "libgcc.a"
    set targetdir "../../lib/"
    
    #------------------------------------------------------
    # Copy libc, libm , libxil files...
        #
        # There are checks and flows to handle differences in
        # the GCC 3.4.1 toolchain (EDK 9.1i and prior) and
        # the GCC 4.1.1 toolchain (EDK 9.2i and later)
    #------------------------------------------------------
    set libcfilename [format "%s%s" $targetdir "libc.a"]
    set libmfilename [format "%s%s" $targetdir "libm.a"]
    
    set library_dir [file join $compiler_root "microblaze/lib"]
    
    if { ![file exists $library_dir] } {
        set library_dir [file join $compiler_root "microblaze-xilinx-elf/lib"]
         if { ![file exists $library_dir] } {
                error "Couldn't figure out compiler's library directory" "" "hsm_error"
        }
        set libgcc_dir [file join $compiler_root "lib/gcc/microblaze-xilinx-elf"]
        set libgcc_dir [glob -dir $libgcc_dir *]
        if { ![file exists $libgcc_dir] } {
            error "Couldn't figure out compiler's GCC library directory" "" "hsm_error"
        }
    }
   
   
   file copy -force [file join $library_dir $libc] $libcfilename
   make_writable $osname $libcfilename
    
   file copy -force [file join $library_dir $libm] $libmfilename    
   make_writable $osname $libmfilename
 
   set libxil_path [file join $library_dir $libxil_shifter $libxil_multiplier $libxil_endian $libxil]
   set symlink [file type $libxil_path] 
   if { ![file exists $libxil_path] || $symlink == "link"} {
    # no libgloss.a in older SDK use libxil.a
    set libxil "libxil.a"
    set libxil_path [file join $library_dir $libxil_shifter $libxil_multiplier $libxil_endian $libxil]
   }
   set libgcc_path [file join $libgcc_dir $libxil_shifter $libxil_multiplier $libxil_endian $libgcc]
   if { ![file exists $libxil_path] } {
        set libxil_path [file join $env(XILINX_SDK) "data/embeddedsw/lib/microblaze/" $libxil]
   }

    file copy -force $libxil_path $targetdir
    make_writable $osname [file join $targetdir $libxil]
    file copy -force $libgcc_path $targetdir
    make_writable $osname [file join $targetdir $libgcc]
    
    } else {
    error  "ERROR: Wrong compiler type selected please use mb-gcc or mb-g++ or mb-c++"
    return;
    }
    
  

    # End of mb-gcc specific processing...
    
    #------------------------------------
    # Handle xmdstub generation
    #------------------------------------
    set xmdstub_periph [get_property CONFIG.xmdstub_peripheral $drv_handle]
    if {[string compare -nocase "none" $xmdstub_periph] != 0 } {
        set xmdstub_periph_handle [xget_hwhandle $xmdstub_periph]
        set targetdir "../../code"
        set filename "xmdstub.s"
        file copy -force [file join $env(XILINX_SDK) "data/embeddedsw/lib/microblaze/src" $filename] $targetdir
            file mtime [file join $targetdir $filename] [clock seconds]
        set filename "make.xmdstub"
        file copy -force [file join $env(XILINX_SDK) "data/embeddedsw/lib/microblaze/src" $filename] $targetdir 
            file mtime [file join $targetdir $filename] [clock seconds]
        set xmd_addr_file [open "../../code/xmdstubaddr.s" w]
        set xmdstub_periph_baseaddr [format_addr_string [xget_value $xmdstub_periph_handle "PARAMETER" "C_BASEADDR"] "C_BASEADDR"]
        puts $xmd_addr_file ".equ DEBUG_PERIPHERAL_BASEADDRESS, $xmdstub_periph_baseaddr"
        close $xmd_addr_file
        # execute make  
        set pwd [pwd]
        if [catch {cd "../../code"} err] {
        error "Couldn't cd to code directory: $err" "" "hsm_error"
        return
        }
        if [catch {exec make -f make.xmdstub xmdstub} err] {
            error "Couldn't make xmdstub: $err" "" "hsm_error"
            return
        }
        cd $pwd
    }

    #--------------------------
    # Handle the Bus Frequency
    #--------------------------
    set file_handle [open_include_file "xparameters.h"]
    puts $file_handle "/* Definitions for bus frequencies */"
    set bus_array {"M_AXI_DP" "M_AXI_IP"}
    set bus_freq [get_clk_pin_freq $periph "Clk"]
    if {[llength $bus_freq] == 0} {
        set bus_freq "100000000"
    }

    foreach bus_inst $bus_array {
        set bhandle [get_intf_pins $bus_inst -of_objects $periph] 
        if { $bhandle == "" } {
          continue;
        }
       puts $file_handle "#define [get_driver_param_name "cpu" [format "%s_FREQ_HZ" $bus_inst]] $bus_freq"
    }

    puts $file_handle "/******************************************************************/"
    puts $file_handle ""
    puts $file_handle "/* Canonical definitions for bus frequencies */"
    set bus_id 0
    foreach bus $bus_array {
        set bhandle [get_intf_pins $bus_inst -of_objects $periph] 
        if { $bhandle == "" } {
          continue;
        }
        puts $file_handle "#define [get_driver_param_name "PROC_BUS" [format "%d_FREQ_HZ" $bus_id]] $bus_freq"
        incr bus_id
    }
    puts $file_handle "/******************************************************************/"
    puts $file_handle ""

    #--------------------------
    # define CORE_CLOCK_FREQ_HZ
    #--------------------------
    set clk_freq [xget_ip_clk_pin_freq $periph "Clk"]
    puts $file_handle "#define [get_driver_param_name "cpu" CORE_CLOCK_FREQ_HZ] $clk_freq"
    puts $file_handle "#define [format "XPAR_%s_CORE_CLOCK_FREQ_HZ" [string toupper $proctype]] $clk_freq"

    puts $file_handle "\n/******************************************************************/\n"
    close $file_handle

    #-------------------------- 
    # define all params
    #--------------------------     
    define_all_params $drv_handle "xparameters.h"

    #----------------------------------------
    # define all params without instance name
    #----------------------------------------
    define_processor_params $drv_handle "xparameters.h"
    xdefine_addr_params_for_ext_intf $drv_handle "xparameters.h"
}
proc xdefine_addr_params_for_ext_intf {drvhandle file_name} {
    set sw_proc_handle [get_sw_processor]
    set hw_proc_handle [get_cells [get_property HW_INSTANCE $sw_proc_handle ]]
    
 # Open include file
   set file_handle [open_include_file $file_name]

   set mem_ranges [get_mem_ranges -of_objects $hw_proc_handle] 
   foreach mem_range $mem_ranges {
       set inst [get_property INSTANCE $mem_range]
       if {$inst != ""} {
            continue
       }     
        
       set bparam_name [get_property BASE_NAME $mem_range]
       set bparam_value [get_property BASE_VALUE $mem_range]
       set hparam_name [get_property HIGH_NAME $mem_range]
       set hparam_value [get_property HIGH_VALUE $mem_range]

       # Print all parameters for all peripherals
           
           set name [string toupper [get_property NAME $mem_range]]
       puts $file_handle ""
           puts $file_handle "/* Definitions for interface [string toupper $name] */"
           set name [format "XPAR_%s_" $name]
           
           if {$bparam_value != ""} {
               set value [format_addr_string $bparam_value $bparam_name]
                   set param [string toupper $bparam_name]
                   if {[string match C_* $param]} {
                       set name [format "%s%s" $name [string range $param 2 end]]
                   } else {
                       set name [format "%s%s" $name $param]
                   }

               puts $file_handle "#define $name $value"
           }

       set name [string toupper [get_property NAME $mem_range]]
           set name [format "XPAR_%s_" $name]
           if {$hparam_value != ""} {
               set value [format_addr_string $hparam_value $hparam_name]
                set param [string toupper $hparam_name]
                   if {[string match C_* $param]} {
                       set name [format "%s%s" $name [string range $param 2 end]]
                   } else {
                       set name [format "%s%s" $name $param]
                   }

               puts $file_handle "#define $name $value"
           }

           
           puts $file_handle ""
      }     

    close $file_handle
}

# Returns the frequency of a bus
#proc xget_busfreq {bus_name} {
#       set bus_freq ""
#       set bus_handle [xget_hwhandle $bus_name]
#       if {$bus_handle == ""} {
#           puts "WARNING: Bus Clock frequency information is not available in the design, for $bus_name. Assuming a default frequency of 100MHz\n"
#           return 100000000
#       }
#
#       set bus_type [xget_hw_value $bus_handle]
#
#       if { $bus_type == "axi_interconnect" } {
#           set port_name "INTERCONNECT_ACLK"
#       }
#       set clkhandle [xget_hw_port_handle $bus_handle $port_name]
#       if { [string compare -nocase $clkhandle ""] != 0 } {
#           set bus_freq [xget_hw_subproperty_value $clkhandle "CLK_FREQ_HZ"]
#       }
#       return $bus_freq
#}

# Returns the frequency of a bus for IPI system
#proc xget_bus_freq_value {periph_handle bus_name} {
#       set bus_freq ""
#       set bus_handle [xget_hw_ipinst_handle $periph_handle $bus_name]
#   if {$bus_handle == ""} {
#       puts "WARNING: Bus Clock frequency information is not available in the design, for $bus_name. Assuming a default frequency of 100MHz\n"
#       return 100000000
#       }
#
#       set bus_type [xget_hw_value $bus_handle]
#
#       if { $bus_type == "plb_v34" || $bus_type == "plb_v46" } {
#           set port_name "PLB_Clk"
#       } elseif { $bus_type == "axi_interconnect" } {
#           set port_name "INTERCONNECT_ACLK"
#       } elseif { $bus_type == "axi_crossbar" } {
#           set port_name "ACLK"
#       } else {
#           set port_name "OPB_Clk"
#       }
#       set clkhandle [xget_hw_port_handle $bus_handle $port_name]
#       if { [string compare -nocase $clkhandle ""] != 0 } {
#           set bus_freq [xget_hw_subproperty_value $clkhandle "CLK_FREQ_HZ"]
#       }
#       return $bus_freq
#}

