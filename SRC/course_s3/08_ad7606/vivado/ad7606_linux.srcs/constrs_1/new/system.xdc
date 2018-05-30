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

set_property PACKAGE_PIN F17 [get_ports {ad_os[1]}]
set_property PACKAGE_PIN F16 [get_ports {ad_os[0]}]
set_property PACKAGE_PIN F20 [get_ports ad_convstab]
set_property PACKAGE_PIN F19 [get_ports {ad_os[2]}]
set_property PACKAGE_PIN G20 [get_ports ad_rd]
set_property PACKAGE_PIN G19 [get_ports ad_reset]
set_property PACKAGE_PIN H18 [get_ports ad_busy]
set_property PACKAGE_PIN J18 [get_ports ad_cs]
set_property PACKAGE_PIN L19 [get_ports first_data]
set_property PACKAGE_PIN K18 [get_ports {ad_data[0]}]
set_property PACKAGE_PIN K17 [get_ports {ad_data[1]}]
set_property PACKAGE_PIN J19 [get_ports {ad_data[2]}]
set_property PACKAGE_PIN K19 [get_ports {ad_data[3]}]
set_property PACKAGE_PIN H20 [get_ports {ad_data[4]}]
set_property PACKAGE_PIN J20 [get_ports {ad_data[5]}]
set_property PACKAGE_PIN L17 [get_ports {ad_data[6]}]
set_property PACKAGE_PIN L16 [get_ports {ad_data[7]}]
set_property PACKAGE_PIN M18 [get_ports {ad_data[8]}]
set_property PACKAGE_PIN M17 [get_ports {ad_data[9]}]
set_property PACKAGE_PIN D20 [get_ports {ad_data[10]}]
set_property PACKAGE_PIN D19 [get_ports {ad_data[11]}]
set_property PACKAGE_PIN E19 [get_ports {ad_data[12]}]
set_property PACKAGE_PIN E18 [get_ports {ad_data[13]}]
set_property PACKAGE_PIN G18 [get_ports {ad_data[14]}]
set_property PACKAGE_PIN G17 [get_ports {ad_data[15]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ad_os[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_os[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports ad_convstab]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_os[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports ad_rd]
set_property IOSTANDARD LVCMOS33 [get_ports ad_reset]
set_property IOSTANDARD LVCMOS33 [get_ports ad_busy]
set_property IOSTANDARD LVCMOS33 [get_ports ad_cs]
set_property IOSTANDARD LVCMOS33 [get_ports first_data]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad_data[15]}]


create_debug_core u_ila_0_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0_0]
set_property port_width 1 [get_debug_ports u_ila_0_0/clk]
connect_debug_port u_ila_0_0/clk [get_nets [list system_i/processing_system7_0/inst/FCLK_CLK1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe0]
set_property port_width 3 [get_debug_ports u_ila_0_0/probe0]
connect_debug_port u_ila_0_0/probe0 [get_nets [list {system_i/axi_adc_0/inst/wr_state[0]} {system_i/axi_adc_0/inst/wr_state[1]} {system_i/axi_adc_0/inst/wr_state[2]}]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0_0/probe1]
connect_debug_port u_ila_0_0/probe1 [get_nets [list {system_i/axi_adc_0/inst/wr_addr_1[0]} {system_i/axi_adc_0/inst/wr_addr_1[1]} {system_i/axi_adc_0/inst/wr_addr_1[2]} {system_i/axi_adc_0/inst/wr_addr_1[3]} {system_i/axi_adc_0/inst/wr_addr_1[4]} {system_i/axi_adc_0/inst/wr_addr_1[5]} {system_i/axi_adc_0/inst/wr_addr_1[6]} {system_i/axi_adc_0/inst/wr_addr_1[7]} {system_i/axi_adc_0/inst/wr_addr_1[8]} {system_i/axi_adc_0/inst/wr_addr_1[9]} {system_i/axi_adc_0/inst/wr_addr_1[10]} {system_i/axi_adc_0/inst/wr_addr_1[11]} {system_i/axi_adc_0/inst/wr_addr_1[12]} {system_i/axi_adc_0/inst/wr_addr_1[13]} {system_i/axi_adc_0/inst/wr_addr_1[14]} {system_i/axi_adc_0/inst/wr_addr_1[15]} {system_i/axi_adc_0/inst/wr_addr_1[16]} {system_i/axi_adc_0/inst/wr_addr_1[17]} {system_i/axi_adc_0/inst/wr_addr_1[18]} {system_i/axi_adc_0/inst/wr_addr_1[19]} {system_i/axi_adc_0/inst/wr_addr_1[20]} {system_i/axi_adc_0/inst/wr_addr_1[21]} {system_i/axi_adc_0/inst/wr_addr_1[22]} {system_i/axi_adc_0/inst/wr_addr_1[23]} {system_i/axi_adc_0/inst/wr_addr_1[24]} {system_i/axi_adc_0/inst/wr_addr_1[25]} {system_i/axi_adc_0/inst/wr_addr_1[26]} {system_i/axi_adc_0/inst/wr_addr_1[27]} {system_i/axi_adc_0/inst/wr_addr_1[28]} {system_i/axi_adc_0/inst/wr_addr_1[29]} {system_i/axi_adc_0/inst/wr_addr_1[30]} {system_i/axi_adc_0/inst/wr_addr_1[31]}]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe2]
set_property port_width 32 [get_debug_ports u_ila_0_0/probe2]
connect_debug_port u_ila_0_0/probe2 [get_nets [list {system_i/axi_adc_0/inst/wr_addr_0[0]} {system_i/axi_adc_0/inst/wr_addr_0[1]} {system_i/axi_adc_0/inst/wr_addr_0[2]} {system_i/axi_adc_0/inst/wr_addr_0[3]} {system_i/axi_adc_0/inst/wr_addr_0[4]} {system_i/axi_adc_0/inst/wr_addr_0[5]} {system_i/axi_adc_0/inst/wr_addr_0[6]} {system_i/axi_adc_0/inst/wr_addr_0[7]} {system_i/axi_adc_0/inst/wr_addr_0[8]} {system_i/axi_adc_0/inst/wr_addr_0[9]} {system_i/axi_adc_0/inst/wr_addr_0[10]} {system_i/axi_adc_0/inst/wr_addr_0[11]} {system_i/axi_adc_0/inst/wr_addr_0[12]} {system_i/axi_adc_0/inst/wr_addr_0[13]} {system_i/axi_adc_0/inst/wr_addr_0[14]} {system_i/axi_adc_0/inst/wr_addr_0[15]} {system_i/axi_adc_0/inst/wr_addr_0[16]} {system_i/axi_adc_0/inst/wr_addr_0[17]} {system_i/axi_adc_0/inst/wr_addr_0[18]} {system_i/axi_adc_0/inst/wr_addr_0[19]} {system_i/axi_adc_0/inst/wr_addr_0[20]} {system_i/axi_adc_0/inst/wr_addr_0[21]} {system_i/axi_adc_0/inst/wr_addr_0[22]} {system_i/axi_adc_0/inst/wr_addr_0[23]} {system_i/axi_adc_0/inst/wr_addr_0[24]} {system_i/axi_adc_0/inst/wr_addr_0[25]} {system_i/axi_adc_0/inst/wr_addr_0[26]} {system_i/axi_adc_0/inst/wr_addr_0[27]} {system_i/axi_adc_0/inst/wr_addr_0[28]} {system_i/axi_adc_0/inst/wr_addr_0[29]} {system_i/axi_adc_0/inst/wr_addr_0[30]} {system_i/axi_adc_0/inst/wr_addr_0[31]}]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0_0/probe3]
connect_debug_port u_ila_0_0/probe3 [get_nets [list {system_i/axi_adc_0/inst/remain_data_len[0]} {system_i/axi_adc_0/inst/remain_data_len[1]} {system_i/axi_adc_0/inst/remain_data_len[2]} {system_i/axi_adc_0/inst/remain_data_len[3]} {system_i/axi_adc_0/inst/remain_data_len[4]} {system_i/axi_adc_0/inst/remain_data_len[5]} {system_i/axi_adc_0/inst/remain_data_len[6]} {system_i/axi_adc_0/inst/remain_data_len[7]} {system_i/axi_adc_0/inst/remain_data_len[8]} {system_i/axi_adc_0/inst/remain_data_len[9]} {system_i/axi_adc_0/inst/remain_data_len[10]} {system_i/axi_adc_0/inst/remain_data_len[11]} {system_i/axi_adc_0/inst/remain_data_len[12]} {system_i/axi_adc_0/inst/remain_data_len[13]} {system_i/axi_adc_0/inst/remain_data_len[14]} {system_i/axi_adc_0/inst/remain_data_len[15]} {system_i/axi_adc_0/inst/remain_data_len[16]} {system_i/axi_adc_0/inst/remain_data_len[17]} {system_i/axi_adc_0/inst/remain_data_len[18]} {system_i/axi_adc_0/inst/remain_data_len[19]} {system_i/axi_adc_0/inst/remain_data_len[20]} {system_i/axi_adc_0/inst/remain_data_len[21]} {system_i/axi_adc_0/inst/remain_data_len[22]} {system_i/axi_adc_0/inst/remain_data_len[23]} {system_i/axi_adc_0/inst/remain_data_len[24]} {system_i/axi_adc_0/inst/remain_data_len[25]} {system_i/axi_adc_0/inst/remain_data_len[26]} {system_i/axi_adc_0/inst/remain_data_len[27]} {system_i/axi_adc_0/inst/remain_data_len[28]} {system_i/axi_adc_0/inst/remain_data_len[29]} {system_i/axi_adc_0/inst/remain_data_len[30]} {system_i/axi_adc_0/inst/remain_data_len[31]}]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe4]
set_property port_width 11 [get_debug_ports u_ila_0_0/probe4]
connect_debug_port u_ila_0_0/probe4 [get_nets [list {system_i/axi_adc_0/inst/rd_data_count[0]} {system_i/axi_adc_0/inst/rd_data_count[1]} {system_i/axi_adc_0/inst/rd_data_count[2]} {system_i/axi_adc_0/inst/rd_data_count[3]} {system_i/axi_adc_0/inst/rd_data_count[4]} {system_i/axi_adc_0/inst/rd_data_count[5]} {system_i/axi_adc_0/inst/rd_data_count[6]} {system_i/axi_adc_0/inst/rd_data_count[7]} {system_i/axi_adc_0/inst/rd_data_count[8]} {system_i/axi_adc_0/inst/rd_data_count[9]} {system_i/axi_adc_0/inst/rd_data_count[10]}]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0_0/probe5]
connect_debug_port u_ila_0_0/probe5 [get_nets [list {system_i/axi_adc_0/inst/data_len[0]} {system_i/axi_adc_0/inst/data_len[1]} {system_i/axi_adc_0/inst/data_len[2]} {system_i/axi_adc_0/inst/data_len[3]} {system_i/axi_adc_0/inst/data_len[4]} {system_i/axi_adc_0/inst/data_len[5]} {system_i/axi_adc_0/inst/data_len[6]} {system_i/axi_adc_0/inst/data_len[7]} {system_i/axi_adc_0/inst/data_len[8]} {system_i/axi_adc_0/inst/data_len[9]} {system_i/axi_adc_0/inst/data_len[10]} {system_i/axi_adc_0/inst/data_len[11]} {system_i/axi_adc_0/inst/data_len[12]} {system_i/axi_adc_0/inst/data_len[13]} {system_i/axi_adc_0/inst/data_len[14]} {system_i/axi_adc_0/inst/data_len[15]} {system_i/axi_adc_0/inst/data_len[16]} {system_i/axi_adc_0/inst/data_len[17]} {system_i/axi_adc_0/inst/data_len[18]} {system_i/axi_adc_0/inst/data_len[19]} {system_i/axi_adc_0/inst/data_len[20]} {system_i/axi_adc_0/inst/data_len[21]} {system_i/axi_adc_0/inst/data_len[22]} {system_i/axi_adc_0/inst/data_len[23]} {system_i/axi_adc_0/inst/data_len[24]} {system_i/axi_adc_0/inst/data_len[25]} {system_i/axi_adc_0/inst/data_len[26]} {system_i/axi_adc_0/inst/data_len[27]} {system_i/axi_adc_0/inst/data_len[28]} {system_i/axi_adc_0/inst/data_len[29]} {system_i/axi_adc_0/inst/data_len[30]} {system_i/axi_adc_0/inst/data_len[31]}]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe6]
set_property port_width 16 [get_debug_ports u_ila_0_0/probe6]
connect_debug_port u_ila_0_0/probe6 [get_nets [list {system_i/axi_adc_0/inst/burst_size[0]} {system_i/axi_adc_0/inst/burst_size[1]} {system_i/axi_adc_0/inst/burst_size[2]} {system_i/axi_adc_0/inst/burst_size[3]} {system_i/axi_adc_0/inst/burst_size[4]} {system_i/axi_adc_0/inst/burst_size[5]} {system_i/axi_adc_0/inst/burst_size[6]} {system_i/axi_adc_0/inst/burst_size[7]} {system_i/axi_adc_0/inst/burst_size[8]} {system_i/axi_adc_0/inst/burst_size[9]} {system_i/axi_adc_0/inst/burst_size[10]} {system_i/axi_adc_0/inst/burst_size[11]} {system_i/axi_adc_0/inst/burst_size[12]} {system_i/axi_adc_0/inst/burst_size[13]} {system_i/axi_adc_0/inst/burst_size[14]} {system_i/axi_adc_0/inst/burst_size[15]}]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0_0/probe7]
connect_debug_port u_ila_0_0/probe7 [get_nets [list system_i/axi_adc_0/inst/done]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0_0/probe8]
connect_debug_port u_ila_0_0/probe8 [get_nets [list system_i/axi_adc_0/inst/fifo_afull]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0_0/probe9]
connect_debug_port u_ila_0_0/probe9 [get_nets [list system_i/axi_adc_0/inst/fifo_full_sync]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0_0/probe10]
connect_debug_port u_ila_0_0/probe10 [get_nets [list system_i/axi_adc_0/inst/fifo_overflow]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0_0/probe11]
connect_debug_port u_ila_0_0/probe11 [get_nets [list system_i/axi_adc_0/inst/go]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0_0/probe12]
connect_debug_port u_ila_0_0/probe12 [get_nets [list system_i/axi_adc_0/inst/int_clr]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0_0/probe13]
connect_debug_port u_ila_0_0/probe13 [get_nets [list system_i/axi_adc_0/inst/int_r]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0_0/probe14]
connect_debug_port u_ila_0_0/probe14 [get_nets [list system_i/axi_adc_0/inst/wr_buf_index]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0_0/probe15]
connect_debug_port u_ila_0_0/probe15 [get_nets [list system_i/axi_adc_0/inst/wr_burst_finish]]
create_debug_port u_ila_0_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0_0/probe16]
connect_debug_port u_ila_0_0/probe16 [get_nets [list system_i/axi_adc_0/inst/wr_burst_req]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_FCLK_CLK1]
