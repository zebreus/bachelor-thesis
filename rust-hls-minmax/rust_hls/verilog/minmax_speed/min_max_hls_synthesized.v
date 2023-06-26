// 
// Politecnico di Milano
// Code created using PandA - Version: PandA 2023.2 - Revision 891ec3caed502474cab0813cc4a9fc678deabaa5 - Date 2023-06-25T19:31:34
// /nix/store/9c5lz0md936sjhs9hw1ya6kghvkfc4zg-bambu-wrapped/bin/bambu executed with: /nix/store/9c5lz0md936sjhs9hw1ya6kghvkfc4zg-bambu-wrapped/bin/bambu --simulator=VERILATOR --top-fname=min_max --clock-name=clk --compiler=I386_CLANG16 --channels-type=MEM_ACC_11 --channels-number=1 -O5 min_max.ll 
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
module ui_bit_and_expr_FU(in1,
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
  assign out1 = in1 & in2;
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
module ui_lt_expr_FU(in1,
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
  assign out1 = in1 < in2;
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
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_rshift_expr_FU(in1,
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
      assign out1 = in1 >> (in2[arg2_bitsize-1:0]);
    else
      assign out1 = in1 >> in2;
  endgenerate

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
  fuselector_BMEMORY_CTRL_92_i0_LOAD,
  fuselector_BMEMORY_CTRL_92_i0_STORE,
  selector_MUX_0_BMEMORY_CTRL_92_i0_0_0_0,
  selector_MUX_113_reg_1_0_0_0,
  selector_MUX_126_reg_21_0_0_0,
  selector_MUX_126_reg_21_0_0_1,
  selector_MUX_126_reg_21_0_1_0,
  selector_MUX_127_reg_22_0_0_0,
  selector_MUX_127_reg_22_0_0_1,
  selector_MUX_128_reg_23_0_0_0,
  selector_MUX_128_reg_23_0_0_1,
  selector_MUX_128_reg_23_0_1_0,
  selector_MUX_129_reg_24_0_0_0,
  selector_MUX_129_reg_24_0_0_1,
  selector_MUX_130_reg_25_0_0_0,
  selector_MUX_131_reg_26_0_0_0,
  selector_MUX_138_reg_6_0_0_0,
  selector_MUX_139_reg_7_0_0_0,
  selector_MUX_140_reg_8_0_0_0,
  selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_0,
  selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_1,
  selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_2,
  selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_3,
  selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_0,
  selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_1,
  selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0,
  wrenable_reg_0,
  wrenable_reg_1,
  wrenable_reg_10,
  wrenable_reg_11,
  wrenable_reg_12,
  wrenable_reg_13,
  wrenable_reg_14,
  wrenable_reg_15,
  wrenable_reg_16,
  wrenable_reg_17,
  wrenable_reg_18,
  wrenable_reg_19,
  wrenable_reg_2,
  wrenable_reg_20,
  wrenable_reg_21,
  wrenable_reg_22,
  wrenable_reg_23,
  wrenable_reg_24,
  wrenable_reg_25,
  wrenable_reg_26,
  wrenable_reg_27,
  wrenable_reg_28,
  wrenable_reg_29,
  wrenable_reg_3,
  wrenable_reg_4,
  wrenable_reg_5,
  wrenable_reg_6,
  wrenable_reg_7,
  wrenable_reg_8,
  wrenable_reg_9,
  OUT_CONDITION_min_max_423516_423742,
  OUT_CONDITION_min_max_423516_423746,
  OUT_CONDITION_min_max_423516_423752,
  OUT_MULTIIF_min_max_423516_423981);
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
  input fuselector_BMEMORY_CTRL_92_i0_LOAD;
  input fuselector_BMEMORY_CTRL_92_i0_STORE;
  input selector_MUX_0_BMEMORY_CTRL_92_i0_0_0_0;
  input selector_MUX_113_reg_1_0_0_0;
  input selector_MUX_126_reg_21_0_0_0;
  input selector_MUX_126_reg_21_0_0_1;
  input selector_MUX_126_reg_21_0_1_0;
  input selector_MUX_127_reg_22_0_0_0;
  input selector_MUX_127_reg_22_0_0_1;
  input selector_MUX_128_reg_23_0_0_0;
  input selector_MUX_128_reg_23_0_0_1;
  input selector_MUX_128_reg_23_0_1_0;
  input selector_MUX_129_reg_24_0_0_0;
  input selector_MUX_129_reg_24_0_0_1;
  input selector_MUX_130_reg_25_0_0_0;
  input selector_MUX_131_reg_26_0_0_0;
  input selector_MUX_138_reg_6_0_0_0;
  input selector_MUX_139_reg_7_0_0_0;
  input selector_MUX_140_reg_8_0_0_0;
  input selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_0;
  input selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_1;
  input selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_2;
  input selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_3;
  input selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_0;
  input selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_1;
  input selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0;
  input wrenable_reg_0;
  input wrenable_reg_1;
  input wrenable_reg_10;
  input wrenable_reg_11;
  input wrenable_reg_12;
  input wrenable_reg_13;
  input wrenable_reg_14;
  input wrenable_reg_15;
  input wrenable_reg_16;
  input wrenable_reg_17;
  input wrenable_reg_18;
  input wrenable_reg_19;
  input wrenable_reg_2;
  input wrenable_reg_20;
  input wrenable_reg_21;
  input wrenable_reg_22;
  input wrenable_reg_23;
  input wrenable_reg_24;
  input wrenable_reg_25;
  input wrenable_reg_26;
  input wrenable_reg_27;
  input wrenable_reg_28;
  input wrenable_reg_29;
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
  output OUT_CONDITION_min_max_423516_423742;
  output OUT_CONDITION_min_max_423516_423746;
  output OUT_CONDITION_min_max_423516_423752;
  output [1:0] OUT_MULTIIF_min_max_423516_423981;
  // Component and signal declarations
  wire [31:0] out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0;
  wire [31:0] out_IUdata_converter_FU_72_i0_fu_min_max_423516_423807;
  wire [31:0] out_IUdata_converter_FU_73_i0_fu_min_max_423516_423810;
  wire [31:0] out_IUdata_converter_FU_74_i0_fu_min_max_423516_423813;
  wire [31:0] out_IUdata_converter_FU_75_i0_fu_min_max_423516_423816;
  wire [31:0] out_IUdata_converter_FU_76_i0_fu_min_max_423516_423819;
  wire [31:0] out_IUdata_converter_FU_77_i0_fu_min_max_423516_423822;
  wire [31:0] out_IUdata_converter_FU_87_i0_fu_min_max_423516_423801;
  wire [31:0] out_IUdata_converter_FU_88_i0_fu_min_max_423516_423804;
  wire [31:0] out_IUdata_converter_FU_89_i0_fu_min_max_423516_423825;
  wire [31:0] out_IUdata_converter_FU_90_i0_fu_min_max_423516_423828;
  wire [31:0] out_MUX_0_BMEMORY_CTRL_92_i0_0_0_0;
  wire [31:0] out_MUX_113_reg_1_0_0_0;
  wire [31:0] out_MUX_126_reg_21_0_0_0;
  wire [31:0] out_MUX_126_reg_21_0_0_1;
  wire [31:0] out_MUX_126_reg_21_0_1_0;
  wire [31:0] out_MUX_127_reg_22_0_0_0;
  wire [31:0] out_MUX_127_reg_22_0_0_1;
  wire [31:0] out_MUX_128_reg_23_0_0_0;
  wire [31:0] out_MUX_128_reg_23_0_0_1;
  wire [31:0] out_MUX_128_reg_23_0_1_0;
  wire [31:0] out_MUX_129_reg_24_0_0_0;
  wire [31:0] out_MUX_129_reg_24_0_0_1;
  wire [63:0] out_MUX_130_reg_25_0_0_0;
  wire [63:0] out_MUX_131_reg_26_0_0_0;
  wire [63:0] out_MUX_138_reg_6_0_0_0;
  wire [31:0] out_MUX_139_reg_7_0_0_0;
  wire [31:0] out_MUX_140_reg_8_0_0_0;
  wire [31:0] out_MUX_1_BMEMORY_CTRL_92_i0_1_0_0;
  wire [31:0] out_MUX_1_BMEMORY_CTRL_92_i0_1_0_1;
  wire [31:0] out_MUX_1_BMEMORY_CTRL_92_i0_1_0_2;
  wire [31:0] out_MUX_1_BMEMORY_CTRL_92_i0_1_0_3;
  wire [31:0] out_MUX_1_BMEMORY_CTRL_92_i0_1_1_0;
  wire [31:0] out_MUX_1_BMEMORY_CTRL_92_i0_1_1_1;
  wire [31:0] out_MUX_1_BMEMORY_CTRL_92_i0_1_2_0;
  wire signed [31:0] out_UIdata_converter_FU_62_i0_fu_min_max_423516_423860;
  wire signed [31:0] out_UIdata_converter_FU_63_i0_fu_min_max_423516_423862;
  wire signed [31:0] out_UIdata_converter_FU_64_i0_fu_min_max_423516_423865;
  wire signed [31:0] out_UIdata_converter_FU_65_i0_fu_min_max_423516_423867;
  wire signed [31:0] out_UIdata_converter_FU_66_i0_fu_min_max_423516_423872;
  wire signed [31:0] out_UIdata_converter_FU_67_i0_fu_min_max_423516_423875;
  wire signed [31:0] out_UIdata_converter_FU_68_i0_fu_min_max_423516_423880;
  wire signed [31:0] out_UIdata_converter_FU_69_i0_fu_min_max_423516_423883;
  wire signed [31:0] out_UIdata_converter_FU_70_i0_fu_min_max_423516_423888;
  wire signed [31:0] out_UIdata_converter_FU_71_i0_fu_min_max_423516_423891;
  wire signed [31:0] out_UIdata_converter_FU_83_i0_fu_min_max_423516_423907;
  wire signed [31:0] out_UIdata_converter_FU_84_i0_fu_min_max_423516_423909;
  wire signed [31:0] out_UIdata_converter_FU_85_i0_fu_min_max_423516_423912;
  wire signed [31:0] out_UIdata_converter_FU_86_i0_fu_min_max_423516_423914;
  wire [31:0] out_UUdata_converter_FU_2_i0_fu_min_max_423516_423571;
  wire [31:0] out_UUdata_converter_FU_61_i0_fu_min_max_423516_423612;
  wire [29:0] out_UUdata_converter_FU_82_i0_fu_min_max_423516_423677;
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
  wire [29:0] out_const_34;
  wire [2:0] out_const_4;
  wire [3:0] out_const_5;
  wire [4:0] out_const_6;
  wire [32:0] out_const_7;
  wire [4:0] out_const_8;
  wire [3:0] out_const_9;
  wire [31:0] out_conv_out_const_0_1_32;
  wire [63:0] out_conv_out_const_0_1_64;
  wire [5:0] out_conv_out_const_1_7_6;
  wire [63:0] out_conv_out_reg_1_reg_1_32_64;
  wire out_lut_expr_FU_38_i0_fu_min_max_423516_424300;
  wire out_lut_expr_FU_39_i0_fu_min_max_423516_424303;
  wire out_lut_expr_FU_40_i0_fu_min_max_423516_424306;
  wire out_lut_expr_FU_41_i0_fu_min_max_423516_424309;
  wire out_lut_expr_FU_42_i0_fu_min_max_423516_424312;
  wire out_lut_expr_FU_43_i0_fu_min_max_423516_424315;
  wire out_lut_expr_FU_44_i0_fu_min_max_423516_423984;
  wire out_lut_expr_FU_46_i0_fu_min_max_423516_423987;
  wire out_lut_expr_FU_5_i0_fu_min_max_423516_423855;
  wire signed [31:0] out_max_expr_FU_32_32_32_93_i0_fu_min_max_423516_423703;
  wire signed [31:0] out_max_expr_FU_32_32_32_93_i1_fu_min_max_423516_423707;
  wire signed [31:0] out_max_expr_FU_32_32_32_93_i2_fu_min_max_423516_423711;
  wire signed [31:0] out_max_expr_FU_32_32_32_93_i3_fu_min_max_423516_423715;
  wire signed [31:0] out_max_expr_FU_32_32_32_93_i4_fu_min_max_423516_423723;
  wire signed [31:0] out_min_expr_FU_32_32_32_94_i0_fu_min_max_423516_423596;
  wire signed [31:0] out_min_expr_FU_32_32_32_94_i1_fu_min_max_423516_423620;
  wire signed [31:0] out_min_expr_FU_32_32_32_94_i2_fu_min_max_423516_423635;
  wire signed [31:0] out_min_expr_FU_32_32_32_94_i3_fu_min_max_423516_423650;
  wire signed [31:0] out_min_expr_FU_32_32_32_94_i4_fu_min_max_423516_423665;
  wire [1:0] out_multi_read_cond_FU_47_i0_fu_min_max_423516_423981;
  wire out_read_cond_FU_57_i0_fu_min_max_423516_423742;
  wire out_read_cond_FU_78_i0_fu_min_max_423516_423746;
  wire out_read_cond_FU_91_i0_fu_min_max_423516_423752;
  wire [1:0] out_reg_0_reg_0;
  wire [31:0] out_reg_10_reg_10;
  wire [31:0] out_reg_11_reg_11;
  wire [31:0] out_reg_12_reg_12;
  wire [31:0] out_reg_13_reg_13;
  wire out_reg_14_reg_14;
  wire [31:0] out_reg_15_reg_15;
  wire [31:0] out_reg_16_reg_16;
  wire [31:0] out_reg_17_reg_17;
  wire [31:0] out_reg_18_reg_18;
  wire [31:0] out_reg_19_reg_19;
  wire [31:0] out_reg_1_reg_1;
  wire [31:0] out_reg_20_reg_20;
  wire [31:0] out_reg_21_reg_21;
  wire [31:0] out_reg_22_reg_22;
  wire [31:0] out_reg_23_reg_23;
  wire [31:0] out_reg_24_reg_24;
  wire [63:0] out_reg_25_reg_25;
  wire [63:0] out_reg_26_reg_26;
  wire [31:0] out_reg_27_reg_27;
  wire [31:0] out_reg_28_reg_28;
  wire out_reg_29_reg_29;
  wire out_reg_2_reg_2;
  wire [29:0] out_reg_3_reg_3;
  wire out_reg_4_reg_4;
  wire out_reg_5_reg_5;
  wire [63:0] out_reg_6_reg_6;
  wire [31:0] out_reg_7_reg_7;
  wire [31:0] out_reg_8_reg_8;
  wire [31:0] out_reg_9_reg_9;
  wire [29:0] out_ui_bit_and_expr_FU_32_0_32_95_i0_fu_min_max_423516_423687;
  wire [1:0] out_ui_bit_and_expr_FU_8_0_8_96_i0_fu_min_max_423516_423572;
  wire [29:0] out_ui_bit_ior_expr_FU_32_0_32_97_i0_fu_min_max_423516_423608;
  wire [29:0] out_ui_bit_ior_expr_FU_32_0_32_98_i0_fu_min_max_423516_423632;
  wire [29:0] out_ui_bit_ior_expr_FU_32_0_32_99_i0_fu_min_max_423516_423647;
  wire out_ui_eq_expr_FU_64_64_64_100_i0_fu_min_max_423516_423893;
  wire out_ui_eq_expr_FU_64_64_64_100_i1_fu_min_max_423516_423916;
  wire out_ui_extract_bit_expr_FU_10_i0_fu_min_max_423516_424175;
  wire out_ui_extract_bit_expr_FU_11_i0_fu_min_max_423516_424179;
  wire out_ui_extract_bit_expr_FU_12_i0_fu_min_max_423516_424183;
  wire out_ui_extract_bit_expr_FU_13_i0_fu_min_max_423516_424187;
  wire out_ui_extract_bit_expr_FU_14_i0_fu_min_max_423516_424191;
  wire out_ui_extract_bit_expr_FU_15_i0_fu_min_max_423516_424195;
  wire out_ui_extract_bit_expr_FU_16_i0_fu_min_max_423516_424199;
  wire out_ui_extract_bit_expr_FU_17_i0_fu_min_max_423516_424203;
  wire out_ui_extract_bit_expr_FU_18_i0_fu_min_max_423516_424207;
  wire out_ui_extract_bit_expr_FU_19_i0_fu_min_max_423516_424211;
  wire out_ui_extract_bit_expr_FU_20_i0_fu_min_max_423516_424215;
  wire out_ui_extract_bit_expr_FU_21_i0_fu_min_max_423516_424219;
  wire out_ui_extract_bit_expr_FU_22_i0_fu_min_max_423516_424223;
  wire out_ui_extract_bit_expr_FU_23_i0_fu_min_max_423516_424227;
  wire out_ui_extract_bit_expr_FU_24_i0_fu_min_max_423516_424231;
  wire out_ui_extract_bit_expr_FU_25_i0_fu_min_max_423516_424235;
  wire out_ui_extract_bit_expr_FU_26_i0_fu_min_max_423516_424239;
  wire out_ui_extract_bit_expr_FU_27_i0_fu_min_max_423516_424243;
  wire out_ui_extract_bit_expr_FU_28_i0_fu_min_max_423516_424247;
  wire out_ui_extract_bit_expr_FU_29_i0_fu_min_max_423516_424251;
  wire out_ui_extract_bit_expr_FU_30_i0_fu_min_max_423516_424255;
  wire out_ui_extract_bit_expr_FU_31_i0_fu_min_max_423516_424259;
  wire out_ui_extract_bit_expr_FU_32_i0_fu_min_max_423516_424263;
  wire out_ui_extract_bit_expr_FU_33_i0_fu_min_max_423516_424267;
  wire out_ui_extract_bit_expr_FU_34_i0_fu_min_max_423516_424271;
  wire out_ui_extract_bit_expr_FU_35_i0_fu_min_max_423516_424275;
  wire out_ui_extract_bit_expr_FU_36_i0_fu_min_max_423516_424279;
  wire out_ui_extract_bit_expr_FU_37_i0_fu_min_max_423516_424283;
  wire out_ui_extract_bit_expr_FU_3_i0_fu_min_max_423516_424291;
  wire out_ui_extract_bit_expr_FU_45_i0_fu_min_max_423516_424287;
  wire out_ui_extract_bit_expr_FU_4_i0_fu_min_max_423516_424295;
  wire out_ui_extract_bit_expr_FU_6_i0_fu_min_max_423516_424159;
  wire out_ui_extract_bit_expr_FU_7_i0_fu_min_max_423516_424163;
  wire out_ui_extract_bit_expr_FU_8_i0_fu_min_max_423516_424167;
  wire out_ui_extract_bit_expr_FU_9_i0_fu_min_max_423516_424171;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_101_i0_fu_min_max_423516_423857;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_101_i1_fu_min_max_423516_423869;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_101_i2_fu_min_max_423516_423877;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_101_i3_fu_min_max_423516_423885;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_101_i4_fu_min_max_423516_423904;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_102_i0_fu_min_max_423516_423951;
  wire [63:0] out_ui_lshift_expr_FU_64_0_64_103_i0_fu_min_max_423516_423961;
  wire out_ui_lt_expr_FU_32_0_32_104_i0_fu_min_max_423516_423845;
  wire [63:0] out_ui_plus_expr_FU_64_0_64_105_i0_fu_min_max_423516_423683;
  wire [63:0] out_ui_plus_expr_FU_64_0_64_105_i1_fu_min_max_423516_423750;
  wire [61:0] out_ui_plus_expr_FU_64_0_64_106_i0_fu_min_max_423516_423958;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_107_i0_fu_min_max_423516_423604;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_107_i1_fu_min_max_423516_423628;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_107_i2_fu_min_max_423516_423643;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_107_i3_fu_min_max_423516_423658;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_107_i4_fu_min_max_423516_423673;
  wire [29:0] out_ui_rshift_expr_FU_32_0_32_108_i0_fu_min_max_423516_423945;
  wire [29:0] out_ui_rshift_expr_FU_32_0_32_108_i1_fu_min_max_423516_423967;
  wire [61:0] out_ui_rshift_expr_FU_64_0_64_109_i0_fu_min_max_423516_423954;
  wire [61:0] out_ui_rshift_expr_FU_64_0_64_109_i1_fu_min_max_423516_423964;
  wire [31:0] out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0;
  wire [63:0] out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1;
  wire [31:0] out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2;
  wire [31:0] out_uu_conv_conn_obj_3_UUdata_converter_FU_uu_conv_3;
  wire [31:0] out_uu_conv_conn_obj_4_UUdata_converter_FU_uu_conv_4;
  wire [63:0] out_uu_conv_conn_obj_5_UUdata_converter_FU_uu_conv_5;
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
    .BITSIZE_Mout_data_ram_size(6)) BMEMORY_CTRL_92_i0 (.out1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0),
    .Mout_oe_ram(sig_out_bus_mergerMout_oe_ram3_),
    .Mout_we_ram(sig_out_bus_mergerMout_we_ram4_),
    .Mout_addr_ram(sig_out_bus_mergerMout_addr_ram1_),
    .Mout_Wdata_ram(sig_out_bus_mergerMout_Wdata_ram0_),
    .Mout_data_ram_size(sig_out_bus_mergerMout_data_ram_size2_),
    .clock(clock),
    .in1(out_MUX_0_BMEMORY_CTRL_92_i0_0_0_0),
    .in2(out_MUX_1_BMEMORY_CTRL_92_i0_1_2_0),
    .in3(out_conv_out_const_1_7_6),
    .in4(out_const_2),
    .sel_LOAD(fuselector_BMEMORY_CTRL_92_i0_LOAD),
    .sel_STORE(fuselector_BMEMORY_CTRL_92_i0_STORE),
    .Min_oe_ram(Min_oe_ram),
    .Min_we_ram(Min_we_ram),
    .Min_addr_ram(Min_addr_ram),
    .M_Rdata_ram(M_Rdata_ram),
    .Min_Wdata_ram(Min_Wdata_ram),
    .Min_data_ram_size(Min_data_ram_size),
    .M_DataRdy(M_DataRdy));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_0_BMEMORY_CTRL_92_i0_0_0_0 (.out1(out_MUX_0_BMEMORY_CTRL_92_i0_0_0_0),
    .sel(selector_MUX_0_BMEMORY_CTRL_92_i0_0_0_0),
    .in1(out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2),
    .in2(out_uu_conv_conn_obj_3_UUdata_converter_FU_uu_conv_3));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_113_reg_1_0_0_0 (.out1(out_MUX_113_reg_1_0_0_0),
    .sel(selector_MUX_113_reg_1_0_0_0),
    .in1(out_ui_lshift_expr_FU_32_0_32_102_i0_fu_min_max_423516_423951),
    .in2(out_uu_conv_conn_obj_4_UUdata_converter_FU_uu_conv_4));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_126_reg_21_0_0_0 (.out1(out_MUX_126_reg_21_0_0_0),
    .sel(selector_MUX_126_reg_21_0_0_0),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0),
    .in2(out_IUdata_converter_FU_73_i0_fu_min_max_423516_423810));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_126_reg_21_0_0_1 (.out1(out_MUX_126_reg_21_0_0_1),
    .sel(selector_MUX_126_reg_21_0_0_1),
    .in1(out_IUdata_converter_FU_87_i0_fu_min_max_423516_423801),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_126_reg_21_0_1_0 (.out1(out_MUX_126_reg_21_0_1_0),
    .sel(selector_MUX_126_reg_21_0_1_0),
    .in1(out_MUX_126_reg_21_0_0_0),
    .in2(out_MUX_126_reg_21_0_0_1));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_127_reg_22_0_0_0 (.out1(out_MUX_127_reg_22_0_0_0),
    .sel(selector_MUX_127_reg_22_0_0_0),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0),
    .in2(out_IUdata_converter_FU_75_i0_fu_min_max_423516_423816));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_127_reg_22_0_0_1 (.out1(out_MUX_127_reg_22_0_0_1),
    .sel(selector_MUX_127_reg_22_0_0_1),
    .in1(out_IUdata_converter_FU_90_i0_fu_min_max_423516_423828),
    .in2(out_MUX_127_reg_22_0_0_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_128_reg_23_0_0_0 (.out1(out_MUX_128_reg_23_0_0_0),
    .sel(selector_MUX_128_reg_23_0_0_0),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0),
    .in2(out_IUdata_converter_FU_72_i0_fu_min_max_423516_423807));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_128_reg_23_0_0_1 (.out1(out_MUX_128_reg_23_0_0_1),
    .sel(selector_MUX_128_reg_23_0_0_1),
    .in1(out_IUdata_converter_FU_88_i0_fu_min_max_423516_423804),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_128_reg_23_0_1_0 (.out1(out_MUX_128_reg_23_0_1_0),
    .sel(selector_MUX_128_reg_23_0_1_0),
    .in1(out_MUX_128_reg_23_0_0_0),
    .in2(out_MUX_128_reg_23_0_0_1));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_129_reg_24_0_0_0 (.out1(out_MUX_129_reg_24_0_0_0),
    .sel(selector_MUX_129_reg_24_0_0_0),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0),
    .in2(out_IUdata_converter_FU_74_i0_fu_min_max_423516_423813));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_129_reg_24_0_0_1 (.out1(out_MUX_129_reg_24_0_0_1),
    .sel(selector_MUX_129_reg_24_0_0_1),
    .in1(out_IUdata_converter_FU_89_i0_fu_min_max_423516_423825),
    .in2(out_MUX_129_reg_24_0_0_0));
  MUX_GATE #(.BITSIZE_in1(64),
    .BITSIZE_in2(64),
    .BITSIZE_out1(64)) MUX_130_reg_25_0_0_0 (.out1(out_MUX_130_reg_25_0_0_0),
    .sel(selector_MUX_130_reg_25_0_0_0),
    .in1(out_ui_plus_expr_FU_64_0_64_105_i0_fu_min_max_423516_423683),
    .in2(out_uu_conv_conn_obj_5_UUdata_converter_FU_uu_conv_5));
  MUX_GATE #(.BITSIZE_in1(64),
    .BITSIZE_in2(64),
    .BITSIZE_out1(64)) MUX_131_reg_26_0_0_0 (.out1(out_MUX_131_reg_26_0_0_0),
    .sel(selector_MUX_131_reg_26_0_0_0),
    .in1(out_ui_plus_expr_FU_64_0_64_105_i1_fu_min_max_423516_423750),
    .in2(out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1));
  MUX_GATE #(.BITSIZE_in1(64),
    .BITSIZE_in2(64),
    .BITSIZE_out1(64)) MUX_138_reg_6_0_0_0 (.out1(out_MUX_138_reg_6_0_0_0),
    .sel(selector_MUX_138_reg_6_0_0_0),
    .in1(out_ui_lshift_expr_FU_64_0_64_103_i0_fu_min_max_423516_423961),
    .in2(out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_139_reg_7_0_0_0 (.out1(out_MUX_139_reg_7_0_0_0),
    .sel(selector_MUX_139_reg_7_0_0_0),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0),
    .in2(out_IUdata_converter_FU_77_i0_fu_min_max_423516_423822));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_140_reg_8_0_0_0 (.out1(out_MUX_140_reg_8_0_0_0),
    .sel(selector_MUX_140_reg_8_0_0_0),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0),
    .in2(out_IUdata_converter_FU_76_i0_fu_min_max_423516_423819));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_BMEMORY_CTRL_92_i0_1_0_0 (.out1(out_MUX_1_BMEMORY_CTRL_92_i0_1_0_0),
    .sel(selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_0),
    .in1(out_reg_9_reg_9),
    .in2(out_reg_11_reg_11));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_BMEMORY_CTRL_92_i0_1_0_1 (.out1(out_MUX_1_BMEMORY_CTRL_92_i0_1_0_1),
    .sel(selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_1),
    .in1(out_reg_10_reg_10),
    .in2(in_port_Pd5));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_BMEMORY_CTRL_92_i0_1_0_2 (.out1(out_MUX_1_BMEMORY_CTRL_92_i0_1_0_2),
    .sel(selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_2),
    .in1(in_port_Pd7),
    .in2(in_port_Pd8));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_BMEMORY_CTRL_92_i0_1_0_3 (.out1(out_MUX_1_BMEMORY_CTRL_92_i0_1_0_3),
    .sel(selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_3),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_107_i2_fu_min_max_423516_423643),
    .in2(out_ui_pointer_plus_expr_FU_32_32_32_107_i4_fu_min_max_423516_423673));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_BMEMORY_CTRL_92_i0_1_1_0 (.out1(out_MUX_1_BMEMORY_CTRL_92_i0_1_1_0),
    .sel(selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_0),
    .in1(out_MUX_1_BMEMORY_CTRL_92_i0_1_0_0),
    .in2(out_MUX_1_BMEMORY_CTRL_92_i0_1_0_1));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_BMEMORY_CTRL_92_i0_1_1_1 (.out1(out_MUX_1_BMEMORY_CTRL_92_i0_1_1_1),
    .sel(selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_1),
    .in1(out_MUX_1_BMEMORY_CTRL_92_i0_1_0_2),
    .in2(out_MUX_1_BMEMORY_CTRL_92_i0_1_0_3));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_BMEMORY_CTRL_92_i0_1_2_0 (.out1(out_MUX_1_BMEMORY_CTRL_92_i0_1_2_0),
    .sel(selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0),
    .in1(out_MUX_1_BMEMORY_CTRL_92_i0_1_1_0),
    .in2(out_MUX_1_BMEMORY_CTRL_92_i0_1_1_1));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_0 (.out1(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0),
    .in1(out_conv_out_const_0_1_32));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(64)) UUdata_converter_FU_uu_conv_1 (.out1(out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1),
    .in1(out_conv_out_const_0_1_64));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_2 (.out1(out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2),
    .in1(out_reg_23_reg_23));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_3 (.out1(out_uu_conv_conn_obj_3_UUdata_converter_FU_uu_conv_3),
    .in1(out_reg_21_reg_21));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_4 (.out1(out_uu_conv_conn_obj_4_UUdata_converter_FU_uu_conv_4),
    .in1(out_conv_out_const_0_1_32));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(64)) UUdata_converter_FU_uu_conv_5 (.out1(out_uu_conv_conn_obj_5_UUdata_converter_FU_uu_conv_5),
    .in1(out_conv_out_reg_1_reg_1_32_64));
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
  constant_value #(.BITSIZE_out1(30),
    .value(30'b111111111111111111111111111111)) const_34 (.out1(out_const_34));
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
    .BITSIZE_out1(32)) conv_out_const_0_1_32 (.out1(out_conv_out_const_0_1_32),
    .in1(out_const_0));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(64)) conv_out_const_0_1_64 (.out1(out_conv_out_const_0_1_64),
    .in1(out_const_0));
  UUdata_converter_FU #(.BITSIZE_in1(7),
    .BITSIZE_out1(6)) conv_out_const_1_7_6 (.out1(out_conv_out_const_1_7_6),
    .in1(out_const_1));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(64)) conv_out_reg_1_reg_1_32_64 (.out1(out_conv_out_reg_1_reg_1_32_64),
    .in1(out_reg_1_reg_1));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423571 (.out1(out_UUdata_converter_FU_2_i0_fu_min_max_423516_423571),
    .in1(in_port_Pd6));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(2)) fu_min_max_423516_423572 (.out1(out_ui_bit_and_expr_FU_8_0_8_96_i0_fu_min_max_423516_423572),
    .in1(out_UUdata_converter_FU_2_i0_fu_min_max_423516_423571),
    .in2(out_const_19));
  min_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423596 (.out1(out_min_expr_FU_32_32_32_94_i0_fu_min_max_423516_423596),
    .in1(out_reg_20_reg_20),
    .in2(out_min_expr_FU_32_32_32_94_i1_fu_min_max_423516_423620));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_min_max_423516_423604 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_107_i0_fu_min_max_423516_423604),
    .in1(in_port_Pd5),
    .in2(out_ui_lshift_expr_FU_32_0_32_101_i3_fu_min_max_423516_423885));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(30)) fu_min_max_423516_423608 (.out1(out_ui_bit_ior_expr_FU_32_0_32_97_i0_fu_min_max_423516_423608),
    .in1(out_UUdata_converter_FU_61_i0_fu_min_max_423516_423612),
    .in2(out_const_19));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(32)) fu_min_max_423516_423612 (.out1(out_UUdata_converter_FU_61_i0_fu_min_max_423516_423612),
    .in1(out_reg_6_reg_6));
  min_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423620 (.out1(out_min_expr_FU_32_32_32_94_i1_fu_min_max_423516_423620),
    .in1(out_UIdata_converter_FU_69_i0_fu_min_max_423516_423883),
    .in2(out_reg_17_reg_17));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_min_max_423516_423628 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_107_i1_fu_min_max_423516_423628),
    .in1(in_port_Pd5),
    .in2(out_ui_lshift_expr_FU_32_0_32_101_i2_fu_min_max_423516_423877));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(30)) fu_min_max_423516_423632 (.out1(out_ui_bit_ior_expr_FU_32_0_32_98_i0_fu_min_max_423516_423632),
    .in1(out_UUdata_converter_FU_61_i0_fu_min_max_423516_423612),
    .in2(out_const_3));
  min_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423635 (.out1(out_min_expr_FU_32_32_32_94_i2_fu_min_max_423516_423635),
    .in1(out_reg_16_reg_16),
    .in2(out_min_expr_FU_32_32_32_94_i3_fu_min_max_423516_423650));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_min_max_423516_423643 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_107_i2_fu_min_max_423516_423643),
    .in1(in_port_Pd5),
    .in2(out_ui_lshift_expr_FU_32_0_32_101_i1_fu_min_max_423516_423869));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(30)) fu_min_max_423516_423647 (.out1(out_ui_bit_ior_expr_FU_32_0_32_99_i0_fu_min_max_423516_423647),
    .in1(out_UUdata_converter_FU_61_i0_fu_min_max_423516_423612),
    .in2(out_const_2));
  min_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423650 (.out1(out_min_expr_FU_32_32_32_94_i3_fu_min_max_423516_423650),
    .in1(out_UIdata_converter_FU_64_i0_fu_min_max_423516_423865),
    .in2(out_reg_13_reg_13));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_min_max_423516_423658 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_107_i3_fu_min_max_423516_423658),
    .in1(in_port_Pd5),
    .in2(out_ui_lshift_expr_FU_32_0_32_101_i0_fu_min_max_423516_423857));
  min_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423665 (.out1(out_min_expr_FU_32_32_32_94_i4_fu_min_max_423516_423665),
    .in1(out_UIdata_converter_FU_85_i0_fu_min_max_423516_423912),
    .in2(out_reg_28_reg_28));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_min_max_423516_423673 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_107_i4_fu_min_max_423516_423673),
    .in1(in_port_Pd5),
    .in2(out_ui_lshift_expr_FU_32_0_32_101_i4_fu_min_max_423516_423904));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(30)) fu_min_max_423516_423677 (.out1(out_UUdata_converter_FU_82_i0_fu_min_max_423516_423677),
    .in1(out_reg_25_reg_25));
  ui_plus_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(1),
    .BITSIZE_out1(64)) fu_min_max_423516_423683 (.out1(out_ui_plus_expr_FU_64_0_64_105_i0_fu_min_max_423516_423683),
    .in1(out_reg_25_reg_25),
    .in2(out_const_2));
  ui_bit_and_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(30),
    .BITSIZE_out1(30)) fu_min_max_423516_423687 (.out1(out_ui_bit_and_expr_FU_32_0_32_95_i0_fu_min_max_423516_423687),
    .in1(out_ui_rshift_expr_FU_32_0_32_108_i0_fu_min_max_423516_423945),
    .in2(out_const_34));
  max_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423703 (.out1(out_max_expr_FU_32_32_32_93_i0_fu_min_max_423516_423703),
    .in1(out_reg_19_reg_19),
    .in2(out_max_expr_FU_32_32_32_93_i1_fu_min_max_423516_423707));
  max_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423707 (.out1(out_max_expr_FU_32_32_32_93_i1_fu_min_max_423516_423707),
    .in1(out_UIdata_converter_FU_68_i0_fu_min_max_423516_423880),
    .in2(out_reg_18_reg_18));
  max_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423711 (.out1(out_max_expr_FU_32_32_32_93_i2_fu_min_max_423516_423711),
    .in1(out_reg_15_reg_15),
    .in2(out_max_expr_FU_32_32_32_93_i3_fu_min_max_423516_423715));
  max_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423715 (.out1(out_max_expr_FU_32_32_32_93_i3_fu_min_max_423516_423715),
    .in1(out_UIdata_converter_FU_62_i0_fu_min_max_423516_423860),
    .in2(out_reg_12_reg_12));
  max_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423723 (.out1(out_max_expr_FU_32_32_32_93_i4_fu_min_max_423516_423723),
    .in1(out_UIdata_converter_FU_83_i0_fu_min_max_423516_423907),
    .in2(out_reg_27_reg_27));
  read_cond_FU #(.BITSIZE_in1(1)) fu_min_max_423516_423742 (.out1(out_read_cond_FU_57_i0_fu_min_max_423516_423742),
    .in1(out_reg_2_reg_2));
  read_cond_FU #(.BITSIZE_in1(1)) fu_min_max_423516_423746 (.out1(out_read_cond_FU_78_i0_fu_min_max_423516_423746),
    .in1(out_reg_14_reg_14));
  ui_plus_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(1),
    .BITSIZE_out1(64)) fu_min_max_423516_423750 (.out1(out_ui_plus_expr_FU_64_0_64_105_i1_fu_min_max_423516_423750),
    .in1(out_reg_26_reg_26),
    .in2(out_const_2));
  read_cond_FU #(.BITSIZE_in1(1)) fu_min_max_423516_423752 (.out1(out_read_cond_FU_91_i0_fu_min_max_423516_423752),
    .in1(out_reg_29_reg_29));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423801 (.out1(out_IUdata_converter_FU_87_i0_fu_min_max_423516_423801),
    .in1(out_min_expr_FU_32_32_32_94_i4_fu_min_max_423516_423665));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423804 (.out1(out_IUdata_converter_FU_88_i0_fu_min_max_423516_423804),
    .in1(out_max_expr_FU_32_32_32_93_i4_fu_min_max_423516_423723));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423807 (.out1(out_IUdata_converter_FU_72_i0_fu_min_max_423516_423807),
    .in1(out_max_expr_FU_32_32_32_93_i0_fu_min_max_423516_423703));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423810 (.out1(out_IUdata_converter_FU_73_i0_fu_min_max_423516_423810),
    .in1(out_min_expr_FU_32_32_32_94_i0_fu_min_max_423516_423596));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423813 (.out1(out_IUdata_converter_FU_74_i0_fu_min_max_423516_423813),
    .in1(out_max_expr_FU_32_32_32_93_i0_fu_min_max_423516_423703));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423816 (.out1(out_IUdata_converter_FU_75_i0_fu_min_max_423516_423816),
    .in1(out_min_expr_FU_32_32_32_94_i0_fu_min_max_423516_423596));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423819 (.out1(out_IUdata_converter_FU_76_i0_fu_min_max_423516_423819),
    .in1(out_max_expr_FU_32_32_32_93_i0_fu_min_max_423516_423703));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423822 (.out1(out_IUdata_converter_FU_77_i0_fu_min_max_423516_423822),
    .in1(out_min_expr_FU_32_32_32_94_i0_fu_min_max_423516_423596));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423825 (.out1(out_IUdata_converter_FU_89_i0_fu_min_max_423516_423825),
    .in1(out_max_expr_FU_32_32_32_93_i4_fu_min_max_423516_423723));
  IUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423828 (.out1(out_IUdata_converter_FU_90_i0_fu_min_max_423516_423828),
    .in1(out_min_expr_FU_32_32_32_94_i4_fu_min_max_423516_423665));
  ui_lt_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(1)) fu_min_max_423516_423845 (.out1(out_ui_lt_expr_FU_32_0_32_104_i0_fu_min_max_423516_423845),
    .in1(in_port_Pd6),
    .in2(out_const_4));
  lut_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_min_max_423516_423855 (.out1(out_lut_expr_FU_5_i0_fu_min_max_423516_423855),
    .in1(out_const_2),
    .in2(out_ui_extract_bit_expr_FU_3_i0_fu_min_max_423516_424291),
    .in3(out_ui_extract_bit_expr_FU_4_i0_fu_min_max_423516_424295),
    .in4(1'b0),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_min_max_423516_423857 (.out1(out_ui_lshift_expr_FU_32_0_32_101_i0_fu_min_max_423516_423857),
    .in1(out_UUdata_converter_FU_61_i0_fu_min_max_423516_423612),
    .in2(out_const_3));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423860 (.out1(out_UIdata_converter_FU_62_i0_fu_min_max_423516_423860),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423862 (.out1(out_UIdata_converter_FU_63_i0_fu_min_max_423516_423862),
    .in1(out_reg_8_reg_8));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423865 (.out1(out_UIdata_converter_FU_64_i0_fu_min_max_423516_423865),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423867 (.out1(out_UIdata_converter_FU_65_i0_fu_min_max_423516_423867),
    .in1(out_reg_7_reg_7));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_min_max_423516_423869 (.out1(out_ui_lshift_expr_FU_32_0_32_101_i1_fu_min_max_423516_423869),
    .in1(out_ui_bit_ior_expr_FU_32_0_32_99_i0_fu_min_max_423516_423647),
    .in2(out_const_3));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423872 (.out1(out_UIdata_converter_FU_66_i0_fu_min_max_423516_423872),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423875 (.out1(out_UIdata_converter_FU_67_i0_fu_min_max_423516_423875),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_min_max_423516_423877 (.out1(out_ui_lshift_expr_FU_32_0_32_101_i2_fu_min_max_423516_423877),
    .in1(out_ui_bit_ior_expr_FU_32_0_32_98_i0_fu_min_max_423516_423632),
    .in2(out_const_3));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423880 (.out1(out_UIdata_converter_FU_68_i0_fu_min_max_423516_423880),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423883 (.out1(out_UIdata_converter_FU_69_i0_fu_min_max_423516_423883),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_min_max_423516_423885 (.out1(out_ui_lshift_expr_FU_32_0_32_101_i3_fu_min_max_423516_423885),
    .in1(out_ui_bit_ior_expr_FU_32_0_32_97_i0_fu_min_max_423516_423608),
    .in2(out_const_3));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423888 (.out1(out_UIdata_converter_FU_70_i0_fu_min_max_423516_423888),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423891 (.out1(out_UIdata_converter_FU_71_i0_fu_min_max_423516_423891),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0));
  ui_eq_expr_FU #(.BITSIZE_in1(62),
    .BITSIZE_in2(30),
    .BITSIZE_out1(1)) fu_min_max_423516_423893 (.out1(out_ui_eq_expr_FU_64_64_64_100_i0_fu_min_max_423516_423893),
    .in1(out_ui_rshift_expr_FU_64_0_64_109_i1_fu_min_max_423516_423964),
    .in2(out_reg_3_reg_3));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_min_max_423516_423904 (.out1(out_ui_lshift_expr_FU_32_0_32_101_i4_fu_min_max_423516_423904),
    .in1(out_UUdata_converter_FU_82_i0_fu_min_max_423516_423677),
    .in2(out_const_3));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423907 (.out1(out_UIdata_converter_FU_83_i0_fu_min_max_423516_423907),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423909 (.out1(out_UIdata_converter_FU_84_i0_fu_min_max_423516_423909),
    .in1(out_reg_24_reg_24));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423912 (.out1(out_UIdata_converter_FU_85_i0_fu_min_max_423516_423912),
    .in1(out_BMEMORY_CTRL_92_i0_BMEMORY_CTRL_92_i0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_423516_423914 (.out1(out_UIdata_converter_FU_86_i0_fu_min_max_423516_423914),
    .in1(out_reg_22_reg_22));
  ui_eq_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(2),
    .BITSIZE_out1(1)) fu_min_max_423516_423916 (.out1(out_ui_eq_expr_FU_64_64_64_100_i1_fu_min_max_423516_423916),
    .in1(out_ui_plus_expr_FU_64_0_64_105_i1_fu_min_max_423516_423750),
    .in2(out_reg_0_reg_0));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(30),
    .PRECISION(64)) fu_min_max_423516_423945 (.out1(out_ui_rshift_expr_FU_32_0_32_108_i0_fu_min_max_423516_423945),
    .in1(out_UUdata_converter_FU_2_i0_fu_min_max_423516_423571),
    .in2(out_const_3));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(64)) fu_min_max_423516_423951 (.out1(out_ui_lshift_expr_FU_32_0_32_102_i0_fu_min_max_423516_423951),
    .in1(out_ui_bit_and_expr_FU_32_0_32_95_i0_fu_min_max_423516_423687),
    .in2(out_const_3));
  ui_rshift_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(2),
    .BITSIZE_out1(62),
    .PRECISION(64)) fu_min_max_423516_423954 (.out1(out_ui_rshift_expr_FU_64_0_64_109_i0_fu_min_max_423516_423954),
    .in1(out_reg_6_reg_6),
    .in2(out_const_3));
  ui_plus_expr_FU #(.BITSIZE_in1(62),
    .BITSIZE_in2(1),
    .BITSIZE_out1(62)) fu_min_max_423516_423958 (.out1(out_ui_plus_expr_FU_64_0_64_106_i0_fu_min_max_423516_423958),
    .in1(out_ui_rshift_expr_FU_64_0_64_109_i0_fu_min_max_423516_423954),
    .in2(out_const_2));
  ui_lshift_expr_FU #(.BITSIZE_in1(62),
    .BITSIZE_in2(2),
    .BITSIZE_out1(64),
    .PRECISION(64)) fu_min_max_423516_423961 (.out1(out_ui_lshift_expr_FU_64_0_64_103_i0_fu_min_max_423516_423961),
    .in1(out_ui_plus_expr_FU_64_0_64_106_i0_fu_min_max_423516_423958),
    .in2(out_const_3));
  ui_rshift_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(2),
    .BITSIZE_out1(62),
    .PRECISION(64)) fu_min_max_423516_423964 (.out1(out_ui_rshift_expr_FU_64_0_64_109_i1_fu_min_max_423516_423964),
    .in1(out_ui_lshift_expr_FU_64_0_64_103_i0_fu_min_max_423516_423961),
    .in2(out_const_3));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(30),
    .PRECISION(64)) fu_min_max_423516_423967 (.out1(out_ui_rshift_expr_FU_32_0_32_108_i1_fu_min_max_423516_423967),
    .in1(out_ui_lshift_expr_FU_32_0_32_102_i0_fu_min_max_423516_423951),
    .in2(out_const_3));
  multi_read_cond_FU #(.BITSIZE_in1(1),
    .PORTSIZE_in1(2),
    .BITSIZE_out1(2)) fu_min_max_423516_423981 (.out1(out_multi_read_cond_FU_47_i0_fu_min_max_423516_423981),
    .in1({out_reg_5_reg_5,
      out_reg_4_reg_4}));
  lut_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_out1(1)) fu_min_max_423516_423984 (.out1(out_lut_expr_FU_44_i0_fu_min_max_423516_423984),
    .in1(out_const_28),
    .in2(out_ui_extract_bit_expr_FU_37_i0_fu_min_max_423516_424283),
    .in3(out_lut_expr_FU_43_i0_fu_min_max_423516_424315),
    .in4(1'b0),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(3),
    .BITSIZE_out1(1)) fu_min_max_423516_423987 (.out1(out_lut_expr_FU_46_i0_fu_min_max_423516_423987),
    .in1(out_const_4),
    .in2(out_ui_extract_bit_expr_FU_45_i0_fu_min_max_423516_424287),
    .in3(out_ui_lt_expr_FU_32_0_32_104_i0_fu_min_max_423516_423845),
    .in4(out_lut_expr_FU_43_i0_fu_min_max_423516_424315),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1)) fu_min_max_423516_424159 (.out1(out_ui_extract_bit_expr_FU_6_i0_fu_min_max_423516_424159),
    .in1(in_port_Pd6),
    .in2(out_const_0));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1)) fu_min_max_423516_424163 (.out1(out_ui_extract_bit_expr_FU_7_i0_fu_min_max_423516_424163),
    .in1(in_port_Pd6),
    .in2(out_const_2));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2)) fu_min_max_423516_424167 (.out1(out_ui_extract_bit_expr_FU_8_i0_fu_min_max_423516_424167),
    .in1(in_port_Pd6),
    .in2(out_const_3));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2)) fu_min_max_423516_424171 (.out1(out_ui_extract_bit_expr_FU_9_i0_fu_min_max_423516_424171),
    .in1(in_port_Pd6),
    .in2(out_const_19));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3)) fu_min_max_423516_424175 (.out1(out_ui_extract_bit_expr_FU_10_i0_fu_min_max_423516_424175),
    .in1(in_port_Pd6),
    .in2(out_const_4));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3)) fu_min_max_423516_424179 (.out1(out_ui_extract_bit_expr_FU_11_i0_fu_min_max_423516_424179),
    .in1(in_port_Pd6),
    .in2(out_const_12));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3)) fu_min_max_423516_424183 (.out1(out_ui_extract_bit_expr_FU_12_i0_fu_min_max_423516_424183),
    .in1(in_port_Pd6),
    .in2(out_const_20));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3)) fu_min_max_423516_424187 (.out1(out_ui_extract_bit_expr_FU_13_i0_fu_min_max_423516_424187),
    .in1(in_port_Pd6),
    .in2(out_const_27));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_424191 (.out1(out_ui_extract_bit_expr_FU_14_i0_fu_min_max_423516_424191),
    .in1(in_port_Pd6),
    .in2(out_const_5));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_424195 (.out1(out_ui_extract_bit_expr_FU_15_i0_fu_min_max_423516_424195),
    .in1(in_port_Pd6),
    .in2(out_const_9));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_424199 (.out1(out_ui_extract_bit_expr_FU_16_i0_fu_min_max_423516_424199),
    .in1(in_port_Pd6),
    .in2(out_const_13));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_424203 (.out1(out_ui_extract_bit_expr_FU_17_i0_fu_min_max_423516_424203),
    .in1(in_port_Pd6),
    .in2(out_const_16));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_424207 (.out1(out_ui_extract_bit_expr_FU_18_i0_fu_min_max_423516_424207),
    .in1(in_port_Pd6),
    .in2(out_const_21));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_424211 (.out1(out_ui_extract_bit_expr_FU_19_i0_fu_min_max_423516_424211),
    .in1(in_port_Pd6),
    .in2(out_const_24));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_424215 (.out1(out_ui_extract_bit_expr_FU_20_i0_fu_min_max_423516_424215),
    .in1(in_port_Pd6),
    .in2(out_const_28));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4)) fu_min_max_423516_424219 (.out1(out_ui_extract_bit_expr_FU_21_i0_fu_min_max_423516_424219),
    .in1(in_port_Pd6),
    .in2(out_const_31));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424223 (.out1(out_ui_extract_bit_expr_FU_22_i0_fu_min_max_423516_424223),
    .in1(in_port_Pd6),
    .in2(out_const_6));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424227 (.out1(out_ui_extract_bit_expr_FU_23_i0_fu_min_max_423516_424227),
    .in1(in_port_Pd6),
    .in2(out_const_8));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424231 (.out1(out_ui_extract_bit_expr_FU_24_i0_fu_min_max_423516_424231),
    .in1(in_port_Pd6),
    .in2(out_const_10));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424235 (.out1(out_ui_extract_bit_expr_FU_25_i0_fu_min_max_423516_424235),
    .in1(in_port_Pd6),
    .in2(out_const_11));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424239 (.out1(out_ui_extract_bit_expr_FU_26_i0_fu_min_max_423516_424239),
    .in1(in_port_Pd6),
    .in2(out_const_14));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424243 (.out1(out_ui_extract_bit_expr_FU_27_i0_fu_min_max_423516_424243),
    .in1(in_port_Pd6),
    .in2(out_const_15));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424247 (.out1(out_ui_extract_bit_expr_FU_28_i0_fu_min_max_423516_424247),
    .in1(in_port_Pd6),
    .in2(out_const_17));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424251 (.out1(out_ui_extract_bit_expr_FU_29_i0_fu_min_max_423516_424251),
    .in1(in_port_Pd6),
    .in2(out_const_18));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424255 (.out1(out_ui_extract_bit_expr_FU_30_i0_fu_min_max_423516_424255),
    .in1(in_port_Pd6),
    .in2(out_const_22));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424259 (.out1(out_ui_extract_bit_expr_FU_31_i0_fu_min_max_423516_424259),
    .in1(in_port_Pd6),
    .in2(out_const_23));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424263 (.out1(out_ui_extract_bit_expr_FU_32_i0_fu_min_max_423516_424263),
    .in1(in_port_Pd6),
    .in2(out_const_25));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424267 (.out1(out_ui_extract_bit_expr_FU_33_i0_fu_min_max_423516_424267),
    .in1(in_port_Pd6),
    .in2(out_const_26));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424271 (.out1(out_ui_extract_bit_expr_FU_34_i0_fu_min_max_423516_424271),
    .in1(in_port_Pd6),
    .in2(out_const_29));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424275 (.out1(out_ui_extract_bit_expr_FU_35_i0_fu_min_max_423516_424275),
    .in1(in_port_Pd6),
    .in2(out_const_30));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424279 (.out1(out_ui_extract_bit_expr_FU_36_i0_fu_min_max_423516_424279),
    .in1(in_port_Pd6),
    .in2(out_const_32));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424283 (.out1(out_ui_extract_bit_expr_FU_37_i0_fu_min_max_423516_424283),
    .in1(in_port_Pd6),
    .in2(out_const_33));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(5)) fu_min_max_423516_424287 (.out1(out_ui_extract_bit_expr_FU_45_i0_fu_min_max_423516_424287),
    .in1(in_port_Pd6),
    .in2(out_const_33));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1)) fu_min_max_423516_424291 (.out1(out_ui_extract_bit_expr_FU_3_i0_fu_min_max_423516_424291),
    .in1(in_port_Pd6),
    .in2(out_const_0));
  ui_extract_bit_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1)) fu_min_max_423516_424295 (.out1(out_ui_extract_bit_expr_FU_4_i0_fu_min_max_423516_424295),
    .in1(in_port_Pd6),
    .in2(out_const_2));
  lut_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) fu_min_max_423516_424300 (.out1(out_lut_expr_FU_38_i0_fu_min_max_423516_424300),
    .in1(out_const_2),
    .in2(out_ui_extract_bit_expr_FU_6_i0_fu_min_max_423516_424159),
    .in3(out_ui_extract_bit_expr_FU_7_i0_fu_min_max_423516_424163),
    .in4(out_ui_extract_bit_expr_FU_8_i0_fu_min_max_423516_424167),
    .in5(out_ui_extract_bit_expr_FU_9_i0_fu_min_max_423516_424171),
    .in6(out_ui_extract_bit_expr_FU_10_i0_fu_min_max_423516_424175),
    .in7(out_ui_extract_bit_expr_FU_11_i0_fu_min_max_423516_424179),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(33),
    .BITSIZE_out1(1)) fu_min_max_423516_424303 (.out1(out_lut_expr_FU_39_i0_fu_min_max_423516_424303),
    .in1(out_const_7),
    .in2(out_ui_extract_bit_expr_FU_12_i0_fu_min_max_423516_424183),
    .in3(out_ui_extract_bit_expr_FU_13_i0_fu_min_max_423516_424187),
    .in4(out_ui_extract_bit_expr_FU_14_i0_fu_min_max_423516_424191),
    .in5(out_ui_extract_bit_expr_FU_15_i0_fu_min_max_423516_424195),
    .in6(out_ui_extract_bit_expr_FU_16_i0_fu_min_max_423516_424199),
    .in7(out_lut_expr_FU_38_i0_fu_min_max_423516_424300),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(33),
    .BITSIZE_out1(1)) fu_min_max_423516_424306 (.out1(out_lut_expr_FU_40_i0_fu_min_max_423516_424306),
    .in1(out_const_7),
    .in2(out_ui_extract_bit_expr_FU_17_i0_fu_min_max_423516_424203),
    .in3(out_ui_extract_bit_expr_FU_18_i0_fu_min_max_423516_424207),
    .in4(out_ui_extract_bit_expr_FU_19_i0_fu_min_max_423516_424211),
    .in5(out_ui_extract_bit_expr_FU_20_i0_fu_min_max_423516_424215),
    .in6(out_ui_extract_bit_expr_FU_21_i0_fu_min_max_423516_424219),
    .in7(out_lut_expr_FU_39_i0_fu_min_max_423516_424303),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(33),
    .BITSIZE_out1(1)) fu_min_max_423516_424309 (.out1(out_lut_expr_FU_41_i0_fu_min_max_423516_424309),
    .in1(out_const_7),
    .in2(out_ui_extract_bit_expr_FU_22_i0_fu_min_max_423516_424223),
    .in3(out_ui_extract_bit_expr_FU_23_i0_fu_min_max_423516_424227),
    .in4(out_ui_extract_bit_expr_FU_24_i0_fu_min_max_423516_424231),
    .in5(out_ui_extract_bit_expr_FU_25_i0_fu_min_max_423516_424235),
    .in6(out_ui_extract_bit_expr_FU_26_i0_fu_min_max_423516_424239),
    .in7(out_lut_expr_FU_40_i0_fu_min_max_423516_424306),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(33),
    .BITSIZE_out1(1)) fu_min_max_423516_424312 (.out1(out_lut_expr_FU_42_i0_fu_min_max_423516_424312),
    .in1(out_const_7),
    .in2(out_ui_extract_bit_expr_FU_27_i0_fu_min_max_423516_424243),
    .in3(out_ui_extract_bit_expr_FU_28_i0_fu_min_max_423516_424247),
    .in4(out_ui_extract_bit_expr_FU_29_i0_fu_min_max_423516_424251),
    .in5(out_ui_extract_bit_expr_FU_30_i0_fu_min_max_423516_424255),
    .in6(out_ui_extract_bit_expr_FU_31_i0_fu_min_max_423516_424259),
    .in7(out_lut_expr_FU_41_i0_fu_min_max_423516_424309),
    .in8(1'b0),
    .in9(1'b0));
  lut_expr_FU #(.BITSIZE_in1(33),
    .BITSIZE_out1(1)) fu_min_max_423516_424315 (.out1(out_lut_expr_FU_43_i0_fu_min_max_423516_424315),
    .in1(out_const_7),
    .in2(out_ui_extract_bit_expr_FU_32_i0_fu_min_max_423516_424263),
    .in3(out_ui_extract_bit_expr_FU_33_i0_fu_min_max_423516_424267),
    .in4(out_ui_extract_bit_expr_FU_34_i0_fu_min_max_423516_424271),
    .in5(out_ui_extract_bit_expr_FU_35_i0_fu_min_max_423516_424275),
    .in6(out_ui_extract_bit_expr_FU_36_i0_fu_min_max_423516_424279),
    .in7(out_lut_expr_FU_42_i0_fu_min_max_423516_424312),
    .in8(1'b0),
    .in9(1'b0));
  register_SE #(.BITSIZE_in1(2),
    .BITSIZE_out1(2)) reg_0 (.out1(out_reg_0_reg_0),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_bit_and_expr_FU_8_0_8_96_i0_fu_min_max_423516_423572),
    .wenable(wrenable_reg_0));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_1 (.out1(out_reg_1_reg_1),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_113_reg_1_0_0_0),
    .wenable(wrenable_reg_1));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_10 (.out1(out_reg_10_reg_10),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_107_i1_fu_min_max_423516_423628),
    .wenable(wrenable_reg_10));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_11 (.out1(out_reg_11_reg_11),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_107_i3_fu_min_max_423516_423658),
    .wenable(wrenable_reg_11));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_12 (.out1(out_reg_12_reg_12),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_63_i0_fu_min_max_423516_423862),
    .wenable(wrenable_reg_12));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_13 (.out1(out_reg_13_reg_13),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_65_i0_fu_min_max_423516_423867),
    .wenable(wrenable_reg_13));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_14 (.out1(out_reg_14_reg_14),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_eq_expr_FU_64_64_64_100_i0_fu_min_max_423516_423893),
    .wenable(wrenable_reg_14));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_15 (.out1(out_reg_15_reg_15),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_66_i0_fu_min_max_423516_423872),
    .wenable(wrenable_reg_15));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_16 (.out1(out_reg_16_reg_16),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_67_i0_fu_min_max_423516_423875),
    .wenable(wrenable_reg_16));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_17 (.out1(out_reg_17_reg_17),
    .clock(clock),
    .reset(reset),
    .in1(out_min_expr_FU_32_32_32_94_i2_fu_min_max_423516_423635),
    .wenable(wrenable_reg_17));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_18 (.out1(out_reg_18_reg_18),
    .clock(clock),
    .reset(reset),
    .in1(out_max_expr_FU_32_32_32_93_i2_fu_min_max_423516_423711),
    .wenable(wrenable_reg_18));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_19 (.out1(out_reg_19_reg_19),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_70_i0_fu_min_max_423516_423888),
    .wenable(wrenable_reg_19));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_2 (.out1(out_reg_2_reg_2),
    .clock(clock),
    .reset(reset),
    .in1(out_lut_expr_FU_5_i0_fu_min_max_423516_423855),
    .wenable(wrenable_reg_2));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_20 (.out1(out_reg_20_reg_20),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_71_i0_fu_min_max_423516_423891),
    .wenable(wrenable_reg_20));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_21 (.out1(out_reg_21_reg_21),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_126_reg_21_0_1_0),
    .wenable(wrenable_reg_21));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_22 (.out1(out_reg_22_reg_22),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_127_reg_22_0_0_1),
    .wenable(wrenable_reg_22));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_23 (.out1(out_reg_23_reg_23),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_128_reg_23_0_1_0),
    .wenable(wrenable_reg_23));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_24 (.out1(out_reg_24_reg_24),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_129_reg_24_0_0_1),
    .wenable(wrenable_reg_24));
  register_SE #(.BITSIZE_in1(64),
    .BITSIZE_out1(64)) reg_25 (.out1(out_reg_25_reg_25),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_130_reg_25_0_0_0),
    .wenable(wrenable_reg_25));
  register_SE #(.BITSIZE_in1(64),
    .BITSIZE_out1(64)) reg_26 (.out1(out_reg_26_reg_26),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_131_reg_26_0_0_0),
    .wenable(wrenable_reg_26));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_27 (.out1(out_reg_27_reg_27),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_84_i0_fu_min_max_423516_423909),
    .wenable(wrenable_reg_27));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_28 (.out1(out_reg_28_reg_28),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_86_i0_fu_min_max_423516_423914),
    .wenable(wrenable_reg_28));
  register_STD #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_29 (.out1(out_reg_29_reg_29),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_eq_expr_FU_64_64_64_100_i1_fu_min_max_423516_423916),
    .wenable(wrenable_reg_29));
  register_SE #(.BITSIZE_in1(30),
    .BITSIZE_out1(30)) reg_3 (.out1(out_reg_3_reg_3),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_rshift_expr_FU_32_0_32_108_i1_fu_min_max_423516_423967),
    .wenable(wrenable_reg_3));
  register_STD #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_4 (.out1(out_reg_4_reg_4),
    .clock(clock),
    .reset(reset),
    .in1(out_lut_expr_FU_44_i0_fu_min_max_423516_423984),
    .wenable(wrenable_reg_4));
  register_STD #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_5 (.out1(out_reg_5_reg_5),
    .clock(clock),
    .reset(reset),
    .in1(out_lut_expr_FU_46_i0_fu_min_max_423516_423987),
    .wenable(wrenable_reg_5));
  register_SE #(.BITSIZE_in1(64),
    .BITSIZE_out1(64)) reg_6 (.out1(out_reg_6_reg_6),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_138_reg_6_0_0_0),
    .wenable(wrenable_reg_6));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_7 (.out1(out_reg_7_reg_7),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_139_reg_7_0_0_0),
    .wenable(wrenable_reg_7));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_8 (.out1(out_reg_8_reg_8),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_140_reg_8_0_0_0),
    .wenable(wrenable_reg_8));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_9 (.out1(out_reg_9_reg_9),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_107_i0_fu_min_max_423516_423604),
    .wenable(wrenable_reg_9));
  // io-signal post fix
  assign Mout_oe_ram = sig_out_bus_mergerMout_oe_ram3_;
  assign Mout_we_ram = sig_out_bus_mergerMout_we_ram4_;
  assign Mout_addr_ram = sig_out_bus_mergerMout_addr_ram1_;
  assign Mout_Wdata_ram = sig_out_bus_mergerMout_Wdata_ram0_;
  assign Mout_data_ram_size = sig_out_bus_mergerMout_data_ram_size2_;
  assign OUT_CONDITION_min_max_423516_423742 = out_read_cond_FU_57_i0_fu_min_max_423516_423742;
  assign OUT_CONDITION_min_max_423516_423746 = out_read_cond_FU_78_i0_fu_min_max_423516_423746;
  assign OUT_CONDITION_min_max_423516_423752 = out_read_cond_FU_91_i0_fu_min_max_423516_423752;
  assign OUT_MULTIIF_min_max_423516_423981 = out_multi_read_cond_FU_47_i0_fu_min_max_423516_423981;

endmodule

// FSM based controller description for min_max
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module controller_min_max(done_port,
  fuselector_BMEMORY_CTRL_92_i0_LOAD,
  fuselector_BMEMORY_CTRL_92_i0_STORE,
  selector_MUX_0_BMEMORY_CTRL_92_i0_0_0_0,
  selector_MUX_113_reg_1_0_0_0,
  selector_MUX_126_reg_21_0_0_0,
  selector_MUX_126_reg_21_0_0_1,
  selector_MUX_126_reg_21_0_1_0,
  selector_MUX_127_reg_22_0_0_0,
  selector_MUX_127_reg_22_0_0_1,
  selector_MUX_128_reg_23_0_0_0,
  selector_MUX_128_reg_23_0_0_1,
  selector_MUX_128_reg_23_0_1_0,
  selector_MUX_129_reg_24_0_0_0,
  selector_MUX_129_reg_24_0_0_1,
  selector_MUX_130_reg_25_0_0_0,
  selector_MUX_131_reg_26_0_0_0,
  selector_MUX_138_reg_6_0_0_0,
  selector_MUX_139_reg_7_0_0_0,
  selector_MUX_140_reg_8_0_0_0,
  selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_0,
  selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_1,
  selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_2,
  selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_3,
  selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_0,
  selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_1,
  selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0,
  wrenable_reg_0,
  wrenable_reg_1,
  wrenable_reg_10,
  wrenable_reg_11,
  wrenable_reg_12,
  wrenable_reg_13,
  wrenable_reg_14,
  wrenable_reg_15,
  wrenable_reg_16,
  wrenable_reg_17,
  wrenable_reg_18,
  wrenable_reg_19,
  wrenable_reg_2,
  wrenable_reg_20,
  wrenable_reg_21,
  wrenable_reg_22,
  wrenable_reg_23,
  wrenable_reg_24,
  wrenable_reg_25,
  wrenable_reg_26,
  wrenable_reg_27,
  wrenable_reg_28,
  wrenable_reg_29,
  wrenable_reg_3,
  wrenable_reg_4,
  wrenable_reg_5,
  wrenable_reg_6,
  wrenable_reg_7,
  wrenable_reg_8,
  wrenable_reg_9,
  OUT_CONDITION_min_max_423516_423742,
  OUT_CONDITION_min_max_423516_423746,
  OUT_CONDITION_min_max_423516_423752,
  OUT_MULTIIF_min_max_423516_423981,
  clock,
  reset,
  start_port);
  // IN
  input OUT_CONDITION_min_max_423516_423742;
  input OUT_CONDITION_min_max_423516_423746;
  input OUT_CONDITION_min_max_423516_423752;
  input [1:0] OUT_MULTIIF_min_max_423516_423981;
  input clock;
  input reset;
  input start_port;
  // OUT
  output done_port;
  output fuselector_BMEMORY_CTRL_92_i0_LOAD;
  output fuselector_BMEMORY_CTRL_92_i0_STORE;
  output selector_MUX_0_BMEMORY_CTRL_92_i0_0_0_0;
  output selector_MUX_113_reg_1_0_0_0;
  output selector_MUX_126_reg_21_0_0_0;
  output selector_MUX_126_reg_21_0_0_1;
  output selector_MUX_126_reg_21_0_1_0;
  output selector_MUX_127_reg_22_0_0_0;
  output selector_MUX_127_reg_22_0_0_1;
  output selector_MUX_128_reg_23_0_0_0;
  output selector_MUX_128_reg_23_0_0_1;
  output selector_MUX_128_reg_23_0_1_0;
  output selector_MUX_129_reg_24_0_0_0;
  output selector_MUX_129_reg_24_0_0_1;
  output selector_MUX_130_reg_25_0_0_0;
  output selector_MUX_131_reg_26_0_0_0;
  output selector_MUX_138_reg_6_0_0_0;
  output selector_MUX_139_reg_7_0_0_0;
  output selector_MUX_140_reg_8_0_0_0;
  output selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_0;
  output selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_1;
  output selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_2;
  output selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_3;
  output selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_0;
  output selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_1;
  output selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0;
  output wrenable_reg_0;
  output wrenable_reg_1;
  output wrenable_reg_10;
  output wrenable_reg_11;
  output wrenable_reg_12;
  output wrenable_reg_13;
  output wrenable_reg_14;
  output wrenable_reg_15;
  output wrenable_reg_16;
  output wrenable_reg_17;
  output wrenable_reg_18;
  output wrenable_reg_19;
  output wrenable_reg_2;
  output wrenable_reg_20;
  output wrenable_reg_21;
  output wrenable_reg_22;
  output wrenable_reg_23;
  output wrenable_reg_24;
  output wrenable_reg_25;
  output wrenable_reg_26;
  output wrenable_reg_27;
  output wrenable_reg_28;
  output wrenable_reg_29;
  output wrenable_reg_3;
  output wrenable_reg_4;
  output wrenable_reg_5;
  output wrenable_reg_6;
  output wrenable_reg_7;
  output wrenable_reg_8;
  output wrenable_reg_9;
  parameter [12:0] S_0 = 13'b0000000000001,
    S_1 = 13'b0000000000010,
    S_6 = 13'b0000001000000,
    S_7 = 13'b0000010000000,
    S_8 = 13'b0000100000000,
    S_9 = 13'b0001000000000,
    S_10 = 13'b0010000000000,
    S_5 = 13'b0000000100000,
    S_11 = 13'b0100000000000,
    S_12 = 13'b1000000000000,
    S_2 = 13'b0000000000100,
    S_3 = 13'b0000000001000,
    S_4 = 13'b0000000010000;
  reg [12:0] _present_state=S_0, _next_state;
  reg done_port;
  reg fuselector_BMEMORY_CTRL_92_i0_LOAD;
  reg fuselector_BMEMORY_CTRL_92_i0_STORE;
  reg selector_MUX_0_BMEMORY_CTRL_92_i0_0_0_0;
  reg selector_MUX_113_reg_1_0_0_0;
  reg selector_MUX_126_reg_21_0_0_0;
  reg selector_MUX_126_reg_21_0_0_1;
  reg selector_MUX_126_reg_21_0_1_0;
  reg selector_MUX_127_reg_22_0_0_0;
  reg selector_MUX_127_reg_22_0_0_1;
  reg selector_MUX_128_reg_23_0_0_0;
  reg selector_MUX_128_reg_23_0_0_1;
  reg selector_MUX_128_reg_23_0_1_0;
  reg selector_MUX_129_reg_24_0_0_0;
  reg selector_MUX_129_reg_24_0_0_1;
  reg selector_MUX_130_reg_25_0_0_0;
  reg selector_MUX_131_reg_26_0_0_0;
  reg selector_MUX_138_reg_6_0_0_0;
  reg selector_MUX_139_reg_7_0_0_0;
  reg selector_MUX_140_reg_8_0_0_0;
  reg selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_0;
  reg selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_1;
  reg selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_2;
  reg selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_3;
  reg selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_0;
  reg selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_1;
  reg selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0;
  reg wrenable_reg_0;
  reg wrenable_reg_1;
  reg wrenable_reg_10;
  reg wrenable_reg_11;
  reg wrenable_reg_12;
  reg wrenable_reg_13;
  reg wrenable_reg_14;
  reg wrenable_reg_15;
  reg wrenable_reg_16;
  reg wrenable_reg_17;
  reg wrenable_reg_18;
  reg wrenable_reg_19;
  reg wrenable_reg_2;
  reg wrenable_reg_20;
  reg wrenable_reg_21;
  reg wrenable_reg_22;
  reg wrenable_reg_23;
  reg wrenable_reg_24;
  reg wrenable_reg_25;
  reg wrenable_reg_26;
  reg wrenable_reg_27;
  reg wrenable_reg_28;
  reg wrenable_reg_29;
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
    fuselector_BMEMORY_CTRL_92_i0_LOAD = 1'b0;
    fuselector_BMEMORY_CTRL_92_i0_STORE = 1'b0;
    selector_MUX_0_BMEMORY_CTRL_92_i0_0_0_0 = 1'b0;
    selector_MUX_113_reg_1_0_0_0 = 1'b0;
    selector_MUX_126_reg_21_0_0_0 = 1'b0;
    selector_MUX_126_reg_21_0_0_1 = 1'b0;
    selector_MUX_126_reg_21_0_1_0 = 1'b0;
    selector_MUX_127_reg_22_0_0_0 = 1'b0;
    selector_MUX_127_reg_22_0_0_1 = 1'b0;
    selector_MUX_128_reg_23_0_0_0 = 1'b0;
    selector_MUX_128_reg_23_0_0_1 = 1'b0;
    selector_MUX_128_reg_23_0_1_0 = 1'b0;
    selector_MUX_129_reg_24_0_0_0 = 1'b0;
    selector_MUX_129_reg_24_0_0_1 = 1'b0;
    selector_MUX_130_reg_25_0_0_0 = 1'b0;
    selector_MUX_131_reg_26_0_0_0 = 1'b0;
    selector_MUX_138_reg_6_0_0_0 = 1'b0;
    selector_MUX_139_reg_7_0_0_0 = 1'b0;
    selector_MUX_140_reg_8_0_0_0 = 1'b0;
    selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_0 = 1'b0;
    selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_1 = 1'b0;
    selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_2 = 1'b0;
    selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_3 = 1'b0;
    selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_0 = 1'b0;
    selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_1 = 1'b0;
    selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0 = 1'b0;
    wrenable_reg_0 = 1'b0;
    wrenable_reg_1 = 1'b0;
    wrenable_reg_10 = 1'b0;
    wrenable_reg_11 = 1'b0;
    wrenable_reg_12 = 1'b0;
    wrenable_reg_13 = 1'b0;
    wrenable_reg_14 = 1'b0;
    wrenable_reg_15 = 1'b0;
    wrenable_reg_16 = 1'b0;
    wrenable_reg_17 = 1'b0;
    wrenable_reg_18 = 1'b0;
    wrenable_reg_19 = 1'b0;
    wrenable_reg_2 = 1'b0;
    wrenable_reg_20 = 1'b0;
    wrenable_reg_21 = 1'b0;
    wrenable_reg_22 = 1'b0;
    wrenable_reg_23 = 1'b0;
    wrenable_reg_24 = 1'b0;
    wrenable_reg_25 = 1'b0;
    wrenable_reg_26 = 1'b0;
    wrenable_reg_27 = 1'b0;
    wrenable_reg_28 = 1'b0;
    wrenable_reg_29 = 1'b0;
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
          fuselector_BMEMORY_CTRL_92_i0_LOAD = 1'b1;
          selector_MUX_113_reg_1_0_0_0 = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0 = 1'b1;
          wrenable_reg_0 = 1'b1;
          wrenable_reg_1 = 1'b1;
          wrenable_reg_2 = 1'b1;
          wrenable_reg_3 = 1'b1;
          wrenable_reg_4 = 1'b1;
          wrenable_reg_5 = 1'b1;
          _next_state = S_1;
        end
        else
        begin
          _next_state = S_0;
        end
      S_1 :
        begin
          selector_MUX_126_reg_21_0_0_0 = 1'b1;
          selector_MUX_126_reg_21_0_1_0 = 1'b1;
          selector_MUX_127_reg_22_0_0_0 = 1'b1;
          selector_MUX_128_reg_23_0_0_0 = 1'b1;
          selector_MUX_128_reg_23_0_1_0 = 1'b1;
          selector_MUX_129_reg_24_0_0_0 = 1'b1;
          selector_MUX_139_reg_7_0_0_0 = 1'b1;
          selector_MUX_140_reg_8_0_0_0 = 1'b1;
          wrenable_reg_1 = 1'b1;
          wrenable_reg_21 = 1'b1;
          wrenable_reg_22 = 1'b1;
          wrenable_reg_23 = 1'b1;
          wrenable_reg_24 = 1'b1;
          wrenable_reg_6 = 1'b1;
          wrenable_reg_7 = 1'b1;
          wrenable_reg_8 = 1'b1;
          casez (OUT_MULTIIF_min_max_423516_423981)
            2'b?1 :
              begin
                _next_state = S_2;
                selector_MUX_127_reg_22_0_0_0 = 1'b0;
                selector_MUX_129_reg_24_0_0_0 = 1'b0;
                selector_MUX_139_reg_7_0_0_0 = 1'b0;
                selector_MUX_140_reg_8_0_0_0 = 1'b0;
                wrenable_reg_1 = 1'b0;
                wrenable_reg_22 = 1'b0;
                wrenable_reg_24 = 1'b0;
                wrenable_reg_6 = 1'b0;
                wrenable_reg_7 = 1'b0;
                wrenable_reg_8 = 1'b0;
              end
            2'b10 :
              begin
                _next_state = S_5;
                selector_MUX_126_reg_21_0_0_0 = 1'b0;
                selector_MUX_126_reg_21_0_1_0 = 1'b0;
                selector_MUX_128_reg_23_0_0_0 = 1'b0;
                selector_MUX_128_reg_23_0_1_0 = 1'b0;
                selector_MUX_139_reg_7_0_0_0 = 1'b0;
                selector_MUX_140_reg_8_0_0_0 = 1'b0;
                wrenable_reg_6 = 1'b0;
                wrenable_reg_7 = 1'b0;
                wrenable_reg_8 = 1'b0;
              end
            default:
              begin
                _next_state = S_6;
                selector_MUX_126_reg_21_0_0_0 = 1'b0;
                selector_MUX_126_reg_21_0_1_0 = 1'b0;
                selector_MUX_127_reg_22_0_0_0 = 1'b0;
                selector_MUX_128_reg_23_0_0_0 = 1'b0;
                selector_MUX_128_reg_23_0_1_0 = 1'b0;
                selector_MUX_129_reg_24_0_0_0 = 1'b0;
                wrenable_reg_1 = 1'b0;
                wrenable_reg_21 = 1'b0;
                wrenable_reg_22 = 1'b0;
                wrenable_reg_23 = 1'b0;
                wrenable_reg_24 = 1'b0;
              end
          endcase
        end
      S_6 :
        begin
          fuselector_BMEMORY_CTRL_92_i0_LOAD = 1'b1;
          selector_MUX_138_reg_6_0_0_0 = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_3 = 1'b1;
          wrenable_reg_10 = 1'b1;
          wrenable_reg_11 = 1'b1;
          wrenable_reg_12 = 1'b1;
          wrenable_reg_13 = 1'b1;
          wrenable_reg_14 = 1'b1;
          wrenable_reg_6 = 1'b1;
          wrenable_reg_9 = 1'b1;
          _next_state = S_7;
        end
      S_7 :
        begin
          fuselector_BMEMORY_CTRL_92_i0_LOAD = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_0 = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0 = 1'b1;
          wrenable_reg_15 = 1'b1;
          wrenable_reg_16 = 1'b1;
          _next_state = S_8;
        end
      S_8 :
        begin
          fuselector_BMEMORY_CTRL_92_i0_LOAD = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_0 = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_0 = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0 = 1'b1;
          wrenable_reg_17 = 1'b1;
          wrenable_reg_18 = 1'b1;
          _next_state = S_9;
        end
      S_9 :
        begin
          fuselector_BMEMORY_CTRL_92_i0_LOAD = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_1 = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0 = 1'b1;
          wrenable_reg_19 = 1'b1;
          wrenable_reg_20 = 1'b1;
          _next_state = S_10;
        end
      S_10 :
        begin
          selector_MUX_126_reg_21_0_1_0 = 1'b1;
          selector_MUX_128_reg_23_0_1_0 = 1'b1;
          wrenable_reg_21 = 1'b1;
          wrenable_reg_22 = 1'b1;
          wrenable_reg_23 = 1'b1;
          wrenable_reg_24 = 1'b1;
          wrenable_reg_7 = 1'b1;
          wrenable_reg_8 = 1'b1;
          if (OUT_CONDITION_min_max_423516_423746 == 1'b1)
            begin
              _next_state = S_5;
              wrenable_reg_7 = 1'b0;
              wrenable_reg_8 = 1'b0;
            end
          else
            begin
              _next_state = S_6;
              selector_MUX_126_reg_21_0_1_0 = 1'b0;
              selector_MUX_128_reg_23_0_1_0 = 1'b0;
              wrenable_reg_21 = 1'b0;
              wrenable_reg_22 = 1'b0;
              wrenable_reg_23 = 1'b0;
              wrenable_reg_24 = 1'b0;
            end
        end
      S_5 :
        begin
          wrenable_reg_25 = 1'b1;
          wrenable_reg_26 = 1'b1;
          if (OUT_CONDITION_min_max_423516_423742 == 1'b1)
            begin
              _next_state = S_2;
              wrenable_reg_25 = 1'b0;
              wrenable_reg_26 = 1'b0;
            end
          else
            begin
              _next_state = S_11;
            end
        end
      S_11 :
        begin
          fuselector_BMEMORY_CTRL_92_i0_LOAD = 1'b1;
          selector_MUX_130_reg_25_0_0_0 = 1'b1;
          selector_MUX_131_reg_26_0_0_0 = 1'b1;
          wrenable_reg_25 = 1'b1;
          wrenable_reg_26 = 1'b1;
          wrenable_reg_27 = 1'b1;
          wrenable_reg_28 = 1'b1;
          wrenable_reg_29 = 1'b1;
          _next_state = S_12;
        end
      S_12 :
        begin
          selector_MUX_126_reg_21_0_0_1 = 1'b1;
          selector_MUX_127_reg_22_0_0_1 = 1'b1;
          selector_MUX_128_reg_23_0_0_1 = 1'b1;
          selector_MUX_129_reg_24_0_0_1 = 1'b1;
          wrenable_reg_21 = 1'b1;
          wrenable_reg_22 = 1'b1;
          wrenable_reg_23 = 1'b1;
          wrenable_reg_24 = 1'b1;
          if (OUT_CONDITION_min_max_423516_423752 == 1'b1)
            begin
              _next_state = S_2;
              selector_MUX_127_reg_22_0_0_1 = 1'b0;
              selector_MUX_129_reg_24_0_0_1 = 1'b0;
              wrenable_reg_22 = 1'b0;
              wrenable_reg_24 = 1'b0;
            end
          else
            begin
              _next_state = S_11;
              selector_MUX_126_reg_21_0_0_1 = 1'b0;
              selector_MUX_128_reg_23_0_0_1 = 1'b0;
              wrenable_reg_21 = 1'b0;
              wrenable_reg_23 = 1'b0;
            end
        end
      S_2 :
        begin
          fuselector_BMEMORY_CTRL_92_i0_STORE = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_1 = 1'b1;
          _next_state = S_3;
        end
      S_3 :
        begin
          fuselector_BMEMORY_CTRL_92_i0_STORE = 1'b1;
          selector_MUX_0_BMEMORY_CTRL_92_i0_0_0_0 = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_2 = 1'b1;
          selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_1 = 1'b1;
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
  wire OUT_CONDITION_min_max_423516_423742;
  wire OUT_CONDITION_min_max_423516_423746;
  wire OUT_CONDITION_min_max_423516_423752;
  wire [1:0] OUT_MULTIIF_min_max_423516_423981;
  wire done_delayed_REG_signal_in;
  wire done_delayed_REG_signal_out;
  wire fuselector_BMEMORY_CTRL_92_i0_LOAD;
  wire fuselector_BMEMORY_CTRL_92_i0_STORE;
  wire selector_MUX_0_BMEMORY_CTRL_92_i0_0_0_0;
  wire selector_MUX_113_reg_1_0_0_0;
  wire selector_MUX_126_reg_21_0_0_0;
  wire selector_MUX_126_reg_21_0_0_1;
  wire selector_MUX_126_reg_21_0_1_0;
  wire selector_MUX_127_reg_22_0_0_0;
  wire selector_MUX_127_reg_22_0_0_1;
  wire selector_MUX_128_reg_23_0_0_0;
  wire selector_MUX_128_reg_23_0_0_1;
  wire selector_MUX_128_reg_23_0_1_0;
  wire selector_MUX_129_reg_24_0_0_0;
  wire selector_MUX_129_reg_24_0_0_1;
  wire selector_MUX_130_reg_25_0_0_0;
  wire selector_MUX_131_reg_26_0_0_0;
  wire selector_MUX_138_reg_6_0_0_0;
  wire selector_MUX_139_reg_7_0_0_0;
  wire selector_MUX_140_reg_8_0_0_0;
  wire selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_0;
  wire selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_1;
  wire selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_2;
  wire selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_3;
  wire selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_0;
  wire selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_1;
  wire selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0;
  wire wrenable_reg_0;
  wire wrenable_reg_1;
  wire wrenable_reg_10;
  wire wrenable_reg_11;
  wire wrenable_reg_12;
  wire wrenable_reg_13;
  wire wrenable_reg_14;
  wire wrenable_reg_15;
  wire wrenable_reg_16;
  wire wrenable_reg_17;
  wire wrenable_reg_18;
  wire wrenable_reg_19;
  wire wrenable_reg_2;
  wire wrenable_reg_20;
  wire wrenable_reg_21;
  wire wrenable_reg_22;
  wire wrenable_reg_23;
  wire wrenable_reg_24;
  wire wrenable_reg_25;
  wire wrenable_reg_26;
  wire wrenable_reg_27;
  wire wrenable_reg_28;
  wire wrenable_reg_29;
  wire wrenable_reg_3;
  wire wrenable_reg_4;
  wire wrenable_reg_5;
  wire wrenable_reg_6;
  wire wrenable_reg_7;
  wire wrenable_reg_8;
  wire wrenable_reg_9;
  
  controller_min_max Controller_i (.done_port(done_delayed_REG_signal_in),
    .fuselector_BMEMORY_CTRL_92_i0_LOAD(fuselector_BMEMORY_CTRL_92_i0_LOAD),
    .fuselector_BMEMORY_CTRL_92_i0_STORE(fuselector_BMEMORY_CTRL_92_i0_STORE),
    .selector_MUX_0_BMEMORY_CTRL_92_i0_0_0_0(selector_MUX_0_BMEMORY_CTRL_92_i0_0_0_0),
    .selector_MUX_113_reg_1_0_0_0(selector_MUX_113_reg_1_0_0_0),
    .selector_MUX_126_reg_21_0_0_0(selector_MUX_126_reg_21_0_0_0),
    .selector_MUX_126_reg_21_0_0_1(selector_MUX_126_reg_21_0_0_1),
    .selector_MUX_126_reg_21_0_1_0(selector_MUX_126_reg_21_0_1_0),
    .selector_MUX_127_reg_22_0_0_0(selector_MUX_127_reg_22_0_0_0),
    .selector_MUX_127_reg_22_0_0_1(selector_MUX_127_reg_22_0_0_1),
    .selector_MUX_128_reg_23_0_0_0(selector_MUX_128_reg_23_0_0_0),
    .selector_MUX_128_reg_23_0_0_1(selector_MUX_128_reg_23_0_0_1),
    .selector_MUX_128_reg_23_0_1_0(selector_MUX_128_reg_23_0_1_0),
    .selector_MUX_129_reg_24_0_0_0(selector_MUX_129_reg_24_0_0_0),
    .selector_MUX_129_reg_24_0_0_1(selector_MUX_129_reg_24_0_0_1),
    .selector_MUX_130_reg_25_0_0_0(selector_MUX_130_reg_25_0_0_0),
    .selector_MUX_131_reg_26_0_0_0(selector_MUX_131_reg_26_0_0_0),
    .selector_MUX_138_reg_6_0_0_0(selector_MUX_138_reg_6_0_0_0),
    .selector_MUX_139_reg_7_0_0_0(selector_MUX_139_reg_7_0_0_0),
    .selector_MUX_140_reg_8_0_0_0(selector_MUX_140_reg_8_0_0_0),
    .selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_0(selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_0),
    .selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_1(selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_1),
    .selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_2(selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_2),
    .selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_3(selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_3),
    .selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_0(selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_0),
    .selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_1(selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_1),
    .selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0(selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0),
    .wrenable_reg_0(wrenable_reg_0),
    .wrenable_reg_1(wrenable_reg_1),
    .wrenable_reg_10(wrenable_reg_10),
    .wrenable_reg_11(wrenable_reg_11),
    .wrenable_reg_12(wrenable_reg_12),
    .wrenable_reg_13(wrenable_reg_13),
    .wrenable_reg_14(wrenable_reg_14),
    .wrenable_reg_15(wrenable_reg_15),
    .wrenable_reg_16(wrenable_reg_16),
    .wrenable_reg_17(wrenable_reg_17),
    .wrenable_reg_18(wrenable_reg_18),
    .wrenable_reg_19(wrenable_reg_19),
    .wrenable_reg_2(wrenable_reg_2),
    .wrenable_reg_20(wrenable_reg_20),
    .wrenable_reg_21(wrenable_reg_21),
    .wrenable_reg_22(wrenable_reg_22),
    .wrenable_reg_23(wrenable_reg_23),
    .wrenable_reg_24(wrenable_reg_24),
    .wrenable_reg_25(wrenable_reg_25),
    .wrenable_reg_26(wrenable_reg_26),
    .wrenable_reg_27(wrenable_reg_27),
    .wrenable_reg_28(wrenable_reg_28),
    .wrenable_reg_29(wrenable_reg_29),
    .wrenable_reg_3(wrenable_reg_3),
    .wrenable_reg_4(wrenable_reg_4),
    .wrenable_reg_5(wrenable_reg_5),
    .wrenable_reg_6(wrenable_reg_6),
    .wrenable_reg_7(wrenable_reg_7),
    .wrenable_reg_8(wrenable_reg_8),
    .wrenable_reg_9(wrenable_reg_9),
    .OUT_CONDITION_min_max_423516_423742(OUT_CONDITION_min_max_423516_423742),
    .OUT_CONDITION_min_max_423516_423746(OUT_CONDITION_min_max_423516_423746),
    .OUT_CONDITION_min_max_423516_423752(OUT_CONDITION_min_max_423516_423752),
    .OUT_MULTIIF_min_max_423516_423981(OUT_MULTIIF_min_max_423516_423981),
    .clock(clock),
    .reset(reset),
    .start_port(start_port));
  datapath_min_max Datapath_i (.Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .OUT_CONDITION_min_max_423516_423742(OUT_CONDITION_min_max_423516_423742),
    .OUT_CONDITION_min_max_423516_423746(OUT_CONDITION_min_max_423516_423746),
    .OUT_CONDITION_min_max_423516_423752(OUT_CONDITION_min_max_423516_423752),
    .OUT_MULTIIF_min_max_423516_423981(OUT_MULTIIF_min_max_423516_423981),
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
    .fuselector_BMEMORY_CTRL_92_i0_LOAD(fuselector_BMEMORY_CTRL_92_i0_LOAD),
    .fuselector_BMEMORY_CTRL_92_i0_STORE(fuselector_BMEMORY_CTRL_92_i0_STORE),
    .selector_MUX_0_BMEMORY_CTRL_92_i0_0_0_0(selector_MUX_0_BMEMORY_CTRL_92_i0_0_0_0),
    .selector_MUX_113_reg_1_0_0_0(selector_MUX_113_reg_1_0_0_0),
    .selector_MUX_126_reg_21_0_0_0(selector_MUX_126_reg_21_0_0_0),
    .selector_MUX_126_reg_21_0_0_1(selector_MUX_126_reg_21_0_0_1),
    .selector_MUX_126_reg_21_0_1_0(selector_MUX_126_reg_21_0_1_0),
    .selector_MUX_127_reg_22_0_0_0(selector_MUX_127_reg_22_0_0_0),
    .selector_MUX_127_reg_22_0_0_1(selector_MUX_127_reg_22_0_0_1),
    .selector_MUX_128_reg_23_0_0_0(selector_MUX_128_reg_23_0_0_0),
    .selector_MUX_128_reg_23_0_0_1(selector_MUX_128_reg_23_0_0_1),
    .selector_MUX_128_reg_23_0_1_0(selector_MUX_128_reg_23_0_1_0),
    .selector_MUX_129_reg_24_0_0_0(selector_MUX_129_reg_24_0_0_0),
    .selector_MUX_129_reg_24_0_0_1(selector_MUX_129_reg_24_0_0_1),
    .selector_MUX_130_reg_25_0_0_0(selector_MUX_130_reg_25_0_0_0),
    .selector_MUX_131_reg_26_0_0_0(selector_MUX_131_reg_26_0_0_0),
    .selector_MUX_138_reg_6_0_0_0(selector_MUX_138_reg_6_0_0_0),
    .selector_MUX_139_reg_7_0_0_0(selector_MUX_139_reg_7_0_0_0),
    .selector_MUX_140_reg_8_0_0_0(selector_MUX_140_reg_8_0_0_0),
    .selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_0(selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_0),
    .selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_1(selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_1),
    .selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_2(selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_2),
    .selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_3(selector_MUX_1_BMEMORY_CTRL_92_i0_1_0_3),
    .selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_0(selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_0),
    .selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_1(selector_MUX_1_BMEMORY_CTRL_92_i0_1_1_1),
    .selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0(selector_MUX_1_BMEMORY_CTRL_92_i0_1_2_0),
    .wrenable_reg_0(wrenable_reg_0),
    .wrenable_reg_1(wrenable_reg_1),
    .wrenable_reg_10(wrenable_reg_10),
    .wrenable_reg_11(wrenable_reg_11),
    .wrenable_reg_12(wrenable_reg_12),
    .wrenable_reg_13(wrenable_reg_13),
    .wrenable_reg_14(wrenable_reg_14),
    .wrenable_reg_15(wrenable_reg_15),
    .wrenable_reg_16(wrenable_reg_16),
    .wrenable_reg_17(wrenable_reg_17),
    .wrenable_reg_18(wrenable_reg_18),
    .wrenable_reg_19(wrenable_reg_19),
    .wrenable_reg_2(wrenable_reg_2),
    .wrenable_reg_20(wrenable_reg_20),
    .wrenable_reg_21(wrenable_reg_21),
    .wrenable_reg_22(wrenable_reg_22),
    .wrenable_reg_23(wrenable_reg_23),
    .wrenable_reg_24(wrenable_reg_24),
    .wrenable_reg_25(wrenable_reg_25),
    .wrenable_reg_26(wrenable_reg_26),
    .wrenable_reg_27(wrenable_reg_27),
    .wrenable_reg_28(wrenable_reg_28),
    .wrenable_reg_29(wrenable_reg_29),
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


