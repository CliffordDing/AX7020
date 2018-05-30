## This file is a general .xdc for the ALINX AX7010 board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used signals according to the project

set_property IOSTANDARD TMDS_33 [get_ports TMDS_clk_n]


set_property PACKAGE_PIN N18 [get_ports TMDS_clk_p]
set_property IOSTANDARD TMDS_33 [get_ports TMDS_clk_p]


set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_n[0]}]


set_property PACKAGE_PIN V20 [get_ports {TMDS_data_p[0]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_p[0]}]

set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_n[1]}]


set_property PACKAGE_PIN T20 [get_ports {TMDS_data_p[1]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_p[1]}]


set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_n[2]}]


set_property PACKAGE_PIN N20 [get_ports {TMDS_data_p[2]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_p[2]}]



set_property PACKAGE_PIN Y19 [get_ports {hdmi_hpd_tri_i[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {hdmi_hpd_tri_i[0]}]


set_property PACKAGE_PIN V16 [get_ports {HDMI_OEN[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {HDMI_OEN[0]}]

set_property PACKAGE_PIN T19 [get_ports iic_0_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_0_scl_io]


set_property PACKAGE_PIN W16 [get_ports iic_0_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_0_sda_io]


set_property PACKAGE_PIN R18 [get_ports hdmi_ddc_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_ddc_scl_io]


set_property PACKAGE_PIN R16 [get_ports hdmi_ddc_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_ddc_sda_io]


set_property PACKAGE_PIN N15 [get_ports {btns_4bits_tri_i[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btns_4bits_tri_i[0]}]


set_property PACKAGE_PIN N16 [get_ports {btns_4bits_tri_i[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btns_4bits_tri_i[1]}]


set_property PACKAGE_PIN T17 [get_ports {btns_4bits_tri_i[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btns_4bits_tri_i[2]}]


set_property PACKAGE_PIN R17 [get_ports {btns_4bits_tri_i[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {btns_4bits_tri_i[3]}]



set_property PACKAGE_PIN M14 [get_ports {leds_4bits_tri_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_4bits_tri_o[0]}]


set_property PACKAGE_PIN M15 [get_ports {leds_4bits_tri_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_4bits_tri_o[1]}]


set_property PACKAGE_PIN K16 [get_ports {leds_4bits_tri_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_4bits_tri_o[2]}]


set_property PACKAGE_PIN J16 [get_ports {leds_4bits_tri_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_4bits_tri_o[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports DS1302_RST]
set_property IOSTANDARD LVCMOS33 [get_ports DS1302_SCLK]
set_property IOSTANDARD LVCMOS33 [get_ports DS1302_SIO]
set_property PACKAGE_PIN L15 [get_ports DS1302_RST]
set_property PACKAGE_PIN R19 [get_ports DS1302_SCLK]
set_property PACKAGE_PIN L14 [get_ports DS1302_SIO]


set_property IOSTANDARD LVCMOS33 [get_ports {ad1_d[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports ad1_clk]
set_property IOSTANDARD LVCMOS33 [get_ports {ad1_d[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad1_d[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad1_d[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad1_d[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad1_d[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad1_d[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad1_d[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad1_d[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad1_d[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad1_d[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports ad1_otr]
set_property IOSTANDARD LVCMOS33 [get_ports {ad1_d[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad2_d[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports ad2_clk]
set_property IOSTANDARD LVCMOS33 [get_ports {ad2_d[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad2_d[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad2_d[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad2_d[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad2_d[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad2_d[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad2_d[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad2_d[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad2_d[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad2_d[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports ad2_otr]
set_property IOSTANDARD LVCMOS33 [get_ports {ad2_d[0]}]



set_property PACKAGE_PIN F17 [get_ports {ad1_d[11]}]
set_property PACKAGE_PIN F16 [get_ports ad1_clk]
set_property PACKAGE_PIN F20 [get_ports {ad1_d[9]}]
set_property PACKAGE_PIN F19 [get_ports {ad1_d[10]}]
set_property PACKAGE_PIN G20 [get_ports {ad1_d[7]}]
set_property PACKAGE_PIN G19 [get_ports {ad1_d[8]}]
set_property PACKAGE_PIN H18 [get_ports {ad1_d[5]}]
set_property PACKAGE_PIN J18 [get_ports {ad1_d[6]}]
set_property PACKAGE_PIN L20 [get_ports {ad1_d[3]}]
set_property PACKAGE_PIN L19 [get_ports {ad1_d[4]}]
set_property PACKAGE_PIN M20 [get_ports {ad1_d[1]}]
set_property PACKAGE_PIN M19 [get_ports {ad1_d[2]}]
set_property PACKAGE_PIN K18 [get_ports ad1_otr]
set_property PACKAGE_PIN K17 [get_ports {ad1_d[0]}]
set_property PACKAGE_PIN J19 [get_ports {ad2_d[11]}]
set_property PACKAGE_PIN K19 [get_ports ad2_clk]
set_property PACKAGE_PIN H20 [get_ports {ad2_d[9]}]
set_property PACKAGE_PIN J20 [get_ports {ad2_d[10]}]
set_property PACKAGE_PIN L17 [get_ports {ad2_d[7]}]
set_property PACKAGE_PIN L16 [get_ports {ad2_d[8]}]
set_property PACKAGE_PIN M18 [get_ports {ad2_d[5]}]
set_property PACKAGE_PIN M17 [get_ports {ad2_d[6]}]
set_property PACKAGE_PIN D20 [get_ports {ad2_d[3]}]
set_property PACKAGE_PIN D19 [get_ports {ad2_d[4]}]
set_property PACKAGE_PIN E19 [get_ports {ad2_d[1]}]
set_property PACKAGE_PIN E18 [get_ports {ad2_d[2]}]
set_property PACKAGE_PIN G18 [get_ports ad2_otr]
set_property PACKAGE_PIN G17 [get_ports {ad2_d[0]}]
set_false_path -from [get_clocks clk_fpga_1] -to [get_clocks clk_fpga_0]
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks clk_fpga_1]


set_false_path -from [get_clocks clk_fpga_2] -to [get_clocks clk_fpga_1]
