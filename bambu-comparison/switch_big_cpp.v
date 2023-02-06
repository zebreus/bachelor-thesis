// 
// Politecnico di Milano
// Code created using PandA - Version: PandA 0.9.8 - Revision 891ec3caed502474cab0813cc4a9fc678deabaa5 - Date 2023-02-06T21:50:55
// /nix/store/2hfjp458bdl98q37hzi2aljm30kda30v-bambu-wrapped/bin/bambu executed with: /nix/store/2hfjp458bdl98q37hzi2aljm30kda30v-bambu-wrapped/bin/bambu --top-fname=switch_big_cpp --generate-tb=src/switch_big_cpp.xml --simulate --simulator=VERILATOR --no-clean --compiler=I386_CLANG12 results/switch_big_cpp_size.ll 
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
module ARRAY_1D_STD_DISTRAM_NN_SDS(clock,
  reset,
  in1,
  in2,
  in3,
  in4,
  out1,
  sel_LOAD,
  sel_STORE,
  S_oe_ram,
  S_we_ram,
  S_addr_ram,
  S_Wdata_ram,
  Sin_Rdata_ram,
  Sout_Rdata_ram,
  S_data_ram_size,
  Sin_DataRdy,
  Sout_DataRdy,
  proxy_in1,
  proxy_in2,
  proxy_in3,
  proxy_sel_LOAD,
  proxy_sel_STORE,
  proxy_out1);
  parameter BITSIZE_in1=1, PORTSIZE_in1=2,
    BITSIZE_in2=1, PORTSIZE_in2=2,
    BITSIZE_in3=1, PORTSIZE_in3=2,
    BITSIZE_in4=1, PORTSIZE_in4=2,
    BITSIZE_sel_LOAD=1, PORTSIZE_sel_LOAD=2,
    BITSIZE_sel_STORE=1, PORTSIZE_sel_STORE=2,
    BITSIZE_S_oe_ram=1, PORTSIZE_S_oe_ram=2,
    BITSIZE_S_we_ram=1, PORTSIZE_S_we_ram=2,
    BITSIZE_out1=1, PORTSIZE_out1=2,
    BITSIZE_S_addr_ram=1, PORTSIZE_S_addr_ram=2,
    BITSIZE_S_Wdata_ram=8, PORTSIZE_S_Wdata_ram=2,
    BITSIZE_Sin_Rdata_ram=8, PORTSIZE_Sin_Rdata_ram=2,
    BITSIZE_Sout_Rdata_ram=8, PORTSIZE_Sout_Rdata_ram=2,
    BITSIZE_S_data_ram_size=1, PORTSIZE_S_data_ram_size=2,
    BITSIZE_Sin_DataRdy=1, PORTSIZE_Sin_DataRdy=2,
    BITSIZE_Sout_DataRdy=1, PORTSIZE_Sout_DataRdy=2,
    MEMORY_INIT_file="array.mem",
    n_elements=1,
    data_size=32,
    address_space_begin=0,
    address_space_rangesize=4,
    BUS_PIPELINED=1,
    PRIVATE_MEMORY=0,
    READ_ONLY_MEMORY=0,
    USE_SPARSE_MEMORY=1,
    ALIGNMENT=32,
    BITSIZE_proxy_in1=1, PORTSIZE_proxy_in1=2,
    BITSIZE_proxy_in2=1, PORTSIZE_proxy_in2=2,
    BITSIZE_proxy_in3=1, PORTSIZE_proxy_in3=2,
    BITSIZE_proxy_sel_LOAD=1, PORTSIZE_proxy_sel_LOAD=2,
    BITSIZE_proxy_sel_STORE=1, PORTSIZE_proxy_sel_STORE=2,
    BITSIZE_proxy_out1=1, PORTSIZE_proxy_out1=2;
  // IN
  input clock;
  input reset;
  input [(PORTSIZE_in1*BITSIZE_in1)+(-1):0] in1;
  input [(PORTSIZE_in2*BITSIZE_in2)+(-1):0] in2;
  input [(PORTSIZE_in3*BITSIZE_in3)+(-1):0] in3;
  input [PORTSIZE_in4-1:0] in4;
  input [PORTSIZE_sel_LOAD-1:0] sel_LOAD;
  input [PORTSIZE_sel_STORE-1:0] sel_STORE;
  input [PORTSIZE_S_oe_ram-1:0] S_oe_ram;
  input [PORTSIZE_S_we_ram-1:0] S_we_ram;
  input [(PORTSIZE_S_addr_ram*BITSIZE_S_addr_ram)+(-1):0] S_addr_ram;
  input [(PORTSIZE_S_Wdata_ram*BITSIZE_S_Wdata_ram)+(-1):0] S_Wdata_ram;
  input [(PORTSIZE_Sin_Rdata_ram*BITSIZE_Sin_Rdata_ram)+(-1):0] Sin_Rdata_ram;
  input [(PORTSIZE_S_data_ram_size*BITSIZE_S_data_ram_size)+(-1):0] S_data_ram_size;
  input [PORTSIZE_Sin_DataRdy-1:0] Sin_DataRdy;
  input [(PORTSIZE_proxy_in1*BITSIZE_proxy_in1)+(-1):0] proxy_in1;
  input [(PORTSIZE_proxy_in2*BITSIZE_proxy_in2)+(-1):0] proxy_in2;
  input [(PORTSIZE_proxy_in3*BITSIZE_proxy_in3)+(-1):0] proxy_in3;
  input [PORTSIZE_proxy_sel_LOAD-1:0] proxy_sel_LOAD;
  input [PORTSIZE_proxy_sel_STORE-1:0] proxy_sel_STORE;
  // OUT
  output [(PORTSIZE_out1*BITSIZE_out1)+(-1):0] out1;
  output [(PORTSIZE_Sout_Rdata_ram*BITSIZE_Sout_Rdata_ram)+(-1):0] Sout_Rdata_ram;
  output [PORTSIZE_Sout_DataRdy-1:0] Sout_DataRdy;
  output [(PORTSIZE_proxy_out1*BITSIZE_proxy_out1)+(-1):0] proxy_out1;
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
  parameter n_byte_on_databus = ALIGNMENT/8;
  parameter nbit_addr = BITSIZE_in2 > BITSIZE_proxy_in2 ? BITSIZE_in2 : BITSIZE_proxy_in2;
  `ifdef _SIM_HAVE_CLOG2
    parameter nbit_read_addr = n_elements == 1 ? 1 : $clog2(n_elements);
    parameter nbits_byte_offset = n_byte_on_databus<=1 ? 0 : $clog2(n_byte_on_databus);
  `else
    parameter nbit_read_addr = n_elements == 1 ? 1 : log2(n_elements);
    parameter nbits_byte_offset = n_byte_on_databus<=1 ? 0 : log2(n_byte_on_databus);
  `endif
  parameter max_n_writes = PORTSIZE_sel_STORE;
  parameter max_n_reads = PORTSIZE_sel_LOAD;
  parameter max_n_rw = max_n_writes > max_n_reads ? max_n_writes : max_n_reads;
  
  wire [max_n_writes-1:0] bram_write;
  
  wire [nbit_read_addr*max_n_rw-1:0] memory_addr_a;
  wire [nbit_read_addr-1:0] memory_addr_a_0;
  wire [nbit_read_addr-1:0] memory_addr_a_1;
  
  wire [data_size*max_n_writes-1:0] din_value_aggregated;
  wire [data_size*max_n_reads-1:0] dout_a;
  wire [nbit_addr*max_n_rw-1:0] tmp_addr;
  wire [nbit_addr*max_n_rw-1:0] relative_addr;
  wire [PORTSIZE_sel_LOAD-1:0] int_sel_LOAD;
  wire [PORTSIZE_sel_STORE-1:0] int_sel_STORE;
  integer index2;
  
  reg [data_size-1:0] memory [0:n_elements-1] /* synthesis syn_ramstyle = "no_rw_check" */;
  
  initial
  begin
    $readmemb(MEMORY_INIT_file, memory, 0, n_elements-1);
  end
  
  generate
  genvar ind2;
  for (ind2=0; ind2<max_n_rw; ind2=ind2+1)
    begin : Lind2
      assign tmp_addr[(ind2+1)*nbit_addr-1:ind2*nbit_addr] = (proxy_sel_LOAD[ind2]||proxy_sel_STORE[ind2]) ? proxy_in2[(ind2+1)*BITSIZE_proxy_in2-1:ind2*BITSIZE_proxy_in2] : in2[(ind2+1)*BITSIZE_in2-1:ind2*BITSIZE_in2];
    end
  endgenerate
  
  generate
  genvar i6;
    for (i6=0; i6<max_n_rw; i6=i6+1)
    begin : L6
      if(USE_SPARSE_MEMORY==1)
        assign relative_addr[(i6)*nbit_addr+nbit_addr-1:i6*nbit_addr] = tmp_addr[(i6)*nbit_addr+nbit_addr-1:i6*nbit_addr];
      else
        assign relative_addr[(i6+1)*nbit_addr-1:i6*nbit_addr] = tmp_addr[(i6+1)*nbit_addr-1:i6*nbit_addr]-address_space_begin;
    end
  endgenerate
  
  generate
  genvar i7;
    for (i7=0; i7<max_n_rw; i7=i7+1)
    begin : L7_A
      if (n_elements==1)
        assign memory_addr_a[(i7+1)*nbit_read_addr-1:i7*nbit_read_addr] = {nbit_read_addr{1'b0}};
      else
        assign memory_addr_a[(i7+1)*nbit_read_addr-1:i7*nbit_read_addr] = relative_addr[nbit_read_addr+nbits_byte_offset-1+i7*nbit_addr:nbits_byte_offset+i7*nbit_addr];
    end
  endgenerate
  
  generate
  genvar i14;
    for (i14=0; i14<max_n_writes; i14=i14+1)
    begin : L14
      assign din_value_aggregated[(i14+1)*data_size-1:i14*data_size] = proxy_sel_STORE[i14] ? proxy_in1[(i14+1)*BITSIZE_proxy_in1-1:i14*BITSIZE_proxy_in1] : in1[(i14+1)*BITSIZE_in1-1:i14*BITSIZE_in1];
    end
  endgenerate
  
  generate
  genvar i11;
    for (i11=0; i11<max_n_reads; i11=i11+1)
    begin : asynchronous_read
      assign dout_a[data_size*i11+:data_size] = memory[memory_addr_a[nbit_read_addr*i11+:nbit_read_addr]];
    end
  endgenerate
  
  assign memory_addr_a_0 = memory_addr_a[nbit_read_addr*0+:nbit_read_addr];
  assign memory_addr_a_1 = memory_addr_a[nbit_read_addr*1+:nbit_read_addr];
  
  generate if(READ_ONLY_MEMORY==0)
    always @(posedge clock)
    begin
      if(bram_write[0])
        memory[memory_addr_a_0] <= din_value_aggregated[data_size*0+:data_size];
      if(bram_write[1])
        memory[memory_addr_a_1] <= din_value_aggregated[data_size*1+:data_size];
    end
  endgenerate
  
  generate
  genvar i21;
    for (i21=0; i21<max_n_writes; i21=i21+1)
    begin : L21
        assign bram_write[i21] = int_sel_STORE[i21] || proxy_sel_STORE[i21];
    end
  endgenerate
  
  generate
  genvar i20;
    for (i20=0; i20<max_n_reads; i20=i20+1)
    begin : L20
      assign out1[(i20+1)*BITSIZE_out1-1:i20*BITSIZE_out1] = dout_a[(i20+1)*data_size-1:i20*data_size];
      assign proxy_out1[(i20+1)*BITSIZE_proxy_out1-1:i20*BITSIZE_proxy_out1] = dout_a[(i20+1)*data_size-1:i20*data_size];
    end
  endgenerate
  assign Sout_Rdata_ram =Sin_Rdata_ram;
  assign Sout_DataRdy = Sin_DataRdy;
  assign int_sel_LOAD = sel_LOAD & in4;
  assign int_sel_STORE = sel_STORE & in4;
  
  assign Sout_DataRdy = Sin_DataRdy;

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module addr_expr_FU(in1,
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

// Datapath RTL description for switch_big_cpp
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module datapath_switch_big_cpp(clock,
  reset,
  in_port_P0,
  return_port,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_LOAD,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_STORE,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_LOAD,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_STORE,
  selector_MUX_23_reg_4_0_0_0,
  selector_MUX_24_reg_5_0_0_0,
  selector_MUX_25_reg_6_0_0_0,
  selector_MUX_26_reg_7_0_0_0,
  wrenable_reg_0,
  wrenable_reg_1,
  wrenable_reg_2,
  wrenable_reg_3,
  wrenable_reg_4,
  wrenable_reg_5,
  wrenable_reg_6,
  wrenable_reg_7,
  OUT_CONDITION_switch_big_cpp_424719_424737);
  parameter MEM_var_424761_424719=32,
    MEM_var_424779_424719=32,
    MEM_var_424790_424719=32,
    MEM_var_424801_424719=32;
  // IN
  input clock;
  input reset;
  input [31:0] in_port_P0;
  input fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_LOAD;
  input fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_STORE;
  input fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD;
  input fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE;
  input fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD;
  input fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE;
  input fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_LOAD;
  input fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_STORE;
  input selector_MUX_23_reg_4_0_0_0;
  input selector_MUX_24_reg_5_0_0_0;
  input selector_MUX_25_reg_6_0_0_0;
  input selector_MUX_26_reg_7_0_0_0;
  input wrenable_reg_0;
  input wrenable_reg_1;
  input wrenable_reg_2;
  input wrenable_reg_3;
  input wrenable_reg_4;
  input wrenable_reg_5;
  input wrenable_reg_6;
  input wrenable_reg_7;
  // OUT
  output [63:0] return_port;
  output OUT_CONDITION_switch_big_cpp_424719_424737;
  // Component and signal declarations
  wire null_out_signal_array_424761_0_Sout_DataRdy_0;
  wire null_out_signal_array_424761_0_Sout_DataRdy_1;
  wire [63:0] null_out_signal_array_424761_0_Sout_Rdata_ram_0;
  wire [63:0] null_out_signal_array_424761_0_Sout_Rdata_ram_1;
  wire [63:0] null_out_signal_array_424761_0_out1_1;
  wire [63:0] null_out_signal_array_424761_0_proxy_out1_0;
  wire [63:0] null_out_signal_array_424761_0_proxy_out1_1;
  wire null_out_signal_array_424779_0_Sout_DataRdy_0;
  wire null_out_signal_array_424779_0_Sout_DataRdy_1;
  wire [63:0] null_out_signal_array_424779_0_Sout_Rdata_ram_0;
  wire [63:0] null_out_signal_array_424779_0_Sout_Rdata_ram_1;
  wire [63:0] null_out_signal_array_424779_0_out1_1;
  wire [63:0] null_out_signal_array_424779_0_proxy_out1_0;
  wire [63:0] null_out_signal_array_424779_0_proxy_out1_1;
  wire null_out_signal_array_424790_0_Sout_DataRdy_0;
  wire null_out_signal_array_424790_0_Sout_DataRdy_1;
  wire [63:0] null_out_signal_array_424790_0_Sout_Rdata_ram_0;
  wire [63:0] null_out_signal_array_424790_0_Sout_Rdata_ram_1;
  wire [63:0] null_out_signal_array_424790_0_out1_1;
  wire [63:0] null_out_signal_array_424790_0_proxy_out1_0;
  wire [63:0] null_out_signal_array_424790_0_proxy_out1_1;
  wire null_out_signal_array_424801_0_Sout_DataRdy_0;
  wire null_out_signal_array_424801_0_Sout_DataRdy_1;
  wire [63:0] null_out_signal_array_424801_0_Sout_Rdata_ram_0;
  wire [63:0] null_out_signal_array_424801_0_Sout_Rdata_ram_1;
  wire [63:0] null_out_signal_array_424801_0_out1_1;
  wire [63:0] null_out_signal_array_424801_0_proxy_out1_0;
  wire [63:0] null_out_signal_array_424801_0_proxy_out1_1;
  wire [63:0] out_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_array_424761_0;
  wire [63:0] out_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_array_424779_0;
  wire [63:0] out_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_array_424790_0;
  wire [63:0] out_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_array_424801_0;
  wire [17:0] out_MUX_23_reg_4_0_0_0;
  wire [34:0] out_MUX_24_reg_5_0_0_0;
  wire [51:0] out_MUX_25_reg_6_0_0_0;
  wire out_MUX_26_reg_7_0_0_0;
  wire [5:0] out_addr_expr_FU_6_i0_fu_switch_big_cpp_424719_424850;
  wire [5:0] out_addr_expr_FU_7_i0_fu_switch_big_cpp_424719_424855;
  wire [5:0] out_addr_expr_FU_8_i0_fu_switch_big_cpp_424719_424860;
  wire [5:0] out_addr_expr_FU_9_i0_fu_switch_big_cpp_424719_424865;
  wire out_const_0;
  wire [7:0] out_const_1;
  wire out_const_2;
  wire [2:0] out_const_3;
  wire [1:0] out_const_4;
  wire [5:0] out_const_5;
  wire [5:0] out_const_6;
  wire [5:0] out_const_7;
  wire [5:0] out_const_8;
  wire [17:0] out_conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_array_424761_0_64_18;
  wire [34:0] out_conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_array_424779_0_64_35;
  wire [51:0] out_conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_array_424790_0_64_52;
  wire out_conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_array_424801_0_64_1;
  wire [6:0] out_conv_out_const_1_8_7;
  wire [31:0] out_conv_out_const_5_6_32;
  wire [31:0] out_conv_out_const_6_6_32;
  wire [31:0] out_conv_out_const_7_6_32;
  wire [31:0] out_conv_out_const_8_6_32;
  wire [17:0] out_conv_out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0_1_18;
  wire [34:0] out_conv_out_u_assign_conn_obj_1_ASSIGN_UNSIGNED_FU_u_assign_1_1_35;
  wire [51:0] out_conv_out_u_assign_conn_obj_2_ASSIGN_UNSIGNED_FU_u_assign_2_1_52;
  wire [63:0] out_conv_out_ui_bit_ior_expr_FU_0_64_64_18_i0_fu_switch_big_cpp_424719_424816_52_64;
  wire out_read_cond_FU_10_i0_fu_switch_big_cpp_424719_424737;
  wire [5:0] out_reg_0_reg_0;
  wire [5:0] out_reg_1_reg_1;
  wire [5:0] out_reg_2_reg_2;
  wire [5:0] out_reg_3_reg_3;
  wire [17:0] out_reg_4_reg_4;
  wire [34:0] out_reg_5_reg_5;
  wire [51:0] out_reg_6_reg_6;
  wire out_reg_7_reg_7;
  wire [0:0] out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0;
  wire [0:0] out_u_assign_conn_obj_1_ASSIGN_UNSIGNED_FU_u_assign_1;
  wire [0:0] out_u_assign_conn_obj_2_ASSIGN_UNSIGNED_FU_u_assign_2;
  wire [34:0] out_ui_bit_ior_expr_FU_0_64_64_16_i0_fu_switch_big_cpp_424719_424814;
  wire [51:0] out_ui_bit_ior_expr_FU_0_64_64_17_i0_fu_switch_big_cpp_424719_424815;
  wire [51:0] out_ui_bit_ior_expr_FU_0_64_64_18_i0_fu_switch_big_cpp_424719_424816;
  wire [5:0] out_ui_lshift_expr_FU_32_0_32_19_i0_fu_switch_big_cpp_424719_424852;
  wire [5:0] out_ui_lshift_expr_FU_32_0_32_19_i1_fu_switch_big_cpp_424719_424857;
  wire [5:0] out_ui_lshift_expr_FU_32_0_32_19_i2_fu_switch_big_cpp_424719_424862;
  wire [5:0] out_ui_lshift_expr_FU_32_0_32_19_i3_fu_switch_big_cpp_424719_424867;
  wire out_ui_lt_expr_FU_32_0_32_20_i0_fu_switch_big_cpp_424719_424846;
  wire [5:0] out_ui_pointer_plus_expr_FU_8_8_8_21_i0_fu_switch_big_cpp_424719_424747;
  wire [5:0] out_ui_pointer_plus_expr_FU_8_8_8_21_i1_fu_switch_big_cpp_424719_424749;
  wire [5:0] out_ui_pointer_plus_expr_FU_8_8_8_21_i2_fu_switch_big_cpp_424719_424751;
  wire [5:0] out_ui_pointer_plus_expr_FU_8_8_8_21_i3_fu_switch_big_cpp_424719_424753;
  
  ASSIGN_UNSIGNED_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) ASSIGN_UNSIGNED_FU_u_assign_0 (.out1(out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0),
    .in1(out_const_0));
  ASSIGN_UNSIGNED_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) ASSIGN_UNSIGNED_FU_u_assign_1 (.out1(out_u_assign_conn_obj_1_ASSIGN_UNSIGNED_FU_u_assign_1),
    .in1(out_const_0));
  ASSIGN_UNSIGNED_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) ASSIGN_UNSIGNED_FU_u_assign_2 (.out1(out_u_assign_conn_obj_2_ASSIGN_UNSIGNED_FU_u_assign_2),
    .in1(out_const_0));
  MUX_GATE #(.BITSIZE_in1(18),
    .BITSIZE_in2(18),
    .BITSIZE_out1(18)) MUX_23_reg_4_0_0_0 (.out1(out_MUX_23_reg_4_0_0_0),
    .sel(selector_MUX_23_reg_4_0_0_0),
    .in1(out_conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_array_424761_0_64_18),
    .in2(out_conv_out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0_1_18));
  MUX_GATE #(.BITSIZE_in1(35),
    .BITSIZE_in2(35),
    .BITSIZE_out1(35)) MUX_24_reg_5_0_0_0 (.out1(out_MUX_24_reg_5_0_0_0),
    .sel(selector_MUX_24_reg_5_0_0_0),
    .in1(out_conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_array_424779_0_64_35),
    .in2(out_conv_out_u_assign_conn_obj_1_ASSIGN_UNSIGNED_FU_u_assign_1_1_35));
  MUX_GATE #(.BITSIZE_in1(52),
    .BITSIZE_in2(52),
    .BITSIZE_out1(52)) MUX_25_reg_6_0_0_0 (.out1(out_MUX_25_reg_6_0_0_0),
    .sel(selector_MUX_25_reg_6_0_0_0),
    .in1(out_conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_array_424790_0_64_52),
    .in2(out_conv_out_u_assign_conn_obj_2_ASSIGN_UNSIGNED_FU_u_assign_2_1_52));
  MUX_GATE #(.BITSIZE_in1(1),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) MUX_26_reg_7_0_0_0 (.out1(out_MUX_26_reg_7_0_0_0),
    .sel(selector_MUX_26_reg_7_0_0_0),
    .in1(out_conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_array_424801_0_64_1),
    .in2(out_const_0));
  ARRAY_1D_STD_DISTRAM_NN_SDS #(.BITSIZE_in1(64),
    .PORTSIZE_in1(2),
    .BITSIZE_in2(6),
    .PORTSIZE_in2(2),
    .BITSIZE_in3(7),
    .PORTSIZE_in3(2),
    .BITSIZE_in4(1),
    .PORTSIZE_in4(2),
    .BITSIZE_sel_LOAD(1),
    .PORTSIZE_sel_LOAD(2),
    .BITSIZE_sel_STORE(1),
    .PORTSIZE_sel_STORE(2),
    .BITSIZE_S_oe_ram(1),
    .PORTSIZE_S_oe_ram(2),
    .BITSIZE_S_we_ram(1),
    .PORTSIZE_S_we_ram(2),
    .BITSIZE_out1(64),
    .PORTSIZE_out1(2),
    .BITSIZE_S_addr_ram(6),
    .PORTSIZE_S_addr_ram(2),
    .BITSIZE_S_Wdata_ram(64),
    .PORTSIZE_S_Wdata_ram(2),
    .BITSIZE_Sin_Rdata_ram(64),
    .PORTSIZE_Sin_Rdata_ram(2),
    .BITSIZE_Sout_Rdata_ram(64),
    .PORTSIZE_Sout_Rdata_ram(2),
    .BITSIZE_S_data_ram_size(7),
    .PORTSIZE_S_data_ram_size(2),
    .BITSIZE_Sin_DataRdy(1),
    .PORTSIZE_Sin_DataRdy(2),
    .BITSIZE_Sout_DataRdy(1),
    .PORTSIZE_Sout_DataRdy(2),
    .MEMORY_INIT_file("/home/lennart/Documents/bachelor-thesis/bambu-comparison/array_ref_424761.mem"),
    .n_elements(4),
    .data_size(64),
    .address_space_begin(MEM_var_424761_424719),
    .address_space_rangesize(32),
    .BUS_PIPELINED(1),
    .PRIVATE_MEMORY(1),
    .READ_ONLY_MEMORY(1),
    .USE_SPARSE_MEMORY(1),
    .ALIGNMENT(64),
    .BITSIZE_proxy_in1(64),
    .PORTSIZE_proxy_in1(2),
    .BITSIZE_proxy_in2(6),
    .PORTSIZE_proxy_in2(2),
    .BITSIZE_proxy_in3(7),
    .PORTSIZE_proxy_in3(2),
    .BITSIZE_proxy_sel_LOAD(1),
    .PORTSIZE_proxy_sel_LOAD(2),
    .BITSIZE_proxy_sel_STORE(1),
    .PORTSIZE_proxy_sel_STORE(2),
    .BITSIZE_proxy_out1(64),
    .PORTSIZE_proxy_out1(2)) array_424761_0 (.out1({null_out_signal_array_424761_0_out1_1,
      out_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_array_424761_0}),
    .Sout_Rdata_ram({null_out_signal_array_424761_0_Sout_Rdata_ram_1,
      null_out_signal_array_424761_0_Sout_Rdata_ram_0}),
    .Sout_DataRdy({null_out_signal_array_424761_0_Sout_DataRdy_1,
      null_out_signal_array_424761_0_Sout_DataRdy_0}),
    .proxy_out1({null_out_signal_array_424761_0_proxy_out1_1,
      null_out_signal_array_424761_0_proxy_out1_0}),
    .clock(clock),
    .reset(reset),
    .in1({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .in2({6'b000000,
      out_reg_0_reg_0}),
    .in3({7'b0000000,
      out_conv_out_const_1_8_7}),
    .in4({1'b0,
      out_const_2}),
    .sel_LOAD({1'b0,
      fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_LOAD}),
    .sel_STORE({1'b0,
      fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_STORE}),
    .S_oe_ram({1'b0,
      1'b0}),
    .S_we_ram({1'b0,
      1'b0}),
    .S_addr_ram({6'b000000,
      6'b000000}),
    .S_Wdata_ram({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .Sin_Rdata_ram({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .S_data_ram_size({7'b0000000,
      7'b0000000}),
    .Sin_DataRdy({1'b0,
      1'b0}),
    .proxy_in1({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .proxy_in2({6'b000000,
      6'b000000}),
    .proxy_in3({7'b0000000,
      7'b0000000}),
    .proxy_sel_LOAD({1'b0,
      1'b0}),
    .proxy_sel_STORE({1'b0,
      1'b0}));
  ARRAY_1D_STD_DISTRAM_NN_SDS #(.BITSIZE_in1(64),
    .PORTSIZE_in1(2),
    .BITSIZE_in2(6),
    .PORTSIZE_in2(2),
    .BITSIZE_in3(7),
    .PORTSIZE_in3(2),
    .BITSIZE_in4(1),
    .PORTSIZE_in4(2),
    .BITSIZE_sel_LOAD(1),
    .PORTSIZE_sel_LOAD(2),
    .BITSIZE_sel_STORE(1),
    .PORTSIZE_sel_STORE(2),
    .BITSIZE_S_oe_ram(1),
    .PORTSIZE_S_oe_ram(2),
    .BITSIZE_S_we_ram(1),
    .PORTSIZE_S_we_ram(2),
    .BITSIZE_out1(64),
    .PORTSIZE_out1(2),
    .BITSIZE_S_addr_ram(6),
    .PORTSIZE_S_addr_ram(2),
    .BITSIZE_S_Wdata_ram(64),
    .PORTSIZE_S_Wdata_ram(2),
    .BITSIZE_Sin_Rdata_ram(64),
    .PORTSIZE_Sin_Rdata_ram(2),
    .BITSIZE_Sout_Rdata_ram(64),
    .PORTSIZE_Sout_Rdata_ram(2),
    .BITSIZE_S_data_ram_size(7),
    .PORTSIZE_S_data_ram_size(2),
    .BITSIZE_Sin_DataRdy(1),
    .PORTSIZE_Sin_DataRdy(2),
    .BITSIZE_Sout_DataRdy(1),
    .PORTSIZE_Sout_DataRdy(2),
    .MEMORY_INIT_file("/home/lennart/Documents/bachelor-thesis/bambu-comparison/array_ref_424779.mem"),
    .n_elements(4),
    .data_size(64),
    .address_space_begin(MEM_var_424779_424719),
    .address_space_rangesize(32),
    .BUS_PIPELINED(1),
    .PRIVATE_MEMORY(1),
    .READ_ONLY_MEMORY(1),
    .USE_SPARSE_MEMORY(1),
    .ALIGNMENT(64),
    .BITSIZE_proxy_in1(64),
    .PORTSIZE_proxy_in1(2),
    .BITSIZE_proxy_in2(6),
    .PORTSIZE_proxy_in2(2),
    .BITSIZE_proxy_in3(7),
    .PORTSIZE_proxy_in3(2),
    .BITSIZE_proxy_sel_LOAD(1),
    .PORTSIZE_proxy_sel_LOAD(2),
    .BITSIZE_proxy_sel_STORE(1),
    .PORTSIZE_proxy_sel_STORE(2),
    .BITSIZE_proxy_out1(64),
    .PORTSIZE_proxy_out1(2)) array_424779_0 (.out1({null_out_signal_array_424779_0_out1_1,
      out_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_array_424779_0}),
    .Sout_Rdata_ram({null_out_signal_array_424779_0_Sout_Rdata_ram_1,
      null_out_signal_array_424779_0_Sout_Rdata_ram_0}),
    .Sout_DataRdy({null_out_signal_array_424779_0_Sout_DataRdy_1,
      null_out_signal_array_424779_0_Sout_DataRdy_0}),
    .proxy_out1({null_out_signal_array_424779_0_proxy_out1_1,
      null_out_signal_array_424779_0_proxy_out1_0}),
    .clock(clock),
    .reset(reset),
    .in1({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .in2({6'b000000,
      out_reg_1_reg_1}),
    .in3({7'b0000000,
      out_conv_out_const_1_8_7}),
    .in4({1'b0,
      out_const_2}),
    .sel_LOAD({1'b0,
      fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD}),
    .sel_STORE({1'b0,
      fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE}),
    .S_oe_ram({1'b0,
      1'b0}),
    .S_we_ram({1'b0,
      1'b0}),
    .S_addr_ram({6'b000000,
      6'b000000}),
    .S_Wdata_ram({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .Sin_Rdata_ram({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .S_data_ram_size({7'b0000000,
      7'b0000000}),
    .Sin_DataRdy({1'b0,
      1'b0}),
    .proxy_in1({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .proxy_in2({6'b000000,
      6'b000000}),
    .proxy_in3({7'b0000000,
      7'b0000000}),
    .proxy_sel_LOAD({1'b0,
      1'b0}),
    .proxy_sel_STORE({1'b0,
      1'b0}));
  ARRAY_1D_STD_DISTRAM_NN_SDS #(.BITSIZE_in1(64),
    .PORTSIZE_in1(2),
    .BITSIZE_in2(6),
    .PORTSIZE_in2(2),
    .BITSIZE_in3(7),
    .PORTSIZE_in3(2),
    .BITSIZE_in4(1),
    .PORTSIZE_in4(2),
    .BITSIZE_sel_LOAD(1),
    .PORTSIZE_sel_LOAD(2),
    .BITSIZE_sel_STORE(1),
    .PORTSIZE_sel_STORE(2),
    .BITSIZE_S_oe_ram(1),
    .PORTSIZE_S_oe_ram(2),
    .BITSIZE_S_we_ram(1),
    .PORTSIZE_S_we_ram(2),
    .BITSIZE_out1(64),
    .PORTSIZE_out1(2),
    .BITSIZE_S_addr_ram(6),
    .PORTSIZE_S_addr_ram(2),
    .BITSIZE_S_Wdata_ram(64),
    .PORTSIZE_S_Wdata_ram(2),
    .BITSIZE_Sin_Rdata_ram(64),
    .PORTSIZE_Sin_Rdata_ram(2),
    .BITSIZE_Sout_Rdata_ram(64),
    .PORTSIZE_Sout_Rdata_ram(2),
    .BITSIZE_S_data_ram_size(7),
    .PORTSIZE_S_data_ram_size(2),
    .BITSIZE_Sin_DataRdy(1),
    .PORTSIZE_Sin_DataRdy(2),
    .BITSIZE_Sout_DataRdy(1),
    .PORTSIZE_Sout_DataRdy(2),
    .MEMORY_INIT_file("/home/lennart/Documents/bachelor-thesis/bambu-comparison/array_ref_424790.mem"),
    .n_elements(4),
    .data_size(64),
    .address_space_begin(MEM_var_424790_424719),
    .address_space_rangesize(32),
    .BUS_PIPELINED(1),
    .PRIVATE_MEMORY(1),
    .READ_ONLY_MEMORY(1),
    .USE_SPARSE_MEMORY(1),
    .ALIGNMENT(64),
    .BITSIZE_proxy_in1(64),
    .PORTSIZE_proxy_in1(2),
    .BITSIZE_proxy_in2(6),
    .PORTSIZE_proxy_in2(2),
    .BITSIZE_proxy_in3(7),
    .PORTSIZE_proxy_in3(2),
    .BITSIZE_proxy_sel_LOAD(1),
    .PORTSIZE_proxy_sel_LOAD(2),
    .BITSIZE_proxy_sel_STORE(1),
    .PORTSIZE_proxy_sel_STORE(2),
    .BITSIZE_proxy_out1(64),
    .PORTSIZE_proxy_out1(2)) array_424790_0 (.out1({null_out_signal_array_424790_0_out1_1,
      out_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_array_424790_0}),
    .Sout_Rdata_ram({null_out_signal_array_424790_0_Sout_Rdata_ram_1,
      null_out_signal_array_424790_0_Sout_Rdata_ram_0}),
    .Sout_DataRdy({null_out_signal_array_424790_0_Sout_DataRdy_1,
      null_out_signal_array_424790_0_Sout_DataRdy_0}),
    .proxy_out1({null_out_signal_array_424790_0_proxy_out1_1,
      null_out_signal_array_424790_0_proxy_out1_0}),
    .clock(clock),
    .reset(reset),
    .in1({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .in2({6'b000000,
      out_reg_2_reg_2}),
    .in3({7'b0000000,
      out_conv_out_const_1_8_7}),
    .in4({1'b0,
      out_const_2}),
    .sel_LOAD({1'b0,
      fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD}),
    .sel_STORE({1'b0,
      fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE}),
    .S_oe_ram({1'b0,
      1'b0}),
    .S_we_ram({1'b0,
      1'b0}),
    .S_addr_ram({6'b000000,
      6'b000000}),
    .S_Wdata_ram({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .Sin_Rdata_ram({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .S_data_ram_size({7'b0000000,
      7'b0000000}),
    .Sin_DataRdy({1'b0,
      1'b0}),
    .proxy_in1({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .proxy_in2({6'b000000,
      6'b000000}),
    .proxy_in3({7'b0000000,
      7'b0000000}),
    .proxy_sel_LOAD({1'b0,
      1'b0}),
    .proxy_sel_STORE({1'b0,
      1'b0}));
  ARRAY_1D_STD_DISTRAM_NN_SDS #(.BITSIZE_in1(64),
    .PORTSIZE_in1(2),
    .BITSIZE_in2(6),
    .PORTSIZE_in2(2),
    .BITSIZE_in3(7),
    .PORTSIZE_in3(2),
    .BITSIZE_in4(1),
    .PORTSIZE_in4(2),
    .BITSIZE_sel_LOAD(1),
    .PORTSIZE_sel_LOAD(2),
    .BITSIZE_sel_STORE(1),
    .PORTSIZE_sel_STORE(2),
    .BITSIZE_S_oe_ram(1),
    .PORTSIZE_S_oe_ram(2),
    .BITSIZE_S_we_ram(1),
    .PORTSIZE_S_we_ram(2),
    .BITSIZE_out1(64),
    .PORTSIZE_out1(2),
    .BITSIZE_S_addr_ram(6),
    .PORTSIZE_S_addr_ram(2),
    .BITSIZE_S_Wdata_ram(64),
    .PORTSIZE_S_Wdata_ram(2),
    .BITSIZE_Sin_Rdata_ram(64),
    .PORTSIZE_Sin_Rdata_ram(2),
    .BITSIZE_Sout_Rdata_ram(64),
    .PORTSIZE_Sout_Rdata_ram(2),
    .BITSIZE_S_data_ram_size(7),
    .PORTSIZE_S_data_ram_size(2),
    .BITSIZE_Sin_DataRdy(1),
    .PORTSIZE_Sin_DataRdy(2),
    .BITSIZE_Sout_DataRdy(1),
    .PORTSIZE_Sout_DataRdy(2),
    .MEMORY_INIT_file("/home/lennart/Documents/bachelor-thesis/bambu-comparison/array_ref_424801.mem"),
    .n_elements(4),
    .data_size(64),
    .address_space_begin(MEM_var_424801_424719),
    .address_space_rangesize(32),
    .BUS_PIPELINED(1),
    .PRIVATE_MEMORY(1),
    .READ_ONLY_MEMORY(1),
    .USE_SPARSE_MEMORY(1),
    .ALIGNMENT(64),
    .BITSIZE_proxy_in1(64),
    .PORTSIZE_proxy_in1(2),
    .BITSIZE_proxy_in2(6),
    .PORTSIZE_proxy_in2(2),
    .BITSIZE_proxy_in3(7),
    .PORTSIZE_proxy_in3(2),
    .BITSIZE_proxy_sel_LOAD(1),
    .PORTSIZE_proxy_sel_LOAD(2),
    .BITSIZE_proxy_sel_STORE(1),
    .PORTSIZE_proxy_sel_STORE(2),
    .BITSIZE_proxy_out1(64),
    .PORTSIZE_proxy_out1(2)) array_424801_0 (.out1({null_out_signal_array_424801_0_out1_1,
      out_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_array_424801_0}),
    .Sout_Rdata_ram({null_out_signal_array_424801_0_Sout_Rdata_ram_1,
      null_out_signal_array_424801_0_Sout_Rdata_ram_0}),
    .Sout_DataRdy({null_out_signal_array_424801_0_Sout_DataRdy_1,
      null_out_signal_array_424801_0_Sout_DataRdy_0}),
    .proxy_out1({null_out_signal_array_424801_0_proxy_out1_1,
      null_out_signal_array_424801_0_proxy_out1_0}),
    .clock(clock),
    .reset(reset),
    .in1({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .in2({6'b000000,
      out_reg_3_reg_3}),
    .in3({7'b0000000,
      out_conv_out_const_1_8_7}),
    .in4({1'b0,
      out_const_2}),
    .sel_LOAD({1'b0,
      fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_LOAD}),
    .sel_STORE({1'b0,
      fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_STORE}),
    .S_oe_ram({1'b0,
      1'b0}),
    .S_we_ram({1'b0,
      1'b0}),
    .S_addr_ram({6'b000000,
      6'b000000}),
    .S_Wdata_ram({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .Sin_Rdata_ram({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .S_data_ram_size({7'b0000000,
      7'b0000000}),
    .Sin_DataRdy({1'b0,
      1'b0}),
    .proxy_in1({64'b0000000000000000000000000000000000000000000000000000000000000000,
      64'b0000000000000000000000000000000000000000000000000000000000000000}),
    .proxy_in2({6'b000000,
      6'b000000}),
    .proxy_in3({7'b0000000,
      7'b0000000}),
    .proxy_sel_LOAD({1'b0,
      1'b0}),
    .proxy_sel_STORE({1'b0,
      1'b0}));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b0)) const_0 (.out1(out_const_0));
  constant_value #(.BITSIZE_out1(8),
    .value(8'b01000000)) const_1 (.out1(out_const_1));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b1)) const_2 (.out1(out_const_2));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b100)) const_3 (.out1(out_const_3));
  constant_value #(.BITSIZE_out1(2),
    .value(2'b11)) const_4 (.out1(out_const_4));
  constant_value #(.BITSIZE_out1(6),
    .value(MEM_var_424761_424719)) const_5 (.out1(out_const_5));
  constant_value #(.BITSIZE_out1(6),
    .value(MEM_var_424779_424719)) const_6 (.out1(out_const_6));
  constant_value #(.BITSIZE_out1(6),
    .value(MEM_var_424790_424719)) const_7 (.out1(out_const_7));
  constant_value #(.BITSIZE_out1(6),
    .value(MEM_var_424801_424719)) const_8 (.out1(out_const_8));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(18)) conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_array_424761_0_64_18 (.out1(out_conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_array_424761_0_64_18),
    .in1(out_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_array_424761_0));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(35)) conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_array_424779_0_64_35 (.out1(out_conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_array_424779_0_64_35),
    .in1(out_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_array_424779_0));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(52)) conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_array_424790_0_64_52 (.out1(out_conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_array_424790_0_64_52),
    .in1(out_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_array_424790_0));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(1)) conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_array_424801_0_64_1 (.out1(out_conv_out_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_array_424801_0_64_1),
    .in1(out_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_array_424801_0));
  UUdata_converter_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(7)) conv_out_const_1_8_7 (.out1(out_conv_out_const_1_8_7),
    .in1(out_const_1));
  UUdata_converter_FU #(.BITSIZE_in1(6),
    .BITSIZE_out1(32)) conv_out_const_5_6_32 (.out1(out_conv_out_const_5_6_32),
    .in1(out_const_5));
  UUdata_converter_FU #(.BITSIZE_in1(6),
    .BITSIZE_out1(32)) conv_out_const_6_6_32 (.out1(out_conv_out_const_6_6_32),
    .in1(out_const_6));
  UUdata_converter_FU #(.BITSIZE_in1(6),
    .BITSIZE_out1(32)) conv_out_const_7_6_32 (.out1(out_conv_out_const_7_6_32),
    .in1(out_const_7));
  UUdata_converter_FU #(.BITSIZE_in1(6),
    .BITSIZE_out1(32)) conv_out_const_8_6_32 (.out1(out_conv_out_const_8_6_32),
    .in1(out_const_8));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(18)) conv_out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0_1_18 (.out1(out_conv_out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0_1_18),
    .in1(out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(35)) conv_out_u_assign_conn_obj_1_ASSIGN_UNSIGNED_FU_u_assign_1_1_35 (.out1(out_conv_out_u_assign_conn_obj_1_ASSIGN_UNSIGNED_FU_u_assign_1_1_35),
    .in1(out_u_assign_conn_obj_1_ASSIGN_UNSIGNED_FU_u_assign_1));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(52)) conv_out_u_assign_conn_obj_2_ASSIGN_UNSIGNED_FU_u_assign_2_1_52 (.out1(out_conv_out_u_assign_conn_obj_2_ASSIGN_UNSIGNED_FU_u_assign_2_1_52),
    .in1(out_u_assign_conn_obj_2_ASSIGN_UNSIGNED_FU_u_assign_2));
  UUdata_converter_FU #(.BITSIZE_in1(52),
    .BITSIZE_out1(64)) conv_out_ui_bit_ior_expr_FU_0_64_64_18_i0_fu_switch_big_cpp_424719_424816_52_64 (.out1(out_conv_out_ui_bit_ior_expr_FU_0_64_64_18_i0_fu_switch_big_cpp_424719_424816_52_64),
    .in1(out_ui_bit_ior_expr_FU_0_64_64_18_i0_fu_switch_big_cpp_424719_424816));
  read_cond_FU #(.BITSIZE_in1(1)) fu_switch_big_cpp_424719_424737 (.out1(out_read_cond_FU_10_i0_fu_switch_big_cpp_424719_424737),
    .in1(out_ui_lt_expr_FU_32_0_32_20_i0_fu_switch_big_cpp_424719_424846));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(6),
    .BITSIZE_in2(6),
    .BITSIZE_out1(6),
    .LSB_PARAMETER(3)) fu_switch_big_cpp_424719_424747 (.out1(out_ui_pointer_plus_expr_FU_8_8_8_21_i0_fu_switch_big_cpp_424719_424747),
    .in1(out_addr_expr_FU_6_i0_fu_switch_big_cpp_424719_424850),
    .in2(out_ui_lshift_expr_FU_32_0_32_19_i0_fu_switch_big_cpp_424719_424852));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(6),
    .BITSIZE_in2(6),
    .BITSIZE_out1(6),
    .LSB_PARAMETER(3)) fu_switch_big_cpp_424719_424749 (.out1(out_ui_pointer_plus_expr_FU_8_8_8_21_i1_fu_switch_big_cpp_424719_424749),
    .in1(out_addr_expr_FU_7_i0_fu_switch_big_cpp_424719_424855),
    .in2(out_ui_lshift_expr_FU_32_0_32_19_i1_fu_switch_big_cpp_424719_424857));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(6),
    .BITSIZE_in2(6),
    .BITSIZE_out1(6),
    .LSB_PARAMETER(3)) fu_switch_big_cpp_424719_424751 (.out1(out_ui_pointer_plus_expr_FU_8_8_8_21_i2_fu_switch_big_cpp_424719_424751),
    .in1(out_addr_expr_FU_8_i0_fu_switch_big_cpp_424719_424860),
    .in2(out_ui_lshift_expr_FU_32_0_32_19_i2_fu_switch_big_cpp_424719_424862));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(6),
    .BITSIZE_in2(6),
    .BITSIZE_out1(6),
    .LSB_PARAMETER(3)) fu_switch_big_cpp_424719_424753 (.out1(out_ui_pointer_plus_expr_FU_8_8_8_21_i3_fu_switch_big_cpp_424719_424753),
    .in1(out_addr_expr_FU_9_i0_fu_switch_big_cpp_424719_424865),
    .in2(out_ui_lshift_expr_FU_32_0_32_19_i3_fu_switch_big_cpp_424719_424867));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(35),
    .BITSIZE_in2(18),
    .BITSIZE_out1(35)) fu_switch_big_cpp_424719_424814 (.out1(out_ui_bit_ior_expr_FU_0_64_64_16_i0_fu_switch_big_cpp_424719_424814),
    .in1(out_reg_5_reg_5),
    .in2(out_reg_4_reg_4));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(35),
    .BITSIZE_in2(52),
    .BITSIZE_out1(52)) fu_switch_big_cpp_424719_424815 (.out1(out_ui_bit_ior_expr_FU_0_64_64_17_i0_fu_switch_big_cpp_424719_424815),
    .in1(out_ui_bit_ior_expr_FU_0_64_64_16_i0_fu_switch_big_cpp_424719_424814),
    .in2(out_reg_6_reg_6));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(52),
    .BITSIZE_in2(1),
    .BITSIZE_out1(52)) fu_switch_big_cpp_424719_424816 (.out1(out_ui_bit_ior_expr_FU_0_64_64_18_i0_fu_switch_big_cpp_424719_424816),
    .in1(out_ui_bit_ior_expr_FU_0_64_64_17_i0_fu_switch_big_cpp_424719_424815),
    .in2(out_reg_7_reg_7));
  ui_lt_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(1)) fu_switch_big_cpp_424719_424846 (.out1(out_ui_lt_expr_FU_32_0_32_20_i0_fu_switch_big_cpp_424719_424846),
    .in1(in_port_P0),
    .in2(out_const_3));
  addr_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(6)) fu_switch_big_cpp_424719_424850 (.out1(out_addr_expr_FU_6_i0_fu_switch_big_cpp_424719_424850),
    .in1(out_conv_out_const_5_6_32));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(6),
    .PRECISION(32)) fu_switch_big_cpp_424719_424852 (.out1(out_ui_lshift_expr_FU_32_0_32_19_i0_fu_switch_big_cpp_424719_424852),
    .in1(in_port_P0),
    .in2(out_const_4));
  addr_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(6)) fu_switch_big_cpp_424719_424855 (.out1(out_addr_expr_FU_7_i0_fu_switch_big_cpp_424719_424855),
    .in1(out_conv_out_const_6_6_32));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(6),
    .PRECISION(32)) fu_switch_big_cpp_424719_424857 (.out1(out_ui_lshift_expr_FU_32_0_32_19_i1_fu_switch_big_cpp_424719_424857),
    .in1(in_port_P0),
    .in2(out_const_4));
  addr_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(6)) fu_switch_big_cpp_424719_424860 (.out1(out_addr_expr_FU_8_i0_fu_switch_big_cpp_424719_424860),
    .in1(out_conv_out_const_7_6_32));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(6),
    .PRECISION(32)) fu_switch_big_cpp_424719_424862 (.out1(out_ui_lshift_expr_FU_32_0_32_19_i2_fu_switch_big_cpp_424719_424862),
    .in1(in_port_P0),
    .in2(out_const_4));
  addr_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(6)) fu_switch_big_cpp_424719_424865 (.out1(out_addr_expr_FU_9_i0_fu_switch_big_cpp_424719_424865),
    .in1(out_conv_out_const_8_6_32));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(6),
    .PRECISION(32)) fu_switch_big_cpp_424719_424867 (.out1(out_ui_lshift_expr_FU_32_0_32_19_i3_fu_switch_big_cpp_424719_424867),
    .in1(in_port_P0),
    .in2(out_const_4));
  register_STD #(.BITSIZE_in1(6),
    .BITSIZE_out1(6)) reg_0 (.out1(out_reg_0_reg_0),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_8_8_8_21_i0_fu_switch_big_cpp_424719_424747),
    .wenable(wrenable_reg_0));
  register_STD #(.BITSIZE_in1(6),
    .BITSIZE_out1(6)) reg_1 (.out1(out_reg_1_reg_1),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_8_8_8_21_i1_fu_switch_big_cpp_424719_424749),
    .wenable(wrenable_reg_1));
  register_STD #(.BITSIZE_in1(6),
    .BITSIZE_out1(6)) reg_2 (.out1(out_reg_2_reg_2),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_8_8_8_21_i2_fu_switch_big_cpp_424719_424751),
    .wenable(wrenable_reg_2));
  register_STD #(.BITSIZE_in1(6),
    .BITSIZE_out1(6)) reg_3 (.out1(out_reg_3_reg_3),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_8_8_8_21_i3_fu_switch_big_cpp_424719_424753),
    .wenable(wrenable_reg_3));
  register_SE #(.BITSIZE_in1(18),
    .BITSIZE_out1(18)) reg_4 (.out1(out_reg_4_reg_4),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_23_reg_4_0_0_0),
    .wenable(wrenable_reg_4));
  register_SE #(.BITSIZE_in1(35),
    .BITSIZE_out1(35)) reg_5 (.out1(out_reg_5_reg_5),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_24_reg_5_0_0_0),
    .wenable(wrenable_reg_5));
  register_SE #(.BITSIZE_in1(52),
    .BITSIZE_out1(52)) reg_6 (.out1(out_reg_6_reg_6),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_25_reg_6_0_0_0),
    .wenable(wrenable_reg_6));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_7 (.out1(out_reg_7_reg_7),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_26_reg_7_0_0_0),
    .wenable(wrenable_reg_7));
  // io-signal post fix
  assign return_port = out_conv_out_ui_bit_ior_expr_FU_0_64_64_18_i0_fu_switch_big_cpp_424719_424816_52_64;
  assign OUT_CONDITION_switch_big_cpp_424719_424737 = out_read_cond_FU_10_i0_fu_switch_big_cpp_424719_424737;

endmodule

// FSM based controller description for switch_big_cpp
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module controller_switch_big_cpp(done_port,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_LOAD,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_STORE,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_LOAD,
  fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_STORE,
  selector_MUX_23_reg_4_0_0_0,
  selector_MUX_24_reg_5_0_0_0,
  selector_MUX_25_reg_6_0_0_0,
  selector_MUX_26_reg_7_0_0_0,
  wrenable_reg_0,
  wrenable_reg_1,
  wrenable_reg_2,
  wrenable_reg_3,
  wrenable_reg_4,
  wrenable_reg_5,
  wrenable_reg_6,
  wrenable_reg_7,
  OUT_CONDITION_switch_big_cpp_424719_424737,
  clock,
  reset,
  start_port);
  // IN
  input OUT_CONDITION_switch_big_cpp_424719_424737;
  input clock;
  input reset;
  input start_port;
  // OUT
  output done_port;
  output fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_LOAD;
  output fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_STORE;
  output fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD;
  output fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE;
  output fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD;
  output fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE;
  output fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_LOAD;
  output fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_STORE;
  output selector_MUX_23_reg_4_0_0_0;
  output selector_MUX_24_reg_5_0_0_0;
  output selector_MUX_25_reg_6_0_0_0;
  output selector_MUX_26_reg_7_0_0_0;
  output wrenable_reg_0;
  output wrenable_reg_1;
  output wrenable_reg_2;
  output wrenable_reg_3;
  output wrenable_reg_4;
  output wrenable_reg_5;
  output wrenable_reg_6;
  output wrenable_reg_7;
  parameter [2:0] S_0 = 3'b001,
    S_1 = 3'b010,
    S_2 = 3'b100;
  reg [2:0] _present_state=S_0, _next_state;
  reg done_port;
  reg fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_LOAD;
  reg fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_STORE;
  reg fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD;
  reg fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE;
  reg fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD;
  reg fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE;
  reg fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_LOAD;
  reg fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_STORE;
  reg selector_MUX_23_reg_4_0_0_0;
  reg selector_MUX_24_reg_5_0_0_0;
  reg selector_MUX_25_reg_6_0_0_0;
  reg selector_MUX_26_reg_7_0_0_0;
  reg wrenable_reg_0;
  reg wrenable_reg_1;
  reg wrenable_reg_2;
  reg wrenable_reg_3;
  reg wrenable_reg_4;
  reg wrenable_reg_5;
  reg wrenable_reg_6;
  reg wrenable_reg_7;
  
  always @(posedge clock)
    if (reset == 1'b0) _present_state <= S_0;
    else _present_state <= _next_state;
  
  always @(*)
  begin
    done_port = 1'b0;
    fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_LOAD = 1'b0;
    fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_STORE = 1'b0;
    fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD = 1'b0;
    fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE = 1'b0;
    fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD = 1'b0;
    fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE = 1'b0;
    fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_LOAD = 1'b0;
    fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_STORE = 1'b0;
    selector_MUX_23_reg_4_0_0_0 = 1'b0;
    selector_MUX_24_reg_5_0_0_0 = 1'b0;
    selector_MUX_25_reg_6_0_0_0 = 1'b0;
    selector_MUX_26_reg_7_0_0_0 = 1'b0;
    wrenable_reg_0 = 1'b0;
    wrenable_reg_1 = 1'b0;
    wrenable_reg_2 = 1'b0;
    wrenable_reg_3 = 1'b0;
    wrenable_reg_4 = 1'b0;
    wrenable_reg_5 = 1'b0;
    wrenable_reg_6 = 1'b0;
    wrenable_reg_7 = 1'b0;
    case (_present_state)
      S_0 :
        if(start_port == 1'b1)
        begin
          wrenable_reg_0 = 1'b1;
          wrenable_reg_1 = 1'b1;
          wrenable_reg_2 = 1'b1;
          wrenable_reg_3 = 1'b1;
          wrenable_reg_4 = 1'b1;
          wrenable_reg_5 = 1'b1;
          wrenable_reg_6 = 1'b1;
          wrenable_reg_7 = 1'b1;
          if (OUT_CONDITION_switch_big_cpp_424719_424737 == 1'b1)
            begin
              _next_state = S_1;
              wrenable_reg_4 = 1'b0;
              wrenable_reg_5 = 1'b0;
              wrenable_reg_6 = 1'b0;
              wrenable_reg_7 = 1'b0;
            end
          else
            begin
              _next_state = S_2;
              done_port = 1'b1;
              wrenable_reg_0 = 1'b0;
              wrenable_reg_1 = 1'b0;
              wrenable_reg_2 = 1'b0;
              wrenable_reg_3 = 1'b0;
            end
        end
        else
        begin
          _next_state = S_0;
        end
      S_1 :
        begin
          fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_LOAD = 1'b1;
          fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD = 1'b1;
          fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD = 1'b1;
          fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_LOAD = 1'b1;
          selector_MUX_23_reg_4_0_0_0 = 1'b1;
          selector_MUX_24_reg_5_0_0_0 = 1'b1;
          selector_MUX_25_reg_6_0_0_0 = 1'b1;
          selector_MUX_26_reg_7_0_0_0 = 1'b1;
          wrenable_reg_4 = 1'b1;
          wrenable_reg_5 = 1'b1;
          wrenable_reg_6 = 1'b1;
          wrenable_reg_7 = 1'b1;
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

// Top component for switch_big_cpp
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module _switch_big_cpp(clock,
  reset,
  start_port,
  done_port,
  P0,
  return_port);
  // IN
  input clock;
  input reset;
  input start_port;
  input [31:0] P0;
  // OUT
  output done_port;
  output [63:0] return_port;
  // Component and signal declarations
  wire OUT_CONDITION_switch_big_cpp_424719_424737;
  wire done_delayed_REG_signal_in;
  wire done_delayed_REG_signal_out;
  wire fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_LOAD;
  wire fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_STORE;
  wire fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD;
  wire fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE;
  wire fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD;
  wire fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE;
  wire fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_LOAD;
  wire fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_STORE;
  wire selector_MUX_23_reg_4_0_0_0;
  wire selector_MUX_24_reg_5_0_0_0;
  wire selector_MUX_25_reg_6_0_0_0;
  wire selector_MUX_26_reg_7_0_0_0;
  wire wrenable_reg_0;
  wire wrenable_reg_1;
  wire wrenable_reg_2;
  wire wrenable_reg_3;
  wire wrenable_reg_4;
  wire wrenable_reg_5;
  wire wrenable_reg_6;
  wire wrenable_reg_7;
  
  controller_switch_big_cpp Controller_i (.done_port(done_delayed_REG_signal_in),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_LOAD(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_LOAD),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_STORE(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_STORE),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_LOAD(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_LOAD),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_STORE(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_STORE),
    .selector_MUX_23_reg_4_0_0_0(selector_MUX_23_reg_4_0_0_0),
    .selector_MUX_24_reg_5_0_0_0(selector_MUX_24_reg_5_0_0_0),
    .selector_MUX_25_reg_6_0_0_0(selector_MUX_25_reg_6_0_0_0),
    .selector_MUX_26_reg_7_0_0_0(selector_MUX_26_reg_7_0_0_0),
    .wrenable_reg_0(wrenable_reg_0),
    .wrenable_reg_1(wrenable_reg_1),
    .wrenable_reg_2(wrenable_reg_2),
    .wrenable_reg_3(wrenable_reg_3),
    .wrenable_reg_4(wrenable_reg_4),
    .wrenable_reg_5(wrenable_reg_5),
    .wrenable_reg_6(wrenable_reg_6),
    .wrenable_reg_7(wrenable_reg_7),
    .OUT_CONDITION_switch_big_cpp_424719_424737(OUT_CONDITION_switch_big_cpp_424719_424737),
    .clock(clock),
    .reset(reset),
    .start_port(start_port));
  datapath_switch_big_cpp #(.MEM_var_424761_424719(32),
    .MEM_var_424779_424719(32),
    .MEM_var_424790_424719(32),
    .MEM_var_424801_424719(32)) Datapath_i (.return_port(return_port),
    .OUT_CONDITION_switch_big_cpp_424719_424737(OUT_CONDITION_switch_big_cpp_424719_424737),
    .clock(clock),
    .reset(reset),
    .in_port_P0(P0),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_LOAD(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_LOAD),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_STORE(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_0_i0_STORE),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_LOAD),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_1_i0_STORE),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_LOAD),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_2_i0_STORE),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_LOAD(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_LOAD),
    .fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_STORE(fuselector_ARRAY_1D_STD_DISTRAM_NN_SDS_3_i0_STORE),
    .selector_MUX_23_reg_4_0_0_0(selector_MUX_23_reg_4_0_0_0),
    .selector_MUX_24_reg_5_0_0_0(selector_MUX_24_reg_5_0_0_0),
    .selector_MUX_25_reg_6_0_0_0(selector_MUX_25_reg_6_0_0_0),
    .selector_MUX_26_reg_7_0_0_0(selector_MUX_26_reg_7_0_0_0),
    .wrenable_reg_0(wrenable_reg_0),
    .wrenable_reg_1(wrenable_reg_1),
    .wrenable_reg_2(wrenable_reg_2),
    .wrenable_reg_3(wrenable_reg_3),
    .wrenable_reg_4(wrenable_reg_4),
    .wrenable_reg_5(wrenable_reg_5),
    .wrenable_reg_6(wrenable_reg_6),
    .wrenable_reg_7(wrenable_reg_7));
  flipflop_AR #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) done_delayed_REG (.out1(done_delayed_REG_signal_out),
    .clock(clock),
    .reset(reset),
    .in1(done_delayed_REG_signal_in));
  // io-signal post fix
  assign done_port = done_delayed_REG_signal_out;

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

// Minimal interface for function: switch_big_cpp
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module switch_big_cpp(clock,
  reset,
  start_port,
  P0,
  done_port,
  return_port);
  // IN
  input clock;
  input reset;
  input start_port;
  input [31:0] P0;
  // OUT
  output done_port;
  output [63:0] return_port;
  // Component and signal declarations
  wire [63:0] out_return_port_ui_view_convert_expr_FU;
  
  _switch_big_cpp _switch_big_cpp_i0 (.done_port(done_port),
    .return_port(out_return_port_ui_view_convert_expr_FU),
    .clock(clock),
    .reset(reset),
    .start_port(start_port),
    .P0(P0));
  ui_view_convert_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(64)) return_port_ui_view_convert_expr_FU (.out1(return_port),
    .in1(out_return_port_ui_view_convert_expr_FU));

endmodule


