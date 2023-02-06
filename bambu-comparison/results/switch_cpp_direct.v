// 
// Politecnico di Milano
// Code created using PandA - Version: PandA 0.9.8 - Revision 891ec3caed502474cab0813cc4a9fc678deabaa5 - Date 2023-02-06T21:45:05
// /nix/store/2hfjp458bdl98q37hzi2aljm30kda30v-bambu-wrapped/bin/bambu executed with: /nix/store/2hfjp458bdl98q37hzi2aljm30kda30v-bambu-wrapped/bin/bambu --top-fname=switch_cpp --generate-tb=src/switch_cpp.xml --simulate --simulator=VERILATOR --no-clean --compiler=I386_CLANG12 -v5 src/switch_cpp.cpp 
// 
// Send any bug to: panda-info@polimi.it
// ************************************************************************
// The following text holds for all the components tagged with PANDA_LGPLv3.
// They are all part of the BAMBU/PANDA IP LIBRARY.
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 3 of the License, or (at your option) any later version.
// 
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public
// License along with the PandA framework; see the files COPYING.LIB
// If not, see <http://www.gnu.org/licenses/>.
// ************************************************************************

`ifdef __ICARUS__
  `define _SIM_HAVE_CLOG2
`endif
`ifdef VERILATOR
  `define _SIM_HAVE_CLOG2
`endif
`ifdef MODEL_TECH
  `define _SIM_HAVE_CLOG2
`endif
`ifdef VCS
  `define _SIM_HAVE_CLOG2
`endif
`ifdef NCVERILOG
  `define _SIM_HAVE_CLOG2
`endif
`ifdef XILINX_SIMULATOR
  `define _SIM_HAVE_CLOG2
`endif
`ifdef XILINX_ISIM
  `define _SIM_HAVE_CLOG2
`endif

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>, Christian Pilato <christian.pilato@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module constant_value(out1);
  parameter BITSIZE_out1=1,
    value=1'b0;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = value;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module register_STD(clock,
  reset,
  in1,
  wenable,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input clock;
  input reset;
  input [BITSIZE_in1-1:0] in1;
  input wenable;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  reg [BITSIZE_out1-1:0] reg_out1 =0;
  assign out1 = reg_out1;
  always @(posedge clock)
    reg_out1 <= in1;

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_view_convert_expr_FU(in1,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2016-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module lut_expr_FU(in1,
  in2,
  in3,
  in4,
  in5,
  in6,
  in7,
  in8,
  in9,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input in2;
  input in3;
  input in4;
  input in5;
  input in6;
  input in7;
  input in8;
  input in9;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  reg[7:0] cleaned_in0;
  wire [7:0] in0;
  wire[BITSIZE_in1-1:0] shifted_s;
  assign in0 = {in9, in8, in7, in6, in5, in4, in3, in2};
  generate
    genvar i0;
    for (i0=0; i0<8; i0=i0+1)
    begin : L0
          always @(*)
          begin
             if (in0[i0] == 1'b1)
                cleaned_in0[i0] = 1'b1;
             else
                cleaned_in0[i0] = 1'b0;
          end
    end
  endgenerate
  assign shifted_s = in1 >> cleaned_in0;
  assign out1[0] = shifted_s[0];
  generate
     if(BITSIZE_out1 > 1)
       assign out1[BITSIZE_out1-1:1] = 0;
  endgenerate

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module multi_read_cond_FU(in1,
  out1);
  parameter BITSIZE_in1=1, PORTSIZE_in1=2,
    BITSIZE_out1=1;
  // IN
  input [(PORTSIZE_in1*BITSIZE_in1)+(-1):0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module BMEMORY_CTRLN(clock,
  in1,
  in2,
  in3,
  in4,
  sel_LOAD,
  sel_STORE,
  out1,
  Min_oe_ram,
  Mout_oe_ram,
  Min_we_ram,
  Mout_we_ram,
  Min_addr_ram,
  Mout_addr_ram,
  M_Rdata_ram,
  Min_Wdata_ram,
  Mout_Wdata_ram,
  Min_data_ram_size,
  Mout_data_ram_size,
  M_DataRdy);
  parameter BITSIZE_in1=1, PORTSIZE_in1=2,
    BITSIZE_in2=1, PORTSIZE_in2=2,
    BITSIZE_in3=1, PORTSIZE_in3=2,
    BITSIZE_in4=1, PORTSIZE_in4=2,
    BITSIZE_sel_LOAD=1, PORTSIZE_sel_LOAD=2,
    BITSIZE_sel_STORE=1, PORTSIZE_sel_STORE=2,
    BITSIZE_out1=1, PORTSIZE_out1=2,
    BITSIZE_Min_oe_ram=1, PORTSIZE_Min_oe_ram=2,
    BITSIZE_Min_we_ram=1, PORTSIZE_Min_we_ram=2,
    BITSIZE_Mout_oe_ram=1, PORTSIZE_Mout_oe_ram=2,
    BITSIZE_Mout_we_ram=1, PORTSIZE_Mout_we_ram=2,
    BITSIZE_M_DataRdy=1, PORTSIZE_M_DataRdy=2,
    BITSIZE_Min_addr_ram=1, PORTSIZE_Min_addr_ram=2,
    BITSIZE_Mout_addr_ram=1, PORTSIZE_Mout_addr_ram=2,
    BITSIZE_M_Rdata_ram=8, PORTSIZE_M_Rdata_ram=2,
    BITSIZE_Min_Wdata_ram=8, PORTSIZE_Min_Wdata_ram=2,
    BITSIZE_Mout_Wdata_ram=8, PORTSIZE_Mout_Wdata_ram=2,
    BITSIZE_Min_data_ram_size=1, PORTSIZE_Min_data_ram_size=2,
    BITSIZE_Mout_data_ram_size=1, PORTSIZE_Mout_data_ram_size=2;
  // IN
  input clock;
  input [(PORTSIZE_in1*BITSIZE_in1)+(-1):0] in1;
  input [(PORTSIZE_in2*BITSIZE_in2)+(-1):0] in2;
  input [(PORTSIZE_in3*BITSIZE_in3)+(-1):0] in3;
  input [PORTSIZE_in4-1:0] in4;
  input [PORTSIZE_sel_LOAD-1:0] sel_LOAD;
  input [PORTSIZE_sel_STORE-1:0] sel_STORE;
  input [PORTSIZE_Min_oe_ram-1:0] Min_oe_ram;
  input [PORTSIZE_Min_we_ram-1:0] Min_we_ram;
  input [(PORTSIZE_Min_addr_ram*BITSIZE_Min_addr_ram)+(-1):0] Min_addr_ram;
  input [(PORTSIZE_M_Rdata_ram*BITSIZE_M_Rdata_ram)+(-1):0] M_Rdata_ram;
  input [(PORTSIZE_Min_Wdata_ram*BITSIZE_Min_Wdata_ram)+(-1):0] Min_Wdata_ram;
  input [(PORTSIZE_Min_data_ram_size*BITSIZE_Min_data_ram_size)+(-1):0] Min_data_ram_size;
  input [PORTSIZE_M_DataRdy-1:0] M_DataRdy;
  // OUT
  output [(PORTSIZE_out1*BITSIZE_out1)+(-1):0] out1;
  output [PORTSIZE_Mout_oe_ram-1:0] Mout_oe_ram;
  output [PORTSIZE_Mout_we_ram-1:0] Mout_we_ram;
  output [(PORTSIZE_Mout_addr_ram*BITSIZE_Mout_addr_ram)+(-1):0] Mout_addr_ram;
  output [(PORTSIZE_Mout_Wdata_ram*BITSIZE_Mout_Wdata_ram)+(-1):0] Mout_Wdata_ram;
  output [(PORTSIZE_Mout_data_ram_size*BITSIZE_Mout_data_ram_size)+(-1):0] Mout_data_ram_size;
  
  parameter max_n_writes = PORTSIZE_sel_STORE > PORTSIZE_Mout_we_ram ? PORTSIZE_sel_STORE : PORTSIZE_Mout_we_ram;
  parameter max_n_reads = PORTSIZE_sel_LOAD > PORTSIZE_Mout_oe_ram ? PORTSIZE_sel_STORE : PORTSIZE_Mout_oe_ram;
  parameter max_n_rw = max_n_writes > max_n_reads ? max_n_writes : max_n_reads;
  wire  [(PORTSIZE_in2*BITSIZE_in2)-1:0] tmp_addr;
  wire [PORTSIZE_sel_LOAD-1:0] int_sel_LOAD;
  wire [PORTSIZE_sel_STORE-1:0] int_sel_STORE;
  assign int_sel_LOAD = sel_LOAD & in4;
  assign int_sel_STORE = sel_STORE & in4;
  assign tmp_addr = in2;
  generate
  genvar i;
    for (i=0; i<max_n_rw; i=i+1)
    begin : L0
      assign Mout_addr_ram[(i+1)*BITSIZE_Mout_addr_ram-1:i*BITSIZE_Mout_addr_ram] = ((i < PORTSIZE_sel_LOAD && int_sel_LOAD[i]) || (i < PORTSIZE_sel_STORE && int_sel_STORE[i])) ? (tmp_addr[(i+1)*BITSIZE_in2-1:i*BITSIZE_in2]) : Min_addr_ram[(i+1)*BITSIZE_Min_addr_ram-1:i*BITSIZE_Min_addr_ram];
    end
    endgenerate
  assign Mout_oe_ram = int_sel_LOAD | Min_oe_ram;
  assign Mout_we_ram = int_sel_STORE | Min_we_ram;
  generate
    for (i=0; i<max_n_reads; i=i+1)
    begin : L1
      assign out1[(i+1)*BITSIZE_out1-1:i*BITSIZE_out1] = M_Rdata_ram[i*BITSIZE_M_Rdata_ram+BITSIZE_out1-1:i*BITSIZE_M_Rdata_ram];
  end
  endgenerate
  generate
    for (i=0; i<max_n_rw; i=i+1)
    begin : L2
      assign Mout_Wdata_ram[(i+1)*BITSIZE_Mout_Wdata_ram-1:i*BITSIZE_Mout_Wdata_ram] = int_sel_STORE[i] ? in1[(i+1)*BITSIZE_in1-1:i*BITSIZE_in1] : Min_Wdata_ram[(i+1)*BITSIZE_Min_Wdata_ram-1:i*BITSIZE_Min_Wdata_ram];
  end
  endgenerate
  generate
    for (i=0; i<max_n_rw; i=i+1)
    begin : L3
      assign Mout_data_ram_size[(i+1)*BITSIZE_Mout_data_ram_size-1:i*BITSIZE_Mout_data_ram_size] = ((i < PORTSIZE_sel_LOAD && int_sel_LOAD[i]) || (i < PORTSIZE_sel_STORE && int_sel_STORE[i])) ? (in3[(i+1)*BITSIZE_in3-1:i*BITSIZE_in3]) : Min_data_ram_size[(i+1)*BITSIZE_Min_data_ram_size-1:i*BITSIZE_Min_data_ram_size];
    end
    endgenerate

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_cond_expr_FU(in1,
  in2,
  in3,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_in3=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  input [BITSIZE_in3-1:0] in3;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 != 0 ? in2 : in3;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_eq_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 == in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_pointer_plus_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1,
    LSB_PARAMETER=-1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  wire [BITSIZE_out1-1:0] in1_tmp;
  wire [BITSIZE_out1-1:0] in2_tmp;
  assign in1_tmp = in1;
  assign in2_tmp = in2;generate if (BITSIZE_out1 > LSB_PARAMETER) assign out1[BITSIZE_out1-1:LSB_PARAMETER] = (in1_tmp[BITSIZE_out1-1:LSB_PARAMETER] + in2_tmp[BITSIZE_out1-1:LSB_PARAMETER]); else assign out1 = 0; endgenerate
  generate if (LSB_PARAMETER != 0 && BITSIZE_out1 > LSB_PARAMETER) assign out1[LSB_PARAMETER-1:0] = 0; endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ASSIGN_VECTOR_BOOL_FU(in1,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>, Christian Pilato <christian.pilato@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module MUX_GATE(sel,
  in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input sel;
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = sel ? in1 : in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module UUdata_converter_FU(in1,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  generate
  if (BITSIZE_out1 <= BITSIZE_in1)
  begin
    assign out1 = in1[BITSIZE_out1-1:0];
  end
  else
  begin
    assign out1 = {{(BITSIZE_out1-BITSIZE_in1){1'b0}},in1};
  end
  endgenerate
endmodule

// Datapath RTL description for switch_cpp
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module datapath_switch_cpp(clock,
  reset,
  in_port_P0,
  in_port_P1,
  M_Rdata_ram,
  M_DataRdy,
  Min_oe_ram,
  Min_we_ram,
  Min_addr_ram,
  Min_Wdata_ram,
  Min_data_ram_size,
  Mout_oe_ram,
  Mout_we_ram,
  Mout_addr_ram,
  Mout_Wdata_ram,
  Mout_data_ram_size,
  fuselector_BMEMORY_CTRLN_7_i0_LOAD,
  fuselector_BMEMORY_CTRLN_7_i0_STORE,
  selector_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0,
  selector_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0,
  selector_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0,
  wrenable_reg_0,
  OUT_MULTIIF_switch_cpp_424720_424818);
  // IN
  input clock;
  input reset;
  input [31:0] in_port_P0;
  input [31:0] in_port_P1;
  input [63:0] M_Rdata_ram;
  input [1:0] M_DataRdy;
  input [1:0] Min_oe_ram;
  input [1:0] Min_we_ram;
  input [63:0] Min_addr_ram;
  input [63:0] Min_Wdata_ram;
  input [11:0] Min_data_ram_size;
  input fuselector_BMEMORY_CTRLN_7_i0_LOAD;
  input fuselector_BMEMORY_CTRLN_7_i0_STORE;
  input selector_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0;
  input selector_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0;
  input selector_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0;
  input wrenable_reg_0;
  // OUT
  output [1:0] Mout_oe_ram;
  output [1:0] Mout_we_ram;
  output [63:0] Mout_addr_ram;
  output [63:0] Mout_Wdata_ram;
  output [11:0] Mout_data_ram_size;
  output OUT_MULTIIF_switch_cpp_424720_424818;
  // Component and signal declarations
  wire null_out_signal_BMEMORY_CTRLN_7_i0_out1_0;
  wire null_out_signal_BMEMORY_CTRLN_7_i0_out1_1;
  wire [31:0] out_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0;
  wire [31:0] out_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0;
  wire [6:0] out_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0;
  wire out_const_0;
  wire [31:0] out_const_1;
  wire [7:0] out_const_2;
  wire [4:0] out_const_3;
  wire [6:0] out_const_4;
  wire out_const_5;
  wire [1:0] out_const_6;
  wire [1:0] out_const_7;
  wire [7:0] out_const_8;
  wire [15:0] out_const_9;
  wire [5:0] out_conv_out_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0_7_6;
  wire [6:0] out_conv_out_const_3_5_7;
  wire [31:0] out_conv_out_vb_assign_conn_obj_1_ASSIGN_VECTOR_BOOL_FU_vb_assign_1_8_32;
  wire out_lut_expr_FU_3_i0_fu_switch_cpp_424720_424848;
  wire out_lut_expr_FU_4_i0_fu_switch_cpp_424720_424854;
  wire out_multi_read_cond_FU_5_i0_fu_switch_cpp_424720_424818;
  wire [31:0] out_reg_0_reg_0;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_8_i0_fu_switch_cpp_424720_424845;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_8_i1_fu_switch_cpp_424720_424851;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_8_i2_fu_switch_cpp_424720_424856;
  wire out_ui_eq_expr_FU_32_0_32_10_i0_fu_switch_cpp_424720_424830;
  wire out_ui_eq_expr_FU_32_0_32_11_i0_fu_switch_cpp_424720_424833;
  wire out_ui_eq_expr_FU_32_0_32_12_i0_fu_switch_cpp_424720_424836;
  wire out_ui_eq_expr_FU_32_0_32_9_i0_fu_switch_cpp_424720_424827;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_0_32_13_i0_fu_switch_cpp_424720_424755;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_0_32_14_i0_fu_switch_cpp_424720_424761;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_0_32_15_i0_fu_switch_cpp_424720_424767;
  wire [31:0] out_ui_view_convert_expr_FU_2_i0_fu_switch_cpp_424720_424772;
  wire [31:0] out_vb_assign_conn_obj_0_ASSIGN_VECTOR_BOOL_FU_vb_assign_0;
  wire [7:0] out_vb_assign_conn_obj_1_ASSIGN_VECTOR_BOOL_FU_vb_assign_1;
  
  ASSIGN_VECTOR_BOOL_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) ASSIGN_VECTOR_BOOL_FU_vb_assign_0 (.out1(out_vb_assign_conn_obj_0_ASSIGN_VECTOR_BOOL_FU_vb_assign_0),
    .in1(out_const_1));
  ASSIGN_VECTOR_BOOL_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(8)) ASSIGN_VECTOR_BOOL_FU_vb_assign_1 (.out1(out_vb_assign_conn_obj_1_ASSIGN_VECTOR_BOOL_FU_vb_assign_1),
    .in1(out_const_2));
  BMEMORY_CTRLN #(.BITSIZE_in1(32),
    .PORTSIZE_in1(2),
    .BITSIZE_in2(32),
    .PORTSIZE_in2(2),
    .BITSIZE_in3(6),
    .PORTSIZE_in3(2),
    .BITSIZE_in4(1),
    .PORTSIZE_in4(2),
    .BITSIZE_sel_LOAD(1),
    .PORTSIZE_sel_LOAD(2),
    .BITSIZE_sel_STORE(1),
    .PORTSIZE_sel_STORE(2),
    .BITSIZE_out1(1),
    .PORTSIZE_out1(2),
    .BITSIZE_Min_oe_ram(1),
    .PORTSIZE_Min_oe_ram(2),
    .BITSIZE_Min_we_ram(1),
    .PORTSIZE_Min_we_ram(2),
    .BITSIZE_Mout_oe_ram(1),
    .PORTSIZE_Mout_oe_ram(2),
    .BITSIZE_Mout_we_ram(1),
    .PORTSIZE_Mout_we_ram(2),
    .BITSIZE_M_DataRdy(1),
    .PORTSIZE_M_DataRdy(2),
    .BITSIZE_Min_addr_ram(32),
    .PORTSIZE_Min_addr_ram(2),
    .BITSIZE_Mout_addr_ram(32),
    .PORTSIZE_Mout_addr_ram(2),
    .BITSIZE_M_Rdata_ram(32),
    .PORTSIZE_M_Rdata_ram(2),
    .BITSIZE_Min_Wdata_ram(32),
    .PORTSIZE_Min_Wdata_ram(2),
    .BITSIZE_Mout_Wdata_ram(32),
    .PORTSIZE_Mout_Wdata_ram(2),
    .BITSIZE_Min_data_ram_size(6),
    .PORTSIZE_Min_data_ram_size(2),
    .BITSIZE_Mout_data_ram_size(6),
    .PORTSIZE_Mout_data_ram_size(2)) BMEMORY_CTRLN_7_i0 (.out1({null_out_signal_BMEMORY_CTRLN_7_i0_out1_1,
      null_out_signal_BMEMORY_CTRLN_7_i0_out1_0}),
    .Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .clock(clock),
    .in1({32'b00000000000000000000000000000000,
      out_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0}),
    .in2({32'b00000000000000000000000000000000,
      out_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0}),
    .in3({6'b000000,
      out_conv_out_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0_7_6}),
    .in4({1'b0,
      out_const_5}),
    .sel_LOAD({1'b0,
      fuselector_BMEMORY_CTRLN_7_i0_LOAD}),
    .sel_STORE({1'b0,
      fuselector_BMEMORY_CTRLN_7_i0_STORE}),
    .Min_oe_ram(Min_oe_ram),
    .Min_we_ram(Min_we_ram),
    .Min_addr_ram(Min_addr_ram),
    .M_Rdata_ram(M_Rdata_ram),
    .Min_Wdata_ram(Min_Wdata_ram),
    .Min_data_ram_size(Min_data_ram_size),
    .M_DataRdy(M_DataRdy));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_0_BMEMORY_CTRLN_7_i0_0_0_0 (.out1(out_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0),
    .sel(selector_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0),
    .in1(out_vb_assign_conn_obj_0_ASSIGN_VECTOR_BOOL_FU_vb_assign_0),
    .in2(out_conv_out_vb_assign_conn_obj_1_ASSIGN_VECTOR_BOOL_FU_vb_assign_1_8_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_BMEMORY_CTRLN_7_i0_1_0_0 (.out1(out_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0),
    .sel(selector_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0),
    .in1(out_reg_0_reg_0),
    .in2(out_ui_view_convert_expr_FU_2_i0_fu_switch_cpp_424720_424772));
  MUX_GATE #(.BITSIZE_in1(7),
    .BITSIZE_in2(7),
    .BITSIZE_out1(7)) MUX_2_BMEMORY_CTRLN_7_i0_2_0_0 (.out1(out_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0),
    .sel(selector_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0),
    .in1(out_conv_out_const_3_5_7),
    .in2(out_const_4));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b0)) const_0 (.out1(out_const_0));
  constant_value #(.BITSIZE_out1(32),
    .value(32'b00000000000000000000000000000000)) const_1 (.out1(out_const_1));
  constant_value #(.BITSIZE_out1(8),
    .value(8'b00000001)) const_2 (.out1(out_const_2));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b01000)) const_3 (.out1(out_const_3));
  constant_value #(.BITSIZE_out1(7),
    .value(7'b0100000)) const_4 (.out1(out_const_4));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b1)) const_5 (.out1(out_const_5));
  constant_value #(.BITSIZE_out1(2),
    .value(2'b10)) const_6 (.out1(out_const_6));
  constant_value #(.BITSIZE_out1(2),
    .value(2'b11)) const_7 (.out1(out_const_7));
  constant_value #(.BITSIZE_out1(8),
    .value(8'b11111110)) const_8 (.out1(out_const_8));
  constant_value #(.BITSIZE_out1(16),
    .value(16'b1111111111111110)) const_9 (.out1(out_const_9));
  UUdata_converter_FU #(.BITSIZE_in1(7),
    .BITSIZE_out1(6)) conv_out_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0_7_6 (.out1(out_conv_out_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0_7_6),
    .in1(out_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0));
  UUdata_converter_FU #(.BITSIZE_in1(5),
    .BITSIZE_out1(7)) conv_out_const_3_5_7 (.out1(out_conv_out_const_3_5_7),
    .in1(out_const_3));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(32)) conv_out_vb_assign_conn_obj_1_ASSIGN_VECTOR_BOOL_FU_vb_assign_1_8_32 (.out1(out_conv_out_vb_assign_conn_obj_1_ASSIGN_VECTOR_BOOL_FU_vb_assign_1_8_32),
    .in1(out_vb_assign_conn_obj_1_ASSIGN_VECTOR_BOOL_FU_vb_assign_1));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_switch_cpp_424720_424755 (.out1(out_ui_pointer_plus_expr_FU_32_0_32_13_i0_fu_switch_cpp_424720_424755),
    .in1(in_port_P0),
    .in2(out_const_5));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_switch_cpp_424720_424761 (.out1(out_ui_pointer_plus_expr_FU_32_0_32_14_i0_fu_switch_cpp_424720_424761),
    .in1(in_port_P0),
    .in2(out_const_6));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_switch_cpp_424720_424767 (.out1(out_ui_pointer_plus_expr_FU_32_0_32_15_i0_fu_switch_cpp_424720_424767),
    .in1(in_port_P0),
    .in2(out_const_7));
  ui_view_convert_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_switch_cpp_424720_424772 (.out1(out_ui_view_convert_expr_FU_2_i0_fu_switch_cpp_424720_424772),
    .in1(in_port_P0));
  multi_read_cond_FU #(.BITSIZE_in1(1),
    .PORTSIZE_in1(1),
    .BITSIZE_out1(1)) fu_switch_cpp_424720_424818 (.out1(out_multi_read_cond_FU_5_i0_fu_switch_cpp_424720_424818),
    .in1({out_lut_expr_FU_4_i0_fu_switch_cpp_424720_424854}));
  ui_eq_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_switch_cpp_424720_424827 (.out1(out_ui_eq_expr_FU_32_0_32_9_i0_fu_switch_cpp_424720_424827),
    .in1(in_port_P1),
    .in2(out_const_0));
  ui_eq_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_switch_cpp_424720_424830 (.out1(out_ui_eq_expr_FU_32_0_32_10_i0_fu_switch_cpp_424720_424830),
    .in1(in_port_P1),
    .in2(out_const_5));
  ui_eq_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(1)) fu_switch_cpp_424720_424833 (.out1(out_ui_eq_expr_FU_32_0_32_11_i0_fu_switch_cpp_424720_424833),
    .in1(in_port_P1),
    .in2(out_const_6));
  ui_eq_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(1)) fu_switch_cpp_424720_424836 (.out1(out_ui_eq_expr_FU_32_0_32_12_i0_fu_switch_cpp_424720_424836),
    .in1(in_port_P1),
    .in2(out_const_7));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(32),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_switch_cpp_424720_424845 (.out1(out_ui_cond_expr_FU_32_32_32_32_8_i0_fu_switch_cpp_424720_424845),
    .in1(out_ui_eq_expr_FU_32_0_32_9_i0_fu_switch_cpp_424720_424827),
    .in2(in_port_P0),
    .in3(out_ui_pointer_plus_expr_FU_32_0_32_13_i0_fu_switch_cpp_424720_424755));
  lut_expr_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(1)) fu_switch_cpp_424720_424848 (.out1(out_lut_expr_FU_3_i0_fu_switch_cpp_424720_424848),
    .in1(out_const_8),
    .in2(out_ui_eq_expr_FU_32_0_32_9_i0_fu_switch_cpp_424720_424827),
    .in3(out_ui_eq_expr_FU_32_0_32_10_i0_fu_switch_cpp_424720_424830),
    .in4(out_ui_eq_expr_FU_32_0_32_11_i0_fu_switch_cpp_424720_424833),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(32),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_switch_cpp_424720_424851 (.out1(out_ui_cond_expr_FU_32_32_32_32_8_i1_fu_switch_cpp_424720_424851),
    .in1(out_ui_eq_expr_FU_32_0_32_11_i0_fu_switch_cpp_424720_424833),
    .in2(out_ui_pointer_plus_expr_FU_32_0_32_14_i0_fu_switch_cpp_424720_424761),
    .in3(out_ui_cond_expr_FU_32_32_32_32_8_i0_fu_switch_cpp_424720_424845));
  lut_expr_FU #(.BITSIZE_in1(16),
    .BITSIZE_out1(1)) fu_switch_cpp_424720_424854 (.out1(out_lut_expr_FU_4_i0_fu_switch_cpp_424720_424854),
    .in1(out_const_9),
    .in2(out_ui_eq_expr_FU_32_0_32_9_i0_fu_switch_cpp_424720_424827),
    .in3(out_ui_eq_expr_FU_32_0_32_10_i0_fu_switch_cpp_424720_424830),
    .in4(out_ui_eq_expr_FU_32_0_32_11_i0_fu_switch_cpp_424720_424833),
    .in5(out_ui_eq_expr_FU_32_0_32_12_i0_fu_switch_cpp_424720_424836),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(32),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_switch_cpp_424720_424856 (.out1(out_ui_cond_expr_FU_32_32_32_32_8_i2_fu_switch_cpp_424720_424856),
    .in1(out_lut_expr_FU_3_i0_fu_switch_cpp_424720_424848),
    .in2(out_ui_cond_expr_FU_32_32_32_32_8_i1_fu_switch_cpp_424720_424851),
    .in3(out_ui_pointer_plus_expr_FU_32_0_32_15_i0_fu_switch_cpp_424720_424767));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_0 (.out1(out_reg_0_reg_0),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_cond_expr_FU_32_32_32_32_8_i2_fu_switch_cpp_424720_424856),
    .wenable(wrenable_reg_0));
  // io-signal post fix
  assign OUT_MULTIIF_switch_cpp_424720_424818 = out_multi_read_cond_FU_5_i0_fu_switch_cpp_424720_424818;

endmodule

// FSM based controller description for switch_cpp
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module controller_switch_cpp(done_port,
  fuselector_BMEMORY_CTRLN_7_i0_LOAD,
  fuselector_BMEMORY_CTRLN_7_i0_STORE,
  selector_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0,
  selector_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0,
  selector_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0,
  wrenable_reg_0,
  OUT_MULTIIF_switch_cpp_424720_424818,
  clock,
  reset,
  start_port);
  // IN
  input OUT_MULTIIF_switch_cpp_424720_424818;
  input clock;
  input reset;
  input start_port;
  // OUT
  output done_port;
  output fuselector_BMEMORY_CTRLN_7_i0_LOAD;
  output fuselector_BMEMORY_CTRLN_7_i0_STORE;
  output selector_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0;
  output selector_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0;
  output selector_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0;
  output wrenable_reg_0;
  parameter [3:0] S_0 = 4'b0001,
    S_3 = 4'b1000,
    S_1 = 4'b0010,
    S_2 = 4'b0100;
  reg [3:0] _present_state=S_0, _next_state;
  reg done_port;
  reg fuselector_BMEMORY_CTRLN_7_i0_LOAD;
  reg fuselector_BMEMORY_CTRLN_7_i0_STORE;
  reg selector_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0;
  reg selector_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0;
  reg selector_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0;
  reg wrenable_reg_0;
  
  always @(posedge clock)
    if (reset == 1'b0) _present_state <= S_0;
    else _present_state <= _next_state;
  
  always @(*)
  begin
    done_port = 1'b0;
    fuselector_BMEMORY_CTRLN_7_i0_LOAD = 1'b0;
    fuselector_BMEMORY_CTRLN_7_i0_STORE = 1'b0;
    selector_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0 = 1'b0;
    selector_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0 = 1'b0;
    selector_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0 = 1'b0;
    wrenable_reg_0 = 1'b0;
    case (_present_state)
      S_0 :
        if(start_port == 1'b1)
        begin
          fuselector_BMEMORY_CTRLN_7_i0_STORE = 1'b1;
          selector_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0 = 1'b1;
          wrenable_reg_0 = 1'b1;
          casez (OUT_MULTIIF_switch_cpp_424720_424818)
            1'b1 :
              begin
                _next_state = S_1;
              end
            default:
              begin
                _next_state = S_3;
                done_port = 1'b1;
                wrenable_reg_0 = 1'b0;
              end
          endcase
        end
        else
        begin
          _next_state = S_0;
        end
      S_3 :
        begin
          _next_state = S_0;
        end
      S_1 :
        begin
          fuselector_BMEMORY_CTRLN_7_i0_STORE = 1'b1;
          selector_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0 = 1'b1;
          selector_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0 = 1'b1;
          _next_state = S_2;
          done_port = 1'b1;
        end
      S_2 :
        begin
          _next_state = S_0;
        end
      default :
        begin
          _next_state = S_0;
        end
    endcase
  end
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Marco Lattuada <marco.lattuada@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module flipflop_AR(clock,
  reset,
  in1,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input clock;
  input reset;
  input in1;
  // OUT
  output out1;
  
  reg reg_out1 =0;
  assign out1 = reg_out1;
  always @(posedge clock )
    if (reset == 1'b0)
      reg_out1 <= {BITSIZE_out1{1'b0}};
    else
      reg_out1 <= in1;
endmodule

// Top component for switch_cpp
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module _switch_cpp(clock,
  reset,
  start_port,
  done_port,
  P0,
  P1,
  M_Rdata_ram,
  M_DataRdy,
  Min_oe_ram,
  Min_we_ram,
  Min_addr_ram,
  Min_Wdata_ram,
  Min_data_ram_size,
  Mout_oe_ram,
  Mout_we_ram,
  Mout_addr_ram,
  Mout_Wdata_ram,
  Mout_data_ram_size);
  // IN
  input clock;
  input reset;
  input start_port;
  input [31:0] P0;
  input [31:0] P1;
  input [63:0] M_Rdata_ram;
  input [1:0] M_DataRdy;
  input [1:0] Min_oe_ram;
  input [1:0] Min_we_ram;
  input [63:0] Min_addr_ram;
  input [63:0] Min_Wdata_ram;
  input [11:0] Min_data_ram_size;
  // OUT
  output done_port;
  output [1:0] Mout_oe_ram;
  output [1:0] Mout_we_ram;
  output [63:0] Mout_addr_ram;
  output [63:0] Mout_Wdata_ram;
  output [11:0] Mout_data_ram_size;
  // Component and signal declarations
  wire OUT_MULTIIF_switch_cpp_424720_424818;
  wire done_delayed_REG_signal_in;
  wire done_delayed_REG_signal_out;
  wire fuselector_BMEMORY_CTRLN_7_i0_LOAD;
  wire fuselector_BMEMORY_CTRLN_7_i0_STORE;
  wire selector_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0;
  wire selector_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0;
  wire selector_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0;
  wire wrenable_reg_0;
  
  controller_switch_cpp Controller_i (.done_port(done_delayed_REG_signal_in),
    .fuselector_BMEMORY_CTRLN_7_i0_LOAD(fuselector_BMEMORY_CTRLN_7_i0_LOAD),
    .fuselector_BMEMORY_CTRLN_7_i0_STORE(fuselector_BMEMORY_CTRLN_7_i0_STORE),
    .selector_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0(selector_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0),
    .selector_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0(selector_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0),
    .selector_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0(selector_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0),
    .wrenable_reg_0(wrenable_reg_0),
    .OUT_MULTIIF_switch_cpp_424720_424818(OUT_MULTIIF_switch_cpp_424720_424818),
    .clock(clock),
    .reset(reset),
    .start_port(start_port));
  datapath_switch_cpp Datapath_i (.Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .OUT_MULTIIF_switch_cpp_424720_424818(OUT_MULTIIF_switch_cpp_424720_424818),
    .clock(clock),
    .reset(reset),
    .in_port_P0(P0),
    .in_port_P1(P1),
    .M_Rdata_ram(M_Rdata_ram),
    .M_DataRdy(M_DataRdy),
    .Min_oe_ram(Min_oe_ram),
    .Min_we_ram(Min_we_ram),
    .Min_addr_ram(Min_addr_ram),
    .Min_Wdata_ram(Min_Wdata_ram),
    .Min_data_ram_size(Min_data_ram_size),
    .fuselector_BMEMORY_CTRLN_7_i0_LOAD(fuselector_BMEMORY_CTRLN_7_i0_LOAD),
    .fuselector_BMEMORY_CTRLN_7_i0_STORE(fuselector_BMEMORY_CTRLN_7_i0_STORE),
    .selector_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0(selector_MUX_0_BMEMORY_CTRLN_7_i0_0_0_0),
    .selector_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0(selector_MUX_1_BMEMORY_CTRLN_7_i0_1_0_0),
    .selector_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0(selector_MUX_2_BMEMORY_CTRLN_7_i0_2_0_0),
    .wrenable_reg_0(wrenable_reg_0));
  flipflop_AR #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) done_delayed_REG (.out1(done_delayed_REG_signal_out),
    .clock(clock),
    .reset(reset),
    .in1(done_delayed_REG_signal_in));
  // io-signal post fix
  assign done_port = done_delayed_REG_signal_out;

endmodule

// Minimal interface for function: switch_cpp
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module switch_cpp(clock,
  reset,
  start_port,
  P0,
  P1,
  M_Rdata_ram,
  M_DataRdy,
  done_port,
  Mout_oe_ram,
  Mout_we_ram,
  Mout_addr_ram,
  Mout_Wdata_ram,
  Mout_data_ram_size);
  // IN
  input clock;
  input reset;
  input start_port;
  input [31:0] P0;
  input [31:0] P1;
  input [63:0] M_Rdata_ram;
  input [1:0] M_DataRdy;
  // OUT
  output done_port;
  output [1:0] Mout_oe_ram;
  output [1:0] Mout_we_ram;
  output [63:0] Mout_addr_ram;
  output [63:0] Mout_Wdata_ram;
  output [11:0] Mout_data_ram_size;
  // Component and signal declarations
  
  _switch_cpp _switch_cpp_i0 (.done_port(done_port),
    .Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .clock(clock),
    .reset(reset),
    .start_port(start_port),
    .P0(P0),
    .P1(P1),
    .M_Rdata_ram(M_Rdata_ram),
    .M_DataRdy(M_DataRdy),
    .Min_oe_ram({1'b0,
      1'b0}),
    .Min_we_ram({1'b0,
      1'b0}),
    .Min_addr_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .Min_Wdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .Min_data_ram_size({6'b000000,
      6'b000000}));

endmodule


