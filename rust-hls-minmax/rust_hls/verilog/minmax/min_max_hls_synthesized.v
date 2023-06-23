// 
// Politecnico di Milano
// Code created using PandA - Version: PandA 2023.2 - Revision 891ec3caed502474cab0813cc4a9fc678deabaa5 - Date 2023-06-22T16:05:56
// /nix/store/9c5lz0md936sjhs9hw1ya6kghvkfc4zg-bambu-wrapped/bin/bambu executed with: /nix/store/9c5lz0md936sjhs9hw1ya6kghvkfc4zg-bambu-wrapped/bin/bambu --simulator=VERILATOR --top-fname=min_max --clock-name=clk --compiler=I386_CLANG16 -Os --channels-type=MEM_ACC_11 --channels-number=1 min_max.ll 
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
// Copyright (C) 2020-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_extract_bit_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  // OUT
  output out1;
  assign out1 = (in1 >> in2)&1;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2016-2023 Politecnico di Milano
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
module ui_plus_expr_FU(in1,
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
  assign out1 = in1 + in2;
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
  in_port_Pd7,
  in_port_Pd8,
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
  fuselector_BMEMORY_CTRL_59_i0_LOAD,
  fuselector_BMEMORY_CTRL_59_i0_STORE,
  selector_MUX_0_BMEMORY_CTRL_59_i0_0_0_0,
  selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_0,
  selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_1,
  selector_MUX_1_BMEMORY_CTRL_59_i0_1_1_0,
  selector_MUX_69_reg_2_0_0_0,
  selector_MUX_70_reg_3_0_0_0,
  selector_MUX_71_reg_4_0_0_0,
  selector_MUX_75_reg_8_0_0_0,
  selector_MUX_76_reg_9_0_0_0,
  wrenable_reg_0,
  wrenable_reg_1,
  wrenable_reg_2,
  wrenable_reg_3,
  wrenable_reg_4,
  wrenable_reg_5,
  wrenable_reg_6,
  wrenable_reg_7,
  wrenable_reg_8,
  wrenable_reg_9,
  OUT_CONDITION_min_max_423516_423551,
  OUT_CONDITION_min_max_423516_423626);
  // IN
  input clock;
  input reset;
  input [31:0] in_port_Pd5;
  input [31:0] in_port_Pd6;
  input [31:0] in_port_Pd7;
  input [31:0] in_port_Pd8;
  input [31:0] M_Rdata_ram;
  input M_DataRdy;
  input Min_oe_ram;
  input Min_we_ram;
  input [31:0] Min_addr_ram;
  input [31:0] Min_Wdata_ram;
  input [5:0] Min_data_ram_size;
  input fuselector_BMEMORY_CTRL_59_i0_LOAD;
  input fuselector_BMEMORY_CTRL_59_i0_STORE;
  input selector_MUX_0_BMEMORY_CTRL_59_i0_0_0_0;
  input selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_0;
  input selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_1;
  input selector_MUX_1_BMEMORY_CTRL_59_i0_1_1_0;
  input selector_MUX_69_reg_2_0_0_0;
  input selector_MUX_70_reg_3_0_0_0;
  input selector_MUX_71_reg_4_0_0_0;
  input selector_MUX_75_reg_8_0_0_0;
  input selector_MUX_76_reg_9_0_0_0;
  input wrenable_reg_0;
  input wrenable_reg_1;
  input wrenable_reg_2;
  input wrenable_reg_3;
  input wrenable_reg_4;
  input wrenable_reg_5;
  input wrenable_reg_6;
  input wrenable_reg_7;
  input wrenable_reg_8;
  input wrenable_reg_9;
  // OUT
  output Mout_oe_ram;
  output Mout_we_ram;
  output [31:0] Mout_addr_ram;
  output [31:0] Mout_Wdata_ram;
  output [5:0] Mout_data_ram_size;
  output OUT_CONDITION_min_max_423516_423551;
  output OUT_CONDITION_min_max_423516_423626;
  // Component and signal declarations
  wire [31:0] out_BMEMORY_CTRL_59_i0_BMEMORY_CTRL_59_i0;
  wire [31:0] out_IUdata_converter_FU_54_i0_fu_min_max_423516_423672;
  wire [31:0] out_IUdata_converter_FU_55_i0_fu_min_max_423516_423675;
  wire [31:0] out_IUdata_converter_FU_56_i0_fu_min_max_423516_423678;
  wire [31:0] out_IUdata_converter_FU_57_i0_fu_min_max_423516_423681;
  wire [31:0] out_MUX_0_BMEMORY_CTRL_59_i0_0_0_0;
  wire [31:0] out_MUX_1_BMEMORY_CTRL_59_i0_1_0_0;
  wire [31:0] out_MUX_1_BMEMORY_CTRL_59_i0_1_0_1;
  wire [31:0] out_MUX_1_BMEMORY_CTRL_59_i0_1_1_0;
  wire [63:0] out_MUX_69_reg_2_0_0_0;
  wire [31:0] out_MUX_70_reg_3_0_0_0;
  wire [31:0] out_MUX_71_reg_4_0_0_0;
  wire [31:0] out_MUX_75_reg_8_0_0_0;
  wire [31:0] out_MUX_76_reg_9_0_0_0;
  wire signed [31:0] out_UIdata_converter_FU_50_i0_fu_min_max_423516_423701;
  wire signed [31:0] out_UIdata_converter_FU_51_i0_fu_min_max_423516_423703;
  wire signed [31:0] out_UIdata_converter_FU_52_i0_fu_min_max_423516_423706;
  wire signed [31:0] out_UIdata_converter_FU_53_i0_fu_min_max_423516_423708;
  wire [31:0] out_UUdata_converter_FU_41_i0_fu_min_max_423516_423571;
  wire [29:0] out_UUdata_converter_FU_49_i0_fu_min_max_423516_423597;
  wire out_const_0;
  wire [6:0] out_const_1;
  wire [4:0] out_const_10;
  wire [4:0] out_const_11;
  wire [2:0] out_const_12;
  wire [3:0] out_const_13;
  wire [4:0] out_const_14;
  wire [4:0] out_const_15;
  wire [3:0] out_const_16;
  wire [4:0] out_const_17;
  wire [4:0] out_const_18;
  wire [1:0] out_const_19;
  wire out_const_2;
  wire [2:0] out_const_20;
  wire [3:0] out_const_21;
  wire [4:0] out_const_22;
  wire [4:0] out_const_23;
  wire [3:0] out_const_24;
  wire [4:0] out_const_25;
  wire [4:0] out_const_26;
  wire [2:0] out_const_27;
  wire [3:0] out_const_28;
  wire [4:0] out_const_29;
  wire [1:0] out_const_3;
  wire [4:0] out_const_30;
  wire [3:0] out_const_31;
  wire [4:0] out_const_32;
  wire [4:0] out_const_33;
  wire [2:0] out_const_4;
  wire [3:0] out_const_5;
  wire [4:0] out_const_6;
  wire [32:0] out_const_7;
  wire [4:0] out_const_8;
  wire [3:0] out_const_9;
  wire [63:0] out_conv_out_const_0_1_64;
  wire [5:0] out_conv_out_const_1_7_6;
  wire out_lut_expr_FU_34_i0_fu_min_max_423516_424010;
  wire out_lut_expr_FU_35_i0_fu_min_max_423516_424013;
  wire out_lut_expr_FU_36_i0_fu_min_max_423516_424016;
  wire out_lut_expr_FU_37_i0_fu_min_max_423516_424019;
  wire out_lut_expr_FU_38_i0_fu_min_max_423516_424022;
  wire out_lut_expr_FU_39_i0_fu_min_max_423516_424025;
  wire out_lut_expr_FU_40_i0_fu_min_max_423516_423696;
  wire signed [31:0] out_max_expr_FU_32_32_32_60_i0_fu_min_max_423516_423610;
  wire signed [31:0] out_min_expr_FU_32_32_32_61_i0_fu_min_max_423516_423584;
  wire out_read_cond_FU_42_i0_fu_min_max_423516_423551;
  wire out_read_cond_FU_58_i0_fu_min_max_423516_423626;
  wire [31:0] out_reg_0_reg_0;
  wire out_reg_1_reg_1;
  wire [63:0] out_reg_2_reg_2;
  wire [31:0] out_reg_3_reg_3;
  wire [31:0] out_reg_4_reg_4;
  wire [31:0] out_reg_5_reg_5;
  wire [31:0] out_reg_6_reg_6;
  wire out_reg_7_reg_7;
  wire [31:0] out_reg_8_reg_8;
  wire [31:0] out_reg_9_reg_9;
  wire out_ui_eq_expr_FU_64_64_64_62_i0_fu_min_max_423516_423710;
  wire out_ui_extract_bit_expr_FU_10_i0_fu_min_max_423516_423914;
  wire out_ui_extract_bit_expr_FU_11_i0_fu_min_max_423516_423918;
  wire out_ui_extract_bit_expr_FU_12_i0_fu_min_max_423516_423922;
  wire out_ui_extract_bit_expr_FU_13_i0_fu_min_max_423516_423926;
  wire out_ui_extract_bit_expr_FU_14_i0_fu_min_max_423516_423930;
  wire out_ui_extract_bit_expr_FU_15_i0_fu_min_max_423516_423934;
  wire out_ui_extract_bit_expr_FU_16_i0_fu_min_max_423516_423938;
  wire out_ui_extract_bit_expr_FU_17_i0_fu_min_max_423516_423942;
  wire out_ui_extract_bit_expr_FU_18_i0_fu_min_max_423516_423946;
  wire out_ui_extract_bit_expr_FU_19_i0_fu_min_max_423516_423950;
  wire out_ui_extract_bit_expr_FU_20_i0_fu_min_max_423516_423954;
  wire out_ui_extract_bit_expr_FU_21_i0_fu_min_max_423516_423958;
  wire out_ui_extract_bit_expr_FU_22_i0_fu_min_max_423516_423962;
  wire out_ui_extract_bit_expr_FU_23_i0_fu_min_max_423516_423966;
  wire out_ui_extract_bit_expr_FU_24_i0_fu_min_max_423516_423970;
  wire out_ui_extract_bit_expr_FU_25_i0_fu_min_max_423516_423974;
  wire out_ui_extract_bit_expr_FU_26_i0_fu_min_max_423516_423978;
  wire out_ui_extract_bit_expr_FU_27_i0_fu_min_max_423516_423982;
  wire out_ui_extract_bit_expr_FU_28_i0_fu_min_max_423516_423986;
  wire out_ui_extract_bit_expr_FU_29_i0_fu_min_max_423516_423990;
  wire out_ui_extract_bit_expr_FU_2_i0_fu_min_max_423516_423882;
  wire out_ui_extract_bit_expr_FU_30_i0_fu_min_max_423516_423994;
  wire out_ui_extract_bit_expr_FU_31_i0_fu_min_max_423516_423998;
  wire out_ui_extract_bit_expr_FU_32_i0_fu_min_max_423516_424002;
  wire out_ui_extract_bit_expr_FU_33_i0_fu_min_max_423516_424006;
  wire out_ui_extract_bit_expr_FU_3_i0_fu_min_max_423516_423886;
  wire out_ui_extract_bit_expr_FU_4_i0_fu_min_max_423516_423890;
  wire out_ui_extract_bit_expr_FU_5_i0_fu_min_max_423516_423894;
  wire out_ui_extract_bit_expr_FU_6_i0_fu_min_max_423516_423898;
  wire out_ui_extract_bit_expr_FU_7_i0_fu_min_max_423516_423902;
  wire out_ui_extract_bit_expr_FU_8_i0_fu_min_max_423516_423906;
  wire out_ui_extract_bit_expr_FU_9_i0_fu_min_max_423516_423910;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_63_i0_fu_min_max_423516_423698;
  wire [63:0] out_ui_plus_expr_FU_64_0_64_64_i0_fu_min_max_423516_423602;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_65_i0_fu_min_max_423516_423592;
  wire [63:0] out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0;
  wire [31:0] out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1;
  wire [31:0] out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2;
  wire [31:0] sig_out_bus_mergerMout_Wdata_ram0_;
  wire [31:0] sig_out_bus_mergerMout_addr_ram1_;
  wire [5:0] sig_out_bus_mergerMout_data_ram_size2_;
  wire sig_out_bus_mergerMout_oe_ram3_;
  wire sig_out_bus_mergerMout_we_ram4_;
  
  BMEMORY_CTRL #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_in3(6),
    .BITSIZE_out1(32),
    .BITSIZE_Min_addr_ram(32),
    .BITSIZE_Mout_addr_ram(32),
    .BITSIZE_M_Rdata_ram(32),
    .BITSIZE_Min_Wdata_ram(32),
    .BITSIZE_Mout_Wdata_ram(32),
    .BITSIZE_Min_data_ram_size(6),
    .BITSIZE_Mout_data_ram_size(6)) BMEMORY_CTRL_59_i0 (.out1(out_BMEMORY_CTRL_59_i0_BMEMORY_CTRL_59_i0),
    .Mout_oe_ram(sig_out_bus_mergerMout_oe_ram3_),
    .Mout_we_ram(sig_out_bus_mergerMout_we_ram4_),
    .Mout_addr_ram(sig_out_bus_mergerMout_addr_ram1_),
    .Mout_Wdata_ram(sig_out_bus_mergerMout_Wdata_ram0_),
    .Mout_data_ram_size(sig_out_bus_mergerMout_data_ram_size2_),
    .clock(clock),
    .in1(out_MUX_0_BMEMORY_CTRL_59_i0_0_0_0),
    .in2(out_MUX_1_BMEMORY_CTRL_59_i0_1_1_0),
    .in3(out_conv_out_const_1_7_6),
    .in4(out_const_2),
    .sel_LOAD(fuselector_BMEMORY_CTRL_59_i0_LOAD),
    .sel_STORE(fuselector_BMEMORY_CTRL_59_i0_STORE),
    .Min_oe_ram(Min_oe_ram),
    .Min_we_ram(Min_we_ram),
    .Min_addr_ram(Min_addr_ram),
    .M_Rdata_ram(M_Rdata_ram),
    .Min_Wdata_ram(Min_Wdata_ram),
    .Min_data_ram_size(Min_data_ram_size),
    .M_DataRdy(M_DataRdy));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_0_BMEMORY_CTRL_59_i0_0_0_0 (.out1(out_MUX_0_BMEMORY_CTRL_59_i0_0_0_0),
    .sel(selector_MUX_0_BMEMORY_CTRL_59_i0_0_0_0),
    .in1(out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1),
    .in2(out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_BMEMORY_CTRL_59_i0_1_0_0 (.out1(out_MUX_1_BMEMORY_CTRL_59_i0_1_0_0),
    .sel(selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_0),
    .in1(in_port_Pd5),
    .in2(in_port_Pd7));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_BMEMORY_CTRL_59_i0_1_0_1 (.out1(out_MUX_1_BMEMORY_CTRL_59_i0_1_0_1),
    .sel(selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_1),
    .in1(in_port_Pd8),
    .in2(out_ui_pointer_plus_expr_FU_32_32_32_65_i0_fu_min_max_423516_423592));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_BMEMORY_CTRL_59_i0_1_1_0 (.out1(out_MUX_1_BMEMORY_CTRL_59_i0_1_1_0),
    .sel(selector_MUX_1_BMEMORY_CTRL_59_i0_1_1_0),
    .in1(out_MUX_1_BMEMORY_CTRL_59_i0_1_0_0),
    .in2(out_MUX_1_BMEMORY_CTRL_59_i0_1_0_1));
  MUX_GATE #(.BITSIZE_in1(64),
    .BITSIZE_in2(64),
    .BITSIZE_out1(64)) MUX_69_reg_2_0_0_0 (.out1(out_MUX_69_reg_2_0_0_0),
    .sel(selector_MUX_69_reg_2_0_0_0),
    .in1(out_ui_plus_expr_FU_64_0_64_64_i0_fu_min_max_423516_423602),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_70_reg_3_0_0_0 (.out1(out_MUX_70_reg_3_0_0_0),
    .sel(selector_MUX_70_reg_3_0_0_0),
    .in1(out_BMEMORY_CTRL_59_i0_BMEMORY_CTRL_59_i0),
    .in2(out_IUdata_converter_FU_57_i0_fu_min_max_423516_423681));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_71_reg_4_0_0_0 (.out1(out_MUX_71_reg_4_0_0_0),
    .sel(selector_MUX_71_reg_4_0_0_0),
    .in1(out_BMEMORY_CTRL_59_i0_BMEMORY_CTRL_59_i0),
    .in2(out_IUdata_converter_FU_56_i0_fu_min_max_423516_423678));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_75_reg_8_0_0_0 (.out1(out_MUX_75_reg_8_0_0_0),
    .sel(selector_MUX_75_reg_8_0_0_0),
    .in1(out_BMEMORY_CTRL_59_i0_BMEMORY_CTRL_59_i0),
    .in2(out_IUdata_converter_FU_54_i0_fu_min_max_423516_423672));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_76_reg_9_0_0_0 (.out1(out_MUX_76_reg_9_0_0_0),
    .sel(selector_MUX_76_reg_9_0_0_0),
    .in1(out_BMEMORY_CTRL_59_i0_BMEMORY_CTRL_59_i0),
    .in2(out_IUdata_converter_FU_55_i0_fu_min_max_423516_423675));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(64)) UUdata_converter_FU_uu_conv_0 (.out1(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0),
    .in1(out_conv_out_const_0_1_64));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_1 (.out1(out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1),
    .in1(out_reg_9_reg_9));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_2 (.out1(out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2),
    .in1(out_reg_8_reg_8));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b0)) const_0 (.out1(out_const_0));
  constant_value #(.BITSIZE_out1(7),
    .value(7'b0100000)) const_1 (.out1(out_const_1));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b10010)) const_10 (.out1(out_const_10));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b10011)) const_11 (.out1(out_const_11));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b101)) const_12 (.out1(out_const_12));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1010)) const_13 (.out1(out_const_13));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b10100)) const_14 (.out1(out_const_14));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b10101)) const_15 (.out1(out_const_15));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1011)) const_16 (.out1(out_const_16));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b10110)) const_17 (.out1(out_const_17));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b10111)) const_18 (.out1(out_const_18));
  constant_value #(.BITSIZE_out1(2),
    .value(2'b11)) const_19 (.out1(out_const_19));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b1)) const_2 (.out1(out_const_2));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b110)) const_20 (.out1(out_const_20));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1100)) const_21 (.out1(out_const_21));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b11000)) const_22 (.out1(out_const_22));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b11001)) const_23 (.out1(out_const_23));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1101)) const_24 (.out1(out_const_24));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b11010)) const_25 (.out1(out_const_25));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b11011)) const_26 (.out1(out_const_26));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b111)) const_27 (.out1(out_const_27));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1110)) const_28 (.out1(out_const_28));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b11100)) const_29 (.out1(out_const_29));
  constant_value #(.BITSIZE_out1(2),
    .value(2'b10)) const_3 (.out1(out_const_3));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b11101)) const_30 (.out1(out_const_30));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1111)) const_31 (.out1(out_const_31));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b11110)) const_32 (.out1(out_const_32));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b11111)) const_33 (.out1(out_const_33));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b100)) const_4 (.out1(out_const_4));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1000)) const_5 (.out1(out_const_5));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b10000)) const_6 (.out1(out_const_6));
  constant_value #(.BITSIZE_out1(33),
    .value(33'b100000000000000000000000000000000)) const_7 (.out1(out_const_7));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b10001)) const_8 (.out1(out_const_8));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1001)) const_9 (.out1(out_const_9));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(64)) conv_out_const_0_1_64 (.out1(out_conv_out_const_0_1_64),
    .in1(out_const_0));
  UUdata_converter_FU #(.BITSIZE_in1(7),
    .BITSIZE_out1(6)) conv_out_const_1_7_6 (.out1(out_conv_out_const_1_7_6),
    .in1(out_const_1));
  read_cond_FU #(.BITSIZE_in1(1)) fu_min_max_423516_423551 (.out1(out_read_cond_FU_42_i0_fu_min_max_423516_423551),
    .in1(out_reg_1_reg_1));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423571 (.out1(out_UUdata_converter_FU_41_i0_fu_min_max_423516_423571),
    .in1(in_port_Pd6));
  min_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423584 (.out1(out_min_expr_FU_32_32_32_61_i0_fu_min_max_423516_423584),
    .in1(out_UIdata_converter_FU_52_i0_fu_min_max_423516_423706),
    .in2(out_reg_6_reg_6));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_min_max_423516_423592 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_65_i0_fu_min_max_423516_423592),
    .in1(in_port_Pd5),
    .in2(out_ui_lshift_expr_FU_32_0_32_63_i0_fu_min_max_423516_423698));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(30)) fu_min_max_423516_423597 (.out1(out_UUdata_converter_FU_49_i0_fu_min_max_423516_423597),
    .in1(out_reg_2_reg_2));
  ui_plus_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(1),
    .BITSIZE_out1(64)) fu_min_max_423516_423602 (.out1(out_ui_plus_expr_FU_64_0_64_64_i0_fu_min_max_423516_423602),
    .in1(out_reg_2_reg_2),
    .in2(out_const_2));
  max_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423610 (.out1(out_max_expr_FU_32_32_32_60_i0_fu_min_max_423516_423610),
    .in1(out_UIdata_converter_FU_50_i0_fu_min_max_423516_423701),
    .in2(out_reg_5_reg_5));
  read_cond_FU #(.BITSIZE_in1(1)) fu_min_max_423516_423626 (.out1(out_read_cond_FU_58_i0_fu_min_max_423516_423626),
    .in1(out_reg_7_reg_7));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423672 (.out1(out_IUdata_converter_FU_54_i0_fu_min_max_423516_423672),
    .in1(out_min_expr_FU_32_32_32_61_i0_fu_min_max_423516_423584));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423675 (.out1(out_IUdata_converter_FU_55_i0_fu_min_max_423516_423675),
    .in1(out_max_expr_FU_32_32_32_60_i0_fu_min_max_423516_423610));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423678 (.out1(out_IUdata_converter_FU_56_i0_fu_min_max_423516_423678),
    .in1(out_max_expr_FU_32_32_32_60_i0_fu_min_max_423516_423610));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423681 (.out1(out_IUdata_converter_FU_57_i0_fu_min_max_423516_423681),
    .in1(out_min_expr_FU_32_32_32_61_i0_fu_min_max_423516_423584));
  lut_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_min_max_423516_423696 (.out1(out_lut_expr_FU_40_i0_fu_min_max_423516_423696),
    .in1(out_const_2),
    .in2(out_ui_extract_bit_expr_FU_33_i0_fu_min_max_423516_424006),
    .in3(out_lut_expr_FU_39_i0_fu_min_max_423516_424025),
    .in4(1'b0),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_min_max_423516_423698 (.out1(out_ui_lshift_expr_FU_32_0_32_63_i0_fu_min_max_423516_423698),
    .in1(out_UUdata_converter_FU_49_i0_fu_min_max_423516_423597),
    .in2(out_const_3));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423701 (.out1(out_UIdata_converter_FU_50_i0_fu_min_max_423516_423701),
    .in1(out_BMEMORY_CTRL_59_i0_BMEMORY_CTRL_59_i0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423703 (.out1(out_UIdata_converter_FU_51_i0_fu_min_max_423516_423703),
    .in1(out_reg_4_reg_4));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423706 (.out1(out_UIdata_converter_FU_52_i0_fu_min_max_423516_423706),
    .in1(out_BMEMORY_CTRL_59_i0_BMEMORY_CTRL_59_i0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423708 (.out1(out_UIdata_converter_FU_53_i0_fu_min_max_423516_423708),
    .in1(out_reg_3_reg_3));
  ui_eq_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(32),
    .BITSIZE_out1(1)) fu_min_max_423516_423710 (.out1(out_ui_eq_expr_FU_64_64_64_62_i0_fu_min_max_423516_423710),
    .in1(out_ui_plus_expr_FU_64_0_64_64_i0_fu_min_max_423516_423602),
    .in2(out_reg_0_reg_0));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1)) fu_min_max_423516_423882 (.out1(out_ui_extract_bit_expr_FU_2_i0_fu_min_max_423516_423882),
    .in1(in_port_Pd6),
    .in2(out_const_0));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1)) fu_min_max_423516_423886 (.out1(out_ui_extract_bit_expr_FU_3_i0_fu_min_max_423516_423886),
    .in1(in_port_Pd6),
    .in2(out_const_2));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2)) fu_min_max_423516_423890 (.out1(out_ui_extract_bit_expr_FU_4_i0_fu_min_max_423516_423890),
    .in1(in_port_Pd6),
    .in2(out_const_3));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2)) fu_min_max_423516_423894 (.out1(out_ui_extract_bit_expr_FU_5_i0_fu_min_max_423516_423894),
    .in1(in_port_Pd6),
    .in2(out_const_19));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3)) fu_min_max_423516_423898 (.out1(out_ui_extract_bit_expr_FU_6_i0_fu_min_max_423516_423898),
    .in1(in_port_Pd6),
    .in2(out_const_4));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3)) fu_min_max_423516_423902 (.out1(out_ui_extract_bit_expr_FU_7_i0_fu_min_max_423516_423902),
    .in1(in_port_Pd6),
    .in2(out_const_12));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3)) fu_min_max_423516_423906 (.out1(out_ui_extract_bit_expr_FU_8_i0_fu_min_max_423516_423906),
    .in1(in_port_Pd6),
    .in2(out_const_20));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3)) fu_min_max_423516_423910 (.out1(out_ui_extract_bit_expr_FU_9_i0_fu_min_max_423516_423910),
    .in1(in_port_Pd6),
    .in2(out_const_27));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_423914 (.out1(out_ui_extract_bit_expr_FU_10_i0_fu_min_max_423516_423914),
    .in1(in_port_Pd6),
    .in2(out_const_5));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_423918 (.out1(out_ui_extract_bit_expr_FU_11_i0_fu_min_max_423516_423918),
    .in1(in_port_Pd6),
    .in2(out_const_9));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_423922 (.out1(out_ui_extract_bit_expr_FU_12_i0_fu_min_max_423516_423922),
    .in1(in_port_Pd6),
    .in2(out_const_13));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_423926 (.out1(out_ui_extract_bit_expr_FU_13_i0_fu_min_max_423516_423926),
    .in1(in_port_Pd6),
    .in2(out_const_16));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_423930 (.out1(out_ui_extract_bit_expr_FU_14_i0_fu_min_max_423516_423930),
    .in1(in_port_Pd6),
    .in2(out_const_21));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_423934 (.out1(out_ui_extract_bit_expr_FU_15_i0_fu_min_max_423516_423934),
    .in1(in_port_Pd6),
    .in2(out_const_24));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_423938 (.out1(out_ui_extract_bit_expr_FU_16_i0_fu_min_max_423516_423938),
    .in1(in_port_Pd6),
    .in2(out_const_28));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_423942 (.out1(out_ui_extract_bit_expr_FU_17_i0_fu_min_max_423516_423942),
    .in1(in_port_Pd6),
    .in2(out_const_31));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_423946 (.out1(out_ui_extract_bit_expr_FU_18_i0_fu_min_max_423516_423946),
    .in1(in_port_Pd6),
    .in2(out_const_6));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_423950 (.out1(out_ui_extract_bit_expr_FU_19_i0_fu_min_max_423516_423950),
    .in1(in_port_Pd6),
    .in2(out_const_8));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_423954 (.out1(out_ui_extract_bit_expr_FU_20_i0_fu_min_max_423516_423954),
    .in1(in_port_Pd6),
    .in2(out_const_10));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_423958 (.out1(out_ui_extract_bit_expr_FU_21_i0_fu_min_max_423516_423958),
    .in1(in_port_Pd6),
    .in2(out_const_11));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_423962 (.out1(out_ui_extract_bit_expr_FU_22_i0_fu_min_max_423516_423962),
    .in1(in_port_Pd6),
    .in2(out_const_14));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_423966 (.out1(out_ui_extract_bit_expr_FU_23_i0_fu_min_max_423516_423966),
    .in1(in_port_Pd6),
    .in2(out_const_15));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_423970 (.out1(out_ui_extract_bit_expr_FU_24_i0_fu_min_max_423516_423970),
    .in1(in_port_Pd6),
    .in2(out_const_17));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_423974 (.out1(out_ui_extract_bit_expr_FU_25_i0_fu_min_max_423516_423974),
    .in1(in_port_Pd6),
    .in2(out_const_18));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_423978 (.out1(out_ui_extract_bit_expr_FU_26_i0_fu_min_max_423516_423978),
    .in1(in_port_Pd6),
    .in2(out_const_22));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_423982 (.out1(out_ui_extract_bit_expr_FU_27_i0_fu_min_max_423516_423982),
    .in1(in_port_Pd6),
    .in2(out_const_23));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_423986 (.out1(out_ui_extract_bit_expr_FU_28_i0_fu_min_max_423516_423986),
    .in1(in_port_Pd6),
    .in2(out_const_25));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_423990 (.out1(out_ui_extract_bit_expr_FU_29_i0_fu_min_max_423516_423990),
    .in1(in_port_Pd6),
    .in2(out_const_26));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_423994 (.out1(out_ui_extract_bit_expr_FU_30_i0_fu_min_max_423516_423994),
    .in1(in_port_Pd6),
    .in2(out_const_29));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_423998 (.out1(out_ui_extract_bit_expr_FU_31_i0_fu_min_max_423516_423998),
    .in1(in_port_Pd6),
    .in2(out_const_30));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424002 (.out1(out_ui_extract_bit_expr_FU_32_i0_fu_min_max_423516_424002),
    .in1(in_port_Pd6),
    .in2(out_const_32));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424006 (.out1(out_ui_extract_bit_expr_FU_33_i0_fu_min_max_423516_424006),
    .in1(in_port_Pd6),
    .in2(out_const_33));
  lut_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_min_max_423516_424010 (.out1(out_lut_expr_FU_34_i0_fu_min_max_423516_424010),
    .in1(out_const_2),
    .in2(out_ui_extract_bit_expr_FU_2_i0_fu_min_max_423516_423882),
    .in3(out_ui_extract_bit_expr_FU_3_i0_fu_min_max_423516_423886),
    .in4(out_ui_extract_bit_expr_FU_4_i0_fu_min_max_423516_423890),
    .in5(out_ui_extract_bit_expr_FU_5_i0_fu_min_max_423516_423894),
    .in6(out_ui_extract_bit_expr_FU_6_i0_fu_min_max_423516_423898),
    .in7(out_ui_extract_bit_expr_FU_7_i0_fu_min_max_423516_423902),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(33),
    .BITSIZE_out1(1)) fu_min_max_423516_424013 (.out1(out_lut_expr_FU_35_i0_fu_min_max_423516_424013),
    .in1(out_const_7),
    .in2(out_ui_extract_bit_expr_FU_8_i0_fu_min_max_423516_423906),
    .in3(out_ui_extract_bit_expr_FU_9_i0_fu_min_max_423516_423910),
    .in4(out_ui_extract_bit_expr_FU_10_i0_fu_min_max_423516_423914),
    .in5(out_ui_extract_bit_expr_FU_11_i0_fu_min_max_423516_423918),
    .in6(out_ui_extract_bit_expr_FU_12_i0_fu_min_max_423516_423922),
    .in7(out_lut_expr_FU_34_i0_fu_min_max_423516_424010),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(33),
    .BITSIZE_out1(1)) fu_min_max_423516_424016 (.out1(out_lut_expr_FU_36_i0_fu_min_max_423516_424016),
    .in1(out_const_7),
    .in2(out_ui_extract_bit_expr_FU_13_i0_fu_min_max_423516_423926),
    .in3(out_ui_extract_bit_expr_FU_14_i0_fu_min_max_423516_423930),
    .in4(out_ui_extract_bit_expr_FU_15_i0_fu_min_max_423516_423934),
    .in5(out_ui_extract_bit_expr_FU_16_i0_fu_min_max_423516_423938),
    .in6(out_ui_extract_bit_expr_FU_17_i0_fu_min_max_423516_423942),
    .in7(out_lut_expr_FU_35_i0_fu_min_max_423516_424013),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(33),
    .BITSIZE_out1(1)) fu_min_max_423516_424019 (.out1(out_lut_expr_FU_37_i0_fu_min_max_423516_424019),
    .in1(out_const_7),
    .in2(out_ui_extract_bit_expr_FU_18_i0_fu_min_max_423516_423946),
    .in3(out_ui_extract_bit_expr_FU_19_i0_fu_min_max_423516_423950),
    .in4(out_ui_extract_bit_expr_FU_20_i0_fu_min_max_423516_423954),
    .in5(out_ui_extract_bit_expr_FU_21_i0_fu_min_max_423516_423958),
    .in6(out_ui_extract_bit_expr_FU_22_i0_fu_min_max_423516_423962),
    .in7(out_lut_expr_FU_36_i0_fu_min_max_423516_424016),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(33),
    .BITSIZE_out1(1)) fu_min_max_423516_424022 (.out1(out_lut_expr_FU_38_i0_fu_min_max_423516_424022),
    .in1(out_const_7),
    .in2(out_ui_extract_bit_expr_FU_23_i0_fu_min_max_423516_423966),
    .in3(out_ui_extract_bit_expr_FU_24_i0_fu_min_max_423516_423970),
    .in4(out_ui_extract_bit_expr_FU_25_i0_fu_min_max_423516_423974),
    .in5(out_ui_extract_bit_expr_FU_26_i0_fu_min_max_423516_423978),
    .in6(out_ui_extract_bit_expr_FU_27_i0_fu_min_max_423516_423982),
    .in7(out_lut_expr_FU_37_i0_fu_min_max_423516_424019),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(33),
    .BITSIZE_out1(1)) fu_min_max_423516_424025 (.out1(out_lut_expr_FU_39_i0_fu_min_max_423516_424025),
    .in1(out_const_7),
    .in2(out_ui_extract_bit_expr_FU_28_i0_fu_min_max_423516_423986),
    .in3(out_ui_extract_bit_expr_FU_29_i0_fu_min_max_423516_423990),
    .in4(out_ui_extract_bit_expr_FU_30_i0_fu_min_max_423516_423994),
    .in5(out_ui_extract_bit_expr_FU_31_i0_fu_min_max_423516_423998),
    .in6(out_ui_extract_bit_expr_FU_32_i0_fu_min_max_423516_424002),
    .in7(out_lut_expr_FU_38_i0_fu_min_max_423516_424022),
    .in8(1'b0),
    .in9(1'b0));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_0 (.out1(out_reg_0_reg_0),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_41_i0_fu_min_max_423516_423571),
    .wenable(wrenable_reg_0));
  register_STD #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_1 (.out1(out_reg_1_reg_1),
    .clock(clock),
    .reset(reset),
    .in1(out_lut_expr_FU_40_i0_fu_min_max_423516_423696),
    .wenable(wrenable_reg_1));
  register_SE #(.BITSIZE_in1(64),
    .BITSIZE_out1(64)) reg_2 (.out1(out_reg_2_reg_2),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_69_reg_2_0_0_0),
    .wenable(wrenable_reg_2));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_3 (.out1(out_reg_3_reg_3),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_70_reg_3_0_0_0),
    .wenable(wrenable_reg_3));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_4 (.out1(out_reg_4_reg_4),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_71_reg_4_0_0_0),
    .wenable(wrenable_reg_4));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_5 (.out1(out_reg_5_reg_5),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_51_i0_fu_min_max_423516_423703),
    .wenable(wrenable_reg_5));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_6 (.out1(out_reg_6_reg_6),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_53_i0_fu_min_max_423516_423708),
    .wenable(wrenable_reg_6));
  register_STD #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_7 (.out1(out_reg_7_reg_7),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_eq_expr_FU_64_64_64_62_i0_fu_min_max_423516_423710),
    .wenable(wrenable_reg_7));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_8 (.out1(out_reg_8_reg_8),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_75_reg_8_0_0_0),
    .wenable(wrenable_reg_8));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_9 (.out1(out_reg_9_reg_9),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_76_reg_9_0_0_0),
    .wenable(wrenable_reg_9));
  // io-signal post fix
  assign Mout_oe_ram = sig_out_bus_mergerMout_oe_ram3_;
  assign Mout_we_ram = sig_out_bus_mergerMout_we_ram4_;
  assign Mout_addr_ram = sig_out_bus_mergerMout_addr_ram1_;
  assign Mout_Wdata_ram = sig_out_bus_mergerMout_Wdata_ram0_;
  assign Mout_data_ram_size = sig_out_bus_mergerMout_data_ram_size2_;
  assign OUT_CONDITION_min_max_423516_423551 = out_read_cond_FU_42_i0_fu_min_max_423516_423551;
  assign OUT_CONDITION_min_max_423516_423626 = out_read_cond_FU_58_i0_fu_min_max_423516_423626;

endmodule

// FSM based controller description for min_max
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module controller_min_max(done_port,
  fuselector_BMEMORY_CTRL_59_i0_LOAD,
  fuselector_BMEMORY_CTRL_59_i0_STORE,
  selector_MUX_0_BMEMORY_CTRL_59_i0_0_0_0,
  selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_0,
  selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_1,
  selector_MUX_1_BMEMORY_CTRL_59_i0_1_1_0,
  selector_MUX_69_reg_2_0_0_0,
  selector_MUX_70_reg_3_0_0_0,
  selector_MUX_71_reg_4_0_0_0,
  selector_MUX_75_reg_8_0_0_0,
  selector_MUX_76_reg_9_0_0_0,
  wrenable_reg_0,
  wrenable_reg_1,
  wrenable_reg_2,
  wrenable_reg_3,
  wrenable_reg_4,
  wrenable_reg_5,
  wrenable_reg_6,
  wrenable_reg_7,
  wrenable_reg_8,
  wrenable_reg_9,
  OUT_CONDITION_min_max_423516_423551,
  OUT_CONDITION_min_max_423516_423626,
  clock,
  reset,
  start_port);
  // IN
  input OUT_CONDITION_min_max_423516_423551;
  input OUT_CONDITION_min_max_423516_423626;
  input clock;
  input reset;
  input start_port;
  // OUT
  output done_port;
  output fuselector_BMEMORY_CTRL_59_i0_LOAD;
  output fuselector_BMEMORY_CTRL_59_i0_STORE;
  output selector_MUX_0_BMEMORY_CTRL_59_i0_0_0_0;
  output selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_0;
  output selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_1;
  output selector_MUX_1_BMEMORY_CTRL_59_i0_1_1_0;
  output selector_MUX_69_reg_2_0_0_0;
  output selector_MUX_70_reg_3_0_0_0;
  output selector_MUX_71_reg_4_0_0_0;
  output selector_MUX_75_reg_8_0_0_0;
  output selector_MUX_76_reg_9_0_0_0;
  output wrenable_reg_0;
  output wrenable_reg_1;
  output wrenable_reg_2;
  output wrenable_reg_3;
  output wrenable_reg_4;
  output wrenable_reg_5;
  output wrenable_reg_6;
  output wrenable_reg_7;
  output wrenable_reg_8;
  output wrenable_reg_9;
  parameter [6:0] S_0 = 7'b0000001,
    S_1 = 7'b0000010,
    S_5 = 7'b0100000,
    S_6 = 7'b1000000,
    S_2 = 7'b0000100,
    S_3 = 7'b0001000,
    S_4 = 7'b0010000;
  reg [6:0] _present_state=S_0, _next_state;
  reg done_port;
  reg fuselector_BMEMORY_CTRL_59_i0_LOAD;
  reg fuselector_BMEMORY_CTRL_59_i0_STORE;
  reg selector_MUX_0_BMEMORY_CTRL_59_i0_0_0_0;
  reg selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_0;
  reg selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_1;
  reg selector_MUX_1_BMEMORY_CTRL_59_i0_1_1_0;
  reg selector_MUX_69_reg_2_0_0_0;
  reg selector_MUX_70_reg_3_0_0_0;
  reg selector_MUX_71_reg_4_0_0_0;
  reg selector_MUX_75_reg_8_0_0_0;
  reg selector_MUX_76_reg_9_0_0_0;
  reg wrenable_reg_0;
  reg wrenable_reg_1;
  reg wrenable_reg_2;
  reg wrenable_reg_3;
  reg wrenable_reg_4;
  reg wrenable_reg_5;
  reg wrenable_reg_6;
  reg wrenable_reg_7;
  reg wrenable_reg_8;
  reg wrenable_reg_9;
  
  always @(posedge clock)
    if (reset == 1'b0) _present_state <= S_0;
    else _present_state <= _next_state;
  
  always @(*)
  begin
    done_port = 1'b0;
    fuselector_BMEMORY_CTRL_59_i0_LOAD = 1'b0;
    fuselector_BMEMORY_CTRL_59_i0_STORE = 1'b0;
    selector_MUX_0_BMEMORY_CTRL_59_i0_0_0_0 = 1'b0;
    selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_0 = 1'b0;
    selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_1 = 1'b0;
    selector_MUX_1_BMEMORY_CTRL_59_i0_1_1_0 = 1'b0;
    selector_MUX_69_reg_2_0_0_0 = 1'b0;
    selector_MUX_70_reg_3_0_0_0 = 1'b0;
    selector_MUX_71_reg_4_0_0_0 = 1'b0;
    selector_MUX_75_reg_8_0_0_0 = 1'b0;
    selector_MUX_76_reg_9_0_0_0 = 1'b0;
    wrenable_reg_0 = 1'b0;
    wrenable_reg_1 = 1'b0;
    wrenable_reg_2 = 1'b0;
    wrenable_reg_3 = 1'b0;
    wrenable_reg_4 = 1'b0;
    wrenable_reg_5 = 1'b0;
    wrenable_reg_6 = 1'b0;
    wrenable_reg_7 = 1'b0;
    wrenable_reg_8 = 1'b0;
    wrenable_reg_9 = 1'b0;
    case (_present_state)
      S_0 :
        if(start_port == 1'b1)
        begin
          fuselector_BMEMORY_CTRL_59_i0_LOAD = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_0 = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_59_i0_1_1_0 = 1'b1;
          wrenable_reg_0 = 1'b1;
          wrenable_reg_1 = 1'b1;
          _next_state = S_1;
        end
        else
        begin
          _next_state = S_0;
        end
      S_1 :
        begin
          selector_MUX_70_reg_3_0_0_0 = 1'b1;
          selector_MUX_71_reg_4_0_0_0 = 1'b1;
          selector_MUX_75_reg_8_0_0_0 = 1'b1;
          selector_MUX_76_reg_9_0_0_0 = 1'b1;
          wrenable_reg_2 = 1'b1;
          wrenable_reg_3 = 1'b1;
          wrenable_reg_4 = 1'b1;
          wrenable_reg_8 = 1'b1;
          wrenable_reg_9 = 1'b1;
          if (OUT_CONDITION_min_max_423516_423551 == 1'b1)
            begin
              _next_state = S_5;
              selector_MUX_75_reg_8_0_0_0 = 1'b0;
              selector_MUX_76_reg_9_0_0_0 = 1'b0;
              wrenable_reg_8 = 1'b0;
              wrenable_reg_9 = 1'b0;
            end
          else
            begin
              _next_state = S_2;
              selector_MUX_70_reg_3_0_0_0 = 1'b0;
              selector_MUX_71_reg_4_0_0_0 = 1'b0;
              wrenable_reg_2 = 1'b0;
              wrenable_reg_3 = 1'b0;
              wrenable_reg_4 = 1'b0;
            end
        end
      S_5 :
        begin
          fuselector_BMEMORY_CTRL_59_i0_LOAD = 1'b1;
          selector_MUX_69_reg_2_0_0_0 = 1'b1;
          wrenable_reg_2 = 1'b1;
          wrenable_reg_5 = 1'b1;
          wrenable_reg_6 = 1'b1;
          wrenable_reg_7 = 1'b1;
          _next_state = S_6;
        end
      S_6 :
        begin
          wrenable_reg_3 = 1'b1;
          wrenable_reg_4 = 1'b1;
          wrenable_reg_8 = 1'b1;
          wrenable_reg_9 = 1'b1;
          if (OUT_CONDITION_min_max_423516_423626 == 1'b1)
            begin
              _next_state = S_2;
              wrenable_reg_3 = 1'b0;
              wrenable_reg_4 = 1'b0;
            end
          else
            begin
              _next_state = S_5;
              wrenable_reg_8 = 1'b0;
              wrenable_reg_9 = 1'b0;
            end
        end
      S_2 :
        begin
          fuselector_BMEMORY_CTRL_59_i0_STORE = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_1 = 1'b1;
          _next_state = S_3;
        end
      S_3 :
        begin
          fuselector_BMEMORY_CTRL_59_i0_STORE = 1'b1;
          selector_MUX_0_BMEMORY_CTRL_59_i0_0_0_0 = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_59_i0_1_1_0 = 1'b1;
          _next_state = S_4;
          done_port = 1'b1;
        end
      S_4 :
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
  Pd7,
  Pd8,
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
  input [31:0] Pd7;
  input [31:0] Pd8;
  input [31:0] M_Rdata_ram;
  input M_DataRdy;
  input Min_oe_ram;
  input Min_we_ram;
  input [31:0] Min_addr_ram;
  input [31:0] Min_Wdata_ram;
  input [5:0] Min_data_ram_size;
  // OUT
  output done_port;
  output Mout_oe_ram;
  output Mout_we_ram;
  output [31:0] Mout_addr_ram;
  output [31:0] Mout_Wdata_ram;
  output [5:0] Mout_data_ram_size;
  // Component and signal declarations
  wire OUT_CONDITION_min_max_423516_423551;
  wire OUT_CONDITION_min_max_423516_423626;
  wire done_delayed_REG_signal_in;
  wire done_delayed_REG_signal_out;
  wire fuselector_BMEMORY_CTRL_59_i0_LOAD;
  wire fuselector_BMEMORY_CTRL_59_i0_STORE;
  wire selector_MUX_0_BMEMORY_CTRL_59_i0_0_0_0;
  wire selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_0;
  wire selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_1;
  wire selector_MUX_1_BMEMORY_CTRL_59_i0_1_1_0;
  wire selector_MUX_69_reg_2_0_0_0;
  wire selector_MUX_70_reg_3_0_0_0;
  wire selector_MUX_71_reg_4_0_0_0;
  wire selector_MUX_75_reg_8_0_0_0;
  wire selector_MUX_76_reg_9_0_0_0;
  wire wrenable_reg_0;
  wire wrenable_reg_1;
  wire wrenable_reg_2;
  wire wrenable_reg_3;
  wire wrenable_reg_4;
  wire wrenable_reg_5;
  wire wrenable_reg_6;
  wire wrenable_reg_7;
  wire wrenable_reg_8;
  wire wrenable_reg_9;
  
  controller_min_max Controller_i (.done_port(done_delayed_REG_signal_in),
    .fuselector_BMEMORY_CTRL_59_i0_LOAD(fuselector_BMEMORY_CTRL_59_i0_LOAD),
    .fuselector_BMEMORY_CTRL_59_i0_STORE(fuselector_BMEMORY_CTRL_59_i0_STORE),
    .selector_MUX_0_BMEMORY_CTRL_59_i0_0_0_0(selector_MUX_0_BMEMORY_CTRL_59_i0_0_0_0),
    .selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_0(selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_0),
    .selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_1(selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_1),
    .selector_MUX_1_BMEMORY_CTRL_59_i0_1_1_0(selector_MUX_1_BMEMORY_CTRL_59_i0_1_1_0),
    .selector_MUX_69_reg_2_0_0_0(selector_MUX_69_reg_2_0_0_0),
    .selector_MUX_70_reg_3_0_0_0(selector_MUX_70_reg_3_0_0_0),
    .selector_MUX_71_reg_4_0_0_0(selector_MUX_71_reg_4_0_0_0),
    .selector_MUX_75_reg_8_0_0_0(selector_MUX_75_reg_8_0_0_0),
    .selector_MUX_76_reg_9_0_0_0(selector_MUX_76_reg_9_0_0_0),
    .wrenable_reg_0(wrenable_reg_0),
    .wrenable_reg_1(wrenable_reg_1),
    .wrenable_reg_2(wrenable_reg_2),
    .wrenable_reg_3(wrenable_reg_3),
    .wrenable_reg_4(wrenable_reg_4),
    .wrenable_reg_5(wrenable_reg_5),
    .wrenable_reg_6(wrenable_reg_6),
    .wrenable_reg_7(wrenable_reg_7),
    .wrenable_reg_8(wrenable_reg_8),
    .wrenable_reg_9(wrenable_reg_9),
    .OUT_CONDITION_min_max_423516_423551(OUT_CONDITION_min_max_423516_423551),
    .OUT_CONDITION_min_max_423516_423626(OUT_CONDITION_min_max_423516_423626),
    .clock(clock),
    .reset(reset),
    .start_port(start_port));
  datapath_min_max Datapath_i (.Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .OUT_CONDITION_min_max_423516_423551(OUT_CONDITION_min_max_423516_423551),
    .OUT_CONDITION_min_max_423516_423626(OUT_CONDITION_min_max_423516_423626),
    .clock(clock),
    .reset(reset),
    .in_port_Pd5(Pd5),
    .in_port_Pd6(Pd6),
    .in_port_Pd7(Pd7),
    .in_port_Pd8(Pd8),
    .M_Rdata_ram(M_Rdata_ram),
    .M_DataRdy(M_DataRdy),
    .Min_oe_ram(Min_oe_ram),
    .Min_we_ram(Min_we_ram),
    .Min_addr_ram(Min_addr_ram),
    .Min_Wdata_ram(Min_Wdata_ram),
    .Min_data_ram_size(Min_data_ram_size),
    .fuselector_BMEMORY_CTRL_59_i0_LOAD(fuselector_BMEMORY_CTRL_59_i0_LOAD),
    .fuselector_BMEMORY_CTRL_59_i0_STORE(fuselector_BMEMORY_CTRL_59_i0_STORE),
    .selector_MUX_0_BMEMORY_CTRL_59_i0_0_0_0(selector_MUX_0_BMEMORY_CTRL_59_i0_0_0_0),
    .selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_0(selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_0),
    .selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_1(selector_MUX_1_BMEMORY_CTRL_59_i0_1_0_1),
    .selector_MUX_1_BMEMORY_CTRL_59_i0_1_1_0(selector_MUX_1_BMEMORY_CTRL_59_i0_1_1_0),
    .selector_MUX_69_reg_2_0_0_0(selector_MUX_69_reg_2_0_0_0),
    .selector_MUX_70_reg_3_0_0_0(selector_MUX_70_reg_3_0_0_0),
    .selector_MUX_71_reg_4_0_0_0(selector_MUX_71_reg_4_0_0_0),
    .selector_MUX_75_reg_8_0_0_0(selector_MUX_75_reg_8_0_0_0),
    .selector_MUX_76_reg_9_0_0_0(selector_MUX_76_reg_9_0_0_0),
    .wrenable_reg_0(wrenable_reg_0),
    .wrenable_reg_1(wrenable_reg_1),
    .wrenable_reg_2(wrenable_reg_2),
    .wrenable_reg_3(wrenable_reg_3),
    .wrenable_reg_4(wrenable_reg_4),
    .wrenable_reg_5(wrenable_reg_5),
    .wrenable_reg_6(wrenable_reg_6),
    .wrenable_reg_7(wrenable_reg_7),
    .wrenable_reg_8(wrenable_reg_8),
    .wrenable_reg_9(wrenable_reg_9));
  flipflop_AR #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) done_delayed_REG (.out1(done_delayed_REG_signal_out),
    .clock(clock),
    .reset(reset),
    .in1(done_delayed_REG_signal_in));
  // io-signal post fix
  assign done_port = done_delayed_REG_signal_out;

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
  Pd7,
  Pd8,
  M_Rdata_ram,
  M_DataRdy,
  done_port,
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
  input [31:0] Pd7;
  input [31:0] Pd8;
  input [31:0] M_Rdata_ram;
  input M_DataRdy;
  // OUT
  output done_port;
  output Mout_oe_ram;
  output Mout_we_ram;
  output [31:0] Mout_addr_ram;
  output [31:0] Mout_Wdata_ram;
  output [5:0] Mout_data_ram_size;
  // Component and signal declarations
  
  _min_max _min_max_i0 (.done_port(done_port),
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
    .Pd7(Pd7),
    .Pd8(Pd8),
    .M_Rdata_ram(M_Rdata_ram),
    .M_DataRdy(M_DataRdy),
    .Min_oe_ram(1'b0),
    .Min_we_ram(1'b0),
    .Min_addr_ram(32'b00000000000000000000000000000000),
    .Min_Wdata_ram(32'b00000000000000000000000000000000),
    .Min_data_ram_size(6'b000000));

endmodule


