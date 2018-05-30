## This file is a general .xdc for the ALINX AX7010 board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used signals according to the project
set_property PACKAGE_PIN W19 [get_ports {lcd_int[0]}]
set_property PACKAGE_PIN R14 [get_ports {lcd_i2c_scl_io}]
set_property PACKAGE_PIN P14 [get_ports {lcd_i2c_sda_io}]

set_property PACKAGE_PIN W18 [get_ports {lcd_bl_pwm[0]}]
set_property PACKAGE_PIN Y17 [get_ports lcd_hsync]
set_property PACKAGE_PIN Y16 [get_ports lcd_vsync]
set_property PACKAGE_PIN W15 [get_ports  {lcd_dclk[0]}]
set_property PACKAGE_PIN V15 [get_ports lcd_de]
set_property PACKAGE_PIN Y14 [get_ports {lcd_data[6]}]
set_property PACKAGE_PIN W14 [get_ports {lcd_data[7]}]
set_property PACKAGE_PIN P18 [get_ports {lcd_data[4]}]
set_property PACKAGE_PIN N17 [get_ports {lcd_data[5]}]
set_property PACKAGE_PIN U15 [get_ports {lcd_data[2]}]
set_property PACKAGE_PIN U14 [get_ports {lcd_data[3]}]
set_property PACKAGE_PIN P16 [get_ports {lcd_data[0]}]
set_property PACKAGE_PIN P15 [get_ports {lcd_data[1]}]

set_property PACKAGE_PIN U17 [get_ports {lcd_data[14]}]
set_property PACKAGE_PIN T16 [get_ports {lcd_data[15]}]
set_property PACKAGE_PIN V18 [get_ports {lcd_data[12]}]
set_property PACKAGE_PIN V17 [get_ports {lcd_data[13]}]
set_property PACKAGE_PIN T15 [get_ports {lcd_data[10]}]
set_property PACKAGE_PIN T14 [get_ports {lcd_data[11]}]
set_property PACKAGE_PIN V13 [get_ports {lcd_data[8]}]
set_property PACKAGE_PIN U13 [get_ports {lcd_data[9]}]

set_property PACKAGE_PIN W13 [get_ports {lcd_data[22]}]
set_property PACKAGE_PIN V12 [get_ports {lcd_data[23]}]
set_property PACKAGE_PIN U12 [get_ports {lcd_data[20]}]
set_property PACKAGE_PIN T12 [get_ports {lcd_data[21]}]
set_property PACKAGE_PIN T10 [get_ports {lcd_data[18]}]
set_property PACKAGE_PIN T11 [get_ports {lcd_data[19]}]
set_property PACKAGE_PIN A20 [get_ports {lcd_data[16]}]
set_property PACKAGE_PIN B19 [get_ports {lcd_data[17]}]

set_property IOSTANDARD LVCMOS33 [get_ports {lcd_int[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_i2c_scl_io}]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_i2c_sda_io}]

set_property IOSTANDARD LVCMOS33 [get_ports {lcd_bl_pwm[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_hsync]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_vsync]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_dclk[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports lcd_de]
set_property IOSTANDARD LVCMOS33 [get_ports {lcd_data[*]}]






set_property PACKAGE_PIN T19 [get_ports iic_0_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_0_scl_io]


set_property PACKAGE_PIN U19 [get_ports iic_0_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_0_sda_io]





set_property PACKAGE_PIN N15 [get_ports btns_4bits_tri_i[0]]
set_property IOSTANDARD LVCMOS33 [get_ports btns_4bits_tri_i[0]]


set_property PACKAGE_PIN N16 [get_ports btns_4bits_tri_i[1]]
set_property IOSTANDARD LVCMOS33 [get_ports btns_4bits_tri_i[1]]


set_property PACKAGE_PIN T17 [get_ports btns_4bits_tri_i[2]]
set_property IOSTANDARD LVCMOS33 [get_ports btns_4bits_tri_i[2]]


set_property PACKAGE_PIN R17 [get_ports btns_4bits_tri_i[3]]
set_property IOSTANDARD LVCMOS33 [get_ports btns_4bits_tri_i[3]]



set_property PACKAGE_PIN M14 [get_ports leds_4bits_tri_o[0]]
set_property IOSTANDARD LVCMOS33 [get_ports leds_4bits_tri_o[0]]


set_property PACKAGE_PIN M15 [get_ports leds_4bits_tri_o[1]]
set_property IOSTANDARD LVCMOS33 [get_ports leds_4bits_tri_o[1]]


set_property PACKAGE_PIN K16 [get_ports leds_4bits_tri_o[2]]
set_property IOSTANDARD LVCMOS33 [get_ports leds_4bits_tri_o[2]]


set_property PACKAGE_PIN J16 [get_ports leds_4bits_tri_o[3]]
set_property IOSTANDARD LVCMOS33 [get_ports leds_4bits_tri_o[3]]