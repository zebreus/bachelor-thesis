// 
// Politecnico di Milano
// Code created using PandA - Version: PandA 2023.2 - Revision 891ec3caed502474cab0813cc4a9fc678deabaa5 - Date 2023-06-26T12:20:55
// /nix/store/9c5lz0md936sjhs9hw1ya6kghvkfc4zg-bambu-wrapped/bin/bambu executed with: /nix/store/9c5lz0md936sjhs9hw1ya6kghvkfc4zg-bambu-wrapped/bin/bambu --simulator=VERILATOR --top-fname=md5_speed --clock-name=clk --compiler=I386_CLANG16 --channels-type=MEM_ACC_11 --channels-number=1 -O5 md5_speed.ll 
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
module ADDRESS_DECODING_LOGIC(clock,
  reset,
  in1,
  in2,
  in3,
  sel_LOAD,
  sel_STORE,
  S_oe_ram,
  S_we_ram,
  S_addr_ram,
  S_Wdata_ram,
  Sin_Rdata_ram,
  S_data_ram_size,
  Sin_DataRdy,
  out1,
  Sout_Rdata_ram,
  Sout_DataRdy,
  proxy_in1,
  proxy_in2,
  proxy_in3,
  proxy_sel_LOAD,
  proxy_sel_STORE,
  proxy_out1,
  dout_a,
  dout_b,
  memory_addr_a,
  memory_addr_b,
  din_value_aggregated,
  be,
  bram_write);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_in3=1,
    BITSIZE_out1=1,
    BITSIZE_S_addr_ram=1,
    BITSIZE_S_Wdata_ram=8,
    BITSIZE_Sin_Rdata_ram=8,
    BITSIZE_Sout_Rdata_ram=8,
    BITSIZE_S_data_ram_size=1,
    address_space_begin=0,
    address_space_rangesize=4,
    BUS_PIPELINED=1,
    BRAM_BITSIZE=32,
    PRIVATE_MEMORY=0,
    USE_SPARSE_MEMORY=1,
    HIGH_LATENCY=0,
    BITSIZE_proxy_in1=1,
    BITSIZE_proxy_in2=1,
    BITSIZE_proxy_in3=1,
    BITSIZE_proxy_out1=1,
    BITSIZE_dout_a=1,
    BITSIZE_dout_b=1,
    BITSIZE_memory_addr_a=1,
    BITSIZE_memory_addr_b=1,
    BITSIZE_din_value_aggregated=1,
    BITSIZE_be=1,
    nbit_read_addr=32,
    n_byte_on_databus=4,
    n_mem_elements=4,
    n_bytes=4;
  // IN
  input clock;
  input reset;
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  input [BITSIZE_in3-1:0] in3;
  input sel_LOAD;
  input sel_STORE;
  input S_oe_ram;
  input S_we_ram;
  input [BITSIZE_S_addr_ram-1:0] S_addr_ram;
  input [BITSIZE_S_Wdata_ram-1:0] S_Wdata_ram;
  input [BITSIZE_Sin_Rdata_ram-1:0] Sin_Rdata_ram;
  input [BITSIZE_S_data_ram_size-1:0] S_data_ram_size;
  input Sin_DataRdy;
  input [BITSIZE_proxy_in1-1:0] proxy_in1;
  input [BITSIZE_proxy_in2-1:0] proxy_in2;
  input [BITSIZE_proxy_in3-1:0] proxy_in3;
  input proxy_sel_LOAD;
  input proxy_sel_STORE;
  input [BITSIZE_dout_a-1:0] dout_a;
  input [BITSIZE_dout_b-1:0] dout_b;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  output [BITSIZE_Sout_Rdata_ram-1:0] Sout_Rdata_ram;
  output Sout_DataRdy;
  output [BITSIZE_proxy_out1-1:0] proxy_out1;
  output [BITSIZE_memory_addr_a-1:0] memory_addr_a;
  output [BITSIZE_memory_addr_b-1:0] memory_addr_b;
  output [BITSIZE_din_value_aggregated-1:0] din_value_aggregated;
  output [BITSIZE_be-1:0] be;
  output bram_write;
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
    parameter nbit_addr = BITSIZE_S_addr_ram/*n_bytes ==  1 ? 1 : $clog2(n_bytes)*/;
    parameter nbits_address_space_rangesize = $clog2(address_space_rangesize);
    parameter nbits_byte_offset = n_byte_on_databus==1 ? 1 : $clog2(n_byte_on_databus);
  `else
    parameter nbit_addr = BITSIZE_S_addr_ram/*n_bytes ==  1 ? 1 : log2(n_bytes)*/;
    parameter nbits_address_space_rangesize = log2(address_space_rangesize);
    parameter nbits_byte_offset = n_byte_on_databus==1 ? 1 : log2(n_byte_on_databus);
  `endif
  
  
  function [n_byte_on_databus*2-1:0] CONV;
    input [n_byte_on_databus*2-1:0] po2;
  begin
    case (po2)
      1:CONV=(1<<1)-1;
      2:CONV=(1<<2)-1;
      4:CONV=(1<<4)-1;
      8:CONV=(1<<8)-1;
      16:CONV=(1<<16)-1;
      32:CONV=(1<<32)-1;
      default:CONV=-1;
    endcase
  end
  endfunction
  wire [2*BRAM_BITSIZE-1:0] dout;
  wire [2*BRAM_BITSIZE-1:0] out1_shifted;
  wire [2*BRAM_BITSIZE-1:0] S_Wdata_ram_int;
  wire cs, oe_ram_cs, we_ram_cs;
  wire [n_byte_on_databus*2-1:0] conv_in;
  wire [n_byte_on_databus*2-1:0] conv_out;
  wire [nbits_byte_offset-1:0] byte_offset;
  wire [BITSIZE_in2-1:0] tmp_addr;
  wire [nbit_addr-1:0] relative_addr;
  
  reg we_ram_cs_delayed =0;
  reg oe_ram_cs_delayed =0;
  reg oe_ram_cs_delayed_registered =0;
  reg oe_ram_cs_delayed_registered1 =0;
  reg [nbits_byte_offset-1:0] delayed_byte_offset =0;
  reg [nbits_byte_offset-1:0] delayed_byte_offset_registered =0;
  reg [nbits_byte_offset-1:0] delayed_byte_offset_registered1 =0;
  
  assign tmp_addr = (proxy_sel_LOAD||proxy_sel_STORE) ? proxy_in2 : in2;
  
  generate
  genvar j0_a;
    for (j0_a=0; j0_a<n_byte_on_databus; j0_a=j0_a+1)
    begin  : dout_a_computation
      assign dout[(j0_a+1)*8-1:j0_a*8] = dout_a[(j0_a+1)*8-1:j0_a*8];
    end
  endgenerate
  
  generate
  genvar j0_b;
    for (j0_b=0; j0_b<n_byte_on_databus; j0_b=j0_b+1)
    begin  : dout_b_computation
      assign dout[(j0_b+n_byte_on_databus+1)*8-1:(j0_b+n_byte_on_databus)*8] = dout_b[(j0_b+1)*8-1:j0_b*8];
    end
  endgenerate
  
  generate
    if(PRIVATE_MEMORY==0 && USE_SPARSE_MEMORY==0)
      assign cs = (S_addr_ram >= (address_space_begin)) && (S_addr_ram < (address_space_begin+address_space_rangesize));
    else if(PRIVATE_MEMORY==0 && nbits_address_space_rangesize < 32)
      assign cs = S_addr_ram[nbit_addr-1:nbits_address_space_rangesize] == address_space_begin[((nbit_addr-1) < 32 ? (nbit_addr-1) : 31):nbits_address_space_rangesize];
    else
      assign cs = 1'b0;
  endgenerate
  assign oe_ram_cs = S_oe_ram && cs;
  assign we_ram_cs = S_we_ram && cs;
  generate
    if(PRIVATE_MEMORY==0 && USE_SPARSE_MEMORY==0)
      assign relative_addr = (sel_STORE===1'b1 || sel_LOAD===1'b1 || proxy_sel_STORE===1'b1 || proxy_sel_LOAD===1'b1) ? tmp_addr-address_space_begin[((nbit_addr-1) < 32 ? (nbit_addr-1) : 31):0] : S_addr_ram-address_space_begin[((nbit_addr-1) < 32 ? (nbit_addr-1) : 31):0];
    else if(PRIVATE_MEMORY==0)
      assign relative_addr = (sel_STORE===1'b1 || sel_LOAD===1'b1 || proxy_sel_STORE===1'b1 || proxy_sel_LOAD===1'b1) ? tmp_addr[nbits_address_space_rangesize-1:0] : S_addr_ram[nbits_address_space_rangesize-1:0];
    else if(USE_SPARSE_MEMORY==1)
      assign relative_addr = tmp_addr[nbits_address_space_rangesize-1:0];
    else
      assign relative_addr = tmp_addr-address_space_begin[((nbit_addr-1) < 32 ? (nbit_addr-1) : 31):0];
  endgenerate
  
  generate
    if (n_mem_elements==1)
      assign memory_addr_a = {nbit_read_addr{1'b0}};
    else if(n_byte_on_databus==1)
      assign memory_addr_a = relative_addr[nbit_read_addr-1:0];
    else
      assign memory_addr_a = relative_addr[nbit_read_addr+nbits_byte_offset-1:nbits_byte_offset];
  endgenerate
  
  generate
    if (n_bytes <= BRAM_BITSIZE/8)
      assign memory_addr_b = {nbit_read_addr{1'b0}};
    else if(n_byte_on_databus==1)
      assign memory_addr_b = relative_addr[nbit_read_addr-1:0] + 1'b1;
    else
      assign memory_addr_b = relative_addr[nbit_read_addr+nbits_byte_offset-1:nbits_byte_offset] + 1'b1;
  endgenerate
  
  generate
    if (n_byte_on_databus==1)
      assign byte_offset = {nbits_byte_offset{1'b0}};
    else
      assign byte_offset = relative_addr[nbits_byte_offset-1:0];
  endgenerate
  
  generate
    if(PRIVATE_MEMORY==0)
    begin
      assign conv_in = proxy_sel_STORE ? proxy_in3[BITSIZE_proxy_in3-1:3] : (sel_STORE ? in3[BITSIZE_in3-1:3] : S_data_ram_size[BITSIZE_S_data_ram_size-1:3]);
      assign conv_out = CONV(conv_in);
      assign be = conv_out << byte_offset;
    end
    else
    begin
      assign conv_in = proxy_sel_STORE ? proxy_in3[BITSIZE_proxy_in3-1:3] : in3[BITSIZE_in3-1:3];
      assign conv_out = CONV(conv_in);
      assign be = conv_out << byte_offset;
    end
  endgenerate
  
  generate
    if (BITSIZE_S_Wdata_ram < 2*BRAM_BITSIZE)
      assign S_Wdata_ram_int = {{2*BRAM_BITSIZE-BITSIZE_S_Wdata_ram{1'b0}}, S_Wdata_ram};
    else
      assign S_Wdata_ram_int = S_Wdata_ram[2*BRAM_BITSIZE-1:0];
  endgenerate
  
  generate
    if(PRIVATE_MEMORY==0)
      assign din_value_aggregated = proxy_sel_STORE ? proxy_in1 << byte_offset*8 : (sel_STORE ? in1 << byte_offset*8 : S_Wdata_ram_int << byte_offset*8);
    else
      assign din_value_aggregated = proxy_sel_STORE ? proxy_in1 << byte_offset*8 : in1 << byte_offset*8;
  endgenerate
  
  assign out1_shifted = dout >> delayed_byte_offset*8;
  assign out1 = out1_shifted;
  assign proxy_out1 = out1_shifted;
  
  always @(posedge clock )
  begin
    if(reset == 1'b0)
    begin
      oe_ram_cs_delayed <= 1'b0;
      if(HIGH_LATENCY != 0) oe_ram_cs_delayed_registered <= 1'b0;
      if(HIGH_LATENCY == 2) oe_ram_cs_delayed_registered1 <= 1'b0;
    end
    else
    begin
      if(HIGH_LATENCY == 0)
      begin
        oe_ram_cs_delayed <= oe_ram_cs & (!oe_ram_cs_delayed | BUS_PIPELINED);
      end
      else if(HIGH_LATENCY == 1)
      begin
        oe_ram_cs_delayed_registered <= oe_ram_cs & ((!oe_ram_cs_delayed_registered & !oe_ram_cs_delayed) | BUS_PIPELINED);
        oe_ram_cs_delayed <= oe_ram_cs_delayed_registered;
      end
      else
      begin
        oe_ram_cs_delayed_registered1 <= oe_ram_cs & ((!oe_ram_cs_delayed_registered1 & !oe_ram_cs_delayed_registered & !oe_ram_cs_delayed) | BUS_PIPELINED);
        oe_ram_cs_delayed_registered <= oe_ram_cs_delayed_registered1;
        oe_ram_cs_delayed <= oe_ram_cs_delayed_registered;
      end
    end
  end
  
  always @(posedge clock)
  begin
    if(HIGH_LATENCY == 0)
      delayed_byte_offset <= byte_offset;
    else if(HIGH_LATENCY == 1)
    begin
      delayed_byte_offset_registered <= byte_offset;
      delayed_byte_offset <= delayed_byte_offset_registered;
    end
    else
    begin
      delayed_byte_offset_registered1 <= byte_offset;
      delayed_byte_offset_registered <= delayed_byte_offset_registered1;
      delayed_byte_offset <= delayed_byte_offset_registered;
    end
  end
  
  always @(posedge clock )
  begin
    if(reset == 1'b0)
      we_ram_cs_delayed <= 1'b0;
    else
      we_ram_cs_delayed <= we_ram_cs & !we_ram_cs_delayed;
  end
  
  generate
    if(PRIVATE_MEMORY==1)
      assign Sout_Rdata_ram =Sin_Rdata_ram;
    else if (BITSIZE_Sout_Rdata_ram <= 2*BRAM_BITSIZE)
      assign Sout_Rdata_ram = oe_ram_cs_delayed ? out1_shifted[BITSIZE_Sout_Rdata_ram-1:0] : Sin_Rdata_ram;
    else
      assign Sout_Rdata_ram = oe_ram_cs_delayed ? {{BITSIZE_Sout_Rdata_ram-2*BRAM_BITSIZE{1'b0}}, out1_shifted} : Sin_Rdata_ram;
  endgenerate
  
  generate
    if(PRIVATE_MEMORY==1)
      assign Sout_DataRdy = Sin_DataRdy;
    else
      assign Sout_DataRdy = oe_ram_cs_delayed | Sin_DataRdy | we_ram_cs_delayed;
  endgenerate
  
  assign bram_write = sel_STORE || proxy_sel_STORE || we_ram_cs;
  
  // Add assertion here
  // psl default clock = (posedge clock);
  // psl ERROR_S_data_ram_size: assert never {S_data_ram_size>2*BRAM_BITSIZE && (we_ram_cs || oe_ram_cs)};
  // psl ERROR_memory_addr: assert never {memory_addr_a>=n_mem_elements && (we_ram_cs || oe_ram_cs || sel_STORE || sel_LOAD || proxy_sel_STORE || proxy_sel_LOAD)};
  // psl ERROR_relative_addr: assert never {relative_addr+(S_data_ram_size/8) >n_bytes && (we_ram_cs || oe_ram_cs)};
  // psl ERROR_unaligned_access: assert never {byte_offset+S_data_ram_size[BITSIZE_S_data_ram_size-1:3] > BRAM_BITSIZE/4 && (we_ram_cs || oe_ram_cs)};
  // psl ERROR_oe_ram_cs_we_ram_cs: assert never {(we_ram_cs & oe_ram_cs) != 0};
  // psl ERROR_LOAD_S_oe_ram: assert never {sel_LOAD && oe_ram_cs};
  // psl ERROR_proxy_LOAD_S_oe_ram: assert never {proxy_sel_LOAD && oe_ram_cs};
  // psl ERROR_STORE_S_we_ram: assert never {sel_STORE && we_ram_cs};
  // psl ERROR_proxy_STORE_S_we_ram: assert never {proxy_sel_STORE && we_ram_cs};
  // psl ERROR_LOAD_we_ram_cs: assert never {sel_LOAD && we_ram_cs};
  // psl ERROR_proxy_LOAD_we_ram_cs: assert never {proxy_sel_LOAD && we_ram_cs};
  // psl ERROR_STORE_oe_ram_cs: assert never {sel_STORE && oe_ram_cs};
  // psl ERROR_proxy_STORE_oe_ram_cs: assert never {proxy_sel_STORE && oe_ram_cs};
  // psl ERROR_Sin_DataRdy_oe_ram_cs_delayed: assert never {Sin_DataRdy && oe_ram_cs_delayed};
  // psl ERROR_in3_size: assert never {in3>2*BRAM_BITSIZE && (sel_STORE || sel_LOAD)};
  // psl ERROR_proxy_in3_size: assert never {proxy_in3>2*BRAM_BITSIZE && (proxy_sel_STORE || proxy_sel_LOAD)};
  // psl ERROR_requested_size: assert never {BITSIZE_out1<in3 && (sel_LOAD)};
  // psl ERROR_proxy_requested_size: assert never {BITSIZE_proxy_out1<proxy_in3 && (proxy_sel_LOAD)};
  // psl ERROR_STORE_LOAD: assert never {sel_STORE && sel_LOAD};
  // psl ERROR_proxy_STORE_proxy_LOAD: assert never {proxy_sel_STORE && proxy_sel_LOAD};
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2016-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module BRAM_MEMORY_CORE_SMALL(clock,
  bram_write0,
  bram_write1,
  memory_addr_a,
  memory_addr_b,
  din_value_aggregated,
  be,
  dout_a,
  dout_b);
  parameter BITSIZE_dout_a=1,
    BITSIZE_dout_b=1,
    BITSIZE_memory_addr_a=1,
    BITSIZE_memory_addr_b=1,
    BITSIZE_din_value_aggregated=1,
    BITSIZE_be=1,
    MEMORY_INIT_file="array.mem",
    n_byte_on_databus=4,
    n_mem_elements=4,
    n_bytes=4,
    HIGH_LATENCY=0;
  // IN
  input clock;
  input bram_write0;
  input bram_write1;
  input [BITSIZE_memory_addr_a-1:0] memory_addr_a;
  input [BITSIZE_memory_addr_b-1:0] memory_addr_b;
  input [BITSIZE_din_value_aggregated-1:0] din_value_aggregated;
  input [BITSIZE_be-1:0] be;
  // OUT
  output [BITSIZE_dout_a-1:0] dout_a;
  output [BITSIZE_dout_b-1:0] dout_b;
  
  reg bram_write01 =0;
  reg bram_write11 =0;
  reg [BITSIZE_memory_addr_a-1:0] memory_addr_a1 =0;
  reg [BITSIZE_memory_addr_b-1:0] memory_addr_b1 =0;
  reg [BITSIZE_be-1:0] be1 =0;
  reg [BITSIZE_din_value_aggregated-1:0] din_value_aggregated1 =0;
  reg [(n_byte_on_databus)*8-1:0] dout_a_tmp =0;
  reg [(n_byte_on_databus)*8-1:0] dout_b_tmp =0;
  reg [(n_byte_on_databus)*8-1:0] dout_a_registered =0;
  reg [(n_byte_on_databus)*8-1:0] dout_b_registered =0;
  reg [(n_byte_on_databus)*8-1:0] memory [0:n_mem_elements-1]/* synthesis syn_ramstyle = "no_rw_check" */ ;
  
  generate
    if(HIGH_LATENCY==2)
    begin
      always @ (posedge clock)
      begin
         memory_addr_a1 <= memory_addr_a;
         memory_addr_b1 <= memory_addr_b;
         bram_write01 <= bram_write0;
         bram_write11 <= bram_write1;
         be1 <= be;
         din_value_aggregated1 <= din_value_aggregated;
      end
    end
  endgenerate
  
  assign dout_a = dout_a_tmp;
  assign dout_b = dout_b_tmp;
  initial
  begin
    $readmemb(MEMORY_INIT_file, memory, 0, n_mem_elements-1);
  end
  
  always @(posedge clock)
  begin
    if(HIGH_LATENCY == 0||HIGH_LATENCY == 1)
    begin
      if (bram_write0)
      begin : L11_write
        integer i11;
        for (i11=0; i11<n_byte_on_databus; i11=i11+1)
        begin
          if(be[i11])
            memory[memory_addr_a][i11*8+:8] <= din_value_aggregated[i11*8+:8];
        end
      end
    end
    else
    begin
      if (bram_write01)
      begin : L11_write1
        integer i11;
        for (i11=0; i11<n_byte_on_databus; i11=i11+1)
        begin
          if(be1[i11])
            memory[memory_addr_a1][i11*8+:8] <= din_value_aggregated1[i11*8+:8];
        end
      end
    end
    if(HIGH_LATENCY == 0)
      dout_a_tmp <= memory[memory_addr_a];
    else if(HIGH_LATENCY == 1)
    begin
      dout_a_registered <= memory[memory_addr_a];
      dout_a_tmp <= dout_a_registered;
    end
    else
    begin
      dout_a_registered <= memory[memory_addr_a1];
      dout_a_tmp <= dout_a_registered;
    end
    if(HIGH_LATENCY == 0||HIGH_LATENCY == 1)
    begin
      if (bram_write1)
      begin : L22_write
        integer i22;
        for (i22=0; i22<n_byte_on_databus; i22=i22+1)
        begin
          if(be[i22+n_byte_on_databus])
            memory[memory_addr_b][i22*8+:8] <= din_value_aggregated[(i22+n_byte_on_databus)*8+:8];
        end
      end
    end
    else
    begin
      if (bram_write11)
      begin : L22_write1
        integer i22;
        for (i22=0; i22<n_byte_on_databus; i22=i22+1)
        begin
          if(be1[i22+n_byte_on_databus])
            memory[memory_addr_b1][i22*8+:8] <= din_value_aggregated1[(i22+n_byte_on_databus)*8+:8];
        end
      end
    end
    if(HIGH_LATENCY == 0)
      dout_b_tmp <= memory[memory_addr_b];
    else if(HIGH_LATENCY == 1)
    begin
      dout_b_registered <= memory[memory_addr_b];
      dout_b_tmp <= dout_b_registered;
    end
    else
    begin
      dout_b_registered <= memory[memory_addr_b1];
      dout_b_tmp <= dout_b_registered;
    end
  end

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2016-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module TRUE_DUAL_PORT_BYTE_ENABLING_RAM(clock,
  bram_write0,
  bram_write1,
  memory_addr_a,
  memory_addr_b,
  din_value_aggregated,
  be,
  dout_a,
  dout_b);
  parameter BITSIZE_dout_a=1,
    BITSIZE_dout_b=1,
    BITSIZE_memory_addr_a=1,
    BITSIZE_memory_addr_b=1,
    BITSIZE_din_value_aggregated=1,
    BITSIZE_be=1,
    MEMORY_INIT_file="array.mem",
    BRAM_BITSIZE=32,
    n_byte_on_databus=4,
    n_mem_elements=4,
    HIGH_LATENCY=0;
  // IN
  input clock;
  input bram_write0;
  input bram_write1;
  input [BITSIZE_memory_addr_a-1:0] memory_addr_a;
  input [BITSIZE_memory_addr_b-1:0] memory_addr_b;
  input [BITSIZE_din_value_aggregated-1:0] din_value_aggregated;
  input [BITSIZE_be-1:0] be;
  // OUT
  output [BITSIZE_dout_a-1:0] dout_a;
  output [BITSIZE_dout_b-1:0] dout_b;
  
  wire [n_byte_on_databus-1:0] we_a;
  wire [n_byte_on_databus-1:0] we_b;
  reg [n_byte_on_databus-1:0] we_a1 =0;
  reg [n_byte_on_databus-1:0] we_b1 =0;
  reg [BITSIZE_din_value_aggregated-1:0] din_value_aggregated1 =0;
  
  reg [BITSIZE_dout_a-1:0] dout_a =0;
  reg [BITSIZE_dout_a-1:0] dout_a_registered =0;
  reg [BITSIZE_dout_b-1:0] dout_b =0;
  reg [BITSIZE_dout_b-1:0] dout_b_registered =0;
  reg [BITSIZE_memory_addr_a-1:0] memory_addr_a1 =0;
  reg [BITSIZE_memory_addr_b-1:0] memory_addr_b1 =0;
  reg [BRAM_BITSIZE-1:0] memory [0:n_mem_elements-1] /* synthesis syn_ramstyle = "no_rw_check" */;
  
  initial
  begin
    $readmemb(MEMORY_INIT_file, memory, 0, n_mem_elements-1);
  end
  
  always @(posedge clock)
  begin
    if(HIGH_LATENCY==0)
    begin
      dout_a <= memory[memory_addr_a];
    end
    else if(HIGH_LATENCY==1)
    begin
      dout_a_registered <= memory[memory_addr_a];
      dout_a <= dout_a_registered;
    end
    else
    begin
      memory_addr_a1 <= memory_addr_a;
      we_a1 <= we_a;
      din_value_aggregated1 <= din_value_aggregated;
      dout_a_registered <= memory[memory_addr_a1];
      dout_a <= dout_a_registered;
    end
  end
  
  generate
  genvar i11;
    for (i11=0; i11<n_byte_on_databus; i11=i11+1)
    begin : L11_write_a
      always @(posedge clock)
      begin
        if(HIGH_LATENCY==0||HIGH_LATENCY==1)
        begin
          if(we_a[i11])
            memory[memory_addr_a][(i11+1)*8-1:i11*8] <= din_value_aggregated[(i11+1)*8-1:i11*8];
        end
        else
        begin
          if(we_a1[i11])
            memory[memory_addr_a1][(i11+1)*8-1:i11*8] <= din_value_aggregated1[(i11+1)*8-1:i11*8];
        end
      end
    end
  endgenerate
  
    always @(posedge clock)
    begin
      if(HIGH_LATENCY==0)
      begin
        dout_b <= memory[memory_addr_b];
      end
      else if(HIGH_LATENCY==1)
      begin
        dout_b_registered <= memory[memory_addr_b];
        dout_b <= dout_b_registered;
      end
      else
      begin
        memory_addr_b1 <= memory_addr_b;
        we_b1 <= we_b;
        dout_b_registered <= memory[memory_addr_b1];
        dout_b <= dout_b_registered;
      end
    end
    for (i11=0; i11<n_byte_on_databus; i11=i11+1)
    begin : L11_write_b
      always @(posedge clock)
      begin
        if(HIGH_LATENCY==0||HIGH_LATENCY==1)
        begin
          if(we_b[i11])
            memory[memory_addr_b][(i11+1)*8-1:i11*8] <= din_value_aggregated[(i11+1+n_byte_on_databus)*8-1:(i11+n_byte_on_databus)*8];
        end
        else
        begin
          if(we_b1[i11])
            memory[memory_addr_b1][(i11+1)*8-1:i11*8] <= din_value_aggregated1[(i11+1+n_byte_on_databus)*8-1:(i11+n_byte_on_databus)*8];
        end
      end
    end
  
  generate
  genvar i2_a;
    for (i2_a=0; i2_a<n_byte_on_databus; i2_a=i2_a+1)
    begin  : write_enable_a
      assign we_a[i2_a] = (bram_write0) && be[i2_a];
    end
  endgenerate
  
  generate
  genvar i2_b;
    for (i2_b=0; i2_b<n_byte_on_databus; i2_b=i2_b+1)
    begin  : write_enable_b
      assign we_b[i2_b] = (bram_write1) && be[i2_b+n_byte_on_databus];
    end
  endgenerate
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2016-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module BRAM_MEMORY_CORE(clock,
  bram_write,
  memory_addr_a,
  memory_addr_b,
  din_value_aggregated,
  be,
  dout_a,
  dout_b);
  parameter BITSIZE_dout_a=1,
    BITSIZE_dout_b=1,
    BITSIZE_memory_addr_a=1,
    BITSIZE_memory_addr_b=1,
    BITSIZE_din_value_aggregated=1,
    BITSIZE_be=1,
    MEMORY_INIT_file="array.mem",
    BRAM_BITSIZE=32,
    nbit_read_addr=32,
    n_byte_on_databus=4,
    n_mem_elements=4,
    n_bytes=4,
    HIGH_LATENCY=0;
  // IN
  input clock;
  input bram_write;
  input [BITSIZE_memory_addr_a-1:0] memory_addr_a;
  input [BITSIZE_memory_addr_b-1:0] memory_addr_b;
  input [BITSIZE_din_value_aggregated-1:0] din_value_aggregated;
  input [BITSIZE_be-1:0] be;
  // OUT
  output [BITSIZE_dout_a-1:0] dout_a;
  output [BITSIZE_dout_b-1:0] dout_b;
  
  generate
  if(n_mem_elements == 1)
  begin
    BRAM_MEMORY_CORE_SMALL #(.BITSIZE_memory_addr_a(BITSIZE_memory_addr_a), .BITSIZE_memory_addr_b(BITSIZE_memory_addr_b), .BITSIZE_din_value_aggregated(BITSIZE_din_value_aggregated), .BITSIZE_be(BITSIZE_be), .BITSIZE_dout_a(BITSIZE_dout_a), .BITSIZE_dout_b(BITSIZE_dout_b), .MEMORY_INIT_file(MEMORY_INIT_file), .n_byte_on_databus(n_byte_on_databus), .n_mem_elements(n_mem_elements), .n_bytes(n_bytes), .HIGH_LATENCY(HIGH_LATENCY)) BRAM_MEMORY_instance_small (.clock(clock), .bram_write0(bram_write), .bram_write1(bram_write), .memory_addr_a(memory_addr_a), .memory_addr_b(memory_addr_b), .din_value_aggregated(din_value_aggregated), .be(be), .dout_a(dout_a), .dout_b(dout_b));
  end
  else
  begin
    TRUE_DUAL_PORT_BYTE_ENABLING_RAM #(.BITSIZE_memory_addr_a(BITSIZE_memory_addr_a), .BITSIZE_memory_addr_b(BITSIZE_memory_addr_b), .BITSIZE_din_value_aggregated(BITSIZE_din_value_aggregated), .BITSIZE_be(BITSIZE_be), .BITSIZE_dout_a(BITSIZE_dout_a), .BITSIZE_dout_b(BITSIZE_dout_b), .MEMORY_INIT_file(MEMORY_INIT_file), .BRAM_BITSIZE(BRAM_BITSIZE), .n_byte_on_databus(n_byte_on_databus), .n_mem_elements(n_mem_elements), .HIGH_LATENCY(HIGH_LATENCY)) TRUE_DUAL_PORT_BYTE_ENABLING_RAM_instance (.clock(clock), .bram_write0(bram_write), .bram_write1(bram_write), .memory_addr_a(memory_addr_a), .memory_addr_b(memory_addr_b), .din_value_aggregated(din_value_aggregated), .be(be), .dout_a(dout_a), .dout_b(dout_b));
  end
  endgenerate

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ARRAY_1D_STD_BRAM_SP(clock,
  reset,
  in1,
  in2,
  in3,
  sel_LOAD,
  sel_STORE,
  S_oe_ram,
  S_we_ram,
  S_addr_ram,
  S_Wdata_ram,
  Sin_Rdata_ram,
  S_data_ram_size,
  Sin_DataRdy,
  out1,
  Sout_Rdata_ram,
  Sout_DataRdy,
  proxy_in1,
  proxy_in2,
  proxy_in3,
  proxy_sel_LOAD,
  proxy_sel_STORE,
  proxy_out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_in3=1,
    BITSIZE_out1=1,
    BITSIZE_S_addr_ram=1,
    BITSIZE_S_Wdata_ram=8,
    BITSIZE_Sin_Rdata_ram=8,
    BITSIZE_Sout_Rdata_ram=8,
    BITSIZE_S_data_ram_size=1,
    MEMORY_INIT_file="array.mem",
    n_elements=1,
    data_size=32,
    address_space_begin=0,
    address_space_rangesize=4,
    BUS_PIPELINED=1,
    BRAM_BITSIZE=32,
    PRIVATE_MEMORY=0,
    USE_SPARSE_MEMORY=1,
    HIGH_LATENCY=0,
    BITSIZE_proxy_in1=1,
    BITSIZE_proxy_in2=1,
    BITSIZE_proxy_in3=1,
    BITSIZE_proxy_out1=1;
  // IN
  input clock;
  input reset;
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  input [BITSIZE_in3-1:0] in3;
  input sel_LOAD;
  input sel_STORE;
  input S_oe_ram;
  input S_we_ram;
  input [BITSIZE_S_addr_ram-1:0] S_addr_ram;
  input [BITSIZE_S_Wdata_ram-1:0] S_Wdata_ram;
  input [BITSIZE_Sin_Rdata_ram-1:0] Sin_Rdata_ram;
  input [BITSIZE_S_data_ram_size-1:0] S_data_ram_size;
  input Sin_DataRdy;
  input [BITSIZE_proxy_in1-1:0] proxy_in1;
  input [BITSIZE_proxy_in2-1:0] proxy_in2;
  input [BITSIZE_proxy_in3-1:0] proxy_in3;
  input proxy_sel_LOAD;
  input proxy_sel_STORE;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  output [BITSIZE_Sout_Rdata_ram-1:0] Sout_Rdata_ram;
  output Sout_DataRdy;
  output [BITSIZE_proxy_out1-1:0] proxy_out1;
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
  parameter n_bytes = (n_elements*data_size)/8 == 0 ? 1 : (n_elements*data_size)/8;
  parameter n_byte_on_databus = BRAM_BITSIZE/8;
  parameter n_mem_elements = n_bytes/(n_byte_on_databus) + (n_bytes%(n_byte_on_databus) == 0 ? 0 : 1);
  `ifdef _SIM_HAVE_CLOG2
    parameter nbit_read_addr = n_mem_elements == 1 ? 1 : $clog2(n_mem_elements);
  `else
    parameter nbit_read_addr = n_mem_elements == 1 ? 1 : log2(n_mem_elements);
  `endif
    
  wire [nbit_read_addr-1:0] memory_addr_a;
  wire [nbit_read_addr-1:0] memory_addr_b;
  wire [n_byte_on_databus*2-1:0] be;
  
  wire [2*BRAM_BITSIZE-1:0] din_value_aggregated;
  wire bram_write;
  wire [BRAM_BITSIZE-1:0] dout_a;
  wire [BRAM_BITSIZE-1:0] dout_b;
  
  BRAM_MEMORY_CORE #(.BITSIZE_memory_addr_a(nbit_read_addr), .BITSIZE_memory_addr_b(nbit_read_addr), .BITSIZE_din_value_aggregated(2*BRAM_BITSIZE), .BITSIZE_be(n_byte_on_databus*2), .BITSIZE_dout_a(BRAM_BITSIZE), .BITSIZE_dout_b(BRAM_BITSIZE), .MEMORY_INIT_file(MEMORY_INIT_file), .BRAM_BITSIZE(BRAM_BITSIZE), .nbit_read_addr(nbit_read_addr), .n_byte_on_databus(n_byte_on_databus), .n_mem_elements(n_mem_elements), .n_bytes(n_bytes), .HIGH_LATENCY(HIGH_LATENCY)) BRAM_MEMORY_instance (.clock(clock), .bram_write(bram_write), .memory_addr_a(memory_addr_a), .memory_addr_b(memory_addr_b), .din_value_aggregated(din_value_aggregated), .be(be), .dout_a(dout_a), .dout_b(dout_b));
  
  ADDRESS_DECODING_LOGIC #(.BITSIZE_memory_addr_a(nbit_read_addr), .BITSIZE_memory_addr_b(nbit_read_addr), .BITSIZE_din_value_aggregated(2*BRAM_BITSIZE), .BITSIZE_be(n_byte_on_databus*2), .BITSIZE_dout_a(BRAM_BITSIZE), .BITSIZE_dout_b(BRAM_BITSIZE), .BITSIZE_in1(BITSIZE_in1), .BITSIZE_in2(BITSIZE_in2), .BITSIZE_in3(BITSIZE_in3), .BITSIZE_out1(BITSIZE_out1), .BITSIZE_S_addr_ram(BITSIZE_S_addr_ram), .BITSIZE_S_Wdata_ram(BITSIZE_S_Wdata_ram), .BITSIZE_Sin_Rdata_ram(BITSIZE_Sin_Rdata_ram), .BITSIZE_Sout_Rdata_ram(BITSIZE_Sout_Rdata_ram), .BITSIZE_S_data_ram_size(BITSIZE_S_data_ram_size), .address_space_begin(address_space_begin), .address_space_rangesize(address_space_rangesize), .BUS_PIPELINED(BUS_PIPELINED), .BRAM_BITSIZE(BRAM_BITSIZE), .PRIVATE_MEMORY(PRIVATE_MEMORY), .USE_SPARSE_MEMORY(USE_SPARSE_MEMORY), .BITSIZE_proxy_in1(BITSIZE_proxy_in1), .BITSIZE_proxy_in2(BITSIZE_proxy_in2), .BITSIZE_proxy_in3(BITSIZE_proxy_in3), .BITSIZE_proxy_out1(BITSIZE_proxy_out1), .nbit_read_addr(nbit_read_addr), .n_byte_on_databus(n_byte_on_databus), .n_mem_elements(n_mem_elements), .n_bytes(n_bytes), .HIGH_LATENCY(HIGH_LATENCY)) ADDRESS_DECODING_LOGIC_instance (.out1(out1), .Sout_Rdata_ram(Sout_Rdata_ram), .Sout_DataRdy(Sout_DataRdy), .proxy_out1(proxy_out1), .clock(clock), .reset(reset), .in1(in1), .in2(in2), .in3(in3), .sel_LOAD(sel_LOAD), .sel_STORE(sel_STORE), .S_oe_ram(S_oe_ram), .S_we_ram(S_we_ram), .S_addr_ram(S_addr_ram), .S_Wdata_ram(S_Wdata_ram), .Sin_Rdata_ram(Sin_Rdata_ram), .S_data_ram_size(S_data_ram_size), .Sin_DataRdy(Sin_DataRdy), .proxy_in1(proxy_in1), .proxy_in2(proxy_in2), .proxy_in3(proxy_in3), .proxy_sel_LOAD(proxy_sel_LOAD), .proxy_sel_STORE(proxy_sel_STORE), .bram_write(bram_write), .memory_addr_a(memory_addr_a), .memory_addr_b(memory_addr_b), .din_value_aggregated(din_value_aggregated), .be(be), .dout_a(dout_a), .dout_b(dout_b));
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ARRAY_1D_STD_BRAM(clock,
  reset,
  in1,
  in2,
  in3,
  in4,
  sel_LOAD,
  sel_STORE,
  S_oe_ram,
  S_we_ram,
  S_addr_ram,
  S_Wdata_ram,
  Sin_Rdata_ram,
  S_data_ram_size,
  Sin_DataRdy,
  out1,
  Sout_Rdata_ram,
  Sout_DataRdy,
  proxy_in1,
  proxy_in2,
  proxy_in3,
  proxy_sel_LOAD,
  proxy_sel_STORE,
  proxy_out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_in3=1,
    BITSIZE_out1=1,
    BITSIZE_S_addr_ram=1,
    BITSIZE_S_Wdata_ram=8,
    BITSIZE_Sin_Rdata_ram=8,
    BITSIZE_Sout_Rdata_ram=8,
    BITSIZE_S_data_ram_size=1,
    MEMORY_INIT_file="array.mem",
    n_elements=1,
    data_size=32,
    address_space_begin=0,
    address_space_rangesize=4,
    BUS_PIPELINED=1,
    BRAM_BITSIZE=32,
    PRIVATE_MEMORY=0,
    USE_SPARSE_MEMORY=1,
    BITSIZE_proxy_in1=1,
    BITSIZE_proxy_in2=1,
    BITSIZE_proxy_in3=1,
    BITSIZE_proxy_out1=1;
  // IN
  input clock;
  input reset;
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  input [BITSIZE_in3-1:0] in3;
  input in4;
  input sel_LOAD;
  input sel_STORE;
  input S_oe_ram;
  input S_we_ram;
  input [BITSIZE_S_addr_ram-1:0] S_addr_ram;
  input [BITSIZE_S_Wdata_ram-1:0] S_Wdata_ram;
  input [BITSIZE_Sin_Rdata_ram-1:0] Sin_Rdata_ram;
  input [BITSIZE_S_data_ram_size-1:0] S_data_ram_size;
  input Sin_DataRdy;
  input [BITSIZE_proxy_in1-1:0] proxy_in1;
  input [BITSIZE_proxy_in2-1:0] proxy_in2;
  input [BITSIZE_proxy_in3-1:0] proxy_in3;
  input proxy_sel_LOAD;
  input proxy_sel_STORE;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  output [BITSIZE_Sout_Rdata_ram-1:0] Sout_Rdata_ram;
  output Sout_DataRdy;
  output [BITSIZE_proxy_out1-1:0] proxy_out1;
  ARRAY_1D_STD_BRAM_SP #(.BITSIZE_in1(BITSIZE_in1), .BITSIZE_in2(BITSIZE_in2), .BITSIZE_in3(BITSIZE_in3), .BITSIZE_out1(BITSIZE_out1), .BITSIZE_S_addr_ram(BITSIZE_S_addr_ram), .BITSIZE_S_Wdata_ram(BITSIZE_S_Wdata_ram), .BITSIZE_Sin_Rdata_ram(BITSIZE_Sin_Rdata_ram), .BITSIZE_Sout_Rdata_ram(BITSIZE_Sout_Rdata_ram), .BITSIZE_S_data_ram_size(BITSIZE_S_data_ram_size), .MEMORY_INIT_file(MEMORY_INIT_file), .n_elements(n_elements), .data_size(data_size), .address_space_begin(address_space_begin), .address_space_rangesize(address_space_rangesize), .BUS_PIPELINED(BUS_PIPELINED), .BRAM_BITSIZE(BRAM_BITSIZE), .PRIVATE_MEMORY(PRIVATE_MEMORY), .USE_SPARSE_MEMORY(USE_SPARSE_MEMORY), .BITSIZE_proxy_in1(BITSIZE_proxy_in1), .BITSIZE_proxy_in2(BITSIZE_proxy_in2), .BITSIZE_proxy_in3(BITSIZE_proxy_in3), .BITSIZE_proxy_out1(BITSIZE_proxy_out1), .HIGH_LATENCY(0)) ARRAY_1D_STD_BRAM_instance (.out1(out1), .Sout_Rdata_ram(Sout_Rdata_ram), .Sout_DataRdy(Sout_DataRdy), .proxy_out1(proxy_out1), .clock(clock), .reset(reset), .in1(in1), .in2(in2), .in3(in3), .sel_LOAD(sel_LOAD & in4), .sel_STORE(sel_STORE & in4), .S_oe_ram(S_oe_ram), .S_we_ram(S_we_ram), .S_addr_ram(S_addr_ram), .S_Wdata_ram(S_Wdata_ram), .Sin_Rdata_ram(Sin_Rdata_ram), .S_data_ram_size(S_data_ram_size), .Sin_DataRdy(Sin_DataRdy), .proxy_in1(proxy_in1), .proxy_in2(proxy_in2), .proxy_in3(proxy_in3), .proxy_sel_LOAD(proxy_sel_LOAD), .proxy_sel_STORE(proxy_sel_STORE));
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
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
// Copyright (C) 2016-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_bit_ior_concat_expr_FU(in1,
  in2,
  in3,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_in3=1,
    BITSIZE_out1=1,
    OFFSET_PARAMETER=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  input [BITSIZE_in3-1:0] in3;
  // OUT
  output [BITSIZE_out1-1:0] out1;
  parameter nbit_out = BITSIZE_out1 > OFFSET_PARAMETER ? BITSIZE_out1 : 1+OFFSET_PARAMETER;
  wire [nbit_out-1:0] tmp_in1;
  wire [OFFSET_PARAMETER-1:0] tmp_in2;
  generate
    if(BITSIZE_in1 >= nbit_out)
      assign tmp_in1=in1[nbit_out-1:0];
    else
      assign tmp_in1={{(nbit_out-BITSIZE_in1){1'b0}},in1};
  endgenerate
  generate
    if(BITSIZE_in2 >= OFFSET_PARAMETER)
      assign tmp_in2=in2[OFFSET_PARAMETER-1:0];
    else
      assign tmp_in2={{(OFFSET_PARAMETER-BITSIZE_in2){1'b0}},in2};
  endgenerate
  assign out1 = {tmp_in1[nbit_out-1:OFFSET_PARAMETER] , tmp_in2};
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
module ui_bit_xor_expr_FU(in1,
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
  assign out1 = in1 ^ in2;
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2023 Politecnico di Milano
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
// Copyright (C) 2021-2023 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_fshl_expr_FU(in1,
  in2,
  in3,
  out1);
  parameter BITSIZE_in1=1,
    BITSIZE_in2=1,
    BITSIZE_in3=1,
    BITSIZE_out1=1,
    PRECISION=1;
  // IN
  input [BITSIZE_in1-1:0] in1;
  input [BITSIZE_in2-1:0] in2;
  input [BITSIZE_in3-1:0] in3;
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
    parameter arg_bitsize = $clog2(PRECISION);
  `else
    parameter arg_bitsize = log2(PRECISION);
  `endif
  parameter marg_bitsize = arg_bitsize < BITSIZE_in3 ? arg_bitsize : BITSIZE_in3;
  assign out1 = (in1 << (in3[marg_bitsize-1:0]))|(in2 >> (PRECISION-(in3[marg_bitsize-1:0])));
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
module ui_minus_expr_FU(in1,
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
  assign out1 = in1 - in2;
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
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ui_ternary_plus_expr_FU(in1,
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
  assign out1 = in1 + in2 + in3;
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

// Datapath RTL description for md5_speed
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module datapath_md5_speed(clock,
  reset,
  in_port_Pd458,
  in_port_Pd459,
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
  fuselector_ARRAY_1D_STD_BRAM_0_i0_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_0_i0_STORE,
  fuselector_ARRAY_1D_STD_BRAM_1_i0_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_1_i0_STORE,
  fuselector_BMEMORY_CTRL_24_i0_LOAD,
  fuselector_BMEMORY_CTRL_24_i0_STORE,
  selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_0,
  selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_1,
  selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_2,
  selector_MUX_10_BMEMORY_CTRL_24_i0_1_1_0,
  selector_MUX_29_reg_0_0_0_0,
  selector_MUX_30_reg_1_0_0_0,
  selector_MUX_41_reg_2_0_0_0,
  selector_MUX_42_reg_3_0_0_0,
  selector_MUX_43_reg_4_0_0_0,
  selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_0,
  selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_1,
  selector_MUX_9_BMEMORY_CTRL_24_i0_0_1_0,
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
  wrenable_reg_3,
  wrenable_reg_4,
  wrenable_reg_5,
  wrenable_reg_6,
  wrenable_reg_7,
  wrenable_reg_8,
  wrenable_reg_9,
  OUT_CONDITION_md5_speed_423516_424205);
  parameter MEM_var_423634_423516=1024,
    MEM_var_424139_423516=1024;
  // IN
  input clock;
  input reset;
  input [31:0] in_port_Pd458;
  input [31:0] in_port_Pd459;
  input [31:0] M_Rdata_ram;
  input M_DataRdy;
  input Min_oe_ram;
  input Min_we_ram;
  input [31:0] Min_addr_ram;
  input [31:0] Min_Wdata_ram;
  input [5:0] Min_data_ram_size;
  input fuselector_ARRAY_1D_STD_BRAM_0_i0_LOAD;
  input fuselector_ARRAY_1D_STD_BRAM_0_i0_STORE;
  input fuselector_ARRAY_1D_STD_BRAM_1_i0_LOAD;
  input fuselector_ARRAY_1D_STD_BRAM_1_i0_STORE;
  input fuselector_BMEMORY_CTRL_24_i0_LOAD;
  input fuselector_BMEMORY_CTRL_24_i0_STORE;
  input selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_0;
  input selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_1;
  input selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_2;
  input selector_MUX_10_BMEMORY_CTRL_24_i0_1_1_0;
  input selector_MUX_29_reg_0_0_0_0;
  input selector_MUX_30_reg_1_0_0_0;
  input selector_MUX_41_reg_2_0_0_0;
  input selector_MUX_42_reg_3_0_0_0;
  input selector_MUX_43_reg_4_0_0_0;
  input selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_0;
  input selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_1;
  input selector_MUX_9_BMEMORY_CTRL_24_i0_0_1_0;
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
  output OUT_CONDITION_md5_speed_423516_424205;
  // Component and signal declarations
  wire [31:0] out_ARRAY_1D_STD_BRAM_0_i0_array_423634_0;
  wire [31:0] out_ARRAY_1D_STD_BRAM_1_i0_array_424139_0;
  wire [3:0] out_ASSIGN_UNSIGNED_FU_14_i0_fu_md5_speed_423516_424101;
  wire [3:0] out_ASSIGN_UNSIGNED_FU_16_i0_fu_md5_speed_423516_424113;
  wire [3:0] out_ASSIGN_UNSIGNED_FU_18_i0_fu_md5_speed_423516_424127;
  wire [31:0] out_BMEMORY_CTRL_24_i0_BMEMORY_CTRL_24_i0;
  wire [31:0] out_MUX_10_BMEMORY_CTRL_24_i0_1_0_0;
  wire [31:0] out_MUX_10_BMEMORY_CTRL_24_i0_1_0_1;
  wire [31:0] out_MUX_10_BMEMORY_CTRL_24_i0_1_0_2;
  wire [31:0] out_MUX_10_BMEMORY_CTRL_24_i0_1_1_0;
  wire [63:0] out_MUX_29_reg_0_0_0_0;
  wire [31:0] out_MUX_30_reg_1_0_0_0;
  wire [31:0] out_MUX_41_reg_2_0_0_0;
  wire [31:0] out_MUX_42_reg_3_0_0_0;
  wire [31:0] out_MUX_43_reg_4_0_0_0;
  wire [31:0] out_MUX_9_BMEMORY_CTRL_24_i0_0_0_0;
  wire [31:0] out_MUX_9_BMEMORY_CTRL_24_i0_0_0_1;
  wire [31:0] out_MUX_9_BMEMORY_CTRL_24_i0_0_1_0;
  wire [31:0] out_UUdata_converter_FU_13_i0_fu_md5_speed_423516_424072;
  wire [31:0] out_UUdata_converter_FU_15_i0_fu_md5_speed_423516_424074;
  wire [31:0] out_UUdata_converter_FU_17_i0_fu_md5_speed_423516_424078;
  wire [29:0] out_UUdata_converter_FU_19_i0_fu_md5_speed_423516_424082;
  wire [31:0] out_addr_expr_FU_4_i0_fu_md5_speed_423516_424284;
  wire [31:0] out_addr_expr_FU_6_i0_fu_md5_speed_423516_424290;
  wire out_const_0;
  wire [6:0] out_const_1;
  wire [28:0] out_const_10;
  wire [30:0] out_const_11;
  wire [31:0] out_const_12;
  wire [2:0] out_const_13;
  wire [10:0] out_const_14;
  wire [10:0] out_const_15;
  wire [1:0] out_const_16;
  wire [3:0] out_const_17;
  wire [5:0] out_const_18;
  wire [30:0] out_const_19;
  wire out_const_2;
  wire [31:0] out_const_20;
  wire [3:0] out_const_21;
  wire [7:0] out_const_22;
  wire [31:0] out_const_23;
  wire [1:0] out_const_3;
  wire [2:0] out_const_4;
  wire [3:0] out_const_5;
  wire [4:0] out_const_6;
  wire [5:0] out_const_7;
  wire [6:0] out_const_8;
  wire [27:0] out_const_9;
  wire [4:0] out_conv_out_ARRAY_1D_STD_BRAM_1_i0_array_424139_0_32_5;
  wire [63:0] out_conv_out_const_0_1_64;
  wire [31:0] out_conv_out_const_10_29_32;
  wire [31:0] out_conv_out_const_14_11_32;
  wire [31:0] out_conv_out_const_15_11_32;
  wire [31:0] out_conv_out_const_19_31_32;
  wire [5:0] out_conv_out_const_1_7_6;
  wire out_lut_expr_FU_20_i0_fu_md5_speed_423516_424431;
  wire out_lut_expr_FU_21_i0_fu_md5_speed_423516_424446;
  wire out_read_cond_FU_22_i0_fu_md5_speed_423516_424205;
  wire [63:0] out_reg_0_reg_0;
  wire [31:0] out_reg_10_reg_10;
  wire [31:0] out_reg_11_reg_11;
  wire out_reg_12_reg_12;
  wire [4:0] out_reg_13_reg_13;
  wire [31:0] out_reg_14_reg_14;
  wire [31:0] out_reg_15_reg_15;
  wire [31:0] out_reg_16_reg_16;
  wire [31:0] out_reg_17_reg_17;
  wire [31:0] out_reg_18_reg_18;
  wire [31:0] out_reg_19_reg_19;
  wire [31:0] out_reg_1_reg_1;
  wire [31:0] out_reg_2_reg_2;
  wire [31:0] out_reg_3_reg_3;
  wire [31:0] out_reg_4_reg_4;
  wire [31:0] out_reg_5_reg_5;
  wire [31:0] out_reg_6_reg_6;
  wire [31:0] out_reg_7_reg_7;
  wire [31:0] out_reg_8_reg_8;
  wire [31:0] out_reg_9_reg_9;
  wire [0:0] out_ui_bit_and_expr_FU_1_0_1_25_i0_fu_md5_speed_423516_424351;
  wire [0:0] out_ui_bit_and_expr_FU_1_0_1_25_i1_fu_md5_speed_423516_424364;
  wire [0:0] out_ui_bit_and_expr_FU_1_0_1_25_i2_fu_md5_speed_423516_424408;
  wire [31:0] out_ui_bit_and_expr_FU_32_32_32_26_i0_fu_md5_speed_423516_423601;
  wire [31:0] out_ui_bit_and_expr_FU_32_32_32_26_i1_fu_md5_speed_423516_423603;
  wire [31:0] out_ui_bit_and_expr_FU_32_32_32_26_i2_fu_md5_speed_423516_423612;
  wire [31:0] out_ui_bit_and_expr_FU_32_32_32_26_i3_fu_md5_speed_423516_423617;
  wire [3:0] out_ui_bit_and_expr_FU_8_0_8_27_i0_fu_md5_speed_423516_424098;
  wire [3:0] out_ui_bit_and_expr_FU_8_0_8_27_i1_fu_md5_speed_423516_424104;
  wire [3:0] out_ui_bit_and_expr_FU_8_0_8_27_i2_fu_md5_speed_423516_424118;
  wire [1:0] out_ui_bit_and_expr_FU_8_0_8_28_i0_fu_md5_speed_423516_424388;
  wire [31:0] out_ui_bit_ior_concat_expr_FU_29_i0_fu_md5_speed_423516_424163;
  wire [31:0] out_ui_bit_ior_concat_expr_FU_29_i1_fu_md5_speed_423516_424170;
  wire [31:0] out_ui_bit_ior_concat_expr_FU_29_i2_fu_md5_speed_423516_424317;
  wire [31:0] out_ui_bit_ior_concat_expr_FU_30_i0_fu_md5_speed_423516_424304;
  wire [31:0] out_ui_bit_ior_expr_FU_32_32_32_31_i0_fu_md5_speed_423516_423587;
  wire [31:0] out_ui_bit_ior_expr_FU_32_32_32_31_i1_fu_md5_speed_423516_423597;
  wire [31:0] out_ui_bit_ior_expr_FU_32_32_32_31_i2_fu_md5_speed_423516_423608;
  wire [31:0] out_ui_bit_xor_expr_FU_32_0_32_32_i0_fu_md5_speed_423516_423590;
  wire [31:0] out_ui_bit_xor_expr_FU_32_0_32_32_i1_fu_md5_speed_423516_423606;
  wire [31:0] out_ui_bit_xor_expr_FU_32_0_32_32_i2_fu_md5_speed_423516_423615;
  wire [31:0] out_ui_bit_xor_expr_FU_32_32_32_33_i0_fu_md5_speed_423516_423583;
  wire [31:0] out_ui_bit_xor_expr_FU_32_32_32_33_i1_fu_md5_speed_423516_423592;
  wire [31:0] out_ui_bit_xor_expr_FU_32_32_32_33_i2_fu_md5_speed_423516_423595;
  wire [29:0] out_ui_cond_expr_FU_32_32_32_32_34_i0_fu_md5_speed_423516_424437;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_34_i1_fu_md5_speed_423516_424440;
  wire [29:0] out_ui_cond_expr_FU_32_32_32_32_34_i2_fu_md5_speed_423516_424443;
  wire [29:0] out_ui_cond_expr_FU_32_32_32_32_34_i3_fu_md5_speed_423516_424449;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_34_i4_fu_md5_speed_423516_424452;
  wire [29:0] out_ui_cond_expr_FU_32_32_32_32_34_i5_fu_md5_speed_423516_424455;
  wire [29:0] out_ui_cond_expr_FU_32_32_32_32_34_i6_fu_md5_speed_423516_424457;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_34_i7_fu_md5_speed_423516_424459;
  wire [29:0] out_ui_cond_expr_FU_32_32_32_32_34_i8_fu_md5_speed_423516_424461;
  wire out_ui_eq_expr_FU_64_0_64_35_i0_fu_md5_speed_423516_424277;
  wire [31:0] out_ui_fshl_expr_FU_32_32_32_32_36_i0_fu_md5_speed_423516_423563;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_37_i0_fu_md5_speed_423516_424269;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_37_i1_fu_md5_speed_423516_424271;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_37_i2_fu_md5_speed_423516_424275;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_37_i3_fu_md5_speed_423516_424301;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_37_i4_fu_md5_speed_423516_424385;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_38_i0_fu_md5_speed_423516_424314;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_38_i1_fu_md5_speed_423516_424348;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_38_i2_fu_md5_speed_423516_424361;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_38_i3_fu_md5_speed_423516_424405;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_39_i0_fu_md5_speed_423516_424321;
  wire out_ui_lt_expr_FU_64_0_64_40_i0_fu_md5_speed_423516_424259;
  wire out_ui_lt_expr_FU_64_0_64_41_i0_fu_md5_speed_423516_424293;
  wire out_ui_lt_expr_FU_64_0_64_42_i0_fu_md5_speed_423516_424306;
  wire [31:0] out_ui_minus_expr_FU_32_32_32_43_i0_fu_md5_speed_423516_424324;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_44_i0_fu_md5_speed_423516_424162;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_45_i0_fu_md5_speed_423516_424164;
  wire [30:0] out_ui_plus_expr_FU_32_0_32_46_i0_fu_md5_speed_423516_424345;
  wire [30:0] out_ui_plus_expr_FU_32_0_32_47_i0_fu_md5_speed_423516_424358;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_48_i0_fu_md5_speed_423516_423560;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_48_i1_fu_md5_speed_423516_423567;
  wire [29:0] out_ui_plus_expr_FU_32_32_32_48_i2_fu_md5_speed_423516_424382;
  wire [30:0] out_ui_plus_expr_FU_32_32_32_48_i3_fu_md5_speed_423516_424402;
  wire [63:0] out_ui_plus_expr_FU_64_0_64_49_i0_fu_md5_speed_423516_423548;
  wire [3:0] out_ui_plus_expr_FU_8_0_8_50_i0_fu_md5_speed_423516_424107;
  wire [3:0] out_ui_plus_expr_FU_8_0_8_51_i0_fu_md5_speed_423516_424121;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_0_32_52_i0_fu_md5_speed_423516_424166;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_0_32_53_i0_fu_md5_speed_423516_424168;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_0_32_54_i0_fu_md5_speed_423516_424171;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_55_i0_fu_md5_speed_423516_423624;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_55_i1_fu_md5_speed_423516_424088;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_55_i2_fu_md5_speed_423516_424134;
  wire [30:0] out_ui_rshift_expr_FU_32_0_32_56_i0_fu_md5_speed_423516_424341;
  wire [30:0] out_ui_rshift_expr_FU_32_0_32_56_i1_fu_md5_speed_423516_424355;
  wire [30:0] out_ui_rshift_expr_FU_32_0_32_56_i2_fu_md5_speed_423516_424397;
  wire [30:0] out_ui_rshift_expr_FU_32_0_32_56_i3_fu_md5_speed_423516_424400;
  wire [29:0] out_ui_rshift_expr_FU_32_0_32_57_i0_fu_md5_speed_423516_424376;
  wire [29:0] out_ui_rshift_expr_FU_32_0_32_57_i1_fu_md5_speed_423516_424380;
  wire [31:0] out_ui_ternary_plus_expr_FU_32_32_32_32_58_i0_fu_md5_speed_423516_423571;
  wire [31:0] out_ui_view_convert_expr_FU_5_i0_fu_md5_speed_423516_424267;
  wire [31:0] out_ui_view_convert_expr_FU_7_i0_fu_md5_speed_423516_424273;
  wire [63:0] out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0;
  wire [31:0] out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1;
  wire [31:0] out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2;
  wire [31:0] out_uu_conv_conn_obj_3_UUdata_converter_FU_uu_conv_3;
  wire [31:0] out_uu_conv_conn_obj_4_UUdata_converter_FU_uu_conv_4;
  wire [31:0] out_uu_conv_conn_obj_5_UUdata_converter_FU_uu_conv_5;
  wire [31:0] out_uu_conv_conn_obj_6_UUdata_converter_FU_uu_conv_6;
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
    .BITSIZE_Mout_data_ram_size(6)) BMEMORY_CTRL_24_i0 (.out1(out_BMEMORY_CTRL_24_i0_BMEMORY_CTRL_24_i0),
    .Mout_oe_ram(sig_out_bus_mergerMout_oe_ram3_),
    .Mout_we_ram(sig_out_bus_mergerMout_we_ram4_),
    .Mout_addr_ram(sig_out_bus_mergerMout_addr_ram1_),
    .Mout_Wdata_ram(sig_out_bus_mergerMout_Wdata_ram0_),
    .Mout_data_ram_size(sig_out_bus_mergerMout_data_ram_size2_),
    .clock(clock),
    .in1(out_MUX_9_BMEMORY_CTRL_24_i0_0_1_0),
    .in2(out_MUX_10_BMEMORY_CTRL_24_i0_1_1_0),
    .in3(out_conv_out_const_1_7_6),
    .in4(out_const_2),
    .sel_LOAD(fuselector_BMEMORY_CTRL_24_i0_LOAD),
    .sel_STORE(fuselector_BMEMORY_CTRL_24_i0_STORE),
    .Min_oe_ram(Min_oe_ram),
    .Min_we_ram(Min_we_ram),
    .Min_addr_ram(Min_addr_ram),
    .M_Rdata_ram(M_Rdata_ram),
    .Min_Wdata_ram(Min_Wdata_ram),
    .Min_data_ram_size(Min_data_ram_size),
    .M_DataRdy(M_DataRdy));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_10_BMEMORY_CTRL_24_i0_1_0_0 (.out1(out_MUX_10_BMEMORY_CTRL_24_i0_1_0_0),
    .sel(selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_0),
    .in1(out_reg_7_reg_7),
    .in2(out_reg_6_reg_6));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_10_BMEMORY_CTRL_24_i0_1_0_1 (.out1(out_MUX_10_BMEMORY_CTRL_24_i0_1_0_1),
    .sel(selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_1),
    .in1(out_reg_5_reg_5),
    .in2(out_reg_11_reg_11));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_10_BMEMORY_CTRL_24_i0_1_0_2 (.out1(out_MUX_10_BMEMORY_CTRL_24_i0_1_0_2),
    .sel(selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_2),
    .in1(in_port_Pd459),
    .in2(out_MUX_10_BMEMORY_CTRL_24_i0_1_0_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_10_BMEMORY_CTRL_24_i0_1_1_0 (.out1(out_MUX_10_BMEMORY_CTRL_24_i0_1_1_0),
    .sel(selector_MUX_10_BMEMORY_CTRL_24_i0_1_1_0),
    .in1(out_MUX_10_BMEMORY_CTRL_24_i0_1_0_1),
    .in2(out_MUX_10_BMEMORY_CTRL_24_i0_1_0_2));
  MUX_GATE #(.BITSIZE_in1(64),
    .BITSIZE_in2(64),
    .BITSIZE_out1(64)) MUX_29_reg_0_0_0_0 (.out1(out_MUX_29_reg_0_0_0_0),
    .sel(selector_MUX_29_reg_0_0_0_0),
    .in1(out_ui_plus_expr_FU_64_0_64_49_i0_fu_md5_speed_423516_423548),
    .in2(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_30_reg_1_0_0_0 (.out1(out_MUX_30_reg_1_0_0_0),
    .sel(selector_MUX_30_reg_1_0_0_0),
    .in1(out_reg_2_reg_2),
    .in2(out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_41_reg_2_0_0_0 (.out1(out_MUX_41_reg_2_0_0_0),
    .sel(selector_MUX_41_reg_2_0_0_0),
    .in1(out_reg_4_reg_4),
    .in2(out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_42_reg_3_0_0_0 (.out1(out_MUX_42_reg_3_0_0_0),
    .sel(selector_MUX_42_reg_3_0_0_0),
    .in1(out_const_20),
    .in2(out_ui_plus_expr_FU_32_32_32_48_i0_fu_md5_speed_423516_423560));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_43_reg_4_0_0_0 (.out1(out_MUX_43_reg_4_0_0_0),
    .sel(selector_MUX_43_reg_4_0_0_0),
    .in1(out_reg_3_reg_3),
    .in2(out_const_12));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_9_BMEMORY_CTRL_24_i0_0_0_0 (.out1(out_MUX_9_BMEMORY_CTRL_24_i0_0_0_0),
    .sel(selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_0),
    .in1(out_uu_conv_conn_obj_3_UUdata_converter_FU_uu_conv_3),
    .in2(out_uu_conv_conn_obj_4_UUdata_converter_FU_uu_conv_4));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_9_BMEMORY_CTRL_24_i0_0_0_1 (.out1(out_MUX_9_BMEMORY_CTRL_24_i0_0_0_1),
    .sel(selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_1),
    .in1(out_uu_conv_conn_obj_5_UUdata_converter_FU_uu_conv_5),
    .in2(out_uu_conv_conn_obj_6_UUdata_converter_FU_uu_conv_6));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_9_BMEMORY_CTRL_24_i0_0_1_0 (.out1(out_MUX_9_BMEMORY_CTRL_24_i0_0_1_0),
    .sel(selector_MUX_9_BMEMORY_CTRL_24_i0_0_1_0),
    .in1(out_MUX_9_BMEMORY_CTRL_24_i0_0_0_0),
    .in2(out_MUX_9_BMEMORY_CTRL_24_i0_0_0_1));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(64)) UUdata_converter_FU_uu_conv_0 (.out1(out_uu_conv_conn_obj_0_UUdata_converter_FU_uu_conv_0),
    .in1(out_conv_out_const_0_1_64));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_1 (.out1(out_uu_conv_conn_obj_1_UUdata_converter_FU_uu_conv_1),
    .in1(out_conv_out_const_19_31_32));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_2 (.out1(out_uu_conv_conn_obj_2_UUdata_converter_FU_uu_conv_2),
    .in1(out_conv_out_const_10_29_32));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_3 (.out1(out_uu_conv_conn_obj_3_UUdata_converter_FU_uu_conv_3),
    .in1(out_reg_18_reg_18));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_4 (.out1(out_uu_conv_conn_obj_4_UUdata_converter_FU_uu_conv_4),
    .in1(out_ui_plus_expr_FU_32_0_32_44_i0_fu_md5_speed_423516_424162));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_5 (.out1(out_uu_conv_conn_obj_5_UUdata_converter_FU_uu_conv_5),
    .in1(out_reg_17_reg_17));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) UUdata_converter_FU_uu_conv_6 (.out1(out_uu_conv_conn_obj_6_UUdata_converter_FU_uu_conv_6),
    .in1(out_reg_19_reg_19));
  ARRAY_1D_STD_BRAM #(.BITSIZE_in1(8),
    .BITSIZE_in2(32),
    .BITSIZE_in3(6),
    .BITSIZE_out1(32),
    .BITSIZE_S_addr_ram(32),
    .BITSIZE_S_Wdata_ram(32),
    .BITSIZE_Sin_Rdata_ram(32),
    .BITSIZE_Sout_Rdata_ram(32),
    .BITSIZE_S_data_ram_size(6),
    .MEMORY_INIT_file("/home/lennart/.cache/rust-hls/51869a6de96a6ed5d56bdb67f9e9a9a-EKXF47u136/array_ref_423634.mem"),
    .n_elements(256),
    .data_size(8),
    .address_space_begin(MEM_var_423634_423516),
    .address_space_rangesize(1024),
    .BUS_PIPELINED(1),
    .BRAM_BITSIZE(32),
    .PRIVATE_MEMORY(1),
    .USE_SPARSE_MEMORY(1),
    .BITSIZE_proxy_in1(32),
    .BITSIZE_proxy_in2(32),
    .BITSIZE_proxy_in3(6),
    .BITSIZE_proxy_out1(32)) array_423634_0 (.out1(out_ARRAY_1D_STD_BRAM_0_i0_array_423634_0),
    .clock(clock),
    .reset(reset),
    .in1(8'b00000000),
    .in2(out_ui_pointer_plus_expr_FU_32_32_32_55_i0_fu_md5_speed_423516_423624),
    .in3(out_conv_out_const_1_7_6),
    .in4(out_const_2),
    .sel_LOAD(fuselector_ARRAY_1D_STD_BRAM_0_i0_LOAD),
    .sel_STORE(fuselector_ARRAY_1D_STD_BRAM_0_i0_STORE),
    .S_oe_ram(1'b0),
    .S_we_ram(1'b0),
    .S_addr_ram(32'b00000000000000000000000000000000),
    .S_Wdata_ram(32'b00000000000000000000000000000000),
    .Sin_Rdata_ram(32'b00000000000000000000000000000000),
    .S_data_ram_size(6'b000000),
    .Sin_DataRdy(1'b0),
    .proxy_in1(32'b00000000000000000000000000000000),
    .proxy_in2(32'b00000000000000000000000000000000),
    .proxy_in3(6'b000000),
    .proxy_sel_LOAD(1'b0),
    .proxy_sel_STORE(1'b0));
  ARRAY_1D_STD_BRAM #(.BITSIZE_in1(8),
    .BITSIZE_in2(32),
    .BITSIZE_in3(6),
    .BITSIZE_out1(32),
    .BITSIZE_S_addr_ram(32),
    .BITSIZE_S_Wdata_ram(32),
    .BITSIZE_Sin_Rdata_ram(32),
    .BITSIZE_Sout_Rdata_ram(32),
    .BITSIZE_S_data_ram_size(6),
    .MEMORY_INIT_file("/home/lennart/.cache/rust-hls/51869a6de96a6ed5d56bdb67f9e9a9a-EKXF47u136/array_ref_424139.mem"),
    .n_elements(256),
    .data_size(8),
    .address_space_begin(MEM_var_424139_423516),
    .address_space_rangesize(1024),
    .BUS_PIPELINED(1),
    .BRAM_BITSIZE(32),
    .PRIVATE_MEMORY(1),
    .USE_SPARSE_MEMORY(1),
    .BITSIZE_proxy_in1(32),
    .BITSIZE_proxy_in2(32),
    .BITSIZE_proxy_in3(6),
    .BITSIZE_proxy_out1(32)) array_424139_0 (.out1(out_ARRAY_1D_STD_BRAM_1_i0_array_424139_0),
    .clock(clock),
    .reset(reset),
    .in1(8'b00000000),
    .in2(out_ui_pointer_plus_expr_FU_32_32_32_55_i2_fu_md5_speed_423516_424134),
    .in3(out_conv_out_const_1_7_6),
    .in4(out_const_2),
    .sel_LOAD(fuselector_ARRAY_1D_STD_BRAM_1_i0_LOAD),
    .sel_STORE(fuselector_ARRAY_1D_STD_BRAM_1_i0_STORE),
    .S_oe_ram(1'b0),
    .S_we_ram(1'b0),
    .S_addr_ram(32'b00000000000000000000000000000000),
    .S_Wdata_ram(32'b00000000000000000000000000000000),
    .Sin_Rdata_ram(32'b00000000000000000000000000000000),
    .S_data_ram_size(6'b000000),
    .Sin_DataRdy(1'b0),
    .proxy_in1(32'b00000000000000000000000000000000),
    .proxy_in2(32'b00000000000000000000000000000000),
    .proxy_in3(6'b000000),
    .proxy_sel_LOAD(1'b0),
    .proxy_sel_STORE(1'b0));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b0)) const_0 (.out1(out_const_0));
  constant_value #(.BITSIZE_out1(7),
    .value(7'b0100000)) const_1 (.out1(out_const_1));
  constant_value #(.BITSIZE_out1(29),
    .value(29'b10000001100100101010001110110)) const_10 (.out1(out_const_10));
  constant_value #(.BITSIZE_out1(31),
    .value(31'b1001100010111010110111001111111)) const_11 (.out1(out_const_11));
  constant_value #(.BITSIZE_out1(32),
    .value(32'b10011000101110101101110011111110)) const_12 (.out1(out_const_12));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b101)) const_13 (.out1(out_const_13));
  constant_value #(.BITSIZE_out1(11),
    .value(MEM_var_423634_423516)) const_14 (.out1(out_const_14));
  constant_value #(.BITSIZE_out1(11),
    .value(MEM_var_424139_423516)) const_15 (.out1(out_const_15));
  constant_value #(.BITSIZE_out1(2),
    .value(2'b11)) const_16 (.out1(out_const_16));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1100)) const_17 (.out1(out_const_17));
  constant_value #(.BITSIZE_out1(6),
    .value(6'b110000)) const_18 (.out1(out_const_18));
  constant_value #(.BITSIZE_out1(31),
    .value(31'b1100111010001010010001100000001)) const_19 (.out1(out_const_19));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b1)) const_2 (.out1(out_const_2));
  constant_value #(.BITSIZE_out1(32),
    .value(32'b11101111110011011010101110001001)) const_20 (.out1(out_const_20));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1111)) const_21 (.out1(out_const_21));
  constant_value #(.BITSIZE_out1(8),
    .value(8'b11111110)) const_22 (.out1(out_const_22));
  constant_value #(.BITSIZE_out1(32),
    .value(32'b11111111111111111111111111111111)) const_23 (.out1(out_const_23));
  constant_value #(.BITSIZE_out1(2),
    .value(2'b10)) const_3 (.out1(out_const_3));
  constant_value #(.BITSIZE_out1(3),
    .value(3'b100)) const_4 (.out1(out_const_4));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1000)) const_5 (.out1(out_const_5));
  constant_value #(.BITSIZE_out1(5),
    .value(5'b10000)) const_6 (.out1(out_const_6));
  constant_value #(.BITSIZE_out1(6),
    .value(6'b100000)) const_7 (.out1(out_const_7));
  constant_value #(.BITSIZE_out1(7),
    .value(7'b1000000)) const_8 (.out1(out_const_8));
  constant_value #(.BITSIZE_out1(28),
    .value(28'b1000000110010010101000111011)) const_9 (.out1(out_const_9));
  UUdata_converter_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(5)) conv_out_ARRAY_1D_STD_BRAM_1_i0_array_424139_0_32_5 (.out1(out_conv_out_ARRAY_1D_STD_BRAM_1_i0_array_424139_0_32_5),
    .in1(out_ARRAY_1D_STD_BRAM_1_i0_array_424139_0));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(64)) conv_out_const_0_1_64 (.out1(out_conv_out_const_0_1_64),
    .in1(out_const_0));
  UUdata_converter_FU #(.BITSIZE_in1(29),
    .BITSIZE_out1(32)) conv_out_const_10_29_32 (.out1(out_conv_out_const_10_29_32),
    .in1(out_const_10));
  UUdata_converter_FU #(.BITSIZE_in1(11),
    .BITSIZE_out1(32)) conv_out_const_14_11_32 (.out1(out_conv_out_const_14_11_32),
    .in1(out_const_14));
  UUdata_converter_FU #(.BITSIZE_in1(11),
    .BITSIZE_out1(32)) conv_out_const_15_11_32 (.out1(out_conv_out_const_15_11_32),
    .in1(out_const_15));
  UUdata_converter_FU #(.BITSIZE_in1(31),
    .BITSIZE_out1(32)) conv_out_const_19_31_32 (.out1(out_conv_out_const_19_31_32),
    .in1(out_const_19));
  UUdata_converter_FU #(.BITSIZE_in1(7),
    .BITSIZE_out1(6)) conv_out_const_1_7_6 (.out1(out_conv_out_const_1_7_6),
    .in1(out_const_1));
  ui_plus_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(1),
    .BITSIZE_out1(64)) fu_md5_speed_423516_423548 (.out1(out_ui_plus_expr_FU_64_0_64_49_i0_fu_md5_speed_423516_423548),
    .in1(out_reg_0_reg_0),
    .in2(out_const_2));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423560 (.out1(out_ui_plus_expr_FU_32_32_32_48_i0_fu_md5_speed_423516_423560),
    .in1(out_reg_15_reg_15),
    .in2(out_reg_3_reg_3));
  ui_fshl_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_in3(5),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_speed_423516_423563 (.out1(out_ui_fshl_expr_FU_32_32_32_32_36_i0_fu_md5_speed_423516_423563),
    .in1(out_ui_plus_expr_FU_32_32_32_48_i1_fu_md5_speed_423516_423567),
    .in2(out_ui_plus_expr_FU_32_32_32_48_i1_fu_md5_speed_423516_423567),
    .in3(out_reg_13_reg_13));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423567 (.out1(out_ui_plus_expr_FU_32_32_32_48_i1_fu_md5_speed_423516_423567),
    .in1(out_reg_14_reg_14),
    .in2(out_BMEMORY_CTRL_24_i0_BMEMORY_CTRL_24_i0));
  ui_ternary_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423571 (.out1(out_ui_ternary_plus_expr_FU_32_32_32_32_58_i0_fu_md5_speed_423516_423571),
    .in1(out_reg_10_reg_10),
    .in2(out_reg_1_reg_1),
    .in3(out_ARRAY_1D_STD_BRAM_0_i0_array_423634_0));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423583 (.out1(out_ui_bit_xor_expr_FU_32_32_32_33_i0_fu_md5_speed_423516_423583),
    .in1(out_ui_bit_ior_expr_FU_32_32_32_31_i0_fu_md5_speed_423516_423587),
    .in2(out_reg_4_reg_4));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423587 (.out1(out_ui_bit_ior_expr_FU_32_32_32_31_i0_fu_md5_speed_423516_423587),
    .in1(out_reg_3_reg_3),
    .in2(out_ui_bit_xor_expr_FU_32_0_32_32_i0_fu_md5_speed_423516_423590));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423590 (.out1(out_ui_bit_xor_expr_FU_32_0_32_32_i0_fu_md5_speed_423516_423590),
    .in1(out_reg_2_reg_2),
    .in2(out_const_23));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423592 (.out1(out_ui_bit_xor_expr_FU_32_32_32_33_i1_fu_md5_speed_423516_423592),
    .in1(out_ui_bit_xor_expr_FU_32_32_32_33_i2_fu_md5_speed_423516_423595),
    .in2(out_reg_2_reg_2));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423595 (.out1(out_ui_bit_xor_expr_FU_32_32_32_33_i2_fu_md5_speed_423516_423595),
    .in1(out_reg_4_reg_4),
    .in2(out_reg_3_reg_3));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423597 (.out1(out_ui_bit_ior_expr_FU_32_32_32_31_i1_fu_md5_speed_423516_423597),
    .in1(out_ui_bit_and_expr_FU_32_32_32_26_i0_fu_md5_speed_423516_423601),
    .in2(out_ui_bit_and_expr_FU_32_32_32_26_i1_fu_md5_speed_423516_423603));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423601 (.out1(out_ui_bit_and_expr_FU_32_32_32_26_i0_fu_md5_speed_423516_423601),
    .in1(out_reg_2_reg_2),
    .in2(out_reg_3_reg_3));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423603 (.out1(out_ui_bit_and_expr_FU_32_32_32_26_i1_fu_md5_speed_423516_423603),
    .in1(out_reg_4_reg_4),
    .in2(out_ui_bit_xor_expr_FU_32_0_32_32_i1_fu_md5_speed_423516_423606));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423606 (.out1(out_ui_bit_xor_expr_FU_32_0_32_32_i1_fu_md5_speed_423516_423606),
    .in1(out_reg_2_reg_2),
    .in2(out_const_23));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423608 (.out1(out_ui_bit_ior_expr_FU_32_32_32_31_i2_fu_md5_speed_423516_423608),
    .in1(out_ui_bit_and_expr_FU_32_32_32_26_i2_fu_md5_speed_423516_423612),
    .in2(out_ui_bit_and_expr_FU_32_32_32_26_i3_fu_md5_speed_423516_423617));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423612 (.out1(out_ui_bit_and_expr_FU_32_32_32_26_i2_fu_md5_speed_423516_423612),
    .in1(out_reg_2_reg_2),
    .in2(out_ui_bit_xor_expr_FU_32_0_32_32_i2_fu_md5_speed_423516_423615));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423615 (.out1(out_ui_bit_xor_expr_FU_32_0_32_32_i2_fu_md5_speed_423516_423615),
    .in1(out_reg_3_reg_3),
    .in2(out_const_23));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_423617 (.out1(out_ui_bit_and_expr_FU_32_32_32_26_i3_fu_md5_speed_423516_423617),
    .in1(out_reg_4_reg_4),
    .in2(out_reg_3_reg_3));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_md5_speed_423516_423624 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_55_i0_fu_md5_speed_423516_423624),
    .in1(out_reg_8_reg_8),
    .in2(out_ui_lshift_expr_FU_32_0_32_37_i0_fu_md5_speed_423516_424269));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(32)) fu_md5_speed_423516_424072 (.out1(out_UUdata_converter_FU_13_i0_fu_md5_speed_423516_424072),
    .in1(out_reg_0_reg_0));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(32)) fu_md5_speed_423516_424074 (.out1(out_UUdata_converter_FU_15_i0_fu_md5_speed_423516_424074),
    .in1(out_reg_0_reg_0));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(32)) fu_md5_speed_423516_424078 (.out1(out_UUdata_converter_FU_17_i0_fu_md5_speed_423516_424078),
    .in1(out_reg_0_reg_0));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(30)) fu_md5_speed_423516_424082 (.out1(out_UUdata_converter_FU_19_i0_fu_md5_speed_423516_424082),
    .in1(out_reg_0_reg_0));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_md5_speed_423516_424088 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_55_i1_fu_md5_speed_423516_424088),
    .in1(in_port_Pd458),
    .in2(out_ui_lshift_expr_FU_32_0_32_37_i1_fu_md5_speed_423516_424271));
  ui_bit_and_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(4),
    .BITSIZE_out1(4)) fu_md5_speed_423516_424098 (.out1(out_ui_bit_and_expr_FU_8_0_8_27_i0_fu_md5_speed_423516_424098),
    .in1(out_ASSIGN_UNSIGNED_FU_14_i0_fu_md5_speed_423516_424101),
    .in2(out_const_21));
  ASSIGN_UNSIGNED_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(4)) fu_md5_speed_423516_424101 (.out1(out_ASSIGN_UNSIGNED_FU_14_i0_fu_md5_speed_423516_424101),
    .in1(out_ui_minus_expr_FU_32_32_32_43_i0_fu_md5_speed_423516_424324));
  ui_bit_and_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(4),
    .BITSIZE_out1(4)) fu_md5_speed_423516_424104 (.out1(out_ui_bit_and_expr_FU_8_0_8_27_i1_fu_md5_speed_423516_424104),
    .in1(out_ui_plus_expr_FU_8_0_8_50_i0_fu_md5_speed_423516_424107),
    .in2(out_const_21));
  ui_plus_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(3),
    .BITSIZE_out1(4)) fu_md5_speed_423516_424107 (.out1(out_ui_plus_expr_FU_8_0_8_50_i0_fu_md5_speed_423516_424107),
    .in1(out_ASSIGN_UNSIGNED_FU_16_i0_fu_md5_speed_423516_424113),
    .in2(out_const_13));
  ASSIGN_UNSIGNED_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(4)) fu_md5_speed_423516_424113 (.out1(out_ASSIGN_UNSIGNED_FU_16_i0_fu_md5_speed_423516_424113),
    .in1(out_ui_bit_ior_concat_expr_FU_29_i2_fu_md5_speed_423516_424317));
  ui_bit_and_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(4),
    .BITSIZE_out1(4)) fu_md5_speed_423516_424118 (.out1(out_ui_bit_and_expr_FU_8_0_8_27_i2_fu_md5_speed_423516_424118),
    .in1(out_ui_plus_expr_FU_8_0_8_51_i0_fu_md5_speed_423516_424121),
    .in2(out_const_21));
  ui_plus_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(1),
    .BITSIZE_out1(4)) fu_md5_speed_423516_424121 (.out1(out_ui_plus_expr_FU_8_0_8_51_i0_fu_md5_speed_423516_424121),
    .in1(out_ASSIGN_UNSIGNED_FU_18_i0_fu_md5_speed_423516_424127),
    .in2(out_const_2));
  ASSIGN_UNSIGNED_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(4)) fu_md5_speed_423516_424127 (.out1(out_ASSIGN_UNSIGNED_FU_18_i0_fu_md5_speed_423516_424127),
    .in1(out_ui_bit_ior_concat_expr_FU_30_i0_fu_md5_speed_423516_424304));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_md5_speed_423516_424134 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_55_i2_fu_md5_speed_423516_424134),
    .in1(out_reg_9_reg_9),
    .in2(out_ui_lshift_expr_FU_32_0_32_37_i2_fu_md5_speed_423516_424275));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_424162 (.out1(out_ui_plus_expr_FU_32_0_32_44_i0_fu_md5_speed_423516_424162),
    .in1(out_reg_16_reg_16),
    .in2(out_const_20));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_in3(1),
    .BITSIZE_out1(32),
    .OFFSET_PARAMETER(1)) fu_md5_speed_423516_424163 (.out1(out_ui_bit_ior_concat_expr_FU_29_i0_fu_md5_speed_423516_424163),
    .in1(out_ui_lshift_expr_FU_32_0_32_38_i1_fu_md5_speed_423516_424348),
    .in2(out_ui_bit_and_expr_FU_1_0_1_25_i0_fu_md5_speed_423516_424351),
    .in3(out_const_2));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(31),
    .BITSIZE_out1(32)) fu_md5_speed_423516_424164 (.out1(out_ui_plus_expr_FU_32_0_32_45_i0_fu_md5_speed_423516_424164),
    .in1(out_reg_2_reg_2),
    .in2(out_const_19));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_md5_speed_423516_424166 (.out1(out_ui_pointer_plus_expr_FU_32_0_32_52_i0_fu_md5_speed_423516_424166),
    .in1(in_port_Pd459),
    .in2(out_const_4));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_md5_speed_423516_424168 (.out1(out_ui_pointer_plus_expr_FU_32_0_32_53_i0_fu_md5_speed_423516_424168),
    .in1(in_port_Pd459),
    .in2(out_const_5));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_in3(1),
    .BITSIZE_out1(32),
    .OFFSET_PARAMETER(1)) fu_md5_speed_423516_424170 (.out1(out_ui_bit_ior_concat_expr_FU_29_i1_fu_md5_speed_423516_424170),
    .in1(out_ui_lshift_expr_FU_32_0_32_38_i2_fu_md5_speed_423516_424361),
    .in2(out_ui_bit_and_expr_FU_1_0_1_25_i1_fu_md5_speed_423516_424364),
    .in3(out_const_2));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_md5_speed_423516_424171 (.out1(out_ui_pointer_plus_expr_FU_32_0_32_54_i0_fu_md5_speed_423516_424171),
    .in1(in_port_Pd459),
    .in2(out_const_17));
  read_cond_FU #(.BITSIZE_in1(1)) fu_md5_speed_423516_424205 (.out1(out_read_cond_FU_22_i0_fu_md5_speed_423516_424205),
    .in1(out_reg_12_reg_12));
  ui_lt_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(5),
    .BITSIZE_out1(1)) fu_md5_speed_423516_424259 (.out1(out_ui_lt_expr_FU_64_0_64_40_i0_fu_md5_speed_423516_424259),
    .in1(out_reg_0_reg_0),
    .in2(out_const_6));
  ui_view_convert_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_424267 (.out1(out_ui_view_convert_expr_FU_5_i0_fu_md5_speed_423516_424267),
    .in1(out_addr_expr_FU_4_i0_fu_md5_speed_423516_424284));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_speed_423516_424269 (.out1(out_ui_lshift_expr_FU_32_0_32_37_i0_fu_md5_speed_423516_424269),
    .in1(out_ui_cond_expr_FU_32_32_32_32_34_i6_fu_md5_speed_423516_424457),
    .in2(out_const_3));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_speed_423516_424271 (.out1(out_ui_lshift_expr_FU_32_0_32_37_i1_fu_md5_speed_423516_424271),
    .in1(out_ui_cond_expr_FU_32_32_32_32_34_i8_fu_md5_speed_423516_424461),
    .in2(out_const_3));
  ui_view_convert_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_424273 (.out1(out_ui_view_convert_expr_FU_7_i0_fu_md5_speed_423516_424273),
    .in1(out_addr_expr_FU_6_i0_fu_md5_speed_423516_424290));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_speed_423516_424275 (.out1(out_ui_lshift_expr_FU_32_0_32_37_i2_fu_md5_speed_423516_424275),
    .in1(out_ui_cond_expr_FU_32_32_32_32_34_i6_fu_md5_speed_423516_424457),
    .in2(out_const_3));
  ui_eq_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(7),
    .BITSIZE_out1(1)) fu_md5_speed_423516_424277 (.out1(out_ui_eq_expr_FU_64_0_64_35_i0_fu_md5_speed_423516_424277),
    .in1(out_ui_plus_expr_FU_64_0_64_49_i0_fu_md5_speed_423516_423548),
    .in2(out_const_8));
  addr_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_424284 (.out1(out_addr_expr_FU_4_i0_fu_md5_speed_423516_424284),
    .in1(out_conv_out_const_14_11_32));
  addr_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_424290 (.out1(out_addr_expr_FU_6_i0_fu_md5_speed_423516_424290),
    .in1(out_conv_out_const_15_11_32));
  ui_lt_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(6),
    .BITSIZE_out1(1)) fu_md5_speed_423516_424293 (.out1(out_ui_lt_expr_FU_64_0_64_41_i0_fu_md5_speed_423516_424293),
    .in1(out_reg_0_reg_0),
    .in2(out_const_7));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_speed_423516_424301 (.out1(out_ui_lshift_expr_FU_32_0_32_37_i3_fu_md5_speed_423516_424301),
    .in1(out_UUdata_converter_FU_17_i0_fu_md5_speed_423516_424078),
    .in2(out_const_3));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_in3(2),
    .BITSIZE_out1(32),
    .OFFSET_PARAMETER(2)) fu_md5_speed_423516_424304 (.out1(out_ui_bit_ior_concat_expr_FU_30_i0_fu_md5_speed_423516_424304),
    .in1(out_ui_lshift_expr_FU_32_0_32_37_i4_fu_md5_speed_423516_424385),
    .in2(out_ui_bit_and_expr_FU_8_0_8_28_i0_fu_md5_speed_423516_424388),
    .in3(out_const_3));
  ui_lt_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(6),
    .BITSIZE_out1(1)) fu_md5_speed_423516_424306 (.out1(out_ui_lt_expr_FU_64_0_64_42_i0_fu_md5_speed_423516_424306),
    .in1(out_reg_0_reg_0),
    .in2(out_const_18));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_speed_423516_424314 (.out1(out_ui_lshift_expr_FU_32_0_32_38_i0_fu_md5_speed_423516_424314),
    .in1(out_UUdata_converter_FU_15_i0_fu_md5_speed_423516_424074),
    .in2(out_const_2));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_in3(1),
    .BITSIZE_out1(32),
    .OFFSET_PARAMETER(1)) fu_md5_speed_423516_424317 (.out1(out_ui_bit_ior_concat_expr_FU_29_i2_fu_md5_speed_423516_424317),
    .in1(out_ui_lshift_expr_FU_32_0_32_38_i3_fu_md5_speed_423516_424405),
    .in2(out_ui_bit_and_expr_FU_1_0_1_25_i2_fu_md5_speed_423516_424408),
    .in3(out_const_2));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_speed_423516_424321 (.out1(out_ui_lshift_expr_FU_32_0_32_39_i0_fu_md5_speed_423516_424321),
    .in1(out_UUdata_converter_FU_13_i0_fu_md5_speed_423516_424072),
    .in2(out_const_16));
  ui_minus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_424324 (.out1(out_ui_minus_expr_FU_32_32_32_43_i0_fu_md5_speed_423516_424324),
    .in1(out_ui_lshift_expr_FU_32_0_32_39_i0_fu_md5_speed_423516_424321),
    .in2(out_UUdata_converter_FU_13_i0_fu_md5_speed_423516_424072));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(31),
    .PRECISION(32)) fu_md5_speed_423516_424341 (.out1(out_ui_rshift_expr_FU_32_0_32_56_i0_fu_md5_speed_423516_424341),
    .in1(out_reg_3_reg_3),
    .in2(out_const_2));
  ui_plus_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(31),
    .BITSIZE_out1(31)) fu_md5_speed_423516_424345 (.out1(out_ui_plus_expr_FU_32_0_32_46_i0_fu_md5_speed_423516_424345),
    .in1(out_ui_rshift_expr_FU_32_0_32_56_i0_fu_md5_speed_423516_424341),
    .in2(out_const_11));
  ui_lshift_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_speed_423516_424348 (.out1(out_ui_lshift_expr_FU_32_0_32_38_i1_fu_md5_speed_423516_424348),
    .in1(out_ui_plus_expr_FU_32_0_32_46_i0_fu_md5_speed_423516_424345),
    .in2(out_const_2));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_md5_speed_423516_424351 (.out1(out_ui_bit_and_expr_FU_1_0_1_25_i0_fu_md5_speed_423516_424351),
    .in1(out_reg_3_reg_3),
    .in2(out_const_2));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(31),
    .PRECISION(32)) fu_md5_speed_423516_424355 (.out1(out_ui_rshift_expr_FU_32_0_32_56_i1_fu_md5_speed_423516_424355),
    .in1(out_reg_4_reg_4),
    .in2(out_const_2));
  ui_plus_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(28),
    .BITSIZE_out1(31)) fu_md5_speed_423516_424358 (.out1(out_ui_plus_expr_FU_32_0_32_47_i0_fu_md5_speed_423516_424358),
    .in1(out_ui_rshift_expr_FU_32_0_32_56_i1_fu_md5_speed_423516_424355),
    .in2(out_const_9));
  ui_lshift_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_speed_423516_424361 (.out1(out_ui_lshift_expr_FU_32_0_32_38_i2_fu_md5_speed_423516_424361),
    .in1(out_ui_plus_expr_FU_32_0_32_47_i0_fu_md5_speed_423516_424358),
    .in2(out_const_2));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_md5_speed_423516_424364 (.out1(out_ui_bit_and_expr_FU_1_0_1_25_i1_fu_md5_speed_423516_424364),
    .in1(out_reg_4_reg_4),
    .in2(out_const_2));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(30),
    .PRECISION(32)) fu_md5_speed_423516_424376 (.out1(out_ui_rshift_expr_FU_32_0_32_57_i0_fu_md5_speed_423516_424376),
    .in1(out_ui_lshift_expr_FU_32_0_32_37_i3_fu_md5_speed_423516_424301),
    .in2(out_const_3));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(30),
    .PRECISION(32)) fu_md5_speed_423516_424380 (.out1(out_ui_rshift_expr_FU_32_0_32_57_i1_fu_md5_speed_423516_424380),
    .in1(out_UUdata_converter_FU_17_i0_fu_md5_speed_423516_424078),
    .in2(out_const_3));
  ui_plus_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(30),
    .BITSIZE_out1(30)) fu_md5_speed_423516_424382 (.out1(out_ui_plus_expr_FU_32_32_32_48_i2_fu_md5_speed_423516_424382),
    .in1(out_ui_rshift_expr_FU_32_0_32_57_i0_fu_md5_speed_423516_424376),
    .in2(out_ui_rshift_expr_FU_32_0_32_57_i1_fu_md5_speed_423516_424380));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_speed_423516_424385 (.out1(out_ui_lshift_expr_FU_32_0_32_37_i4_fu_md5_speed_423516_424385),
    .in1(out_ui_plus_expr_FU_32_32_32_48_i2_fu_md5_speed_423516_424382),
    .in2(out_const_3));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(2)) fu_md5_speed_423516_424388 (.out1(out_ui_bit_and_expr_FU_8_0_8_28_i0_fu_md5_speed_423516_424388),
    .in1(out_UUdata_converter_FU_17_i0_fu_md5_speed_423516_424078),
    .in2(out_const_16));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(31),
    .PRECISION(32)) fu_md5_speed_423516_424397 (.out1(out_ui_rshift_expr_FU_32_0_32_56_i2_fu_md5_speed_423516_424397),
    .in1(out_ui_lshift_expr_FU_32_0_32_38_i0_fu_md5_speed_423516_424314),
    .in2(out_const_2));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(31),
    .PRECISION(32)) fu_md5_speed_423516_424400 (.out1(out_ui_rshift_expr_FU_32_0_32_56_i3_fu_md5_speed_423516_424400),
    .in1(out_UUdata_converter_FU_15_i0_fu_md5_speed_423516_424074),
    .in2(out_const_2));
  ui_plus_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(31),
    .BITSIZE_out1(31)) fu_md5_speed_423516_424402 (.out1(out_ui_plus_expr_FU_32_32_32_48_i3_fu_md5_speed_423516_424402),
    .in1(out_ui_rshift_expr_FU_32_0_32_56_i2_fu_md5_speed_423516_424397),
    .in2(out_ui_rshift_expr_FU_32_0_32_56_i3_fu_md5_speed_423516_424400));
  ui_lshift_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_speed_423516_424405 (.out1(out_ui_lshift_expr_FU_32_0_32_38_i3_fu_md5_speed_423516_424405),
    .in1(out_ui_plus_expr_FU_32_32_32_48_i3_fu_md5_speed_423516_424402),
    .in2(out_const_2));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_md5_speed_423516_424408 (.out1(out_ui_bit_and_expr_FU_1_0_1_25_i2_fu_md5_speed_423516_424408),
    .in1(out_UUdata_converter_FU_15_i0_fu_md5_speed_423516_424074),
    .in2(out_const_2));
  lut_expr_FU #(.BITSIZE_in1(5),
    .BITSIZE_out1(1)) fu_md5_speed_423516_424431 (.out1(out_lut_expr_FU_20_i0_fu_md5_speed_423516_424431),
    .in1(out_const_6),
    .in2(out_ui_lt_expr_FU_64_0_64_40_i0_fu_md5_speed_423516_424259),
    .in3(out_ui_lt_expr_FU_64_0_64_41_i0_fu_md5_speed_423516_424293),
    .in4(out_ui_lt_expr_FU_64_0_64_42_i0_fu_md5_speed_423516_424306),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(30),
    .BITSIZE_in3(32),
    .BITSIZE_out1(30)) fu_md5_speed_423516_424437 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i0_fu_md5_speed_423516_424437),
    .in1(out_ui_lt_expr_FU_64_0_64_40_i0_fu_md5_speed_423516_424259),
    .in2(out_UUdata_converter_FU_19_i0_fu_md5_speed_423516_424082),
    .in3(out_UUdata_converter_FU_17_i0_fu_md5_speed_423516_424078));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(32),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_424440 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i1_fu_md5_speed_423516_424440),
    .in1(out_ui_lt_expr_FU_64_0_64_40_i0_fu_md5_speed_423516_424259),
    .in2(out_ui_bit_ior_expr_FU_32_32_32_31_i2_fu_md5_speed_423516_423608),
    .in3(out_ui_bit_ior_expr_FU_32_32_32_31_i1_fu_md5_speed_423516_423597));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(30),
    .BITSIZE_in3(4),
    .BITSIZE_out1(30)) fu_md5_speed_423516_424443 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i2_fu_md5_speed_423516_424443),
    .in1(out_ui_lt_expr_FU_64_0_64_40_i0_fu_md5_speed_423516_424259),
    .in2(out_UUdata_converter_FU_19_i0_fu_md5_speed_423516_424082),
    .in3(out_ui_bit_and_expr_FU_8_0_8_27_i2_fu_md5_speed_423516_424118));
  lut_expr_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(1)) fu_md5_speed_423516_424446 (.out1(out_lut_expr_FU_21_i0_fu_md5_speed_423516_424446),
    .in1(out_const_22),
    .in2(out_ui_lt_expr_FU_64_0_64_40_i0_fu_md5_speed_423516_424259),
    .in3(out_ui_lt_expr_FU_64_0_64_41_i0_fu_md5_speed_423516_424293),
    .in4(out_ui_lt_expr_FU_64_0_64_42_i0_fu_md5_speed_423516_424306),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(32),
    .BITSIZE_in3(30),
    .BITSIZE_out1(30)) fu_md5_speed_423516_424449 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i3_fu_md5_speed_423516_424449),
    .in1(out_lut_expr_FU_20_i0_fu_md5_speed_423516_424431),
    .in2(out_UUdata_converter_FU_15_i0_fu_md5_speed_423516_424074),
    .in3(out_ui_cond_expr_FU_32_32_32_32_34_i0_fu_md5_speed_423516_424437));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(32),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_424452 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i4_fu_md5_speed_423516_424452),
    .in1(out_lut_expr_FU_20_i0_fu_md5_speed_423516_424431),
    .in2(out_ui_bit_xor_expr_FU_32_32_32_33_i1_fu_md5_speed_423516_423592),
    .in3(out_ui_cond_expr_FU_32_32_32_32_34_i1_fu_md5_speed_423516_424440));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(4),
    .BITSIZE_in3(30),
    .BITSIZE_out1(30)) fu_md5_speed_423516_424455 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i5_fu_md5_speed_423516_424455),
    .in1(out_lut_expr_FU_20_i0_fu_md5_speed_423516_424431),
    .in2(out_ui_bit_and_expr_FU_8_0_8_27_i1_fu_md5_speed_423516_424104),
    .in3(out_ui_cond_expr_FU_32_32_32_32_34_i2_fu_md5_speed_423516_424443));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(30),
    .BITSIZE_in3(32),
    .BITSIZE_out1(30)) fu_md5_speed_423516_424457 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i6_fu_md5_speed_423516_424457),
    .in1(out_lut_expr_FU_21_i0_fu_md5_speed_423516_424446),
    .in2(out_ui_cond_expr_FU_32_32_32_32_34_i3_fu_md5_speed_423516_424449),
    .in3(out_UUdata_converter_FU_13_i0_fu_md5_speed_423516_424072));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(32),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_md5_speed_423516_424459 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i7_fu_md5_speed_423516_424459),
    .in1(out_lut_expr_FU_21_i0_fu_md5_speed_423516_424446),
    .in2(out_ui_cond_expr_FU_32_32_32_32_34_i4_fu_md5_speed_423516_424452),
    .in3(out_ui_bit_xor_expr_FU_32_32_32_33_i0_fu_md5_speed_423516_423583));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(30),
    .BITSIZE_in3(4),
    .BITSIZE_out1(30)) fu_md5_speed_423516_424461 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i8_fu_md5_speed_423516_424461),
    .in1(out_lut_expr_FU_21_i0_fu_md5_speed_423516_424446),
    .in2(out_ui_cond_expr_FU_32_32_32_32_34_i5_fu_md5_speed_423516_424455),
    .in3(out_ui_bit_and_expr_FU_8_0_8_27_i0_fu_md5_speed_423516_424098));
  register_SE #(.BITSIZE_in1(64),
    .BITSIZE_out1(64)) reg_0 (.out1(out_reg_0_reg_0),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_29_reg_0_0_0_0),
    .wenable(wrenable_reg_0));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_1 (.out1(out_reg_1_reg_1),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_30_reg_1_0_0_0),
    .wenable(wrenable_reg_1));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_10 (.out1(out_reg_10_reg_10),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_cond_expr_FU_32_32_32_32_34_i7_fu_md5_speed_423516_424459),
    .wenable(wrenable_reg_10));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_11 (.out1(out_reg_11_reg_11),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_55_i1_fu_md5_speed_423516_424088),
    .wenable(wrenable_reg_11));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_12 (.out1(out_reg_12_reg_12),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_eq_expr_FU_64_0_64_35_i0_fu_md5_speed_423516_424277),
    .wenable(wrenable_reg_12));
  register_STD #(.BITSIZE_in1(5),
    .BITSIZE_out1(5)) reg_13 (.out1(out_reg_13_reg_13),
    .clock(clock),
    .reset(reset),
    .in1(out_conv_out_ARRAY_1D_STD_BRAM_1_i0_array_424139_0_32_5),
    .wenable(wrenable_reg_13));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_14 (.out1(out_reg_14_reg_14),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_ternary_plus_expr_FU_32_32_32_32_58_i0_fu_md5_speed_423516_423571),
    .wenable(wrenable_reg_14));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_15 (.out1(out_reg_15_reg_15),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_fshl_expr_FU_32_32_32_32_36_i0_fu_md5_speed_423516_423563),
    .wenable(wrenable_reg_15));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_16 (.out1(out_reg_16_reg_16),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_plus_expr_FU_32_32_32_48_i0_fu_md5_speed_423516_423560),
    .wenable(wrenable_reg_16));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_17 (.out1(out_reg_17_reg_17),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_bit_ior_concat_expr_FU_29_i0_fu_md5_speed_423516_424163),
    .wenable(wrenable_reg_17));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_18 (.out1(out_reg_18_reg_18),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_plus_expr_FU_32_0_32_45_i0_fu_md5_speed_423516_424164),
    .wenable(wrenable_reg_18));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_19 (.out1(out_reg_19_reg_19),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_bit_ior_concat_expr_FU_29_i1_fu_md5_speed_423516_424170),
    .wenable(wrenable_reg_19));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_2 (.out1(out_reg_2_reg_2),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_41_reg_2_0_0_0),
    .wenable(wrenable_reg_2));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_3 (.out1(out_reg_3_reg_3),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_42_reg_3_0_0_0),
    .wenable(wrenable_reg_3));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_4 (.out1(out_reg_4_reg_4),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_43_reg_4_0_0_0),
    .wenable(wrenable_reg_4));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_5 (.out1(out_reg_5_reg_5),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_0_32_52_i0_fu_md5_speed_423516_424166),
    .wenable(wrenable_reg_5));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_6 (.out1(out_reg_6_reg_6),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_0_32_53_i0_fu_md5_speed_423516_424168),
    .wenable(wrenable_reg_6));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_7 (.out1(out_reg_7_reg_7),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_0_32_54_i0_fu_md5_speed_423516_424171),
    .wenable(wrenable_reg_7));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_8 (.out1(out_reg_8_reg_8),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_view_convert_expr_FU_5_i0_fu_md5_speed_423516_424267),
    .wenable(wrenable_reg_8));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_9 (.out1(out_reg_9_reg_9),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_view_convert_expr_FU_7_i0_fu_md5_speed_423516_424273),
    .wenable(wrenable_reg_9));
  // io-signal post fix
  assign Mout_oe_ram = sig_out_bus_mergerMout_oe_ram3_;
  assign Mout_we_ram = sig_out_bus_mergerMout_we_ram4_;
  assign Mout_addr_ram = sig_out_bus_mergerMout_addr_ram1_;
  assign Mout_Wdata_ram = sig_out_bus_mergerMout_Wdata_ram0_;
  assign Mout_data_ram_size = sig_out_bus_mergerMout_data_ram_size2_;
  assign OUT_CONDITION_md5_speed_423516_424205 = out_read_cond_FU_22_i0_fu_md5_speed_423516_424205;

endmodule

// FSM based controller description for md5_speed
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module controller_md5_speed(done_port,
  fuselector_ARRAY_1D_STD_BRAM_0_i0_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_0_i0_STORE,
  fuselector_ARRAY_1D_STD_BRAM_1_i0_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_1_i0_STORE,
  fuselector_BMEMORY_CTRL_24_i0_LOAD,
  fuselector_BMEMORY_CTRL_24_i0_STORE,
  selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_0,
  selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_1,
  selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_2,
  selector_MUX_10_BMEMORY_CTRL_24_i0_1_1_0,
  selector_MUX_29_reg_0_0_0_0,
  selector_MUX_30_reg_1_0_0_0,
  selector_MUX_41_reg_2_0_0_0,
  selector_MUX_42_reg_3_0_0_0,
  selector_MUX_43_reg_4_0_0_0,
  selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_0,
  selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_1,
  selector_MUX_9_BMEMORY_CTRL_24_i0_0_1_0,
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
  wrenable_reg_3,
  wrenable_reg_4,
  wrenable_reg_5,
  wrenable_reg_6,
  wrenable_reg_7,
  wrenable_reg_8,
  wrenable_reg_9,
  OUT_CONDITION_md5_speed_423516_424205,
  clock,
  reset,
  start_port);
  // IN
  input OUT_CONDITION_md5_speed_423516_424205;
  input clock;
  input reset;
  input start_port;
  // OUT
  output done_port;
  output fuselector_ARRAY_1D_STD_BRAM_0_i0_LOAD;
  output fuselector_ARRAY_1D_STD_BRAM_0_i0_STORE;
  output fuselector_ARRAY_1D_STD_BRAM_1_i0_LOAD;
  output fuselector_ARRAY_1D_STD_BRAM_1_i0_STORE;
  output fuselector_BMEMORY_CTRL_24_i0_LOAD;
  output fuselector_BMEMORY_CTRL_24_i0_STORE;
  output selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_0;
  output selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_1;
  output selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_2;
  output selector_MUX_10_BMEMORY_CTRL_24_i0_1_1_0;
  output selector_MUX_29_reg_0_0_0_0;
  output selector_MUX_30_reg_1_0_0_0;
  output selector_MUX_41_reg_2_0_0_0;
  output selector_MUX_42_reg_3_0_0_0;
  output selector_MUX_43_reg_4_0_0_0;
  output selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_0;
  output selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_1;
  output selector_MUX_9_BMEMORY_CTRL_24_i0_0_1_0;
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
  output wrenable_reg_3;
  output wrenable_reg_4;
  output wrenable_reg_5;
  output wrenable_reg_6;
  output wrenable_reg_7;
  output wrenable_reg_8;
  output wrenable_reg_9;
  parameter [9:0] S_0 = 10'b0000000001,
    S_1 = 10'b0000000010,
    S_2 = 10'b0000000100,
    S_3 = 10'b0000001000,
    S_4 = 10'b0000010000,
    S_5 = 10'b0000100000,
    S_6 = 10'b0001000000,
    S_7 = 10'b0010000000,
    S_8 = 10'b0100000000,
    S_9 = 10'b1000000000;
  reg [9:0] _present_state=S_0, _next_state;
  reg done_port;
  reg fuselector_ARRAY_1D_STD_BRAM_0_i0_LOAD;
  reg fuselector_ARRAY_1D_STD_BRAM_0_i0_STORE;
  reg fuselector_ARRAY_1D_STD_BRAM_1_i0_LOAD;
  reg fuselector_ARRAY_1D_STD_BRAM_1_i0_STORE;
  reg fuselector_BMEMORY_CTRL_24_i0_LOAD;
  reg fuselector_BMEMORY_CTRL_24_i0_STORE;
  reg selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_0;
  reg selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_1;
  reg selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_2;
  reg selector_MUX_10_BMEMORY_CTRL_24_i0_1_1_0;
  reg selector_MUX_29_reg_0_0_0_0;
  reg selector_MUX_30_reg_1_0_0_0;
  reg selector_MUX_41_reg_2_0_0_0;
  reg selector_MUX_42_reg_3_0_0_0;
  reg selector_MUX_43_reg_4_0_0_0;
  reg selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_0;
  reg selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_1;
  reg selector_MUX_9_BMEMORY_CTRL_24_i0_0_1_0;
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
    fuselector_ARRAY_1D_STD_BRAM_0_i0_LOAD = 1'b0;
    fuselector_ARRAY_1D_STD_BRAM_0_i0_STORE = 1'b0;
    fuselector_ARRAY_1D_STD_BRAM_1_i0_LOAD = 1'b0;
    fuselector_ARRAY_1D_STD_BRAM_1_i0_STORE = 1'b0;
    fuselector_BMEMORY_CTRL_24_i0_LOAD = 1'b0;
    fuselector_BMEMORY_CTRL_24_i0_STORE = 1'b0;
    selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_0 = 1'b0;
    selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_1 = 1'b0;
    selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_2 = 1'b0;
    selector_MUX_10_BMEMORY_CTRL_24_i0_1_1_0 = 1'b0;
    selector_MUX_29_reg_0_0_0_0 = 1'b0;
    selector_MUX_30_reg_1_0_0_0 = 1'b0;
    selector_MUX_41_reg_2_0_0_0 = 1'b0;
    selector_MUX_42_reg_3_0_0_0 = 1'b0;
    selector_MUX_43_reg_4_0_0_0 = 1'b0;
    selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_0 = 1'b0;
    selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_1 = 1'b0;
    selector_MUX_9_BMEMORY_CTRL_24_i0_0_1_0 = 1'b0;
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
          selector_MUX_42_reg_3_0_0_0 = 1'b1;
          wrenable_reg_0 = 1'b1;
          wrenable_reg_1 = 1'b1;
          wrenable_reg_2 = 1'b1;
          wrenable_reg_3 = 1'b1;
          wrenable_reg_4 = 1'b1;
          wrenable_reg_5 = 1'b1;
          wrenable_reg_6 = 1'b1;
          wrenable_reg_7 = 1'b1;
          wrenable_reg_8 = 1'b1;
          wrenable_reg_9 = 1'b1;
          _next_state = S_1;
        end
        else
        begin
          _next_state = S_0;
        end
      S_1 :
        begin
          fuselector_ARRAY_1D_STD_BRAM_0_i0_LOAD = 1'b1;
          fuselector_ARRAY_1D_STD_BRAM_1_i0_LOAD = 1'b1;
          selector_MUX_29_reg_0_0_0_0 = 1'b1;
          wrenable_reg_0 = 1'b1;
          wrenable_reg_10 = 1'b1;
          wrenable_reg_11 = 1'b1;
          wrenable_reg_12 = 1'b1;
          _next_state = S_2;
        end
      S_2 :
        begin
          fuselector_BMEMORY_CTRL_24_i0_LOAD = 1'b1;
          selector_MUX_10_BMEMORY_CTRL_24_i0_1_1_0 = 1'b1;
          wrenable_reg_13 = 1'b1;
          wrenable_reg_14 = 1'b1;
          _next_state = S_3;
        end
      S_3 :
        begin
          wrenable_reg_15 = 1'b1;
          _next_state = S_4;
        end
      S_4 :
        begin
          selector_MUX_30_reg_1_0_0_0 = 1'b1;
          selector_MUX_41_reg_2_0_0_0 = 1'b1;
          selector_MUX_43_reg_4_0_0_0 = 1'b1;
          wrenable_reg_1 = 1'b1;
          wrenable_reg_16 = 1'b1;
          wrenable_reg_2 = 1'b1;
          wrenable_reg_3 = 1'b1;
          wrenable_reg_4 = 1'b1;
          if (OUT_CONDITION_md5_speed_423516_424205 == 1'b1)
            begin
              _next_state = S_5;
              selector_MUX_30_reg_1_0_0_0 = 1'b0;
              selector_MUX_41_reg_2_0_0_0 = 1'b0;
              selector_MUX_43_reg_4_0_0_0 = 1'b0;
              wrenable_reg_1 = 1'b0;
              wrenable_reg_2 = 1'b0;
              wrenable_reg_3 = 1'b0;
              wrenable_reg_4 = 1'b0;
            end
          else
            begin
              _next_state = S_1;
              wrenable_reg_16 = 1'b0;
            end
        end
      S_5 :
        begin
          fuselector_BMEMORY_CTRL_24_i0_STORE = 1'b1;
          selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_1 = 1'b1;
          selector_MUX_10_BMEMORY_CTRL_24_i0_1_1_0 = 1'b1;
          selector_MUX_9_BMEMORY_CTRL_24_i0_0_1_0 = 1'b1;
          wrenable_reg_17 = 1'b1;
          wrenable_reg_18 = 1'b1;
          wrenable_reg_19 = 1'b1;
          _next_state = S_6;
        end
      S_6 :
        begin
          fuselector_BMEMORY_CTRL_24_i0_STORE = 1'b1;
          selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_2 = 1'b1;
          selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_0 = 1'b1;
          selector_MUX_9_BMEMORY_CTRL_24_i0_0_1_0 = 1'b1;
          _next_state = S_7;
        end
      S_7 :
        begin
          fuselector_BMEMORY_CTRL_24_i0_STORE = 1'b1;
          selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_1 = 1'b1;
          _next_state = S_8;
        end
      S_8 :
        begin
          fuselector_BMEMORY_CTRL_24_i0_STORE = 1'b1;
          selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_0 = 1'b1;
          _next_state = S_9;
          done_port = 1'b1;
        end
      S_9 :
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

// Top component for md5_speed
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module _md5_speed(clock,
  reset,
  start_port,
  done_port,
  Pd458,
  Pd459,
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
  input [31:0] Pd458;
  input [31:0] Pd459;
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
  wire OUT_CONDITION_md5_speed_423516_424205;
  wire done_delayed_REG_signal_in;
  wire done_delayed_REG_signal_out;
  wire fuselector_ARRAY_1D_STD_BRAM_0_i0_LOAD;
  wire fuselector_ARRAY_1D_STD_BRAM_0_i0_STORE;
  wire fuselector_ARRAY_1D_STD_BRAM_1_i0_LOAD;
  wire fuselector_ARRAY_1D_STD_BRAM_1_i0_STORE;
  wire fuselector_BMEMORY_CTRL_24_i0_LOAD;
  wire fuselector_BMEMORY_CTRL_24_i0_STORE;
  wire selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_0;
  wire selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_1;
  wire selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_2;
  wire selector_MUX_10_BMEMORY_CTRL_24_i0_1_1_0;
  wire selector_MUX_29_reg_0_0_0_0;
  wire selector_MUX_30_reg_1_0_0_0;
  wire selector_MUX_41_reg_2_0_0_0;
  wire selector_MUX_42_reg_3_0_0_0;
  wire selector_MUX_43_reg_4_0_0_0;
  wire selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_0;
  wire selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_1;
  wire selector_MUX_9_BMEMORY_CTRL_24_i0_0_1_0;
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
  wire wrenable_reg_3;
  wire wrenable_reg_4;
  wire wrenable_reg_5;
  wire wrenable_reg_6;
  wire wrenable_reg_7;
  wire wrenable_reg_8;
  wire wrenable_reg_9;
  
  controller_md5_speed Controller_i (.done_port(done_delayed_REG_signal_in),
    .fuselector_ARRAY_1D_STD_BRAM_0_i0_LOAD(fuselector_ARRAY_1D_STD_BRAM_0_i0_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_0_i0_STORE(fuselector_ARRAY_1D_STD_BRAM_0_i0_STORE),
    .fuselector_ARRAY_1D_STD_BRAM_1_i0_LOAD(fuselector_ARRAY_1D_STD_BRAM_1_i0_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_1_i0_STORE(fuselector_ARRAY_1D_STD_BRAM_1_i0_STORE),
    .fuselector_BMEMORY_CTRL_24_i0_LOAD(fuselector_BMEMORY_CTRL_24_i0_LOAD),
    .fuselector_BMEMORY_CTRL_24_i0_STORE(fuselector_BMEMORY_CTRL_24_i0_STORE),
    .selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_0(selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_0),
    .selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_1(selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_1),
    .selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_2(selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_2),
    .selector_MUX_10_BMEMORY_CTRL_24_i0_1_1_0(selector_MUX_10_BMEMORY_CTRL_24_i0_1_1_0),
    .selector_MUX_29_reg_0_0_0_0(selector_MUX_29_reg_0_0_0_0),
    .selector_MUX_30_reg_1_0_0_0(selector_MUX_30_reg_1_0_0_0),
    .selector_MUX_41_reg_2_0_0_0(selector_MUX_41_reg_2_0_0_0),
    .selector_MUX_42_reg_3_0_0_0(selector_MUX_42_reg_3_0_0_0),
    .selector_MUX_43_reg_4_0_0_0(selector_MUX_43_reg_4_0_0_0),
    .selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_0(selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_0),
    .selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_1(selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_1),
    .selector_MUX_9_BMEMORY_CTRL_24_i0_0_1_0(selector_MUX_9_BMEMORY_CTRL_24_i0_0_1_0),
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
    .wrenable_reg_3(wrenable_reg_3),
    .wrenable_reg_4(wrenable_reg_4),
    .wrenable_reg_5(wrenable_reg_5),
    .wrenable_reg_6(wrenable_reg_6),
    .wrenable_reg_7(wrenable_reg_7),
    .wrenable_reg_8(wrenable_reg_8),
    .wrenable_reg_9(wrenable_reg_9),
    .OUT_CONDITION_md5_speed_423516_424205(OUT_CONDITION_md5_speed_423516_424205),
    .clock(clock),
    .reset(reset),
    .start_port(start_port));
  datapath_md5_speed #(.MEM_var_423634_423516(1024),
    .MEM_var_424139_423516(1024)) Datapath_i (.Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .OUT_CONDITION_md5_speed_423516_424205(OUT_CONDITION_md5_speed_423516_424205),
    .clock(clock),
    .reset(reset),
    .in_port_Pd458(Pd458),
    .in_port_Pd459(Pd459),
    .M_Rdata_ram(M_Rdata_ram),
    .M_DataRdy(M_DataRdy),
    .Min_oe_ram(Min_oe_ram),
    .Min_we_ram(Min_we_ram),
    .Min_addr_ram(Min_addr_ram),
    .Min_Wdata_ram(Min_Wdata_ram),
    .Min_data_ram_size(Min_data_ram_size),
    .fuselector_ARRAY_1D_STD_BRAM_0_i0_LOAD(fuselector_ARRAY_1D_STD_BRAM_0_i0_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_0_i0_STORE(fuselector_ARRAY_1D_STD_BRAM_0_i0_STORE),
    .fuselector_ARRAY_1D_STD_BRAM_1_i0_LOAD(fuselector_ARRAY_1D_STD_BRAM_1_i0_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_1_i0_STORE(fuselector_ARRAY_1D_STD_BRAM_1_i0_STORE),
    .fuselector_BMEMORY_CTRL_24_i0_LOAD(fuselector_BMEMORY_CTRL_24_i0_LOAD),
    .fuselector_BMEMORY_CTRL_24_i0_STORE(fuselector_BMEMORY_CTRL_24_i0_STORE),
    .selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_0(selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_0),
    .selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_1(selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_1),
    .selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_2(selector_MUX_10_BMEMORY_CTRL_24_i0_1_0_2),
    .selector_MUX_10_BMEMORY_CTRL_24_i0_1_1_0(selector_MUX_10_BMEMORY_CTRL_24_i0_1_1_0),
    .selector_MUX_29_reg_0_0_0_0(selector_MUX_29_reg_0_0_0_0),
    .selector_MUX_30_reg_1_0_0_0(selector_MUX_30_reg_1_0_0_0),
    .selector_MUX_41_reg_2_0_0_0(selector_MUX_41_reg_2_0_0_0),
    .selector_MUX_42_reg_3_0_0_0(selector_MUX_42_reg_3_0_0_0),
    .selector_MUX_43_reg_4_0_0_0(selector_MUX_43_reg_4_0_0_0),
    .selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_0(selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_0),
    .selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_1(selector_MUX_9_BMEMORY_CTRL_24_i0_0_0_1),
    .selector_MUX_9_BMEMORY_CTRL_24_i0_0_1_0(selector_MUX_9_BMEMORY_CTRL_24_i0_0_1_0),
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

// Minimal interface for function: md5_speed
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module md5_speed(clk,
  reset,
  start_port,
  Pd458,
  Pd459,
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
  input [31:0] Pd458;
  input [31:0] Pd459;
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
  
  _md5_speed _md5_speed_i0 (.done_port(done_port),
    .Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .clock(clk),
    .reset(reset),
    .start_port(start_port),
    .Pd458(Pd458),
    .Pd459(Pd459),
    .M_Rdata_ram(M_Rdata_ram),
    .M_DataRdy(M_DataRdy),
    .Min_oe_ram(1'b0),
    .Min_we_ram(1'b0),
    .Min_addr_ram(32'b00000000000000000000000000000000),
    .Min_Wdata_ram(32'b00000000000000000000000000000000),
    .Min_data_ram_size(6'b000000));

endmodule


