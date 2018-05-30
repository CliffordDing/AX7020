##############################################################################
#
# (c) Copyright 2005-2014 Xilinx, Inc. All rights reserved.
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
# MODIFICATION HISTORY:
# Ver      Who    Date     Changes
# -------- ------ -------- ------------------------------------
# 3.0      adk    12/10/13 Updated as per the New Tcl API's
##############################################################################

## @BEGIN_CHANGELOG 
##
##     09/17/07 ecm  Removed the PCI specific connections
##              Moved to the Linux MLD.
##     10/24/07 rpm  Fixed KIND_OF_INTR bug in canonicals and
##              also generalized match on external interrupts
##     06/25/09 sdm  Updated so that canonical definitions are
##              not generated when instance name matches
##              canonical name
##     04/27/10 sdm Updated the tcl so that the defintions are generated in
##      the xparameters.h to know whether the optional registers
##      SIE, CIE and IVR are enabled in the HW - Refer CR 555392
##     05/24/11 hvm updated tcl to generate vector ids for external interrupts
##      CR565336
##     06/15/11 hvm Updated tcl with bypassing the external interrupt definition
##      in xredefine_intc function. CR613925.
##     01/19/12 Updated the intc_define_use_dcr function so that it doesnot 
##              error out if there is more than one bus interface to the 
##              intc controller. The new version of the AXI_INTC can have two
##              bus interfaces to support the fast interrupt for MicroBlaze.
##              Updated for the generation of the C_HAS_FAST xparameters
##     08/16/12 bss added generation of C_IVAR_RESET_VALUE xparameters
##
##     01/29/13 bss Added check_cascade and get_intctype to support 
##          Cascade mode. Modified intc_define_vector_table procedure
##          to generate interrupt IDs as 32..63 and 64..95 and so on
##          for Slave controllers in Cascade mode
##     01/22/14 bss Modified check_cascade to fix CR#764865 
##     17/02/14 adk Fixed the CR:771287 in intc_define_vector_table
##          if number of interrupt ports not equal to total numer of 
##          interrupts returning immediatly.And in the xredefine_intc
##          if there is not interrupt source returining immediately.
##
##
##    
## @END_CHANGELOG

############################################################
# Global interrupt handlers array, default handler routine
############################################################
array set interrupt_handlers ""
set default_interrupt_handler "XNullHandler"
set cascade 0
set intrid 0

namespace import ::hsm::utils::*


############################################################
# DRC procedure
############################################################
proc intc_drc {drv_handle} {

}


############################################################
# "generate" procedure
############################################################
proc generate {drv_handle} {
    ucos_log_put "TRACE" "Generating ucos_axiintc."
    
        # Generate the following definitions in xparameters.h
        # 2. BASEADDR, HIGHADDR, C_NUM_INTR_INPUTS, XPAR_INTC_MAX_NUM_INTR_INPUTS
    
    set periphs [get_common_driver_ips $drv_handle]
    set count [llength $periphs]
    variable cascade
   
    if {$count > 1} {
        set cascade [check_cascade $drv_handle]
    }

    if {$cascade == 0} {
        define_max $drv_handle "xparameters.h" "XPAR_INTC_MAX_NUM_INTR_INPUTS" "C_NUM_INTR_INPUTS"
    } else {
        set maxintrs 0
        foreach periph $periphs {
            set intrs [get_property CONFIG.C_NUM_INTR_INPUTS $periph]
            set maxintrs [expr "$maxintrs + $intrs"]
        }
        set file_handle [open_include_file "xparameters.h"]
        puts $file_handle "#define XPAR_INTC_MAX_NUM_INTR_INPUTS $maxintrs"
        close $file_handle
    }
    
    define_if_all $drv_handle "xparameters.h" "UCOS_AXIINTC" "C_HAS_IPR" "C_HAS_SIE" "C_HAS_CIE" "C_HAS_IVR" 
    xdefine_include_file $drv_handle "xparameters.h" "UCOS_AXIINTC" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" "C_KIND_OF_INTR" "C_HAS_FAST" "C_IVAR_RESET_VALUE" "C_NUM_INTR_INPUTS"
    
        
    # Define XPAR_SINGLE_DEVICE_ID
        
        if {$count == 1} {
            xdefine_with_names $drv_handle [get_common_driver_ips $drv_handle] "xparameters.h" "XPAR_INTC_SINGLE_BASEADDR" "C_BASEADDR" "XPAR_INTC_SINGLE_HIGHADDR" "C_HIGHADDR" "XPAR_INTC_SINGLE_DEVICE_ID" "DEVICE_ID"
        }

        
        set config_inc [open_include_file "xparameters.h"]

        # Generate config table, vector tables
        intc_define_config_file $drv_handle $periphs $config_inc

        close $config_inc

        # Generate canonical xparameters
        xdefine_canonical_xpars $drv_handle "xparameters.h" "UCOS_AXIINTC" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" "C_KIND_OF_INTR" "C_HAS_FAST" "C_IVAR_RESET_VALUE" "C_NUM_INTR_INPUTS"
}


##########################################################################
# Generate Configuration C file xintc_g.c
# This file has the Config Table and vector tables for each intc instance
# as required by Xilinx intc driver
##########################################################################

proc intc_define_config_file {drv_handle periphs config_inc} {

    variable interrupt_handlers
    variable default_interrupt_handler
    variable cascade

    # set isr_options to be XIN_SVC_SGL_ISR_OPTION as defined in xintc.h
    set isr_options XIN_SVC_SGL_ISR_OPTION
    set file_name "ucos_axiintc_g.c"
    set drv_string "UCOS_AXIINTC"  
    set args [list "DEVICE_ID" "C_BASEADDR" "C_KIND_OF_INTR" "C_HAS_FAST" "C_IVAR_RESET_VALUE" "C_NUM_INTR_INPUTS"]
    set filename [file join "src" $file_name]
    file delete $filename
    set config_file [open $filename w]
    write_c_header $config_file "Driver configuration"
    puts $config_file "#include \"xparameters.h\""
    puts $config_file "#include \"[string tolower $drv_string].h\""
    puts $config_file "\n"

    set tmp_filename [file join "src" "tmpconfig.c"]
    set tmp_config_file [open $tmp_filename w]

    puts $tmp_config_file "\n/*"
    puts $tmp_config_file "* The configuration table for devices"
    puts $tmp_config_file "*/\n"
    puts $tmp_config_file [format "%s_Config %s_ConfigTable\[\] =" $drv_string $drv_string]
    puts $tmp_config_file "\{"

    set start_comma ""
    foreach periph $periphs {
        if {$cascade == 1} {
            puts $config_inc [format "#define XPAR_%s_%s %d" [string toupper [get_property NAME $periph ]] "TYPE" [get_intctype $periph]] 
        } else {
            puts $config_inc [format "#define XPAR_%s_%s %d" [string toupper [get_property NAME $periph ]] "TYPE" $cascade]
        }
        puts $tmp_config_file [format "%s\t\{" $start_comma]
            set comma ""
            foreach arg $args {
                # Check if this is a driver parameter or a peripheral parameter
                set value [get_property CONFIG.$arg $drv_handle ]
            if {[llength $value] == 0} {
                puts -nonewline $tmp_config_file [format "%s\t\t%s" $comma [get_ip_param_name $periph $arg]]
            } else {
                puts -nonewline $tmp_config_file [format "%s\t\t%s" $comma [get_driver_param_name $drv_string $arg]]
            }
            set comma ",\n"
        }
        # add the OPTIONS as an arg to the config table - default OPTIONS value is XIN_SVC_SGL_ISR_OPTION
            # puts -nonewline $tmp_config_file [format "%s\t\t%s" $comma $isr_options]
            puts -nonewline $tmp_config_file ",\n\t\t"
            puts -nonewline $tmp_config_file [format "XPAR_%s_%s" [string toupper [get_property NAME $periph]] "TYPE"]
        
            # generate the vector table for this intc instance
            # intc_define_vector_table $periph $config_inc $tmp_config_file

            puts $config_inc "\n/******************************************************************/\n"

            puts -nonewline $tmp_config_file "\n\t\}"
            set start_comma ",\n"
    }
        puts $tmp_config_file "\n\};"
        close $tmp_config_file

        # Write out the extern definitions of handlers...
        foreach elem [array names interrupt_handlers] {
            puts $config_file [format "extern void %s (void *);" $elem ]
        }

        # copy over the tmp_config_file contents to config_file
        set tmp_config_file [open $tmp_filename r]
        while {![eof $tmp_config_file]} {
            gets $tmp_config_file line
        puts $config_file $line
        }
        close $tmp_config_file
        file delete -force $tmp_filename

        close $config_file
    }

proc intc_define_vector_table {periph config_inc config_file} {

    variable interrupt_handlers
    variable default_interrupt_handler
    variable intrid
    variable cascade

    set periph_name [get_property NAME $periph]
    set interrupt_pin [get_pins -of_objects $periph intr]

    # Get pins/ports that are driving the interrupt
    lappend source_pins
    set source_pins [xget_source_pins $interrupt_pin]
    
    set num_intr_inputs [get_property CONFIG.C_NUM_INTR_INPUTS $periph]

    #calculate the total interrupt sources

    set total_intr_ports [xget_connected_pin_count $interrupt_pin]
   
    if {$num_intr_inputs != $total_intr_ports} {
        puts "ERROR: Internal error: Num intr inputs $num_intr_inputs not the same as length of get_interrupt_sources [llength $source_pins] hsm_error"
    return  
        
    }

    set i 0
    foreach source_pin $source_pins {
    
        set pin_class [get_property CLASS $source_pin]
        if { [string compare -nocase "$pin_class" port] == 0} {
            set is_external [is_external_pin $source_pin]
        } else {
            set is_external 1
        }


        if {$is_external} {
            #external interrupt port case
            set width [xget_port_width $source_pin]
            for { set j 0 } { $j < $width } { incr j } {
                set source_port_name($i) "[get_property NAME $source_pin]_$j"
                set source_name($i) "system"
                set port_type($i) "global"
                set source_driver ""
                set source_interrupt_handler($i) $default_interrupt_handler
                incr i
            }
        } else {
            #peripheral interrrupt case
            set source_periph [get_cells -of_objects $source_pin ]
            set port_type($i) "local"
            set source_name($i) [get_property NAME $source_periph]
            set source_port_name($i) [get_property NAME $source_pin]
            set source_driver [get_drivers -filter "HW_INSTANCE==$source_periph"]
            set source_interrupt_handler($i) $default_interrupt_handler
            incr i
        }
    }
    #Check if default_interrupt_handler has to have an extern definition
    if {[array size interrupt_handlers] < [llength $source_pins]} {
        intc_add_handler $default_interrupt_handler
    }

    puts -nonewline $config_file ",\n\t\t\{"
    set comma "\n"

    for {set i 0} {$i < $num_intr_inputs} {incr i} {
        puts $config_file [format "%s\t\t\t\{" $comma ]
        puts $config_file [format "\t\t\t\t%s," $source_interrupt_handler($i) ]
        if {[llength $source_name($i)] == 0} {
            puts $config_file "\t\t\t\t(void *)XNULL"
        } else {
            puts $config_inc [format "#define XPAR_%s_%s_MASK %#08X" [string toupper $source_name($i)] [string toupper $source_port_name($i)] [expr 1 << $i]]
            if {$cascade ==1} {
                puts $config_inc [format "#define XPAR_%s_%s_%s_INTR %d" [string toupper $periph_name] [string toupper $source_name($i)] [string toupper $source_port_name($i)] $intrid]
            } else {
                puts $config_inc [format "#define XPAR_%s_%s_%s_INTR %d" [string toupper $periph_name] [string toupper $source_name($i)] [string toupper $source_port_name($i)] $i]
            }
            if {[string compare -nocase "global" $port_type($i) ] != 0 && \
                [string compare $source_interrupt_handler($i) $default_interrupt_handler ] != 0} {
                puts $config_file [format "\t\t\t\t(void *) %s" $source_handler_arg($i)]
            } else {
                puts $config_file "\t\t\t\t(void *) XNULL"
            }
        }
        puts -nonewline $config_file "\t\t\t\}"
        set comma ",\n"
        incr intrid
    }
    puts $config_file "\n\t\t\}"
}

################################################
# This procedure creates a unique list of
# handlers that needs to have an extern defn.
# in xparameters.h
################################################
proc intc_add_handler {handler} {

    variable interrupt_handlers

    set interrupt_handlers($handler) 1
}


#
# Given a list of arguments, define each as a canonical constant name, using
# the driver name, in an include file.
#
proc xdefine_canonical_xpars {drv_handle file_name drv_string args} {
   
   variable cascade
   
   # Open include file
    set file_handle [open_include_file $file_name]

    # Get all the peripherals connected to this driver
    set periphs [get_common_driver_ips $drv_handle]

    # Get the names of all the peripherals connected to this driver
    foreach periph $periphs {
        set peripheral_name [string toupper [get_property NAME $periph]]
        lappend peripherals $peripheral_name
    }

    # Get possible canonical names for all the peripherals connected to this driver
    set device_id 0
    foreach periph $periphs {
        set canonical_name [string toupper [format "%s_%s" $drv_string $device_id]]
        lappend canonicals $canonical_name
        
        # Create a list of IDs of the peripherals whose hardware instance name
        # doesn't match the canonical name. These IDs can be used later to
        # generate canonical definitions
        if { [lsearch $peripherals $canonical_name] < 0 } {
              lappend indices $device_id
        }
        incr device_id
    }

    set i 0
    foreach periph $periphs {
        set periph_name [string toupper [get_property NAME $periph]]

        # Generate canonical definitions only for the peripherals whose
        # canonical name is not the same as hardware instance name
        if { [lsearch $canonicals $periph_name] < 0 } {
            puts $file_handle "/* Canonical definitions for peripheral $periph_name */"
            set canonical_name [format "%s_%s" $drv_string [lindex $indices $i]]

            foreach arg $args {
                set lvalue [get_driver_param_name $canonical_name $arg]

    # The commented out rvalue is the name of the instance-specific constant
    #           set rvalue [get_ip_param_name $periph $arg]

                # The rvalue set below is the actual value of the parameter
                set rvalue [get_param_value $periph $arg]
                if {[llength $rvalue] == 0} {
                     set rvalue 0
                }
                set rvalue [format_addr_string $rvalue $arg]
    
                puts $file_handle "#define $lvalue $rvalue"

            }
            if {$cascade == 1} {
                puts $file_handle "#define [get_driver_param_name $canonical_name "INTC_TYPE"] [get_intctype $periph]"
            } else {
                puts $file_handle "#define [get_driver_param_name $canonical_name "INTC_TYPE"] $cascade"
            }
            puts $file_handle ""
            incr i
        }
    }

    #
    # Now redefine the Interrupt ID constants
    #
    xredefine_intc $drv_handle $file_handle

    puts $file_handle "\n/******************************************************************/\n"
    close $file_handle
}

################################################
#
# intc redefines
#
################################################
proc xredefine_intc {drvhandle config_inc} {


    # Next define interrupt IDs for each connected peripheral

    set periphs [get_common_driver_ips $drvhandle]
    set device_id 0
    set periph_name [string toupper "intc"]

    foreach periph $periphs {

        # Get the edk based name of peripheral for printing redefines
        set periph_ip_name [get_property NAME $periph]

        # Get ports that are driving the interrupt
        set source_pins [get_interrupt_sources $periph]
    if {$source_pins == ""} {
        return
    }
        set i 0
        lappend source_list
        foreach source_pin $source_pins {
        
            set pin_class [get_property CLASS $source_pin]
            if { [string compare -nocase "$pin_class" port] == 0} {
                set is_external [is_external_pin $source_pin]
            } else {
                set is_external 1
            }
            
            set source_pin_name($i) [get_property NAME $source_pin]
            if {$is_external} {
                set source_name($i) "system"
            } else {
                set source_periph [get_cells -of_objects $source_pin]
                set source_name($i) [get_property NAME $source_periph]
            }

            lappend source_list $source_name($i)
            incr i
        }

        set num_intr_inputs [get_property CONFIG.C_NUM_INTR_INPUTS $periph]
        for {set i 0} {$i < $num_intr_inputs} {incr i} {

            if {[string compare -nocase $source_name($i) "system"] == 0} {
                continue
            }
            set drv [get_drivers -filter "HW_INSTANCE==$source_name($i)"]

            if {[llength $source_name($i)] != 0 && [llength $drv] != 0} {

                set instance [xfind_instance $drv $source_name($i)]
                set drvname [get_property NAME $drv]

                #
                # Handle reference cores, which have non-reference driver names
                #
                if {[string compare -nocase $drvname "touchscreen_ref"] == 0} {
                    set drvname "touchscreen"
                } elseif {[string compare -nocase $drvname "ps2_ref"] == 0} {
                    set drvname "ps2"
                    set instance [expr $instance*2]
                    if {[string match -nocase  "*SYS_INTR2" $source_pin_name($i)] == 1} {
                        incr instance
                    }
                }

                #
                # Define the interrupt vector IDs in xparameters.h for each core
                # that is connected to this intc.
                #
                set drvname [string toupper $drvname]

                #
                # Treat sources with multiple interrupt ports slightly different
                # by including the interrupt port name in the canonical constant
                # name
                #
                if { [lcount $source_list $source_name($i)] > 1} {
                    set port_name [string toupper $source_pin_name($i)]
                    
                    #
                    # If there are multiple interrupt ports for axi_ethernet, do not include
                    # the port name in the canonical name, for the port "INTERRUPT". Other ports
                    # will have the port name in the canonical name. This is to make sure that
                    # the canonical name for the port INTERRUPT will remain same irrespective of
                    # whether the design has a single interrupt port or multiple interrupt ports
                    #
                    if {[string compare -nocase $drvname "axiethernet"] == 0} {
                        if {[string compare -nocase $port_name "INTERRUPT"] == 0} {
                            set first_part [format "#define XPAR_%s_%s_%s_%s_VEC_ID" $periph_name $device_id $drvname $instance]
                        } else {
                            set first_part [format "#define XPAR_%s_%s_%s_%s_%s_VEC_ID" $periph_name $device_id $drvname $instance $port_name]
                        }
                    } else {
                        set first_part [format "#define XPAR_%s_%s_%s_%s_%s_VEC_ID" $periph_name $device_id $drvname $instance $port_name]
                    }
                } else {
                    set first_part [format "#define XPAR_%s_%s_%s_%s_VEC_ID" $periph_name $device_id $drvname $instance]
                }
            set second_part [format "XPAR_%s_%s_%s_INTR" [string toupper $periph_ip_name] [string toupper $source_name($i)] [string toupper $source_pin_name($i)] ]

                if {[string compare -nocase $drvname "generic"] != 0} {
                    puts $config_inc "$first_part $second_part"
                }
            }
        }
        incr device_id
    }
}

###################################################################
#
# Get the number of elements in the given list that match the
# given entry.  Assume elements are strings.
#
###################################################################
proc lcount {list match_entry} {

    set len [llength $list]
    set count 0

    for {set i 0} {$i < $len} {incr i} {
        set entry [lindex $list $i]
        if { [string compare -nocase $entry $match_entry] == 0} {
            incr count
        }
    }

    return $count
}


###################################################################
#
# Get the HW instance number for a particular device. This will be used to enumerate
# the vector ID defines if more than one interrupt from the core is connected to the
# interrupt controller.
#
###################################################################
proc xfind_instance {drvhandle instname} {

    set instlist [get_common_driver_ips $drvhandle]
    set i 0
    foreach inst $instlist {
        set name [get_property NAME $inst]
        if {[string compare -nocase $instname $name] == 0} {
            return $i
        }
        incr i
    }
    set i 0
    return $i
}

###################################################################################
#
# Checks whether system has Cascade interrupt controllers
#
###################################################################################
proc check_cascade {drv_handle} {
    set periphs [get_common_driver_ips $drv_handle]
    foreach periph $periphs {
        set i 0
        set source_pins [get_interrupt_sources $periph]
        foreach source_pin $source_pins {
            set source_pin_name($i) [get_property NAME $source_pin]
            if { [is_external_pin $source_pin] } {
                continue
            }
            set source_periph [get_cells -of_objects $source_pin ]
            set source_type [get_property IP_TYPE $source_periph]           
            if {[string compare -nocase $source_type "INTERRUPT_CNTLR"] == 0} {
                return 1
            }
        }
    }
    return 0
}

##################################################################
#
# Returns Interrupt controller type 
# 1 - primary instance
# 2 - secondary instance
# 3 - last instance
#
##################################################################

proc get_intctype {periph} {
        set iscascade [get_param_value $periph "C_EN_CASCADE_MODE"]
            set ismaster [get_param_value $periph "C_CASCADE_MASTER"]
            if {$iscascade == 1 && $ismaster == 1} {
                set retval 1
            } elseif {$iscascade == 1 && $ismaster == 0} {
                 set retval 2
        } elseif {$iscascade == 0 && $ismaster == 0} {
             set retval 3
            } else {
                error "ERROR: The C_CASCADE_MASTER is allowed to set only when the C_EN_CASCADE_MODE is set to 1"
            }
        
            return $retval
}

