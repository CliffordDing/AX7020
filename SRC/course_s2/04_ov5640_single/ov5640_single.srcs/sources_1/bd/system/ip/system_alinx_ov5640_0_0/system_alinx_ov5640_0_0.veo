// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.

// IP VLNV: www.alinx.com.cn:user:alinx_ov5640_RGB565:2.1
// IP Revision: 1

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
system_alinx_ov5640_0_0 your_instance_name (
  .cmos_xclk(cmos_xclk),                      // input wire cmos_xclk
  .cmos_scl(cmos_scl),                        // inout wire cmos_scl
  .cmos_sda(cmos_sda),                        // inout wire cmos_sda
  .cmos_vsync(cmos_vsync),                    // input wire cmos_vsync
  .cmos_href(cmos_href),                      // input wire cmos_href
  .cmos_pclk(cmos_pclk),                      // input wire cmos_pclk
  .cmos_d(cmos_d),                            // input wire [9 : 0] cmos_d
  .cmos_reset(cmos_reset),                    // output wire cmos_reset
  .aclk(aclk),                                // input wire aclk
  .aclken(aclken),                            // input wire aclken
  .aresetn(aresetn),                          // input wire aresetn
  .m_axis_video_tdata(m_axis_video_tdata),    // output wire [31 : 0] m_axis_video_tdata
  .m_axis_video_tvalid(m_axis_video_tvalid),  // output wire m_axis_video_tvalid
  .m_axis_video_tready(m_axis_video_tready),  // input wire m_axis_video_tready
  .m_axis_video_tuser(m_axis_video_tuser),    // output wire m_axis_video_tuser
  .m_axis_video_tlast(m_axis_video_tlast),    // output wire m_axis_video_tlast
  .m_axis_video_tkeep(m_axis_video_tkeep),    // output wire [3 : 0] m_axis_video_tkeep
  .axis_enable(axis_enable)                  // input wire axis_enable
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

