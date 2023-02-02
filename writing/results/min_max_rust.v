// 
// Politecnico di Milano
// Code created using PandA - Version: PandA 0.9.8 - Revision 891ec3caed502474cab0813cc4a9fc678deabaa5 - Date 2023-02-02T20:13:11
// /nix/store/2hfjp458bdl98q37hzi2aljm30kda30v-bambu-wrapped/bin/bambu executed with: /nix/store/2hfjp458bdl98q37hzi2aljm30kda30v-bambu-wrapped/bin/bambu --top-fname=min_max_rust --generate-tb=src/testbench_rust.xml --simulate --simulator=VERILATOR -v2 --compiler=I386_CLANG12 -Os build/min_max_rust_size.ll 
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
// Copyright (C) 2004-2022 Politecnico di Milano
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
// Copyright (C) 2004-2022 Politecnico di Milano
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
module gt_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 > in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module lt_expr_FU(in1,
  in2,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_out1=1;
  // IN
  input signed [BITSIZE_in1-1:0] in1;
  input signed [BITSIZE_in2-1:0] in2;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  assign out1 = in1 < in2;

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
// Copyright (C) 2004-2022 Politecnico di Milano
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
module ASSIGN_UNSIGNED_FU(in1,
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

// Datapath RTL description for min_max_rust
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module datapath_min_max_rust(clock,
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
  fuselector_BMEMORY_CTRLN_17_i0_LOAD,
  fuselector_BMEMORY_CTRLN_17_i0_STORE,
  fuselector_BMEMORY_CTRLN_17_i1_LOAD,
  fuselector_BMEMORY_CTRLN_17_i1_STORE,
  selector_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0,
  selector_MUX_27_reg_2_0_0_0,
  selector_MUX_28_reg_3_0_0_0,
  selector_MUX_29_reg_4_0_0_0,
  selector_MUX_33_reg_8_0_0_0,
  selector_MUX_34_reg_9_0_0_0,
  selector_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0,
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
  OUT_CONDITION_min_max_rust_424721_424756,
  OUT_CONDITION_min_max_rust_424721_424789);
  // IN
  input clock;
  input reset;
  input [31:0] in_port_Pd5;
  input [31:0] in_port_Pd6;
  input [31:0] in_port_Pd7;
  input [31:0] in_port_Pd8;
  input [63:0] M_Rdata_ram;
  input [1:0] M_DataRdy;
  input [1:0] Min_oe_ram;
  input [1:0] Min_we_ram;
  input [63:0] Min_addr_ram;
  input [63:0] Min_Wdata_ram;
  input [11:0] Min_data_ram_size;
  input fuselector_BMEMORY_CTRLN_17_i0_LOAD;
  input fuselector_BMEMORY_CTRLN_17_i0_STORE;
  input fuselector_BMEMORY_CTRLN_17_i1_LOAD;
  input fuselector_BMEMORY_CTRLN_17_i1_STORE;
  input selector_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0;
  input selector_MUX_27_reg_2_0_0_0;
  input selector_MUX_28_reg_3_0_0_0;
  input selector_MUX_29_reg_4_0_0_0;
  input selector_MUX_33_reg_8_0_0_0;
  input selector_MUX_34_reg_9_0_0_0;
  input selector_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0;
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
  output [1:0] Mout_oe_ram;
  output [1:0] Mout_we_ram;
  output [63:0] Mout_addr_ram;
  output [63:0] Mout_Wdata_ram;
  output [11:0] Mout_data_ram_size;
  output OUT_CONDITION_min_max_rust_424721_424756;
  output OUT_CONDITION_min_max_rust_424721_424789;
  // Component and signal declarations
  wire [31:0] out_BMEMORY_CTRLN_17_i0_BMEMORY_CTRLN_17_i0;
  wire [31:0] out_BMEMORY_CTRLN_17_i1_BMEMORY_CTRLN_17_i0;
  wire [31:0] out_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0;
  wire [31:0] out_MUX_27_reg_2_0_0_0;
  wire [31:0] out_MUX_28_reg_3_0_0_0;
  wire [63:0] out_MUX_29_reg_4_0_0_0;
  wire [31:0] out_MUX_33_reg_8_0_0_0;
  wire [31:0] out_MUX_34_reg_9_0_0_0;
  wire [31:0] out_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0;
  wire signed [31:0] out_UIdata_converter_FU_10_i0_fu_min_max_rust_424721_424892;
  wire signed [31:0] out_UIdata_converter_FU_11_i0_fu_min_max_rust_424721_424894;
  wire signed [31:0] out_UIdata_converter_FU_12_i0_fu_min_max_rust_424721_424905;
  wire signed [31:0] out_UIdata_converter_FU_13_i0_fu_min_max_rust_424721_424907;
  wire signed [31:0] out_UIdata_converter_FU_3_i0_fu_min_max_rust_424721_424880;
  wire [31:0] out_UUdata_converter_FU_2_i0_fu_min_max_rust_424721_424754;
  wire [29:0] out_UUdata_converter_FU_9_i0_fu_min_max_rust_424721_424780;
  wire [2:0] out_const_0;
  wire [6:0] out_const_1;
  wire out_const_2;
  wire [1:0] out_const_3;
  wire [5:0] out_conv_out_const_1_7_6;
  wire [63:0] out_conv_out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0_1_64;
  wire out_gt_expr_FU_32_32_32_18_i0_fu_min_max_rust_424721_424896;
  wire out_lt_expr_FU_32_0_32_19_i0_fu_min_max_rust_424721_424886;
  wire out_lt_expr_FU_32_32_32_20_i0_fu_min_max_rust_424721_424909;
  wire out_read_cond_FU_14_i0_fu_min_max_rust_424721_424789;
  wire out_read_cond_FU_4_i0_fu_min_max_rust_424721_424756;
  wire [31:0] out_reg_0_reg_0;
  wire out_reg_1_reg_1;
  wire [31:0] out_reg_2_reg_2;
  wire [31:0] out_reg_3_reg_3;
  wire [63:0] out_reg_4_reg_4;
  wire [31:0] out_reg_5_reg_5;
  wire [31:0] out_reg_6_reg_6;
  wire out_reg_7_reg_7;
  wire [31:0] out_reg_8_reg_8;
  wire [31:0] out_reg_9_reg_9;
  wire [0:0] out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_21_i0_fu_min_max_rust_424721_424785;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_21_i1_fu_min_max_rust_424721_424787;
  wire out_ui_eq_expr_FU_64_64_64_22_i0_fu_min_max_rust_424721_424915;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_23_i0_fu_min_max_rust_424721_424889;
  wire [63:0] out_ui_plus_expr_FU_64_0_64_24_i0_fu_min_max_rust_424721_424783;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_25_i0_fu_min_max_rust_424721_424781;
  wire [31:0] out_vb_assign_conn_obj_1_ASSIGN_VECTOR_BOOL_FU_vb_assign_1;
  wire [31:0] out_vb_assign_conn_obj_2_ASSIGN_VECTOR_BOOL_FU_vb_assign_2;
  
  ASSIGN_UNSIGNED_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) ASSIGN_UNSIGNED_FU_u_assign_0 (.out1(out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0),
    .in1(out_const_2));
  ASSIGN_VECTOR_BOOL_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) ASSIGN_VECTOR_BOOL_FU_vb_assign_1 (.out1(out_vb_assign_conn_obj_1_ASSIGN_VECTOR_BOOL_FU_vb_assign_1),
    .in1(out_reg_9_reg_9));
  ASSIGN_VECTOR_BOOL_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) ASSIGN_VECTOR_BOOL_FU_vb_assign_2 (.out1(out_vb_assign_conn_obj_2_ASSIGN_VECTOR_BOOL_FU_vb_assign_2),
    .in1(out_reg_8_reg_8));
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
    .BITSIZE_out1(32),
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
    .PORTSIZE_Mout_data_ram_size(2)) BMEMORY_CTRLN_17_i0 (.out1({out_BMEMORY_CTRLN_17_i1_BMEMORY_CTRLN_17_i0,
      out_BMEMORY_CTRLN_17_i0_BMEMORY_CTRLN_17_i0}),
    .Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .clock(clock),
    .in1({out_vb_assign_conn_obj_2_ASSIGN_VECTOR_BOOL_FU_vb_assign_2,
      out_vb_assign_conn_obj_1_ASSIGN_VECTOR_BOOL_FU_vb_assign_1}),
    .in2({out_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0,
      out_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0}),
    .in3({out_conv_out_const_1_7_6,
      out_conv_out_const_1_7_6}),
    .in4({out_const_2,
      out_const_2}),
    .sel_LOAD({fuselector_BMEMORY_CTRLN_17_i1_LOAD,
      fuselector_BMEMORY_CTRLN_17_i0_LOAD}),
    .sel_STORE({fuselector_BMEMORY_CTRLN_17_i1_STORE,
      fuselector_BMEMORY_CTRLN_17_i0_STORE}),
    .Min_oe_ram(Min_oe_ram),
    .Min_we_ram(Min_we_ram),
    .Min_addr_ram(Min_addr_ram),
    .M_Rdata_ram(M_Rdata_ram),
    .Min_Wdata_ram(Min_Wdata_ram),
    .Min_data_ram_size(Min_data_ram_size),
    .M_DataRdy(M_DataRdy));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_1_BMEMORY_CTRLN_17_i0_1_0_0 (.out1(out_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0),
    .sel(selector_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0),
    .in1(in_port_Pd7),
    .in2(out_ui_pointer_plus_expr_FU_32_32_32_25_i0_fu_min_max_rust_424721_424781));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_27_reg_2_0_0_0 (.out1(out_MUX_27_reg_2_0_0_0),
    .sel(selector_MUX_27_reg_2_0_0_0),
    .in1(out_BMEMORY_CTRLN_17_i1_BMEMORY_CTRLN_17_i0),
    .in2(out_ui_cond_expr_FU_32_32_32_32_21_i1_fu_min_max_rust_424721_424787));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_28_reg_3_0_0_0 (.out1(out_MUX_28_reg_3_0_0_0),
    .sel(selector_MUX_28_reg_3_0_0_0),
    .in1(out_BMEMORY_CTRLN_17_i1_BMEMORY_CTRLN_17_i0),
    .in2(out_ui_cond_expr_FU_32_32_32_32_21_i0_fu_min_max_rust_424721_424785));
  MUX_GATE #(.BITSIZE_in1(64),
    .BITSIZE_in2(64),
    .BITSIZE_out1(64)) MUX_29_reg_4_0_0_0 (.out1(out_MUX_29_reg_4_0_0_0),
    .sel(selector_MUX_29_reg_4_0_0_0),
    .in1(out_conv_out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0_1_64),
    .in2(out_ui_plus_expr_FU_64_0_64_24_i0_fu_min_max_rust_424721_424783));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_33_reg_8_0_0_0 (.out1(out_MUX_33_reg_8_0_0_0),
    .sel(selector_MUX_33_reg_8_0_0_0),
    .in1(out_BMEMORY_CTRLN_17_i1_BMEMORY_CTRLN_17_i0),
    .in2(out_ui_cond_expr_FU_32_32_32_32_21_i1_fu_min_max_rust_424721_424787));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_34_reg_9_0_0_0 (.out1(out_MUX_34_reg_9_0_0_0),
    .sel(selector_MUX_34_reg_9_0_0_0),
    .in1(out_BMEMORY_CTRLN_17_i1_BMEMORY_CTRLN_17_i0),
    .in2(out_ui_cond_expr_FU_32_32_32_32_21_i0_fu_min_max_rust_424721_424785));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_5_BMEMORY_CTRLN_17_i1_1_0_0 (.out1(out_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0),
    .sel(selector_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0),
    .in1(in_port_Pd5),
    .in2(in_port_Pd8));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b010)) const_0 (.out1(out_const_0));
  constant_value #(.BITSIZE_out1(7),
    .value(7'b0100000)) const_1 (.out1(out_const_1));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b1)) const_2 (.out1(out_const_2));
  constant_value #(.BITSIZE_out1(2),
    .value(2'b10)) const_3 (.out1(out_const_3));
  UUdata_converter_FU #(.BITSIZE_in1(7),
    .BITSIZE_out1(6)) conv_out_const_1_7_6 (.out1(out_conv_out_const_1_7_6),
    .in1(out_const_1));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(64)) conv_out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0_1_64 (.out1(out_conv_out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0_1_64),
    .in1(out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_rust_424721_424754 (.out1(out_UUdata_converter_FU_2_i0_fu_min_max_rust_424721_424754),
    .in1(in_port_Pd6));
  read_cond_FU #(.BITSIZE_in1(1)) fu_min_max_rust_424721_424756 (.out1(out_read_cond_FU_4_i0_fu_min_max_rust_424721_424756),
    .in1(out_reg_1_reg_1));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(30)) fu_min_max_rust_424721_424780 (.out1(out_UUdata_converter_FU_9_i0_fu_min_max_rust_424721_424780),
    .in1(out_reg_4_reg_4));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_min_max_rust_424721_424781 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_25_i0_fu_min_max_rust_424721_424781),
    .in1(in_port_Pd5),
    .in2(out_ui_lshift_expr_FU_32_0_32_23_i0_fu_min_max_rust_424721_424889));
  ui_plus_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(1),
    .BITSIZE_out1(64)) fu_min_max_rust_424721_424783 (.out1(out_ui_plus_expr_FU_64_0_64_24_i0_fu_min_max_rust_424721_424783),
    .in1(out_reg_4_reg_4),
    .in2(out_const_2));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(32),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_min_max_rust_424721_424785 (.out1(out_ui_cond_expr_FU_32_32_32_32_21_i0_fu_min_max_rust_424721_424785),
    .in1(out_gt_expr_FU_32_32_32_18_i0_fu_min_max_rust_424721_424896),
    .in2(out_BMEMORY_CTRLN_17_i0_BMEMORY_CTRLN_17_i0),
    .in3(out_reg_3_reg_3));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(32),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_min_max_rust_424721_424787 (.out1(out_ui_cond_expr_FU_32_32_32_32_21_i1_fu_min_max_rust_424721_424787),
    .in1(out_lt_expr_FU_32_32_32_20_i0_fu_min_max_rust_424721_424909),
    .in2(out_BMEMORY_CTRLN_17_i0_BMEMORY_CTRLN_17_i0),
    .in3(out_reg_2_reg_2));
  read_cond_FU #(.BITSIZE_in1(1)) fu_min_max_rust_424721_424789 (.out1(out_read_cond_FU_14_i0_fu_min_max_rust_424721_424789),
    .in1(out_reg_7_reg_7));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_rust_424721_424880 (.out1(out_UIdata_converter_FU_3_i0_fu_min_max_rust_424721_424880),
    .in1(in_port_Pd6));
  lt_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(1)) fu_min_max_rust_424721_424886 (.out1(out_lt_expr_FU_32_0_32_19_i0_fu_min_max_rust_424721_424886),
    .in1(out_UIdata_converter_FU_3_i0_fu_min_max_rust_424721_424880),
    .in2(out_const_0));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_min_max_rust_424721_424889 (.out1(out_ui_lshift_expr_FU_32_0_32_23_i0_fu_min_max_rust_424721_424889),
    .in1(out_UUdata_converter_FU_9_i0_fu_min_max_rust_424721_424780),
    .in2(out_const_3));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_rust_424721_424892 (.out1(out_UIdata_converter_FU_10_i0_fu_min_max_rust_424721_424892),
    .in1(out_BMEMORY_CTRLN_17_i0_BMEMORY_CTRLN_17_i0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_rust_424721_424894 (.out1(out_UIdata_converter_FU_11_i0_fu_min_max_rust_424721_424894),
    .in1(out_reg_3_reg_3));
  gt_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(1)) fu_min_max_rust_424721_424896 (.out1(out_gt_expr_FU_32_32_32_18_i0_fu_min_max_rust_424721_424896),
    .in1(out_UIdata_converter_FU_10_i0_fu_min_max_rust_424721_424892),
    .in2(out_reg_5_reg_5));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_rust_424721_424905 (.out1(out_UIdata_converter_FU_12_i0_fu_min_max_rust_424721_424905),
    .in1(out_BMEMORY_CTRLN_17_i0_BMEMORY_CTRLN_17_i0));
  UIdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_min_max_rust_424721_424907 (.out1(out_UIdata_converter_FU_13_i0_fu_min_max_rust_424721_424907),
    .in1(out_reg_2_reg_2));
  lt_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(1)) fu_min_max_rust_424721_424909 (.out1(out_lt_expr_FU_32_32_32_20_i0_fu_min_max_rust_424721_424909),
    .in1(out_UIdata_converter_FU_12_i0_fu_min_max_rust_424721_424905),
    .in2(out_reg_6_reg_6));
  ui_eq_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(32),
    .BITSIZE_out1(1)) fu_min_max_rust_424721_424915 (.out1(out_ui_eq_expr_FU_64_64_64_22_i0_fu_min_max_rust_424721_424915),
    .in1(out_ui_plus_expr_FU_64_0_64_24_i0_fu_min_max_rust_424721_424783),
    .in2(out_reg_0_reg_0));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_0 (.out1(out_reg_0_reg_0),
    .clock(clock),
    .reset(reset),
    .in1(out_UUdata_converter_FU_2_i0_fu_min_max_rust_424721_424754),
    .wenable(wrenable_reg_0));
  register_STD #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_1 (.out1(out_reg_1_reg_1),
    .clock(clock),
    .reset(reset),
    .in1(out_lt_expr_FU_32_0_32_19_i0_fu_min_max_rust_424721_424886),
    .wenable(wrenable_reg_1));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_2 (.out1(out_reg_2_reg_2),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_27_reg_2_0_0_0),
    .wenable(wrenable_reg_2));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_3 (.out1(out_reg_3_reg_3),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_28_reg_3_0_0_0),
    .wenable(wrenable_reg_3));
  register_SE #(.BITSIZE_in1(64),
    .BITSIZE_out1(64)) reg_4 (.out1(out_reg_4_reg_4),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_29_reg_4_0_0_0),
    .wenable(wrenable_reg_4));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_5 (.out1(out_reg_5_reg_5),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_11_i0_fu_min_max_rust_424721_424894),
    .wenable(wrenable_reg_5));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_6 (.out1(out_reg_6_reg_6),
    .clock(clock),
    .reset(reset),
    .in1(out_UIdata_converter_FU_13_i0_fu_min_max_rust_424721_424907),
    .wenable(wrenable_reg_6));
  register_STD #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_7 (.out1(out_reg_7_reg_7),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_eq_expr_FU_64_64_64_22_i0_fu_min_max_rust_424721_424915),
    .wenable(wrenable_reg_7));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_8 (.out1(out_reg_8_reg_8),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_33_reg_8_0_0_0),
    .wenable(wrenable_reg_8));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_9 (.out1(out_reg_9_reg_9),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_34_reg_9_0_0_0),
    .wenable(wrenable_reg_9));
  // io-signal post fix
  assign OUT_CONDITION_min_max_rust_424721_424756 = out_read_cond_FU_4_i0_fu_min_max_rust_424721_424756;
  assign OUT_CONDITION_min_max_rust_424721_424789 = out_read_cond_FU_14_i0_fu_min_max_rust_424721_424789;

endmodule

// FSM based controller description for min_max_rust
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module controller_min_max_rust(done_port,
  fuselector_BMEMORY_CTRLN_17_i0_LOAD,
  fuselector_BMEMORY_CTRLN_17_i0_STORE,
  fuselector_BMEMORY_CTRLN_17_i1_LOAD,
  fuselector_BMEMORY_CTRLN_17_i1_STORE,
  selector_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0,
  selector_MUX_27_reg_2_0_0_0,
  selector_MUX_28_reg_3_0_0_0,
  selector_MUX_29_reg_4_0_0_0,
  selector_MUX_33_reg_8_0_0_0,
  selector_MUX_34_reg_9_0_0_0,
  selector_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0,
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
  OUT_CONDITION_min_max_rust_424721_424756,
  OUT_CONDITION_min_max_rust_424721_424789,
  clock,
  reset,
  start_port);
  // IN
  input OUT_CONDITION_min_max_rust_424721_424756;
  input OUT_CONDITION_min_max_rust_424721_424789;
  input clock;
  input reset;
  input start_port;
  // OUT
  output done_port;
  output fuselector_BMEMORY_CTRLN_17_i0_LOAD;
  output fuselector_BMEMORY_CTRLN_17_i0_STORE;
  output fuselector_BMEMORY_CTRLN_17_i1_LOAD;
  output fuselector_BMEMORY_CTRLN_17_i1_STORE;
  output selector_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0;
  output selector_MUX_27_reg_2_0_0_0;
  output selector_MUX_28_reg_3_0_0_0;
  output selector_MUX_29_reg_4_0_0_0;
  output selector_MUX_33_reg_8_0_0_0;
  output selector_MUX_34_reg_9_0_0_0;
  output selector_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0;
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
  parameter [5:0] S_0 = 6'b000001,
    S_1 = 6'b000010,
    S_2 = 6'b000100,
    S_3 = 6'b001000,
    S_4 = 6'b010000,
    S_5 = 6'b100000;
  reg [5:0] _present_state=S_0, _next_state;
  reg done_port;
  reg fuselector_BMEMORY_CTRLN_17_i0_LOAD;
  reg fuselector_BMEMORY_CTRLN_17_i0_STORE;
  reg fuselector_BMEMORY_CTRLN_17_i1_LOAD;
  reg fuselector_BMEMORY_CTRLN_17_i1_STORE;
  reg selector_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0;
  reg selector_MUX_27_reg_2_0_0_0;
  reg selector_MUX_28_reg_3_0_0_0;
  reg selector_MUX_29_reg_4_0_0_0;
  reg selector_MUX_33_reg_8_0_0_0;
  reg selector_MUX_34_reg_9_0_0_0;
  reg selector_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0;
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
    fuselector_BMEMORY_CTRLN_17_i0_LOAD = 1'b0;
    fuselector_BMEMORY_CTRLN_17_i0_STORE = 1'b0;
    fuselector_BMEMORY_CTRLN_17_i1_LOAD = 1'b0;
    fuselector_BMEMORY_CTRLN_17_i1_STORE = 1'b0;
    selector_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0 = 1'b0;
    selector_MUX_27_reg_2_0_0_0 = 1'b0;
    selector_MUX_28_reg_3_0_0_0 = 1'b0;
    selector_MUX_29_reg_4_0_0_0 = 1'b0;
    selector_MUX_33_reg_8_0_0_0 = 1'b0;
    selector_MUX_34_reg_9_0_0_0 = 1'b0;
    selector_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0 = 1'b0;
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
          fuselector_BMEMORY_CTRLN_17_i1_LOAD = 1'b1;
          selector_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0 = 1'b1;
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
          selector_MUX_27_reg_2_0_0_0 = 1'b1;
          selector_MUX_28_reg_3_0_0_0 = 1'b1;
          selector_MUX_29_reg_4_0_0_0 = 1'b1;
          selector_MUX_33_reg_8_0_0_0 = 1'b1;
          selector_MUX_34_reg_9_0_0_0 = 1'b1;
          wrenable_reg_2 = 1'b1;
          wrenable_reg_3 = 1'b1;
          wrenable_reg_4 = 1'b1;
          wrenable_reg_8 = 1'b1;
          wrenable_reg_9 = 1'b1;
          if (OUT_CONDITION_min_max_rust_424721_424756 == 1'b1)
            begin
              _next_state = S_4;
              selector_MUX_27_reg_2_0_0_0 = 1'b0;
              selector_MUX_28_reg_3_0_0_0 = 1'b0;
              selector_MUX_29_reg_4_0_0_0 = 1'b0;
              wrenable_reg_2 = 1'b0;
              wrenable_reg_3 = 1'b0;
              wrenable_reg_4 = 1'b0;
            end
          else
            begin
              _next_state = S_2;
              selector_MUX_33_reg_8_0_0_0 = 1'b0;
              selector_MUX_34_reg_9_0_0_0 = 1'b0;
              wrenable_reg_8 = 1'b0;
              wrenable_reg_9 = 1'b0;
            end
        end
      S_2 :
        begin
          fuselector_BMEMORY_CTRLN_17_i0_LOAD = 1'b1;
          wrenable_reg_4 = 1'b1;
          wrenable_reg_5 = 1'b1;
          wrenable_reg_6 = 1'b1;
          wrenable_reg_7 = 1'b1;
          _next_state = S_3;
        end
      S_3 :
        begin
          wrenable_reg_2 = 1'b1;
          wrenable_reg_3 = 1'b1;
          wrenable_reg_8 = 1'b1;
          wrenable_reg_9 = 1'b1;
          if (OUT_CONDITION_min_max_rust_424721_424789 == 1'b1)
            begin
              _next_state = S_4;
              wrenable_reg_2 = 1'b0;
              wrenable_reg_3 = 1'b0;
            end
          else
            begin
              _next_state = S_2;
              wrenable_reg_8 = 1'b0;
              wrenable_reg_9 = 1'b0;
            end
        end
      S_4 :
        begin
          fuselector_BMEMORY_CTRLN_17_i0_STORE = 1'b1;
          fuselector_BMEMORY_CTRLN_17_i1_STORE = 1'b1;
          selector_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0 = 1'b1;
          _next_state = S_5;
          done_port = 1'b1;
        end
      S_5 :
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

// Top component for min_max_rust
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module _min_max_rust(clock,
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
  wire OUT_CONDITION_min_max_rust_424721_424756;
  wire OUT_CONDITION_min_max_rust_424721_424789;
  wire done_delayed_REG_signal_in;
  wire done_delayed_REG_signal_out;
  wire fuselector_BMEMORY_CTRLN_17_i0_LOAD;
  wire fuselector_BMEMORY_CTRLN_17_i0_STORE;
  wire fuselector_BMEMORY_CTRLN_17_i1_LOAD;
  wire fuselector_BMEMORY_CTRLN_17_i1_STORE;
  wire selector_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0;
  wire selector_MUX_27_reg_2_0_0_0;
  wire selector_MUX_28_reg_3_0_0_0;
  wire selector_MUX_29_reg_4_0_0_0;
  wire selector_MUX_33_reg_8_0_0_0;
  wire selector_MUX_34_reg_9_0_0_0;
  wire selector_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0;
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
  
  controller_min_max_rust Controller_i (.done_port(done_delayed_REG_signal_in),
    .fuselector_BMEMORY_CTRLN_17_i0_LOAD(fuselector_BMEMORY_CTRLN_17_i0_LOAD),
    .fuselector_BMEMORY_CTRLN_17_i0_STORE(fuselector_BMEMORY_CTRLN_17_i0_STORE),
    .fuselector_BMEMORY_CTRLN_17_i1_LOAD(fuselector_BMEMORY_CTRLN_17_i1_LOAD),
    .fuselector_BMEMORY_CTRLN_17_i1_STORE(fuselector_BMEMORY_CTRLN_17_i1_STORE),
    .selector_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0(selector_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0),
    .selector_MUX_27_reg_2_0_0_0(selector_MUX_27_reg_2_0_0_0),
    .selector_MUX_28_reg_3_0_0_0(selector_MUX_28_reg_3_0_0_0),
    .selector_MUX_29_reg_4_0_0_0(selector_MUX_29_reg_4_0_0_0),
    .selector_MUX_33_reg_8_0_0_0(selector_MUX_33_reg_8_0_0_0),
    .selector_MUX_34_reg_9_0_0_0(selector_MUX_34_reg_9_0_0_0),
    .selector_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0(selector_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0),
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
    .OUT_CONDITION_min_max_rust_424721_424756(OUT_CONDITION_min_max_rust_424721_424756),
    .OUT_CONDITION_min_max_rust_424721_424789(OUT_CONDITION_min_max_rust_424721_424789),
    .clock(clock),
    .reset(reset),
    .start_port(start_port));
  datapath_min_max_rust Datapath_i (.Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .OUT_CONDITION_min_max_rust_424721_424756(OUT_CONDITION_min_max_rust_424721_424756),
    .OUT_CONDITION_min_max_rust_424721_424789(OUT_CONDITION_min_max_rust_424721_424789),
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
    .fuselector_BMEMORY_CTRLN_17_i0_LOAD(fuselector_BMEMORY_CTRLN_17_i0_LOAD),
    .fuselector_BMEMORY_CTRLN_17_i0_STORE(fuselector_BMEMORY_CTRLN_17_i0_STORE),
    .fuselector_BMEMORY_CTRLN_17_i1_LOAD(fuselector_BMEMORY_CTRLN_17_i1_LOAD),
    .fuselector_BMEMORY_CTRLN_17_i1_STORE(fuselector_BMEMORY_CTRLN_17_i1_STORE),
    .selector_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0(selector_MUX_1_BMEMORY_CTRLN_17_i0_1_0_0),
    .selector_MUX_27_reg_2_0_0_0(selector_MUX_27_reg_2_0_0_0),
    .selector_MUX_28_reg_3_0_0_0(selector_MUX_28_reg_3_0_0_0),
    .selector_MUX_29_reg_4_0_0_0(selector_MUX_29_reg_4_0_0_0),
    .selector_MUX_33_reg_8_0_0_0(selector_MUX_33_reg_8_0_0_0),
    .selector_MUX_34_reg_9_0_0_0(selector_MUX_34_reg_9_0_0_0),
    .selector_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0(selector_MUX_5_BMEMORY_CTRLN_17_i1_1_0_0),
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

// Minimal interface for function: min_max_rust
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module min_max_rust(clock,
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
  input clock;
  input reset;
  input start_port;
  input [31:0] Pd5;
  input [31:0] Pd6;
  input [31:0] Pd7;
  input [31:0] Pd8;
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
  
  _min_max_rust _min_max_rust_i0 (.done_port(done_port),
    .Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .clock(clock),
    .reset(reset),
    .start_port(start_port),
    .Pd5(Pd5),
    .Pd6(Pd6),
    .Pd7(Pd7),
    .Pd8(Pd8),
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


