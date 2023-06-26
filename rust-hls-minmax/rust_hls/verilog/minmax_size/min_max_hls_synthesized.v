// 
// Politecnico di Milano
// Code created using PandA - Version: PandA 2023.2 - Revision 891ec3caed502474cab0813cc4a9fc678deabaa5 - Date 2023-06-26T16:43:27
// /nix/store/9c5lz0md936sjhs9hw1ya6kghvkfc4zg-bambu-wrapped/bin/bambu executed with: /nix/store/9c5lz0md936sjhs9hw1ya6kghvkfc4zg-bambu-wrapped/bin/bambu --simulator=VERILATOR --top-fname=min_max --clock-name=clk --compiler=I386_CLANG16 --channels-type=MEM_ACC_11 --channels-number=1 -Os min_max.ll 
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
// Copyright (C) 2004-2023 Politecnico di Milano
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
// Copyright (C) 2004-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module register_SE(clock,
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
    if (wenable)
      reg_out1 <= in1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
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
// Copyright (C) 2004-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module read_cond_FU(in1,
  out1);
  parameter BITSIZE_in1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output out1;
  assign out1 = in1 != {BITSIZE_in1{1'b0}};
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
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

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module UIdata_converter_FU(in1,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
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

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module IUdata_converter_FU(in1,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  generate
  if (BITSIZE_out1 <= BITSIZE_in1)
  begin
    assign out1 = in1[BITSIZE_out1-1:0];
  end
  else
  begin
    assign out1 = {{(BITSIZE_out1-BITSIZE_in1){in1[BITSIZE_in1-1]}},in1};
  end
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module BMEMORY_CTRL(clock,
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
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_in3=1,
    BITSIZE_out1=1,
    BITSIZE_Min_addr_ram=1,
    BITSIZE_Mout_addr_ram=1,
    BITSIZE_M_Rdata_ram=8,
    BITSIZE_Min_Wdata_ram=8,
    BITSIZE_Mout_Wdata_ram=8,
    BITSIZE_Min_data_ram_size=1,
    BITSIZE_Mout_data_ram_size=1;
  // IN
  input clock;
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  input [BITSIZE_in3-1:0] in3;
  input in4;
  input sel_LOAD;
  input sel_STORE;
  input Min_oe_ram;
  input Min_we_ram;
  input [BITSIZE_Min_addr_ram-1:0] Min_addr_ram;
  input [BITSIZE_M_Rdata_ram-1:0] M_Rdata_ram;
  input [BITSIZE_Min_Wdata_ram-1:0] Min_Wdata_ram;
  input [BITSIZE_Min_data_ram_size-1:0] Min_data_ram_size;
  input M_DataRdy;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  output Mout_oe_ram;
  output Mout_we_ram;
  output [BITSIZE_Mout_addr_ram-1:0] Mout_addr_ram;
  output [BITSIZE_Mout_Wdata_ram-1:0] Mout_Wdata_ram;
  output [BITSIZE_Mout_data_ram_size-1:0] Mout_data_ram_size;
  
  wire  [BITSIZE_in2-1:0] tmp_addr;
  wire int_sel_LOAD;
  wire int_sel_STORE;
  assign tmp_addr = in2;
  assign Mout_addr_ram = (int_sel_LOAD || int_sel_STORE) ? tmp_addr : Min_addr_ram;
  assign Mout_oe_ram = int_sel_LOAD ? 1'b1 : Min_oe_ram;
  assign Mout_we_ram = int_sel_STORE ? 1'b1 : Min_we_ram;
  assign out1 = M_Rdata_ram[BITSIZE_out1-1:0];
  assign Mout_Wdata_ram = int_sel_STORE ? in1 : Min_Wdata_ram;
  assign Mout_data_ram_size = int_sel_STORE || int_sel_LOAD ? in3[BITSIZE_in3-1:0] : Min_data_ram_size;
  assign int_sel_LOAD = sel_LOAD & in4;
  assign int_sel_STORE = sel_STORE & in4;
  // Add assertion here
  // psl default clock = (posedge clock);
  // psl ERROR_LOAD_Min_oe_ram: assert never {sel_LOAD && Min_oe_ram};
  // psl ERROR_STORE_Min_we_ram: assert never {sel_STORE && Min_we_ram};
  // psl ERROR_STORE_LOAD: assert never {sel_STORE && sel_LOAD};
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module max_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  assign out1 = in1 > in2 ? in1 : in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module min_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output signed [BITSIZE_out1-1:0] out1;
  assign out1 = in1 < in2 ? in1 : in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_bit_ior_expr_FU(in1,
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
  assign out1 = in1 | in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
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
// Copyright (C) 2004-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_lshift_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1,
    PRECISION=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  `ifndef _SIM_HAVE_CLOG2
    function integer log2;
       input integer value;
       integer temp_value;
      begin
        temp_value = value-1;
        for (log2=0; temp_value>0; log2=log2+1)
          temp_value = temp_value>>1;
      end
    endfunction
  `endif
  `ifdef _SIM_HAVE_CLOG2
    parameter arg2_bitsize = $clog2(PRECISION);
  `else
    parameter arg2_bitsize = log2(PRECISION);
  `endif
  generate
    if(BITSIZE_in2 > arg2_bitsize)
      assign out1 = in1 << in2[arg2_bitsize-1:0];
    else
      assign out1 = in1 << in2;
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
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
// Copyright (C) 2004-2023 Politecnico di Milano
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

// Datapath RTL description for min_max
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module datapath_min_max(clock,
  reset,
  in_port_Pd5,
  in_port_Pd6,
  return_port,
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
  fuselector_BMEMORY_CTRL_20_i0_LOAD,
  fuselector_BMEMORY_CTRL_20_i0_STORE,
  selector_MUX_23_reg_1_0_0_0,
  selector_MUX_24_reg_2_0_0_0,
  selector_MUX_25_reg_3_0_0_0,
  selector_MUX_29_reg_7_0_0_0,
  selector_MUX_30_reg_8_0_0_0,
  wrenable_reg_0,
  wrenable_reg_1,
  wrenable_reg_2,
  wrenable_reg_3,
  wrenable_reg_4,
  wrenable_reg_5,
  wrenable_reg_6,
  wrenable_reg_7,
  wrenable_reg_8,
  OUT_CONDITION_min_max_423516_423545,
  OUT_CONDITION_min_max_423516_423617);
  // IN
  input clock;
  input reset;
  input [31:0] in_port_Pd5;
  input [31:0] in_port_Pd6;
  input [31:0] M_Rdata_ram;
  input M_DataRdy;
  input Min_oe_ram;
  input Min_we_ram;
  input [31:0] Min_addr_ram;
  input [31:0] Min_Wdata_ram;
  input [5:0] Min_data_ram_size;
  input fuselector_BMEMORY_CTRL_20_i0_LOAD;
  input fuselector_BMEMORY_CTRL_20_i0_STORE;
  input selector_MUX_23_reg_1_0_0_0;
  input selector_MUX_24_reg_2_0_0_0;
  input selector_MUX_25_reg_3_0_0_0;
  input selector_MUX_29_reg_7_0_0_0;
  input selector_MUX_30_reg_8_0_0_0;
  input wrenable_reg_0;
  input wrenable_reg_1;
  input wrenable_reg_2;
  input wrenable_reg_3;
  input wrenable_reg_4;
  input wrenable_reg_5;
  input wrenable_reg_6;
  input wrenable_reg_7;
  input wrenable_reg_8;
  // OUT
  output [63:0] return_port;
  output Mout_oe_ram;
  output Mout_we_ram;
  output [31:0] Mout_addr_ram;
  output [31:0] Mout_Wdata_ram;
  output [5:0] Mout_data_ram_size;
  output OUT_CONDITION_min_max_423516_423545;
  output OUT_CONDITION_min_max_423516_423617;
  // Component and signal declarations
  wire [31:0] out_BMEMORY_CTRL_20_i0_BMEMORY_CTRL_20_i0;
  wire [31:0] out_IUdata_converter_FU_15_i0_fu_min_max_423516_423664;
  wire [31:0] out_IUdata_converter_FU_16_i0_fu_min_max_423516_423667;
  wire [31:0] out_IUdata_converter_FU_17_i0_fu_min_max_423516_423670;
  wire [31:0] out_IUdata_converter_FU_18_i0_fu_min_max_423516_423673;
  wire [31:0] out_MUX_23_reg_1_0_0_0;
  wire [31:0] out_MUX_24_reg_2_0_0_0;
  wire [31:0] out_MUX_25_reg_3_0_0_0;
  wire [31:0] out_MUX_29_reg_7_0_0_0;
  wire [31:0] out_MUX_30_reg_8_0_0_0;
  wire signed [31:0] out_UIdata_converter_FU_11_i0_fu_min_max_423516_423695;
  wire signed [31:0] out_UIdata_converter_FU_12_i0_fu_min_max_423516_423697;
  wire signed [31:0] out_UIdata_converter_FU_13_i0_fu_min_max_423516_423700;
  wire signed [31:0] out_UIdata_converter_FU_14_i0_fu_min_max_423516_423702;
  wire [31:0] out_UUdata_converter_FU_6_i0_fu_min_max_423516_423565;
  wire [31:0] out_UUdata_converter_FU_7_i0_fu_min_max_423516_423567;
  wire out_const_0;
  wire [6:0] out_const_1;
  wire out_const_2;
  wire [1:0] out_const_3;
  wire [2:0] out_const_4;
  wire [5:0] out_const_5;
  wire [31:0] out_const_6;
  wire [30:0] out_const_7;
  wire [5:0] out_conv_out_const_1_7_6;
  wire [31:0] out_conv_out_const_7_31_32;
  wire signed [31:0] out_max_expr_FU_32_32_32_21_i0_fu_min_max_423516_423599;
  wire signed [31:0] out_min_expr_FU_32_32_32_22_i0_fu_min_max_423516_423575;
  wire out_read_cond_FU_19_i0_fu_min_max_423516_423617;
  wire out_read_cond_FU_2_i0_fu_min_max_423516_423545;
  wire [31:0] out_reg_0_reg_0;
  wire [31:0] out_reg_1_reg_1;
  wire [31:0] out_reg_2_reg_2;
  wire [31:0] out_reg_3_reg_3;
  wire [31:0] out_reg_4_reg_4;
  wire [31:0] out_reg_5_reg_5;
  wire out_reg_6_reg_6;
  wire [31:0] out_reg_7_reg_7;
  wire [31:0] out_reg_8_reg_8;
  wire [63:0] out_ui_bit_ior_expr_FU_0_64_64_23_i0_fu_min_max_423516_423568;
  wire out_ui_eq_expr_FU_32_0_32_24_i0_fu_min_max_423516_423684;
  wire out_ui_eq_expr_FU_32_32_32_25_i0_fu_min_max_423516_423704;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_26_i0_fu_min_max_423516_423675;
  wire [63:0] out_ui_lshift_expr_FU_64_0_64_27_i0_fu_min_max_423516_423566;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_0_32_28_i0_fu_min_max_423516_423590;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_29_i0_fu_min_max_423516_423542;
  wire [31:0] out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0;
  wire [31:0] sig_out_bus_mergerMout_Wdata_ram0_;
  wire [31:0] sig_out_bus_mergerMout_addr_ram1_;
  wire [5:0] sig_out_bus_mergerMout_data_ram_size2_;
  wire sig_out_bus_mergerMout_oe_ram3_;
  wire sig_out_bus_mergerMout_we_ram4_;
  
  BMEMORY_CTRL #(.BITSIZE_in1(1),
    .BITSIZE_in2(32),
    .BITSIZE_in3(6),
    .BITSIZE_out1(32),
    .BITSIZE_Min_addr_ram(32),
    .BITSIZE_Mout_addr_ram(32),
    .BITSIZE_M_Rdata_ram(32),
    .BITSIZE_Min_Wdata_ram(32),
    .BITSIZE_Mout_Wdata_ram(32),
    .BITSIZE_Min_data_ram_size(6),
    .BITSIZE_Mout_data_ram_size(6)) BMEMORY_CTRL_20_i0 (.out1(out_BMEMORY_CTRL_20_i0_BMEMORY_CTRL_20_i0),
    .Mout_oe_ram(sig_out_bus_mergerMout_oe_ram3_),
    .Mout_we_ram(sig_out_bus_mergerMout_we_ram4_),
    .Mout_addr_ram(sig_out_bus_mergerMout_addr_ram1_),
    .Mout_Wdata_ram(sig_out_bus_mergerMout_Wdata_ram0_),
    .Mout_data_ram_size(sig_out_bus_mergerMout_data_ram_size2_),
    .clock(clock),
    .in1(1'b0),
    .in2(out_reg_1_reg_1),
    .in3(out_conv_out_const_1_7_6),
    .in4(out_const_2),
    .sel_LOAD(fuselector_BMEMORY_CTRL_20_i0_LOAD),
    .sel_STORE(fuselector_BMEMORY_CTRL_20_i0_STORE),
    .Min_oe_ram(Min_oe_ram),
    .Min_we_ram(Min_we_ram),
    .Min_addr_ram(Min_addr_ram),
    .M_Rdata_ram(M_Rdata_ram),
    .Min_Wdata_ram(Min_Wdata_ram),
    .Min_data_ram_size(Min_data_ram_size),
    .M_DataRdy(M_DataRdy));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_23_reg_1_0_0_0 (.out1(out_MUX_23_reg_1_0_0_0),
    .sel(selector_MUX_23_reg_1_0_0_0),
    .in1(in_port_Pd5),
    .in2(out_ui_pointer_plus_expr_FU_32_0_32_28_i0_fu_min_max_423516_423590));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_24_reg_2_0_0_0 (.out1(out_MUX_24_reg_2_0_0_0),
    .sel(selector_MUX_24_reg_2_0_0_0),
    .in1(out_IUdata_converter_FU_18_i0_fu_min_max_423516_423673),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_25_reg_3_0_0_0 (.out1(out_MUX_25_reg_3_0_0_0),
    .sel(selector_MUX_25_reg_3_0_0_0),
    .in1(out_const_6),
    .in2(out_IUdata_converter_FU_17_i0_fu_min_max_423516_423670));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_29_reg_7_0_0_0 (.out1(out_MUX_29_reg_7_0_0_0),
    .sel(selector_MUX_29_reg_7_0_0_0),
    .in1(out_IUdata_converter_FU_15_i0_fu_min_max_423516_423664),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_30_reg_8_0_0_0 (.out1(out_MUX_30_reg_8_0_0_0),
    .sel(selector_MUX_30_reg_8_0_0_0),
    .in1(out_const_6),
    .in2(out_IUdata_converter_FU_16_i0_fu_min_max_423516_423667));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_0 (.out1(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0),
    .in1(out_conv_out_const_7_31_32));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b0)) const_0 (.out1(out_const_0));
  constant_value #(.BITSIZE_out1(7),
    .value(7'b0100000)) const_1 (.out1(out_const_1));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b1)) const_2 (.out1(out_const_2));
  constant_value #(.BITSIZE_out1(2),
    .value(2'b10)) const_3 (.out1(out_const_3));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b100)) const_4 (.out1(out_const_4));
  constant_value #(.BITSIZE_out1(6),
    .value(6'b100000)) const_5 (.out1(out_const_5));
  constant_value #(.BITSIZE_out1(32),
    .value(32'b10000000000000000000000000000000)) const_6 (.out1(out_const_6));
  constant_value #(.BITSIZE_out1(31),
    .value(31'b1111111111111111111111111111111)) const_7 (.out1(out_const_7));
  UUdata_converter_FU #(.BITSIZE_in1(7),
    .BITSIZE_out1(6)) conv_out_const_1_7_6 (.out1(out_conv_out_const_1_7_6),
    .in1(out_const_1));
  UUdata_converter_FU #(.BITSIZE_in1(31),
    .BITSIZE_out1(32)) conv_out_const_7_31_32 (.out1(out_conv_out_const_7_31_32),
    .in1(out_const_7));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_min_max_423516_423542 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_29_i0_fu_min_max_423516_423542),
    .in1(in_port_Pd5),
    .in2(out_ui_lshift_expr_FU_32_0_32_26_i0_fu_min_max_423516_423675));
  read_cond_FU #(.BITSIZE_in1(1)) fu_min_max_423516_423545 (.out1(out_read_cond_FU_2_i0_fu_min_max_423516_423545),
    .in1(out_ui_eq_expr_FU_32_0_32_24_i0_fu_min_max_423516_423684));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423565 (.out1(out_UUdata_converter_FU_6_i0_fu_min_max_423516_423565),
    .in1(out_reg_7_reg_7));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(6),
    .BITSIZE_out1(64),
    .PRECISION(64)) fu_min_max_423516_423566 (.out1(out_ui_lshift_expr_FU_64_0_64_27_i0_fu_min_max_423516_423566),
    .in1(out_UUdata_converter_FU_6_i0_fu_min_max_423516_423565),
    .in2(out_const_5));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423567 (.out1(out_UUdata_converter_FU_7_i0_fu_min_max_423516_423567),
    .in1(out_reg_8_reg_8));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(32),
    .BITSIZE_out1(64)) fu_min_max_423516_423568 (.out1(out_ui_bit_ior_expr_FU_0_64_64_23_i0_fu_min_max_423516_423568),
    .in1(out_ui_lshift_expr_FU_64_0_64_27_i0_fu_min_max_423516_423566),
    .in2(out_UUdata_converter_FU_7_i0_fu_min_max_423516_423567));
  min_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423575 (.out1(out_min_expr_FU_32_32_32_22_i0_fu_min_max_423516_423575),
    .in1(out_UIdata_converter_FU_13_i0_fu_min_max_423516_423700),
    .in2(out_reg_5_reg_5));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_min_max_423516_423590 (.out1(out_ui_pointer_plus_expr_FU_32_0_32_28_i0_fu_min_max_423516_423590),
    .in1(out_reg_1_reg_1),
    .in2(out_const_4));
  max_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423599 (.out1(out_max_expr_FU_32_32_32_21_i0_fu_min_max_423516_423599),
    .in1(out_UIdata_converter_FU_11_i0_fu_min_max_423516_423695),
    .in2(out_reg_4_reg_4));
  read_cond_FU #(.BITSIZE_in1(1)) fu_min_max_423516_423617 (.out1(out_read_cond_FU_19_i0_fu_min_max_423516_423617),
    .in1(out_reg_6_reg_6));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423664 (.out1(out_IUdata_converter_FU_15_i0_fu_min_max_423516_423664),
    .in1(out_min_expr_FU_32_32_32_22_i0_fu_min_max_423516_423575));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423667 (.out1(out_IUdata_converter_FU_16_i0_fu_min_max_423516_423667),
    .in1(out_max_expr_FU_32_32_32_21_i0_fu_min_max_423516_423599));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423670 (.out1(out_IUdata_converter_FU_17_i0_fu_min_max_423516_423670),
    .in1(out_max_expr_FU_32_32_32_21_i0_fu_min_max_423516_423599));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423673 (.out1(out_IUdata_converter_FU_18_i0_fu_min_max_423516_423673),
    .in1(out_min_expr_FU_32_32_32_22_i0_fu_min_max_423516_423575));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_min_max_423516_423675 (.out1(out_ui_lshift_expr_FU_32_0_32_26_i0_fu_min_max_423516_423675),
    .in1(in_port_Pd6),
    .in2(out_const_3));
  ui_eq_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_min_max_423516_423684 (.out1(out_ui_eq_expr_FU_32_0_32_24_i0_fu_min_max_423516_423684),
    .in1(in_port_Pd6),
    .in2(out_const_0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423695 (.out1(out_UIdata_converter_FU_11_i0_fu_min_max_423516_423695),
    .in1(out_BMEMORY_CTRL_20_i0_BMEMORY_CTRL_20_i0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423697 (.out1(out_UIdata_converter_FU_12_i0_fu_min_max_423516_423697),
    .in1(out_reg_3_reg_3));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423700 (.out1(out_UIdata_converter_FU_13_i0_fu_min_max_423516_423700),
    .in1(out_BMEMORY_CTRL_20_i0_BMEMORY_CTRL_20_i0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423702 (.out1(out_UIdata_converter_FU_14_i0_fu_min_max_423516_423702),
    .in1(out_reg_2_reg_2));
  ui_eq_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(1)) fu_min_max_423516_423704 (.out1(out_ui_eq_expr_FU_32_32_32_25_i0_fu_min_max_423516_423704),
    .in1(out_ui_pointer_plus_expr_FU_32_0_32_28_i0_fu_min_max_423516_423590),
    .in2(out_reg_0_reg_0));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_0 (.out1(out_reg_0_reg_0),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_29_i0_fu_min_max_423516_423542),
    .wenable(wrenable_reg_0));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_1 (.out1(out_reg_1_reg_1),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_23_reg_1_0_0_0),
    .wenable(wrenable_reg_1));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_2 (.out1(out_reg_2_reg_2),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_24_reg_2_0_0_0),
    .wenable(wrenable_reg_2));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_3 (.out1(out_reg_3_reg_3),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_25_reg_3_0_0_0),
    .wenable(wrenable_reg_3));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_4 (.out1(out_reg_4_reg_4),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_12_i0_fu_min_max_423516_423697),
    .wenable(wrenable_reg_4));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_5 (.out1(out_reg_5_reg_5),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_14_i0_fu_min_max_423516_423702),
    .wenable(wrenable_reg_5));
  register_STD #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_6 (.out1(out_reg_6_reg_6),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_eq_expr_FU_32_32_32_25_i0_fu_min_max_423516_423704),
    .wenable(wrenable_reg_6));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_7 (.out1(out_reg_7_reg_7),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_29_reg_7_0_0_0),
    .wenable(wrenable_reg_7));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_8 (.out1(out_reg_8_reg_8),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_30_reg_8_0_0_0),
    .wenable(wrenable_reg_8));
  // io-signal post fix
  assign return_port = out_ui_bit_ior_expr_FU_0_64_64_23_i0_fu_min_max_423516_423568;
  assign Mout_oe_ram = sig_out_bus_mergerMout_oe_ram3_;
  assign Mout_we_ram = sig_out_bus_mergerMout_we_ram4_;
  assign Mout_addr_ram = sig_out_bus_mergerMout_addr_ram1_;
  assign Mout_Wdata_ram = sig_out_bus_mergerMout_Wdata_ram0_;
  assign Mout_data_ram_size = sig_out_bus_mergerMout_data_ram_size2_;
  assign OUT_CONDITION_min_max_423516_423545 = out_read_cond_FU_2_i0_fu_min_max_423516_423545;
  assign OUT_CONDITION_min_max_423516_423617 = out_read_cond_FU_19_i0_fu_min_max_423516_423617;

endmodule

// FSM based controller description for min_max
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module controller_min_max(done_port,
  fuselector_BMEMORY_CTRL_20_i0_LOAD,
  fuselector_BMEMORY_CTRL_20_i0_STORE,
  selector_MUX_23_reg_1_0_0_0,
  selector_MUX_24_reg_2_0_0_0,
  selector_MUX_25_reg_3_0_0_0,
  selector_MUX_29_reg_7_0_0_0,
  selector_MUX_30_reg_8_0_0_0,
  wrenable_reg_0,
  wrenable_reg_1,
  wrenable_reg_2,
  wrenable_reg_3,
  wrenable_reg_4,
  wrenable_reg_5,
  wrenable_reg_6,
  wrenable_reg_7,
  wrenable_reg_8,
  OUT_CONDITION_min_max_423516_423545,
  OUT_CONDITION_min_max_423516_423617,
  clock,
  reset,
  start_port);
  // IN
  input OUT_CONDITION_min_max_423516_423545;
  input OUT_CONDITION_min_max_423516_423617;
  input clock;
  input reset;
  input start_port;
  // OUT
  output done_port;
  output fuselector_BMEMORY_CTRL_20_i0_LOAD;
  output fuselector_BMEMORY_CTRL_20_i0_STORE;
  output selector_MUX_23_reg_1_0_0_0;
  output selector_MUX_24_reg_2_0_0_0;
  output selector_MUX_25_reg_3_0_0_0;
  output selector_MUX_29_reg_7_0_0_0;
  output selector_MUX_30_reg_8_0_0_0;
  output wrenable_reg_0;
  output wrenable_reg_1;
  output wrenable_reg_2;
  output wrenable_reg_3;
  output wrenable_reg_4;
  output wrenable_reg_5;
  output wrenable_reg_6;
  output wrenable_reg_7;
  output wrenable_reg_8;
  parameter [3:0] S_0 = 4'b0001,
    S_2 = 4'b0100,
    S_3 = 4'b1000,
    S_1 = 4'b0010;
  reg [3:0] _present_state=S_0, _next_state;
  reg done_port;
  reg fuselector_BMEMORY_CTRL_20_i0_LOAD;
  reg fuselector_BMEMORY_CTRL_20_i0_STORE;
  reg selector_MUX_23_reg_1_0_0_0;
  reg selector_MUX_24_reg_2_0_0_0;
  reg selector_MUX_25_reg_3_0_0_0;
  reg selector_MUX_29_reg_7_0_0_0;
  reg selector_MUX_30_reg_8_0_0_0;
  reg wrenable_reg_0;
  reg wrenable_reg_1;
  reg wrenable_reg_2;
  reg wrenable_reg_3;
  reg wrenable_reg_4;
  reg wrenable_reg_5;
  reg wrenable_reg_6;
  reg wrenable_reg_7;
  reg wrenable_reg_8;
  
  always @(posedge clock)
    if (reset == 1'b0) _present_state <= S_0;
    else _present_state <= _next_state;
  
  always @(*)
  begin
    done_port = 1'b0;
    fuselector_BMEMORY_CTRL_20_i0_LOAD = 1'b0;
    fuselector_BMEMORY_CTRL_20_i0_STORE = 1'b0;
    selector_MUX_23_reg_1_0_0_0 = 1'b0;
    selector_MUX_24_reg_2_0_0_0 = 1'b0;
    selector_MUX_25_reg_3_0_0_0 = 1'b0;
    selector_MUX_29_reg_7_0_0_0 = 1'b0;
    selector_MUX_30_reg_8_0_0_0 = 1'b0;
    wrenable_reg_0 = 1'b0;
    wrenable_reg_1 = 1'b0;
    wrenable_reg_2 = 1'b0;
    wrenable_reg_3 = 1'b0;
    wrenable_reg_4 = 1'b0;
    wrenable_reg_5 = 1'b0;
    wrenable_reg_6 = 1'b0;
    wrenable_reg_7 = 1'b0;
    wrenable_reg_8 = 1'b0;
    case (_present_state)
      S_0 :
        if(start_port == 1'b1)
        begin
          selector_MUX_23_reg_1_0_0_0 = 1'b1;
          selector_MUX_25_reg_3_0_0_0 = 1'b1;
          selector_MUX_30_reg_8_0_0_0 = 1'b1;
          wrenable_reg_0 = 1'b1;
          wrenable_reg_1 = 1'b1;
          wrenable_reg_2 = 1'b1;
          wrenable_reg_3 = 1'b1;
          wrenable_reg_7 = 1'b1;
          wrenable_reg_8 = 1'b1;
          if (OUT_CONDITION_min_max_423516_423545 == 1'b1)
            begin
              _next_state = S_1;
              done_port = 1'b1;
              selector_MUX_23_reg_1_0_0_0 = 1'b0;
              selector_MUX_25_reg_3_0_0_0 = 1'b0;
              wrenable_reg_0 = 1'b0;
              wrenable_reg_1 = 1'b0;
              wrenable_reg_2 = 1'b0;
              wrenable_reg_3 = 1'b0;
            end
          else
            begin
              _next_state = S_2;
              selector_MUX_30_reg_8_0_0_0 = 1'b0;
              wrenable_reg_7 = 1'b0;
              wrenable_reg_8 = 1'b0;
            end
        end
        else
        begin
          _next_state = S_0;
        end
      S_2 :
        begin
          fuselector_BMEMORY_CTRL_20_i0_LOAD = 1'b1;
          wrenable_reg_1 = 1'b1;
          wrenable_reg_4 = 1'b1;
          wrenable_reg_5 = 1'b1;
          wrenable_reg_6 = 1'b1;
          _next_state = S_3;
        end
      S_3 :
        begin
          selector_MUX_24_reg_2_0_0_0 = 1'b1;
          selector_MUX_29_reg_7_0_0_0 = 1'b1;
          wrenable_reg_2 = 1'b1;
          wrenable_reg_3 = 1'b1;
          wrenable_reg_7 = 1'b1;
          wrenable_reg_8 = 1'b1;
          if (OUT_CONDITION_min_max_423516_423617 == 1'b1)
            begin
              _next_state = S_1;
              done_port = 1'b1;
              selector_MUX_24_reg_2_0_0_0 = 1'b0;
              wrenable_reg_2 = 1'b0;
              wrenable_reg_3 = 1'b0;
            end
          else
            begin
              _next_state = S_2;
              selector_MUX_29_reg_7_0_0_0 = 1'b0;
              wrenable_reg_7 = 1'b0;
              wrenable_reg_8 = 1'b0;
            end
        end
      S_1 :
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
// Copyright (C) 2004-2023 Politecnico di Milano
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

// Top component for min_max
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module _min_max(clock,
  reset,
  start_port,
  done_port,
  Pd5,
  Pd6,
  return_port,
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
  input [31:0] Pd5;
  input [31:0] Pd6;
  input [31:0] M_Rdata_ram;
  input M_DataRdy;
  input Min_oe_ram;
  input Min_we_ram;
  input [31:0] Min_addr_ram;
  input [31:0] Min_Wdata_ram;
  input [5:0] Min_data_ram_size;
  // OUT
  output done_port;
  output [63:0] return_port;
  output Mout_oe_ram;
  output Mout_we_ram;
  output [31:0] Mout_addr_ram;
  output [31:0] Mout_Wdata_ram;
  output [5:0] Mout_data_ram_size;
  // Component and signal declarations
  wire OUT_CONDITION_min_max_423516_423545;
  wire OUT_CONDITION_min_max_423516_423617;
  wire done_delayed_REG_signal_in;
  wire done_delayed_REG_signal_out;
  wire fuselector_BMEMORY_CTRL_20_i0_LOAD;
  wire fuselector_BMEMORY_CTRL_20_i0_STORE;
  wire selector_MUX_23_reg_1_0_0_0;
  wire selector_MUX_24_reg_2_0_0_0;
  wire selector_MUX_25_reg_3_0_0_0;
  wire selector_MUX_29_reg_7_0_0_0;
  wire selector_MUX_30_reg_8_0_0_0;
  wire wrenable_reg_0;
  wire wrenable_reg_1;
  wire wrenable_reg_2;
  wire wrenable_reg_3;
  wire wrenable_reg_4;
  wire wrenable_reg_5;
  wire wrenable_reg_6;
  wire wrenable_reg_7;
  wire wrenable_reg_8;
  
  controller_min_max Controller_i (.done_port(done_delayed_REG_signal_in),
    .fuselector_BMEMORY_CTRL_20_i0_LOAD(fuselector_BMEMORY_CTRL_20_i0_LOAD),
    .fuselector_BMEMORY_CTRL_20_i0_STORE(fuselector_BMEMORY_CTRL_20_i0_STORE),
    .selector_MUX_23_reg_1_0_0_0(selector_MUX_23_reg_1_0_0_0),
    .selector_MUX_24_reg_2_0_0_0(selector_MUX_24_reg_2_0_0_0),
    .selector_MUX_25_reg_3_0_0_0(selector_MUX_25_reg_3_0_0_0),
    .selector_MUX_29_reg_7_0_0_0(selector_MUX_29_reg_7_0_0_0),
    .selector_MUX_30_reg_8_0_0_0(selector_MUX_30_reg_8_0_0_0),
    .wrenable_reg_0(wrenable_reg_0),
    .wrenable_reg_1(wrenable_reg_1),
    .wrenable_reg_2(wrenable_reg_2),
    .wrenable_reg_3(wrenable_reg_3),
    .wrenable_reg_4(wrenable_reg_4),
    .wrenable_reg_5(wrenable_reg_5),
    .wrenable_reg_6(wrenable_reg_6),
    .wrenable_reg_7(wrenable_reg_7),
    .wrenable_reg_8(wrenable_reg_8),
    .OUT_CONDITION_min_max_423516_423545(OUT_CONDITION_min_max_423516_423545),
    .OUT_CONDITION_min_max_423516_423617(OUT_CONDITION_min_max_423516_423617),
    .clock(clock),
    .reset(reset),
    .start_port(start_port));
  datapath_min_max Datapath_i (.return_port(return_port),
    .Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .OUT_CONDITION_min_max_423516_423545(OUT_CONDITION_min_max_423516_423545),
    .OUT_CONDITION_min_max_423516_423617(OUT_CONDITION_min_max_423516_423617),
    .clock(clock),
    .reset(reset),
    .in_port_Pd5(Pd5),
    .in_port_Pd6(Pd6),
    .M_Rdata_ram(M_Rdata_ram),
    .M_DataRdy(M_DataRdy),
    .Min_oe_ram(Min_oe_ram),
    .Min_we_ram(Min_we_ram),
    .Min_addr_ram(Min_addr_ram),
    .Min_Wdata_ram(Min_Wdata_ram),
    .Min_data_ram_size(Min_data_ram_size),
    .fuselector_BMEMORY_CTRL_20_i0_LOAD(fuselector_BMEMORY_CTRL_20_i0_LOAD),
    .fuselector_BMEMORY_CTRL_20_i0_STORE(fuselector_BMEMORY_CTRL_20_i0_STORE),
    .selector_MUX_23_reg_1_0_0_0(selector_MUX_23_reg_1_0_0_0),
    .selector_MUX_24_reg_2_0_0_0(selector_MUX_24_reg_2_0_0_0),
    .selector_MUX_25_reg_3_0_0_0(selector_MUX_25_reg_3_0_0_0),
    .selector_MUX_29_reg_7_0_0_0(selector_MUX_29_reg_7_0_0_0),
    .selector_MUX_30_reg_8_0_0_0(selector_MUX_30_reg_8_0_0_0),
    .wrenable_reg_0(wrenable_reg_0),
    .wrenable_reg_1(wrenable_reg_1),
    .wrenable_reg_2(wrenable_reg_2),
    .wrenable_reg_3(wrenable_reg_3),
    .wrenable_reg_4(wrenable_reg_4),
    .wrenable_reg_5(wrenable_reg_5),
    .wrenable_reg_6(wrenable_reg_6),
    .wrenable_reg_7(wrenable_reg_7),
    .wrenable_reg_8(wrenable_reg_8));
  flipflop_AR #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) done_delayed_REG (.out1(done_delayed_REG_signal_out),
    .clock(clock),
    .reset(reset),
    .in1(done_delayed_REG_signal_in));
  // io-signal post fix
  assign done_port = done_delayed_REG_signal_out;

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
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

// Minimal interface for function: min_max
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module min_max(clk,
  reset,
  start_port,
  Pd5,
  Pd6,
  M_Rdata_ram,
  M_DataRdy,
  done_port,
  return_port,
  Mout_oe_ram,
  Mout_we_ram,
  Mout_addr_ram,
  Mout_Wdata_ram,
  Mout_data_ram_size);
  // IN
  input clk;
  input reset;
  input start_port;
  input [31:0] Pd5;
  input [31:0] Pd6;
  input [31:0] M_Rdata_ram;
  input M_DataRdy;
  // OUT
  output done_port;
  output [63:0] return_port;
  output Mout_oe_ram;
  output Mout_we_ram;
  output [31:0] Mout_addr_ram;
  output [31:0] Mout_Wdata_ram;
  output [5:0] Mout_data_ram_size;
  // Component and signal declarations
  wire [63:0] out_return_port_ui_view_convert_expr_FU;
  
  _min_max _min_max_i0 (.done_port(done_port),
    .return_port(out_return_port_ui_view_convert_expr_FU),
    .Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .clock(clk),
    .reset(reset),
    .start_port(start_port),
    .Pd5(Pd5),
    .Pd6(Pd6),
    .M_Rdata_ram(M_Rdata_ram),
    .M_DataRdy(M_DataRdy),
    .Min_oe_ram(1'b0),
    .Min_we_ram(1'b0),
    .Min_addr_ram(32'b00000000000000000000000000000000),
    .Min_Wdata_ram(32'b00000000000000000000000000000000),
    .Min_data_ram_size(6'b000000));
  ui_view_convert_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(64)) return_port_ui_view_convert_expr_FU (.out1(return_port),
    .in1(out_return_port_ui_view_convert_expr_FU));

endmodule


