// 
// Politecnico di Milano
// Code created using PandA - Version: PandA 0.9.8 - Revision 891ec3caed502474cab0813cc4a9fc678deabaa5 - Date 2023-02-25T16:22:16
// /nix/store/2hfjp458bdl98q37hzi2aljm30kda30v-bambu-wrapped/bin/bambu executed with: /nix/store/2hfjp458bdl98q37hzi2aljm30kda30v-bambu-wrapped/bin/bambu --top-fname=md5 --clock-name=clk --compiler=I386_CLANG12 -Os md5.ll 
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
module ADDRESS_DECODING_LOGIC_NN(clock,
  reset,
  in1,
  in2,
  in3,
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
  proxy_out1,
  dout_a,
  dout_b,
  memory_addr_a,
  memory_addr_b,
  din_value_aggregated_swapped,
  be_swapped,
  bram_write);
  parameter BITSIZE_in1=1, PORTSIZE_in1=2,
    BITSIZE_in2=1, PORTSIZE_in2=2,
    BITSIZE_in3=1, PORTSIZE_in3=2,
    BITSIZE_sel_LOAD=1, PORTSIZE_sel_LOAD=2,
    BITSIZE_sel_STORE=1, PORTSIZE_sel_STORE=2,
    BITSIZE_out1=1, PORTSIZE_out1=2,
    BITSIZE_S_oe_ram=1, PORTSIZE_S_oe_ram=2,
    BITSIZE_S_we_ram=1, PORTSIZE_S_we_ram=2,
    BITSIZE_Sin_DataRdy=1, PORTSIZE_Sin_DataRdy=2,
    BITSIZE_Sout_DataRdy=1, PORTSIZE_Sout_DataRdy=2,
    BITSIZE_S_addr_ram=1, PORTSIZE_S_addr_ram=2,
    BITSIZE_S_Wdata_ram=8, PORTSIZE_S_Wdata_ram=2,
    BITSIZE_Sin_Rdata_ram=8, PORTSIZE_Sin_Rdata_ram=2,
    BITSIZE_Sout_Rdata_ram=8, PORTSIZE_Sout_Rdata_ram=2,
    BITSIZE_S_data_ram_size=1, PORTSIZE_S_data_ram_size=2,
    address_space_begin=0,
    address_space_rangesize=4,
    BUS_PIPELINED=1,
    BRAM_BITSIZE=32,
    PRIVATE_MEMORY=0,
    USE_SPARSE_MEMORY=1,
    HIGH_LATENCY=0,
    BITSIZE_proxy_in1=1, PORTSIZE_proxy_in1=2,
    BITSIZE_proxy_in2=1, PORTSIZE_proxy_in2=2,
    BITSIZE_proxy_in3=1, PORTSIZE_proxy_in3=2,
    BITSIZE_proxy_sel_LOAD=1, PORTSIZE_proxy_sel_LOAD=2,
    BITSIZE_proxy_sel_STORE=1, PORTSIZE_proxy_sel_STORE=2,
    BITSIZE_proxy_out1=1, PORTSIZE_proxy_out1=2,
    BITSIZE_dout_a=1, PORTSIZE_dout_a=2,
    BITSIZE_dout_b=1, PORTSIZE_dout_b=2,
    BITSIZE_memory_addr_a=1, PORTSIZE_memory_addr_a=2,
    BITSIZE_memory_addr_b=1, PORTSIZE_memory_addr_b=2,
    BITSIZE_din_value_aggregated_swapped=1, PORTSIZE_din_value_aggregated_swapped=2,
    BITSIZE_be_swapped=1, PORTSIZE_be_swapped=2,
    BITSIZE_bram_write=1, PORTSIZE_bram_write=2,
    nbit_read_addr=32,
    n_byte_on_databus=4,
    n_mem_elements=4,
    max_n_reads=2,
    max_n_writes=2,
    max_n_rw=2;
  // IN
  input clock;
  input reset;
  input [(PORTSIZE_in1*BITSIZE_in1)+(-1):0] in1;
  input [(PORTSIZE_in2*BITSIZE_in2)+(-1):0] in2;
  input [(PORTSIZE_in3*BITSIZE_in3)+(-1):0] in3;
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
  input [(PORTSIZE_dout_a*BITSIZE_dout_a)+(-1):0] dout_a;
  input [(PORTSIZE_dout_b*BITSIZE_dout_b)+(-1):0] dout_b;
  // OUT
  output [(PORTSIZE_out1*BITSIZE_out1)+(-1):0] out1;
  output [(PORTSIZE_Sout_Rdata_ram*BITSIZE_Sout_Rdata_ram)+(-1):0] Sout_Rdata_ram;
  output [PORTSIZE_Sout_DataRdy-1:0] Sout_DataRdy;
  output [(PORTSIZE_proxy_out1*BITSIZE_proxy_out1)+(-1):0] proxy_out1;
  output [(PORTSIZE_memory_addr_a*BITSIZE_memory_addr_a)+(-1):0] memory_addr_a;
  output [(PORTSIZE_memory_addr_b*BITSIZE_memory_addr_b)+(-1):0] memory_addr_b;
  output [(PORTSIZE_din_value_aggregated_swapped*BITSIZE_din_value_aggregated_swapped)+(-1):0] din_value_aggregated_swapped;
  output [(PORTSIZE_be_swapped*BITSIZE_be_swapped)+(-1):0] be_swapped;
  output [PORTSIZE_bram_write-1:0] bram_write;
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
    parameter nbits_byte_offset = n_byte_on_databus==1 ? 1 : $clog2(n_byte_on_databus);
    parameter nbits_address_space_rangesize = $clog2(address_space_rangesize);
  `else
    parameter nbit_addr = BITSIZE_S_addr_ram/*n_bytes ==  1 ? 1 : log2(n_bytes)*/;
    parameter nbits_address_space_rangesize = log2(address_space_rangesize);
    parameter nbits_byte_offset = n_byte_on_databus==1 ? 1 : log2(n_byte_on_databus);
  `endif
   parameter memory_bitsize = 2*BRAM_BITSIZE;
  
  function [n_byte_on_databus*max_n_writes-1:0] CONV;
    input [n_byte_on_databus*max_n_writes-1:0] po2;
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
  
  wire [(PORTSIZE_in2*BITSIZE_in2)+(-1):0] tmp_addr;
  wire [n_byte_on_databus*max_n_writes-1:0] conv_in;
  wire [n_byte_on_databus*max_n_writes-1:0] conv_out;
  wire [PORTSIZE_S_addr_ram-1:0] cs;
  wire [PORTSIZE_S_oe_ram-1:0] oe_ram_cs;
  wire [PORTSIZE_S_we_ram-1:0] we_ram_cs;
  wire [nbit_addr*max_n_rw-1:0] relative_addr;
  wire [memory_bitsize*max_n_writes-1:0] din_value_aggregated;
  wire [memory_bitsize*PORTSIZE_S_Wdata_ram-1:0] S_Wdata_ram_int;
  wire [memory_bitsize*max_n_reads-1:0] out1_shifted;
  wire [memory_bitsize*max_n_reads-1:0] dout;
  wire [nbits_byte_offset*max_n_rw-1:0] byte_offset;
  wire [n_byte_on_databus*max_n_writes-1:0] be;
  
  reg [PORTSIZE_S_we_ram-1:0] we_ram_cs_delayed =0;
  reg [PORTSIZE_S_oe_ram-1:0] oe_ram_cs_delayed =0;
  reg [PORTSIZE_S_oe_ram-1:0] oe_ram_cs_delayed_registered =0;
  reg [PORTSIZE_S_oe_ram-1:0] oe_ram_cs_delayed_registered1 =0;
  reg [max_n_reads-1:0] delayed_swapped_bit =0;
  reg [max_n_reads-1:0] delayed_swapped_bit_registered =0;
  reg [max_n_reads-1:0] delayed_swapped_bit_registered1 =0;
  reg [nbits_byte_offset*max_n_reads-1:0] delayed_byte_offset =0;
  reg [nbits_byte_offset*max_n_reads-1:0] delayed_byte_offset_registered =0;
  reg [nbits_byte_offset*max_n_reads-1:0] delayed_byte_offset_registered1 =0;
  
  generate
  genvar ind2;
  for (ind2=0; ind2<PORTSIZE_in2; ind2=ind2+1)
    begin : Lind2
      assign tmp_addr[(ind2+1)*BITSIZE_in2-1:ind2*BITSIZE_in2] = (proxy_sel_LOAD[ind2]||proxy_sel_STORE[ind2]) ? proxy_in2[(ind2+1)*BITSIZE_proxy_in2-1:ind2*BITSIZE_proxy_in2] : in2[(ind2+1)*BITSIZE_in2-1:ind2*BITSIZE_in2];
    end
  endgenerate
  
  generate
  genvar i2;
    for (i2=0;i2<max_n_reads;i2=i2+1)
    begin : L_copy
        assign dout[(memory_bitsize/2)+memory_bitsize*i2-1:memory_bitsize*i2] = delayed_swapped_bit[i2] ? dout_a[(memory_bitsize/2)*(i2+1)-1:(memory_bitsize/2)*i2] : dout_b[(memory_bitsize/2)*(i2+1)-1:(memory_bitsize/2)*i2];
        assign dout[memory_bitsize*(i2+1)-1:memory_bitsize*i2+(memory_bitsize/2)] = delayed_swapped_bit[i2] ? dout_b[(memory_bitsize/2)*(i2+1)-1:(memory_bitsize/2)*i2] : dout_a[(memory_bitsize/2)*(i2+1)-1:(memory_bitsize/2)*i2];
        always @(posedge clock)
        begin
          if(HIGH_LATENCY == 0)
            delayed_swapped_bit[i2] <= !relative_addr[nbits_byte_offset+i2*nbit_addr-1];
          else if(HIGH_LATENCY == 1)
          begin
            delayed_swapped_bit_registered[i2] <= !relative_addr[nbits_byte_offset+i2*nbit_addr-1];
            delayed_swapped_bit[i2] <= delayed_swapped_bit_registered[i2];
          end
          else
          begin
            delayed_swapped_bit_registered1[i2] <= !relative_addr[nbits_byte_offset+i2*nbit_addr-1];
            delayed_swapped_bit_registered[i2] <= delayed_swapped_bit_registered1[i2];
            delayed_swapped_bit[i2] <= delayed_swapped_bit_registered[i2];
          end
        end
    end
  endgenerate
  
  generate
  genvar i3;
    for (i3=0; i3<PORTSIZE_S_addr_ram; i3=i3+1)
    begin : L3
      if(PRIVATE_MEMORY==0 && USE_SPARSE_MEMORY==0)
        assign cs[i3] = (S_addr_ram[(i3+1)*BITSIZE_S_addr_ram-1:i3*BITSIZE_S_addr_ram] >= (address_space_begin)) && (S_addr_ram[(i3+1)*BITSIZE_S_addr_ram-1:i3*BITSIZE_S_addr_ram] < (address_space_begin+address_space_rangesize));
      else if(PRIVATE_MEMORY==0)
        assign cs[i3] = S_addr_ram[(i3+1)*BITSIZE_S_addr_ram-1:i3*BITSIZE_S_addr_ram+nbits_address_space_rangesize] == address_space_begin[nbit_addr-1:nbits_address_space_rangesize];
      else
        assign cs[i3] = 1'b0;
    end
  endgenerate
  
  generate
  genvar i4;
    for (i4=0; i4<PORTSIZE_S_oe_ram; i4=i4+1)
    begin : L4
      assign oe_ram_cs[i4] = S_oe_ram[i4] & cs[i4];
    end
  endgenerate
  
  generate
  genvar i5;
    for (i5=0; i5<PORTSIZE_S_we_ram; i5=i5+1)
    begin : L5
      assign we_ram_cs[i5] = S_we_ram[i5] & cs[i5];
    end
  endgenerate
  
  generate
  genvar i6;
    for (i6=0; i6<max_n_rw; i6=i6+1)
    begin : L6
      if(PRIVATE_MEMORY==0 && USE_SPARSE_MEMORY==0 && i6< PORTSIZE_S_addr_ram)
        assign relative_addr[(i6+1)*nbit_addr-1:i6*nbit_addr] = ((i6 < max_n_writes && (sel_STORE[i6]==1'b1 || proxy_sel_STORE[i6]==1'b1)) || (i6 < max_n_reads && (sel_LOAD[i6]==1'b1 || proxy_sel_LOAD[i6]==1'b1))) ? tmp_addr[(i6+1)*BITSIZE_in2-1:i6*BITSIZE_in2]-address_space_begin: S_addr_ram[(i6+1)*BITSIZE_S_addr_ram-1:i6*BITSIZE_S_addr_ram]-address_space_begin;
      else if(PRIVATE_MEMORY==0 && i6< PORTSIZE_S_addr_ram)
        assign relative_addr[(i6)*nbit_addr+nbits_address_space_rangesize-1:i6*nbit_addr] = ((i6 < max_n_writes && (sel_STORE[i6]==1'b1 || proxy_sel_STORE[i6]==1'b1)) || (i6 < max_n_reads && (sel_LOAD[i6]==1'b1 || proxy_sel_LOAD[i6]==1'b1))) ? tmp_addr[(i6)*BITSIZE_in2+nbits_address_space_rangesize-1:i6*BITSIZE_in2] : S_addr_ram[(i6)*BITSIZE_S_addr_ram+nbits_address_space_rangesize-1:i6*BITSIZE_S_addr_ram];
      else if(USE_SPARSE_MEMORY==1)
        assign relative_addr[(i6)*nbit_addr+nbits_address_space_rangesize-1:i6*nbit_addr] = tmp_addr[(i6)*BITSIZE_in2+nbits_address_space_rangesize-1:i6*BITSIZE_in2];
      else
        assign relative_addr[(i6+1)*nbit_addr-1:i6*nbit_addr] = tmp_addr[(i6+1)*BITSIZE_in2-1:i6*BITSIZE_in2]-address_space_begin;
    end
  endgenerate
  
  generate
  genvar i7;
    for (i7=0; i7<max_n_rw; i7=i7+1)
    begin : L7_A
      if (n_mem_elements==1)
        assign memory_addr_a[(i7+1)*nbit_read_addr-1:i7*nbit_read_addr] = {nbit_read_addr{1'b0}};
      else
        assign memory_addr_a[(i7+1)*nbit_read_addr-1:i7*nbit_read_addr] = !relative_addr[nbits_byte_offset+i7*nbit_addr-1] ? relative_addr[nbit_read_addr+nbits_byte_offset-1+i7*nbit_addr:nbits_byte_offset+i7*nbit_addr] : (relative_addr[nbit_read_addr+nbits_byte_offset-1+i7*nbit_addr:nbits_byte_offset+i7*nbit_addr-1]+ 1'b1) >> 1;
    end
  endgenerate
  
  generate
    for (i7=0; i7<max_n_rw; i7=i7+1)
    begin : L7_B
      if (n_mem_elements==1)
        assign memory_addr_b[(i7+1)*nbit_read_addr-1:i7*nbit_read_addr] = {nbit_read_addr{1'b0}};
      else
        assign memory_addr_b[(i7+1)*nbit_read_addr-1:i7*nbit_read_addr] = !relative_addr[nbits_byte_offset+i7*nbit_addr-1] ? (relative_addr[nbit_read_addr+nbits_byte_offset-1+i7*nbit_addr:nbits_byte_offset+i7*nbit_addr-1] + 1'b1) >> 1 : relative_addr[nbit_read_addr+nbits_byte_offset-1+i7*nbit_addr:nbits_byte_offset+i7*nbit_addr];
    end
  endgenerate
  
  generate
  genvar i8;
    for (i8=0; i8<max_n_rw; i8=i8+1)
    begin : L8
      if (n_byte_on_databus==2)
        assign byte_offset[(i8+1)*nbits_byte_offset-1:i8*nbits_byte_offset] = {nbits_byte_offset{1'b0}};
      else
        assign byte_offset[(i8+1)*nbits_byte_offset-1:i8*nbits_byte_offset] = {1'b0, relative_addr[nbits_byte_offset+i8*nbit_addr-2:i8*nbit_addr]};
    end
  endgenerate
  
  generate
  genvar i9, i10;
    for (i9=0; i9<max_n_writes; i9=i9+1)
    begin : byte_enable
      if(PRIVATE_MEMORY==0 && i9 < PORTSIZE_S_data_ram_size)
      begin
        assign conv_in[(i9+1)*n_byte_on_databus-1:i9*n_byte_on_databus] = proxy_sel_STORE[i9] ? proxy_in3[BITSIZE_proxy_in3+BITSIZE_proxy_in3*i9-1:3+BITSIZE_proxy_in3*i9] : (sel_STORE[i9] ? in3[BITSIZE_in3+BITSIZE_in3*i9-1:3+BITSIZE_in3*i9] : S_data_ram_size[BITSIZE_S_data_ram_size+BITSIZE_S_data_ram_size*i9-1:3+BITSIZE_S_data_ram_size*i9]);
        assign conv_out[(i9+1)*n_byte_on_databus-1:i9*n_byte_on_databus] = CONV(conv_in[(i9+1)*n_byte_on_databus-1:i9*n_byte_on_databus]);
        assign be[(i9+1)*n_byte_on_databus-1:i9*n_byte_on_databus] = conv_out[(i9+1)*n_byte_on_databus-1:i9*n_byte_on_databus] << byte_offset[(i9+1)*nbits_byte_offset-1:i9*nbits_byte_offset];
      end
      else
      begin
        assign conv_in[(i9+1)*n_byte_on_databus-1:i9*n_byte_on_databus] = proxy_sel_STORE[i9] ? proxy_in3[BITSIZE_proxy_in3+BITSIZE_proxy_in3*i9-1:3+BITSIZE_proxy_in3*i9] : in3[BITSIZE_in3+BITSIZE_in3*i9-1:3+BITSIZE_in3*i9];
        assign conv_out[(i9+1)*n_byte_on_databus-1:i9*n_byte_on_databus] = CONV(conv_in[(i9+1)*n_byte_on_databus-1:i9*n_byte_on_databus]);
        assign be[(i9+1)*n_byte_on_databus-1:i9*n_byte_on_databus] = conv_out[(i9+1)*n_byte_on_databus-1:i9*n_byte_on_databus] << byte_offset[(i9+1)*nbits_byte_offset-1:i9*nbits_byte_offset];
      end
    end
  endgenerate
  
  generate
    for (i9=0; i9<max_n_writes; i9=i9+1)
    begin : L9_swapped
      for (i10=0; i10<n_byte_on_databus/2; i10=i10+1)
      begin  : byte_enable_swapped
        assign be_swapped[i10+i9*n_byte_on_databus] = !relative_addr[nbits_byte_offset+i9*nbit_addr-1] ? be[i10+i9*n_byte_on_databus] : be[i10+i9*n_byte_on_databus+n_byte_on_databus/2];
        assign be_swapped[i10+i9*n_byte_on_databus+n_byte_on_databus/2] =  !relative_addr[nbits_byte_offset+i9*nbit_addr-1] ? be[i10+i9*n_byte_on_databus+n_byte_on_databus/2] : be[i10+i9*n_byte_on_databus];
      end
    end
  endgenerate
    
  generate
  genvar i13;
    for (i13=0; i13<PORTSIZE_S_Wdata_ram; i13=i13+1)
    begin : L13
      if (BITSIZE_S_Wdata_ram < memory_bitsize)
        assign S_Wdata_ram_int[memory_bitsize*(i13+1)-1:memory_bitsize*i13] = {{memory_bitsize-BITSIZE_S_Wdata_ram{1'b0}}, S_Wdata_ram[(i13+1)*BITSIZE_S_Wdata_ram-1:BITSIZE_S_Wdata_ram*i13]};
      else
        assign S_Wdata_ram_int[memory_bitsize*(i13+1)-1:memory_bitsize*i13] = S_Wdata_ram[memory_bitsize+BITSIZE_S_Wdata_ram*i13-1:BITSIZE_S_Wdata_ram*i13];
    end
  endgenerate
  
  generate
  genvar i14;
    for (i14=0; i14<max_n_writes; i14=i14+1)
    begin : L14
      if(PRIVATE_MEMORY==0 && i14 < PORTSIZE_S_Wdata_ram)
        assign din_value_aggregated[(i14+1)*memory_bitsize-1:i14*memory_bitsize] = proxy_sel_STORE[i14] ? proxy_in1[(i14+1)*BITSIZE_proxy_in1-1:i14*BITSIZE_proxy_in1] << byte_offset[(i14+1)*nbits_byte_offset-1:i14*nbits_byte_offset]*8 : (sel_STORE[i14] ? in1[(i14+1)*BITSIZE_in1-1:i14*BITSIZE_in1] << byte_offset[(i14+1)*nbits_byte_offset-1:i14*nbits_byte_offset]*8 : S_Wdata_ram_int[memory_bitsize*(i14+1)-1:memory_bitsize*i14] << byte_offset[(i14+1)*nbits_byte_offset-1:i14*nbits_byte_offset]*8);
      else
        assign din_value_aggregated[(i14+1)*memory_bitsize-1:i14*memory_bitsize] = proxy_sel_STORE[i14] ? proxy_in1[(i14+1)*BITSIZE_proxy_in1-1:i14*BITSIZE_proxy_in1] << byte_offset[(i14+1)*nbits_byte_offset-1:i14*nbits_byte_offset]*8 : in1[(i14+1)*BITSIZE_in1-1:i14*BITSIZE_in1] << byte_offset[(i14+1)*nbits_byte_offset-1:i14*nbits_byte_offset]*8;
    end
  endgenerate
  
  generate
    for (i14=0; i14<max_n_writes; i14=i14+1)
    begin : L14_swapped
      assign din_value_aggregated_swapped[(i14)*memory_bitsize+memory_bitsize/2-1:i14*memory_bitsize] = !relative_addr[nbits_byte_offset+i14*nbit_addr-1] ? din_value_aggregated[(i14)*memory_bitsize+memory_bitsize/2-1:i14*memory_bitsize] : din_value_aggregated[(i14+1)*memory_bitsize-1:i14*memory_bitsize+memory_bitsize/2];
      assign din_value_aggregated_swapped[(i14+1)*memory_bitsize-1:i14*memory_bitsize+memory_bitsize/2] = !relative_addr[nbits_byte_offset+i14*nbit_addr-1] ?  din_value_aggregated[(i14+1)*memory_bitsize-1:i14*memory_bitsize+memory_bitsize/2] : din_value_aggregated[(i14)*memory_bitsize+memory_bitsize/2-1:i14*memory_bitsize];
    end
  endgenerate
  
  generate
  genvar i15;
    for (i15=0; i15<max_n_reads; i15=i15+1)
    begin : L15
      assign out1_shifted[(i15+1)*memory_bitsize-1:i15*memory_bitsize] = dout[(i15+1)*memory_bitsize-1:i15*memory_bitsize] >> delayed_byte_offset[(i15+1)*nbits_byte_offset-1:i15*nbits_byte_offset]*8;
    end
  endgenerate
  
  generate
  genvar i20;
    for (i20=0; i20<max_n_reads; i20=i20+1)
    begin : L20
      assign out1[(i20+1)*BITSIZE_out1-1:i20*BITSIZE_out1] = out1_shifted[i20*memory_bitsize+BITSIZE_out1-1:i20*memory_bitsize];
      assign proxy_out1[(i20+1)*BITSIZE_proxy_out1-1:i20*BITSIZE_proxy_out1] = out1_shifted[i20*memory_bitsize+BITSIZE_proxy_out1-1:i20*memory_bitsize];
    end
  endgenerate
  
  generate
  genvar i16;
    for (i16=0; i16<PORTSIZE_S_oe_ram; i16=i16+1)
    begin : L16
      always @(posedge clock )
      begin
        if(reset == 1'b0)
          begin
            oe_ram_cs_delayed[i16] <= 1'b0;
            if(HIGH_LATENCY != 0) oe_ram_cs_delayed_registered[i16] <= 1'b0;
            if(HIGH_LATENCY == 2) oe_ram_cs_delayed_registered1[i16] <= 1'b0;
          end
        else
          if(HIGH_LATENCY == 0)
          begin
            oe_ram_cs_delayed[i16] <= oe_ram_cs[i16] & (!oe_ram_cs_delayed[i16] | BUS_PIPELINED);
          end
          else if(HIGH_LATENCY == 1)
          begin
            oe_ram_cs_delayed_registered[i16] <= oe_ram_cs[i16] & ((!oe_ram_cs_delayed_registered[i16] & !oe_ram_cs_delayed[i16]) | BUS_PIPELINED);
            oe_ram_cs_delayed[i16] <= oe_ram_cs_delayed_registered[i16];
          end
          else
          begin
            oe_ram_cs_delayed_registered1[i16] <= oe_ram_cs[i16] & ((!oe_ram_cs_delayed_registered1[i16] & !oe_ram_cs_delayed_registered[i16] & !oe_ram_cs_delayed[i16]) | BUS_PIPELINED);
            oe_ram_cs_delayed_registered[i16] <= oe_ram_cs_delayed_registered1[i16];
            oe_ram_cs_delayed[i16] <= oe_ram_cs_delayed_registered[i16];
          end
        end
      end
  endgenerate
  
  always @(posedge clock)
  begin
    if(HIGH_LATENCY == 0)
      delayed_byte_offset <= byte_offset[nbits_byte_offset*max_n_reads-1:0];
    else if(HIGH_LATENCY == 1)
    begin
      delayed_byte_offset_registered <= byte_offset[nbits_byte_offset*max_n_reads-1:0];
      delayed_byte_offset <= delayed_byte_offset_registered;
    end
    else
    begin
      delayed_byte_offset_registered1 <= byte_offset[nbits_byte_offset*max_n_reads-1:0];
      delayed_byte_offset_registered <= delayed_byte_offset_registered1;
      delayed_byte_offset <= delayed_byte_offset_registered;
    end
  end
  
  
  generate
  genvar i17;
    for (i17=0; i17<PORTSIZE_S_we_ram; i17=i17+1)
    begin : L17
      always @(posedge clock )
      begin
        if(reset == 1'b0)
          we_ram_cs_delayed[i17] <= 1'b0;
        else
          we_ram_cs_delayed[i17] <= we_ram_cs[i17] & !we_ram_cs_delayed[i17];
      end
    end
  endgenerate
  
  generate
  genvar i18;
    for (i18=0; i18<PORTSIZE_Sout_Rdata_ram; i18=i18+1)
    begin : L18
      if(PRIVATE_MEMORY==1)
        assign Sout_Rdata_ram[(i18+1)*BITSIZE_Sout_Rdata_ram-1:i18*BITSIZE_Sout_Rdata_ram] = Sin_Rdata_ram[(i18+1)*BITSIZE_Sin_Rdata_ram-1:i18*BITSIZE_Sin_Rdata_ram];
      else if (BITSIZE_Sout_Rdata_ram <= memory_bitsize)
        assign Sout_Rdata_ram[(i18+1)*BITSIZE_Sout_Rdata_ram-1:i18*BITSIZE_Sout_Rdata_ram] = oe_ram_cs_delayed[i18] ? out1_shifted[BITSIZE_Sout_Rdata_ram+i18*memory_bitsize-1:i18*memory_bitsize] : Sin_Rdata_ram[(i18+1)*BITSIZE_Sin_Rdata_ram-1:i18*BITSIZE_Sin_Rdata_ram];
      else
        assign Sout_Rdata_ram[(i18+1)*BITSIZE_Sout_Rdata_ram-1:i18*BITSIZE_Sout_Rdata_ram] = oe_ram_cs_delayed[i18] ? {{BITSIZE_S_Wdata_ram-memory_bitsize{1'b0}}, out1_shifted[(i18+1)*memory_bitsize-1:i18*memory_bitsize]} : Sin_Rdata_ram[(i18+1)*BITSIZE_Sin_Rdata_ram-1:i18*BITSIZE_Sin_Rdata_ram];
    end
  endgenerate
  
  generate
  genvar i19;
    for (i19=0; i19<PORTSIZE_Sout_DataRdy; i19=i19+1)
    begin : L19
      if(PRIVATE_MEMORY==0)
        assign Sout_DataRdy[i19] = (i19 < PORTSIZE_S_oe_ram && oe_ram_cs_delayed[i19]) | Sin_DataRdy[i19] | (i19 < PORTSIZE_S_we_ram && we_ram_cs_delayed[i19]);
      else
        assign Sout_DataRdy[i19] = Sin_DataRdy[i19];
    end
  endgenerate
  
  generate
  genvar i21;
    for (i21=0; i21<PORTSIZE_bram_write; i21=i21+1)
    begin : L21
      if(i21 < PORTSIZE_S_we_ram)
        assign bram_write[i21] = (sel_STORE[i21] || proxy_sel_STORE[i21] || we_ram_cs[i21]);
      else
        assign bram_write[i21] = (sel_STORE[i21] || proxy_sel_STORE[i21]);
    end
    endgenerate

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2016-2022 Politecnico di Milano
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
// Copyright (C) 2016-2022 Politecnico di Milano
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
// Copyright (C) 2016-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module BRAM_MEMORY_NN_CORE(clock,
  bram_write,
  memory_addr_a,
  din_value_aggregated_swapped,
  be_swapped,
  dout_a);
  parameter BITSIZE_bram_write=1, PORTSIZE_bram_write=2,
    BITSIZE_dout_a=1, PORTSIZE_dout_a=2,
    BITSIZE_memory_addr_a=1, PORTSIZE_memory_addr_a=2,
    BITSIZE_din_value_aggregated_swapped=1, PORTSIZE_din_value_aggregated_swapped=2,
    BITSIZE_be_swapped=1, PORTSIZE_be_swapped=2,
    MEMORY_INIT_file="array.mem",
    BRAM_BITSIZE=32,
    n_bytes=32,
    n_byte_on_databus=4,
    n_mem_elements=4,
    max_n_reads=2,
    max_n_writes=2,
    memory_offset=16,
    n_byte_on_databus_offset=2,
    HIGH_LATENCY=0;
  // IN
  input clock;
  input [PORTSIZE_bram_write-1:0] bram_write;
  input [(PORTSIZE_memory_addr_a*BITSIZE_memory_addr_a)+(-1):0] memory_addr_a;
  input [(PORTSIZE_din_value_aggregated_swapped*BITSIZE_din_value_aggregated_swapped)+(-1):0] din_value_aggregated_swapped;
  input [(PORTSIZE_be_swapped*BITSIZE_be_swapped)+(-1):0] be_swapped;
  // OUT
  output [(PORTSIZE_dout_a*BITSIZE_dout_a)+(-1):0] dout_a;
  
  generate
  if(n_mem_elements == 1)
  begin
    BRAM_MEMORY_CORE_SMALL #(.BITSIZE_memory_addr_a(BITSIZE_memory_addr_a), .BITSIZE_memory_addr_b(BITSIZE_memory_addr_a), .BITSIZE_din_value_aggregated((n_byte_on_databus)*8), .BITSIZE_be(n_byte_on_databus), .BITSIZE_dout_a((n_byte_on_databus/2)*8), .BITSIZE_dout_b((n_byte_on_databus/2)*8), .MEMORY_INIT_file(MEMORY_INIT_file), .n_byte_on_databus(n_byte_on_databus/2), .n_mem_elements(n_mem_elements), .n_bytes(n_bytes), .HIGH_LATENCY(HIGH_LATENCY)) BRAM_MEMORY_instance_small (.clock(clock), .bram_write0(bram_write[0]), .bram_write1(bram_write[1]), .memory_addr_a(memory_addr_a[BITSIZE_memory_addr_a-1:0]), .memory_addr_b(memory_addr_a[2*BITSIZE_memory_addr_a-1:BITSIZE_memory_addr_a]), .din_value_aggregated({din_value_aggregated_swapped[2*BRAM_BITSIZE+(n_byte_on_databus/2)*8+memory_offset-1:2*BRAM_BITSIZE+memory_offset],din_value_aggregated_swapped[(n_byte_on_databus/2)*8+memory_offset-1:memory_offset]}), .be({be_swapped[n_byte_on_databus+n_byte_on_databus/2+n_byte_on_databus_offset-1:n_byte_on_databus+n_byte_on_databus_offset],be_swapped[n_byte_on_databus/2+n_byte_on_databus_offset-1:n_byte_on_databus_offset]}), .dout_a(dout_a[BRAM_BITSIZE-1:0]), .dout_b(dout_a[2*BRAM_BITSIZE-1:BRAM_BITSIZE]));
  end
  else
  begin
    TRUE_DUAL_PORT_BYTE_ENABLING_RAM #(.BITSIZE_memory_addr_a(BITSIZE_memory_addr_a), .BITSIZE_memory_addr_b(BITSIZE_memory_addr_a), .BITSIZE_din_value_aggregated((n_byte_on_databus)*8), .BITSIZE_be(n_byte_on_databus), .BITSIZE_dout_a((n_byte_on_databus/2)*8), .BITSIZE_dout_b((n_byte_on_databus/2)*8), .MEMORY_INIT_file(MEMORY_INIT_file), .BRAM_BITSIZE(BRAM_BITSIZE), .n_byte_on_databus(n_byte_on_databus/2), .n_mem_elements(n_mem_elements), .HIGH_LATENCY(HIGH_LATENCY)) TRUE_DUAL_PORT_BYTE_ENABLING_RAM_instance (.clock(clock), .bram_write0(bram_write[0]), .bram_write1(bram_write[1]), .memory_addr_a(memory_addr_a[BITSIZE_memory_addr_a-1:0]), .memory_addr_b(memory_addr_a[2*BITSIZE_memory_addr_a-1:BITSIZE_memory_addr_a]), .din_value_aggregated({din_value_aggregated_swapped[2*BRAM_BITSIZE+(n_byte_on_databus/2)*8+memory_offset-1:2*BRAM_BITSIZE+memory_offset],din_value_aggregated_swapped[(n_byte_on_databus/2)*8+memory_offset-1:memory_offset]}), .be({be_swapped[n_byte_on_databus+n_byte_on_databus/2+n_byte_on_databus_offset-1:n_byte_on_databus+n_byte_on_databus_offset],be_swapped[n_byte_on_databus/2+n_byte_on_databus_offset-1:n_byte_on_databus_offset]}), .dout_a(dout_a[BRAM_BITSIZE-1:0]), .dout_b(dout_a[2*BRAM_BITSIZE-1:BRAM_BITSIZE]));
  end
  endgenerate

endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ARRAY_1D_STD_BRAM_NN_SP(clock,
  reset,
  in1,
  in2,
  in3,
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
    MEMORY_INIT_file_a="array_a.mem",
    MEMORY_INIT_file_b="array_b.mem",
    n_elements=1,
    data_size=32,
    address_space_begin=0,
    address_space_rangesize=4,
    BUS_PIPELINED=1,
    BRAM_BITSIZE=32,
    PRIVATE_MEMORY=0,
    USE_SPARSE_MEMORY=1,
    HIGH_LATENCY=0,
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
  parameter n_bytes = (n_elements*data_size)/8;
  parameter memory_bitsize = 2*BRAM_BITSIZE;
  parameter n_byte_on_databus = memory_bitsize/8;
  parameter n_mem_elements = n_bytes/(n_byte_on_databus) + (n_bytes%(n_byte_on_databus) == 0 ? 0 : 1);
  `ifdef _SIM_HAVE_CLOG2
    parameter nbit_read_addr = n_mem_elements == 1 ? 1 : $clog2(n_mem_elements);
  `else
    parameter nbit_read_addr = n_mem_elements == 1 ? 1 : log2(n_mem_elements);
  `endif
  parameter max_n_writes = PORTSIZE_sel_STORE > PORTSIZE_S_we_ram ? PORTSIZE_sel_STORE : PORTSIZE_S_we_ram;
  parameter max_n_reads = PORTSIZE_sel_LOAD > PORTSIZE_S_oe_ram ? PORTSIZE_sel_LOAD : PORTSIZE_S_oe_ram;
  parameter max_n_rw = max_n_writes > max_n_reads ? max_n_writes : max_n_reads;
  
  wire [max_n_writes-1:0] bram_write;
  
  wire [nbit_read_addr*max_n_rw-1:0] memory_addr_a;
  wire [nbit_read_addr*max_n_rw-1:0] memory_addr_b;
  wire [n_byte_on_databus*max_n_writes-1:0] be_swapped;
  
  wire [memory_bitsize*max_n_writes-1:0] din_value_aggregated_swapped;
  wire [(memory_bitsize/2)*max_n_reads-1:0] dout_a;
  wire [(memory_bitsize/2)*max_n_reads-1:0] dout_b;
  
  
  BRAM_MEMORY_NN_CORE #(.PORTSIZE_bram_write(max_n_writes), .BITSIZE_bram_write(1), .BITSIZE_dout_a(memory_bitsize/2), .PORTSIZE_dout_a(max_n_reads), .BITSIZE_memory_addr_a(nbit_read_addr), .PORTSIZE_memory_addr_a(max_n_rw), .BITSIZE_din_value_aggregated_swapped(memory_bitsize), .PORTSIZE_din_value_aggregated_swapped(max_n_writes), .BITSIZE_be_swapped(n_byte_on_databus), .PORTSIZE_be_swapped(max_n_writes), .MEMORY_INIT_file(MEMORY_INIT_file_a), .BRAM_BITSIZE(BRAM_BITSIZE), .n_bytes(n_bytes), .n_byte_on_databus(n_byte_on_databus), .n_mem_elements(n_mem_elements), .max_n_reads(max_n_reads), .max_n_writes(max_n_writes), .memory_offset(0), .n_byte_on_databus_offset(0), .HIGH_LATENCY(HIGH_LATENCY)) BRAM_MEMORY_NN_instance_a(.clock(clock), .bram_write(bram_write), .memory_addr_a(memory_addr_a), .din_value_aggregated_swapped(din_value_aggregated_swapped), .be_swapped(be_swapped), .dout_a(dout_a));
  
  generate
    if (n_bytes > BRAM_BITSIZE/8)
    begin : SECOND_MEMORY
      BRAM_MEMORY_NN_CORE #(.PORTSIZE_bram_write(max_n_writes), .BITSIZE_bram_write(1), .BITSIZE_dout_a((memory_bitsize/2)), .PORTSIZE_dout_a(max_n_reads), .BITSIZE_memory_addr_a(nbit_read_addr), .PORTSIZE_memory_addr_a(max_n_rw), .BITSIZE_din_value_aggregated_swapped(memory_bitsize), .PORTSIZE_din_value_aggregated_swapped(max_n_writes), .BITSIZE_be_swapped(n_byte_on_databus), .PORTSIZE_be_swapped(max_n_writes), .MEMORY_INIT_file(MEMORY_INIT_file_b), .BRAM_BITSIZE(BRAM_BITSIZE), .n_bytes(n_bytes), .n_byte_on_databus(n_byte_on_databus), .n_mem_elements(n_mem_elements), .max_n_reads(max_n_reads), .max_n_writes(max_n_writes), .memory_offset(memory_bitsize/2), .n_byte_on_databus_offset(n_byte_on_databus/2), .HIGH_LATENCY(HIGH_LATENCY)) BRAM_MEMORY_NN_instance_b(.clock(clock), .bram_write(bram_write), .memory_addr_a(memory_addr_b), .din_value_aggregated_swapped(din_value_aggregated_swapped), .be_swapped(be_swapped), .dout_a(dout_b));
    end
  else
    assign dout_b = {(memory_bitsize/2)*max_n_reads{1'b0}};
  endgenerate
  
  ADDRESS_DECODING_LOGIC_NN #(.BITSIZE_in1(BITSIZE_in1), .PORTSIZE_in1(PORTSIZE_in1), .BITSIZE_in2(BITSIZE_in2), .PORTSIZE_in2(PORTSIZE_in2), .BITSIZE_in3(BITSIZE_in3), .PORTSIZE_in3(PORTSIZE_in3), .BITSIZE_sel_LOAD(BITSIZE_sel_LOAD), .PORTSIZE_sel_LOAD(PORTSIZE_sel_LOAD), .BITSIZE_sel_STORE(BITSIZE_sel_STORE), .PORTSIZE_sel_STORE(PORTSIZE_sel_STORE), .BITSIZE_out1(BITSIZE_out1), .PORTSIZE_out1(PORTSIZE_out1), .BITSIZE_S_oe_ram(BITSIZE_S_oe_ram), .PORTSIZE_S_oe_ram(PORTSIZE_S_oe_ram), .BITSIZE_S_we_ram(BITSIZE_S_we_ram), .PORTSIZE_S_we_ram(PORTSIZE_S_we_ram), .BITSIZE_Sin_DataRdy(BITSIZE_Sin_DataRdy), .PORTSIZE_Sin_DataRdy(PORTSIZE_Sin_DataRdy), .BITSIZE_Sout_DataRdy(BITSIZE_Sout_DataRdy), .PORTSIZE_Sout_DataRdy(PORTSIZE_Sout_DataRdy), .BITSIZE_S_addr_ram(BITSIZE_S_addr_ram), .PORTSIZE_S_addr_ram(PORTSIZE_S_addr_ram), .BITSIZE_S_Wdata_ram(BITSIZE_S_Wdata_ram), .PORTSIZE_S_Wdata_ram(PORTSIZE_S_Wdata_ram), .BITSIZE_Sin_Rdata_ram(BITSIZE_Sin_Rdata_ram), .PORTSIZE_Sin_Rdata_ram(PORTSIZE_Sin_Rdata_ram), .BITSIZE_Sout_Rdata_ram(BITSIZE_Sout_Rdata_ram), .PORTSIZE_Sout_Rdata_ram(PORTSIZE_Sout_Rdata_ram), .BITSIZE_S_data_ram_size(BITSIZE_S_data_ram_size), .PORTSIZE_S_data_ram_size(PORTSIZE_S_data_ram_size), .address_space_begin(address_space_begin), .address_space_rangesize(address_space_rangesize), .BUS_PIPELINED(BUS_PIPELINED), .BRAM_BITSIZE(BRAM_BITSIZE), .PRIVATE_MEMORY(PRIVATE_MEMORY), .USE_SPARSE_MEMORY(USE_SPARSE_MEMORY), .HIGH_LATENCY(HIGH_LATENCY), .BITSIZE_proxy_in1(BITSIZE_proxy_in1), .PORTSIZE_proxy_in1(PORTSIZE_proxy_in1), .BITSIZE_proxy_in2(BITSIZE_proxy_in2), .PORTSIZE_proxy_in2(PORTSIZE_proxy_in2), .BITSIZE_proxy_in3(BITSIZE_proxy_in3), .PORTSIZE_proxy_in3(PORTSIZE_proxy_in3), .BITSIZE_proxy_sel_LOAD(BITSIZE_proxy_sel_LOAD), .PORTSIZE_proxy_sel_LOAD(PORTSIZE_proxy_sel_LOAD), .BITSIZE_proxy_sel_STORE(BITSIZE_proxy_sel_STORE), .PORTSIZE_proxy_sel_STORE(PORTSIZE_proxy_sel_STORE), .BITSIZE_proxy_out1(BITSIZE_proxy_out1), .PORTSIZE_proxy_out1(PORTSIZE_proxy_out1), .BITSIZE_dout_a(memory_bitsize/2), .PORTSIZE_dout_a(max_n_reads), .BITSIZE_dout_b(memory_bitsize/2), .PORTSIZE_dout_b(max_n_reads), .BITSIZE_memory_addr_a(nbit_read_addr), .PORTSIZE_memory_addr_a(max_n_rw), .BITSIZE_memory_addr_b(nbit_read_addr), .PORTSIZE_memory_addr_b(max_n_rw), .BITSIZE_din_value_aggregated_swapped(memory_bitsize), .PORTSIZE_din_value_aggregated_swapped(max_n_writes), .BITSIZE_be_swapped(n_byte_on_databus), .PORTSIZE_be_swapped(max_n_writes), .BITSIZE_bram_write(1), .PORTSIZE_bram_write(max_n_writes), .nbit_read_addr(nbit_read_addr), .n_byte_on_databus(n_byte_on_databus), .n_mem_elements(n_mem_elements), .max_n_reads(max_n_reads), .max_n_writes(max_n_writes), .max_n_rw(max_n_rw)) ADDRESS_DECODING_LOGIC_NN_instance (.clock(clock), .reset(reset), .in1(in1), .in2(in2), .in3(in3), .out1(out1), .sel_LOAD(sel_LOAD), .sel_STORE(sel_STORE), .S_oe_ram(S_oe_ram), .S_we_ram(S_we_ram), .S_addr_ram(S_addr_ram), .S_Wdata_ram(S_Wdata_ram), .Sin_Rdata_ram(Sin_Rdata_ram), .Sout_Rdata_ram(Sout_Rdata_ram), .S_data_ram_size(S_data_ram_size), .Sin_DataRdy(Sin_DataRdy), .Sout_DataRdy(Sout_DataRdy), .proxy_in1(proxy_in1), .proxy_in2(proxy_in2), .proxy_in3(proxy_in3), .proxy_sel_LOAD(proxy_sel_LOAD), .proxy_sel_STORE(proxy_sel_STORE), .proxy_out1(proxy_out1), .dout_a(dout_a), .dout_b(dout_b), .memory_addr_a(memory_addr_a), .memory_addr_b(memory_addr_b), .din_value_aggregated_swapped(din_value_aggregated_swapped), .be_swapped(be_swapped), .bram_write(bram_write));
endmodule

// This component is part of the BAMBU/PANDA IP LIBRARY
// Copyright (C) 2004-2022 Politecnico di Milano
// Author(s): Fabrizio Ferrandi <fabrizio.ferrandi@polimi.it>
// License: PANDA_LGPLv3
`timescale 1ns / 1ps
module ARRAY_1D_STD_BRAM_NN(clock,
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
    MEMORY_INIT_file_a="array_a.mem",
    MEMORY_INIT_file_b="array_b.mem",
    n_elements=1,
    data_size=32,
    address_space_begin=0,
    address_space_rangesize=4,
    BUS_PIPELINED=1,
    BRAM_BITSIZE=32,
    PRIVATE_MEMORY=0,
    USE_SPARSE_MEMORY=1,
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
  ARRAY_1D_STD_BRAM_NN_SP #(.BITSIZE_in1(BITSIZE_in1), .PORTSIZE_in1(PORTSIZE_in1), .BITSIZE_in2(BITSIZE_in2), .PORTSIZE_in2(PORTSIZE_in2), .BITSIZE_in3(BITSIZE_in3), .PORTSIZE_in3(PORTSIZE_in3), .BITSIZE_sel_LOAD(BITSIZE_sel_LOAD), .PORTSIZE_sel_LOAD(PORTSIZE_sel_LOAD), .BITSIZE_sel_STORE(BITSIZE_sel_STORE), .PORTSIZE_sel_STORE(PORTSIZE_sel_STORE), .BITSIZE_S_oe_ram(BITSIZE_S_oe_ram), .PORTSIZE_S_oe_ram(PORTSIZE_S_oe_ram), .BITSIZE_S_we_ram(BITSIZE_S_we_ram), .PORTSIZE_S_we_ram(PORTSIZE_S_we_ram), .BITSIZE_out1(BITSIZE_out1), .PORTSIZE_out1(PORTSIZE_out1), .BITSIZE_S_addr_ram(BITSIZE_S_addr_ram), .PORTSIZE_S_addr_ram(PORTSIZE_S_addr_ram), .BITSIZE_S_Wdata_ram(BITSIZE_S_Wdata_ram), .PORTSIZE_S_Wdata_ram(PORTSIZE_S_Wdata_ram), .BITSIZE_Sin_Rdata_ram(BITSIZE_Sin_Rdata_ram), .PORTSIZE_Sin_Rdata_ram(PORTSIZE_Sin_Rdata_ram), .BITSIZE_Sout_Rdata_ram(BITSIZE_Sout_Rdata_ram), .PORTSIZE_Sout_Rdata_ram(PORTSIZE_Sout_Rdata_ram), .BITSIZE_S_data_ram_size(BITSIZE_S_data_ram_size), .PORTSIZE_S_data_ram_size(PORTSIZE_S_data_ram_size), .BITSIZE_Sin_DataRdy(BITSIZE_Sin_DataRdy), .PORTSIZE_Sin_DataRdy(PORTSIZE_Sin_DataRdy), .BITSIZE_Sout_DataRdy(BITSIZE_Sout_DataRdy), .PORTSIZE_Sout_DataRdy(PORTSIZE_Sout_DataRdy), .MEMORY_INIT_file_a(MEMORY_INIT_file_a), .MEMORY_INIT_file_b(MEMORY_INIT_file_b), .n_elements(n_elements), .data_size(data_size), .address_space_begin(address_space_begin), .address_space_rangesize(address_space_rangesize), .BUS_PIPELINED(BUS_PIPELINED), .BRAM_BITSIZE(BRAM_BITSIZE), .PRIVATE_MEMORY(PRIVATE_MEMORY), .USE_SPARSE_MEMORY(USE_SPARSE_MEMORY), .BITSIZE_proxy_in1(BITSIZE_proxy_in1), .PORTSIZE_proxy_in1(PORTSIZE_proxy_in1), .BITSIZE_proxy_in2(BITSIZE_proxy_in2), .PORTSIZE_proxy_in2(PORTSIZE_proxy_in2), .BITSIZE_proxy_in3(BITSIZE_proxy_in3), .PORTSIZE_proxy_in3(PORTSIZE_proxy_in3), .BITSIZE_proxy_sel_LOAD(BITSIZE_proxy_sel_LOAD), .PORTSIZE_proxy_sel_LOAD(PORTSIZE_proxy_sel_LOAD), .BITSIZE_proxy_sel_STORE(BITSIZE_proxy_sel_STORE), .PORTSIZE_proxy_sel_STORE(PORTSIZE_proxy_sel_STORE), .BITSIZE_proxy_out1(BITSIZE_proxy_out1), .PORTSIZE_proxy_out1(PORTSIZE_proxy_out1), .HIGH_LATENCY(0)) ARRAY_1D_STD_BRAM_NN_instance (.out1(out1), .Sout_Rdata_ram(Sout_Rdata_ram), .Sout_DataRdy(Sout_DataRdy), .proxy_out1(proxy_out1), .clock(clock), .reset(reset), .in1(in1), .in2(in2), .in3(in3), .sel_LOAD(sel_LOAD & in4), .sel_STORE(sel_STORE & in4), .S_oe_ram(S_oe_ram), .S_we_ram(S_we_ram), .S_addr_ram(S_addr_ram), .S_Wdata_ram(S_Wdata_ram), .Sin_Rdata_ram(Sin_Rdata_ram), .S_data_ram_size(S_data_ram_size), .Sin_DataRdy(Sin_DataRdy), .proxy_in1(proxy_in1), .proxy_in2(proxy_in2), .proxy_in3(proxy_in3), .proxy_sel_LOAD(proxy_sel_LOAD), .proxy_sel_STORE(proxy_sel_STORE));
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
// Copyright (C) 2016-2022 Politecnico di Milano
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
// Copyright (C) 2021-2022 Politecnico di Milano
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
// Copyright (C) 2004-2022 Politecnico di Milano
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

// Datapath RTL description for md5
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module datapath_md5(clock,
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
  fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_STORE,
  fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_STORE,
  fuselector_BMEMORY_CTRLN_24_i0_LOAD,
  fuselector_BMEMORY_CTRLN_24_i0_STORE,
  fuselector_BMEMORY_CTRLN_24_i1_LOAD,
  fuselector_BMEMORY_CTRLN_24_i1_STORE,
  selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0,
  selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1,
  selector_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0,
  selector_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0,
  selector_MUX_33_reg_0_0_0_0,
  selector_MUX_34_reg_1_0_0_0,
  selector_MUX_44_reg_2_0_0_0,
  selector_MUX_45_reg_3_0_0_0,
  selector_MUX_46_reg_4_0_0_0,
  selector_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0,
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
  wrenable_reg_2,
  wrenable_reg_3,
  wrenable_reg_4,
  wrenable_reg_5,
  wrenable_reg_6,
  wrenable_reg_7,
  wrenable_reg_8,
  wrenable_reg_9,
  OUT_CONDITION_md5_424721_425410);
  parameter MEM_var_424832_424721=256,
    MEM_var_425349_424721=256;
  // IN
  input clock;
  input reset;
  input [31:0] in_port_Pd458;
  input [31:0] in_port_Pd459;
  input [63:0] M_Rdata_ram;
  input [1:0] M_DataRdy;
  input [1:0] Min_oe_ram;
  input [1:0] Min_we_ram;
  input [63:0] Min_addr_ram;
  input [63:0] Min_Wdata_ram;
  input [11:0] Min_data_ram_size;
  input fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_LOAD;
  input fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_STORE;
  input fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_LOAD;
  input fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_STORE;
  input fuselector_BMEMORY_CTRLN_24_i0_LOAD;
  input fuselector_BMEMORY_CTRLN_24_i0_STORE;
  input fuselector_BMEMORY_CTRLN_24_i1_LOAD;
  input fuselector_BMEMORY_CTRLN_24_i1_STORE;
  input selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0;
  input selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1;
  input selector_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0;
  input selector_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0;
  input selector_MUX_33_reg_0_0_0_0;
  input selector_MUX_34_reg_1_0_0_0;
  input selector_MUX_44_reg_2_0_0_0;
  input selector_MUX_45_reg_3_0_0_0;
  input selector_MUX_46_reg_4_0_0_0;
  input selector_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0;
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
  output OUT_CONDITION_md5_424721_425410;
  // Component and signal declarations
  wire [31:0] null_out_signal_BMEMORY_CTRLN_24_i0_out1_1;
  wire null_out_signal_array_424832_0_Sout_DataRdy_0;
  wire null_out_signal_array_424832_0_Sout_DataRdy_1;
  wire [31:0] null_out_signal_array_424832_0_Sout_Rdata_ram_0;
  wire [31:0] null_out_signal_array_424832_0_Sout_Rdata_ram_1;
  wire [31:0] null_out_signal_array_424832_0_out1_1;
  wire [31:0] null_out_signal_array_424832_0_proxy_out1_0;
  wire [31:0] null_out_signal_array_424832_0_proxy_out1_1;
  wire null_out_signal_array_425349_0_Sout_DataRdy_0;
  wire null_out_signal_array_425349_0_Sout_DataRdy_1;
  wire [31:0] null_out_signal_array_425349_0_Sout_Rdata_ram_0;
  wire [31:0] null_out_signal_array_425349_0_Sout_Rdata_ram_1;
  wire [31:0] null_out_signal_array_425349_0_out1_1;
  wire [31:0] null_out_signal_array_425349_0_proxy_out1_0;
  wire [31:0] null_out_signal_array_425349_0_proxy_out1_1;
  wire [31:0] out_ARRAY_1D_STD_BRAM_NN_0_i0_array_424832_0;
  wire [31:0] out_ARRAY_1D_STD_BRAM_NN_1_i0_array_425349_0;
  wire [3:0] out_ASSIGN_UNSIGNED_FU_14_i0_fu_md5_424721_425320;
  wire [3:0] out_ASSIGN_UNSIGNED_FU_16_i0_fu_md5_424721_425330;
  wire [3:0] out_ASSIGN_UNSIGNED_FU_18_i0_fu_md5_424721_425342;
  wire [31:0] out_BMEMORY_CTRLN_24_i0_BMEMORY_CTRLN_24_i0;
  wire [31:0] out_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0;
  wire [31:0] out_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1;
  wire [31:0] out_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0;
  wire [31:0] out_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0;
  wire [63:0] out_MUX_33_reg_0_0_0_0;
  wire [31:0] out_MUX_34_reg_1_0_0_0;
  wire [31:0] out_MUX_44_reg_2_0_0_0;
  wire [31:0] out_MUX_45_reg_3_0_0_0;
  wire [31:0] out_MUX_46_reg_4_0_0_0;
  wire [31:0] out_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0;
  wire [31:0] out_UUdata_converter_FU_13_i0_fu_md5_424721_424857;
  wire [31:0] out_UUdata_converter_FU_15_i0_fu_md5_424721_424868;
  wire [31:0] out_UUdata_converter_FU_17_i0_fu_md5_424721_424873;
  wire [29:0] out_UUdata_converter_FU_19_i0_fu_md5_424721_424878;
  wire [31:0] out_addr_expr_FU_4_i0_fu_md5_424721_425482;
  wire [31:0] out_addr_expr_FU_6_i0_fu_md5_424721_425488;
  wire out_const_0;
  wire [6:0] out_const_1;
  wire [28:0] out_const_10;
  wire [30:0] out_const_11;
  wire [31:0] out_const_12;
  wire [2:0] out_const_13;
  wire [1:0] out_const_14;
  wire [3:0] out_const_15;
  wire [5:0] out_const_16;
  wire [30:0] out_const_17;
  wire [31:0] out_const_18;
  wire [3:0] out_const_19;
  wire out_const_2;
  wire [7:0] out_const_20;
  wire [31:0] out_const_21;
  wire [8:0] out_const_22;
  wire [8:0] out_const_23;
  wire [1:0] out_const_3;
  wire [2:0] out_const_4;
  wire [3:0] out_const_5;
  wire [4:0] out_const_6;
  wire [5:0] out_const_7;
  wire [6:0] out_const_8;
  wire [27:0] out_const_9;
  wire [4:0] out_conv_out_ARRAY_1D_STD_BRAM_NN_1_i0_array_425349_0_32_5;
  wire [5:0] out_conv_out_const_1_7_6;
  wire [31:0] out_conv_out_const_22_9_32;
  wire [31:0] out_conv_out_const_23_9_32;
  wire [63:0] out_conv_out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0_1_64;
  wire [31:0] out_conv_out_u_assign_conn_obj_1_ASSIGN_UNSIGNED_FU_u_assign_1_31_32;
  wire [31:0] out_conv_out_u_assign_conn_obj_2_ASSIGN_UNSIGNED_FU_u_assign_2_29_32;
  wire out_lut_expr_FU_20_i0_fu_md5_424721_425608;
  wire out_lut_expr_FU_21_i0_fu_md5_424721_425623;
  wire out_read_cond_FU_22_i0_fu_md5_424721_425410;
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
  wire [31:0] out_reg_1_reg_1;
  wire [31:0] out_reg_2_reg_2;
  wire [31:0] out_reg_3_reg_3;
  wire [31:0] out_reg_4_reg_4;
  wire [31:0] out_reg_5_reg_5;
  wire [31:0] out_reg_6_reg_6;
  wire [31:0] out_reg_7_reg_7;
  wire [31:0] out_reg_8_reg_8;
  wire [31:0] out_reg_9_reg_9;
  wire [0:0] out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0;
  wire [30:0] out_u_assign_conn_obj_1_ASSIGN_UNSIGNED_FU_u_assign_1;
  wire [28:0] out_u_assign_conn_obj_2_ASSIGN_UNSIGNED_FU_u_assign_2;
  wire [0:0] out_ui_bit_and_expr_FU_1_0_1_25_i0_fu_md5_424721_425544;
  wire [0:0] out_ui_bit_and_expr_FU_1_0_1_25_i1_fu_md5_424721_425557;
  wire [0:0] out_ui_bit_and_expr_FU_1_0_1_25_i2_fu_md5_424721_425589;
  wire [31:0] out_ui_bit_and_expr_FU_32_32_32_26_i0_fu_md5_424721_424809;
  wire [31:0] out_ui_bit_and_expr_FU_32_32_32_26_i1_fu_md5_424721_424811;
  wire [31:0] out_ui_bit_and_expr_FU_32_32_32_26_i2_fu_md5_424721_424820;
  wire [31:0] out_ui_bit_and_expr_FU_32_32_32_26_i3_fu_md5_424721_424825;
  wire [3:0] out_ui_bit_and_expr_FU_8_0_8_27_i0_fu_md5_424721_425317;
  wire [3:0] out_ui_bit_and_expr_FU_8_0_8_27_i1_fu_md5_424721_425322;
  wire [3:0] out_ui_bit_and_expr_FU_8_0_8_27_i2_fu_md5_424721_425334;
  wire [1:0] out_ui_bit_and_expr_FU_8_0_8_28_i0_fu_md5_424721_425573;
  wire [31:0] out_ui_bit_ior_concat_expr_FU_29_i0_fu_md5_424721_425375;
  wire [31:0] out_ui_bit_ior_concat_expr_FU_29_i1_fu_md5_424721_425376;
  wire [31:0] out_ui_bit_ior_concat_expr_FU_29_i2_fu_md5_424721_425509;
  wire [31:0] out_ui_bit_ior_concat_expr_FU_30_i0_fu_md5_424721_425499;
  wire [31:0] out_ui_bit_ior_expr_FU_32_32_32_31_i0_fu_md5_424721_424794;
  wire [31:0] out_ui_bit_ior_expr_FU_32_32_32_31_i1_fu_md5_424721_424805;
  wire [31:0] out_ui_bit_ior_expr_FU_32_32_32_31_i2_fu_md5_424721_424816;
  wire [31:0] out_ui_bit_xor_expr_FU_32_0_32_32_i0_fu_md5_424721_424797;
  wire [31:0] out_ui_bit_xor_expr_FU_32_0_32_32_i1_fu_md5_424721_424814;
  wire [31:0] out_ui_bit_xor_expr_FU_32_0_32_32_i2_fu_md5_424721_424823;
  wire [31:0] out_ui_bit_xor_expr_FU_32_32_32_33_i0_fu_md5_424721_424790;
  wire [31:0] out_ui_bit_xor_expr_FU_32_32_32_33_i1_fu_md5_424721_424800;
  wire [31:0] out_ui_bit_xor_expr_FU_32_32_32_33_i2_fu_md5_424721_424803;
  wire [29:0] out_ui_cond_expr_FU_32_32_32_32_34_i0_fu_md5_424721_425614;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_34_i1_fu_md5_424721_425617;
  wire [29:0] out_ui_cond_expr_FU_32_32_32_32_34_i2_fu_md5_424721_425620;
  wire [29:0] out_ui_cond_expr_FU_32_32_32_32_34_i3_fu_md5_424721_425626;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_34_i4_fu_md5_424721_425629;
  wire [29:0] out_ui_cond_expr_FU_32_32_32_32_34_i5_fu_md5_424721_425632;
  wire [29:0] out_ui_cond_expr_FU_32_32_32_32_34_i6_fu_md5_424721_425634;
  wire [31:0] out_ui_cond_expr_FU_32_32_32_32_34_i7_fu_md5_424721_425636;
  wire [29:0] out_ui_cond_expr_FU_32_32_32_32_34_i8_fu_md5_424721_425638;
  wire out_ui_eq_expr_FU_64_0_64_35_i0_fu_md5_424721_425478;
  wire [31:0] out_ui_fshl_expr_FU_32_32_32_32_36_i0_fu_md5_424721_424770;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_37_i0_fu_md5_424721_425470;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_37_i1_fu_md5_424721_425472;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_37_i2_fu_md5_424721_425476;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_37_i3_fu_md5_424721_425496;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_37_i4_fu_md5_424721_425570;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_38_i0_fu_md5_424721_425506;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_38_i1_fu_md5_424721_425541;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_38_i2_fu_md5_424721_425554;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_38_i3_fu_md5_424721_425586;
  wire [31:0] out_ui_lshift_expr_FU_32_0_32_39_i0_fu_md5_424721_425513;
  wire out_ui_lt_expr_FU_64_0_64_40_i0_fu_md5_424721_425465;
  wire out_ui_lt_expr_FU_64_0_64_41_i0_fu_md5_424721_425491;
  wire out_ui_lt_expr_FU_64_0_64_42_i0_fu_md5_424721_425501;
  wire [31:0] out_ui_minus_expr_FU_32_32_32_43_i0_fu_md5_424721_425516;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_44_i0_fu_md5_424721_425373;
  wire [31:0] out_ui_plus_expr_FU_32_0_32_45_i0_fu_md5_424721_425374;
  wire [30:0] out_ui_plus_expr_FU_32_0_32_46_i0_fu_md5_424721_425538;
  wire [30:0] out_ui_plus_expr_FU_32_0_32_47_i0_fu_md5_424721_425551;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_48_i0_fu_md5_424721_424767;
  wire [31:0] out_ui_plus_expr_FU_32_32_32_48_i1_fu_md5_424721_424774;
  wire [29:0] out_ui_plus_expr_FU_32_32_32_48_i2_fu_md5_424721_425567;
  wire [30:0] out_ui_plus_expr_FU_32_32_32_48_i3_fu_md5_424721_425583;
  wire [63:0] out_ui_plus_expr_FU_64_0_64_49_i0_fu_md5_424721_424752;
  wire [3:0] out_ui_plus_expr_FU_8_0_8_50_i0_fu_md5_424721_425325;
  wire [3:0] out_ui_plus_expr_FU_8_0_8_51_i0_fu_md5_424721_425337;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_0_32_52_i0_fu_md5_424721_425378;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_0_32_53_i0_fu_md5_424721_425380;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_0_32_54_i0_fu_md5_424721_425382;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_55_i0_fu_md5_424721_424833;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_55_i1_fu_md5_424721_425307;
  wire [31:0] out_ui_pointer_plus_expr_FU_32_32_32_55_i2_fu_md5_424721_425350;
  wire [30:0] out_ui_rshift_expr_FU_32_0_32_56_i0_fu_md5_424721_425534;
  wire [30:0] out_ui_rshift_expr_FU_32_0_32_56_i1_fu_md5_424721_425548;
  wire [30:0] out_ui_rshift_expr_FU_32_0_32_56_i2_fu_md5_424721_425578;
  wire [30:0] out_ui_rshift_expr_FU_32_0_32_56_i3_fu_md5_424721_425581;
  wire [29:0] out_ui_rshift_expr_FU_32_0_32_57_i0_fu_md5_424721_425561;
  wire [29:0] out_ui_rshift_expr_FU_32_0_32_57_i1_fu_md5_424721_425565;
  wire [31:0] out_ui_ternary_plus_expr_FU_32_32_32_32_58_i0_fu_md5_424721_424778;
  wire [31:0] out_ui_view_convert_expr_FU_5_i0_fu_md5_424721_425468;
  wire [31:0] out_ui_view_convert_expr_FU_7_i0_fu_md5_424721_425474;
  wire [31:0] out_vb_assign_conn_obj_3_ASSIGN_VECTOR_BOOL_FU_vb_assign_3;
  wire [31:0] out_vb_assign_conn_obj_4_ASSIGN_VECTOR_BOOL_FU_vb_assign_4;
  wire [31:0] out_vb_assign_conn_obj_5_ASSIGN_VECTOR_BOOL_FU_vb_assign_5;
  wire [31:0] out_vb_assign_conn_obj_6_ASSIGN_VECTOR_BOOL_FU_vb_assign_6;
  
  ASSIGN_UNSIGNED_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) ASSIGN_UNSIGNED_FU_u_assign_0 (.out1(out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0),
    .in1(out_const_0));
  ASSIGN_UNSIGNED_FU #(.BITSIZE_in1(31),
    .BITSIZE_out1(31)) ASSIGN_UNSIGNED_FU_u_assign_1 (.out1(out_u_assign_conn_obj_1_ASSIGN_UNSIGNED_FU_u_assign_1),
    .in1(out_const_17));
  ASSIGN_UNSIGNED_FU #(.BITSIZE_in1(29),
    .BITSIZE_out1(29)) ASSIGN_UNSIGNED_FU_u_assign_2 (.out1(out_u_assign_conn_obj_2_ASSIGN_UNSIGNED_FU_u_assign_2),
    .in1(out_const_10));
  ASSIGN_VECTOR_BOOL_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) ASSIGN_VECTOR_BOOL_FU_vb_assign_3 (.out1(out_vb_assign_conn_obj_3_ASSIGN_VECTOR_BOOL_FU_vb_assign_3),
    .in1(out_ui_plus_expr_FU_32_0_32_44_i0_fu_md5_424721_425373));
  ASSIGN_VECTOR_BOOL_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) ASSIGN_VECTOR_BOOL_FU_vb_assign_4 (.out1(out_vb_assign_conn_obj_4_ASSIGN_VECTOR_BOOL_FU_vb_assign_4),
    .in1(out_ui_plus_expr_FU_32_0_32_45_i0_fu_md5_424721_425374));
  ASSIGN_VECTOR_BOOL_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) ASSIGN_VECTOR_BOOL_FU_vb_assign_5 (.out1(out_vb_assign_conn_obj_5_ASSIGN_VECTOR_BOOL_FU_vb_assign_5),
    .in1(out_reg_17_reg_17));
  ASSIGN_VECTOR_BOOL_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) ASSIGN_VECTOR_BOOL_FU_vb_assign_6 (.out1(out_vb_assign_conn_obj_6_ASSIGN_VECTOR_BOOL_FU_vb_assign_6),
    .in1(out_reg_18_reg_18));
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
    .PORTSIZE_Mout_data_ram_size(2)) BMEMORY_CTRLN_24_i0 (.out1({null_out_signal_BMEMORY_CTRLN_24_i0_out1_1,
      out_BMEMORY_CTRLN_24_i0_BMEMORY_CTRLN_24_i0}),
    .Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .clock(clock),
    .in1({out_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0,
      out_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0}),
    .in2({out_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0,
      out_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1}),
    .in3({out_conv_out_const_1_7_6,
      out_conv_out_const_1_7_6}),
    .in4({out_const_2,
      out_const_2}),
    .sel_LOAD({fuselector_BMEMORY_CTRLN_24_i1_LOAD,
      fuselector_BMEMORY_CTRLN_24_i0_LOAD}),
    .sel_STORE({fuselector_BMEMORY_CTRLN_24_i1_STORE,
      fuselector_BMEMORY_CTRLN_24_i0_STORE}),
    .Min_oe_ram(Min_oe_ram),
    .Min_we_ram(Min_we_ram),
    .Min_addr_ram(Min_addr_ram),
    .M_Rdata_ram(M_Rdata_ram),
    .Min_Wdata_ram(Min_Wdata_ram),
    .Min_data_ram_size(Min_data_ram_size),
    .M_DataRdy(M_DataRdy));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_10_BMEMORY_CTRLN_24_i0_1_0_0 (.out1(out_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0),
    .sel(selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0),
    .in1(out_reg_6_reg_6),
    .in2(out_reg_11_reg_11));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_10_BMEMORY_CTRLN_24_i0_1_0_1 (.out1(out_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1),
    .sel(selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1),
    .in1(in_port_Pd459),
    .in2(out_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_13_BMEMORY_CTRLN_24_i1_0_0_0 (.out1(out_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0),
    .sel(selector_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0),
    .in1(out_vb_assign_conn_obj_4_ASSIGN_VECTOR_BOOL_FU_vb_assign_4),
    .in2(out_vb_assign_conn_obj_6_ASSIGN_VECTOR_BOOL_FU_vb_assign_6));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_14_BMEMORY_CTRLN_24_i1_1_0_0 (.out1(out_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0),
    .sel(selector_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0),
    .in1(out_reg_7_reg_7),
    .in2(out_reg_5_reg_5));
  MUX_GATE #(.BITSIZE_in1(64),
    .BITSIZE_in2(64),
    .BITSIZE_out1(64)) MUX_33_reg_0_0_0_0 (.out1(out_MUX_33_reg_0_0_0_0),
    .sel(selector_MUX_33_reg_0_0_0_0),
    .in1(out_conv_out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0_1_64),
    .in2(out_ui_plus_expr_FU_64_0_64_49_i0_fu_md5_424721_424752));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_34_reg_1_0_0_0 (.out1(out_MUX_34_reg_1_0_0_0),
    .sel(selector_MUX_34_reg_1_0_0_0),
    .in1(out_reg_2_reg_2),
    .in2(out_conv_out_u_assign_conn_obj_1_ASSIGN_UNSIGNED_FU_u_assign_1_31_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_44_reg_2_0_0_0 (.out1(out_MUX_44_reg_2_0_0_0),
    .sel(selector_MUX_44_reg_2_0_0_0),
    .in1(out_reg_4_reg_4),
    .in2(out_conv_out_u_assign_conn_obj_2_ASSIGN_UNSIGNED_FU_u_assign_2_29_32));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_45_reg_3_0_0_0 (.out1(out_MUX_45_reg_3_0_0_0),
    .sel(selector_MUX_45_reg_3_0_0_0),
    .in1(out_const_18),
    .in2(out_ui_plus_expr_FU_32_32_32_48_i0_fu_md5_424721_424767));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_46_reg_4_0_0_0 (.out1(out_MUX_46_reg_4_0_0_0),
    .sel(selector_MUX_46_reg_4_0_0_0),
    .in1(out_reg_3_reg_3),
    .in2(out_const_12));
  MUX_GATE #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) MUX_9_BMEMORY_CTRLN_24_i0_0_0_0 (.out1(out_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0),
    .sel(selector_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0),
    .in1(out_vb_assign_conn_obj_3_ASSIGN_VECTOR_BOOL_FU_vb_assign_3),
    .in2(out_vb_assign_conn_obj_5_ASSIGN_VECTOR_BOOL_FU_vb_assign_5));
  ARRAY_1D_STD_BRAM_NN #(.BITSIZE_in1(8),
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
    .BITSIZE_S_oe_ram(1),
    .PORTSIZE_S_oe_ram(2),
    .BITSIZE_S_we_ram(1),
    .PORTSIZE_S_we_ram(2),
    .BITSIZE_out1(32),
    .PORTSIZE_out1(2),
    .BITSIZE_S_addr_ram(32),
    .PORTSIZE_S_addr_ram(2),
    .BITSIZE_S_Wdata_ram(32),
    .PORTSIZE_S_Wdata_ram(2),
    .BITSIZE_Sin_Rdata_ram(32),
    .PORTSIZE_Sin_Rdata_ram(2),
    .BITSIZE_Sout_Rdata_ram(32),
    .PORTSIZE_Sout_Rdata_ram(2),
    .BITSIZE_S_data_ram_size(6),
    .PORTSIZE_S_data_ram_size(2),
    .BITSIZE_Sin_DataRdy(1),
    .PORTSIZE_Sin_DataRdy(2),
    .BITSIZE_Sout_DataRdy(1),
    .PORTSIZE_Sout_DataRdy(2),
    .MEMORY_INIT_file_a("/home/lennart/Documents/bachelor-thesis/hardware-tang/array_ref_424832.mem"),
    .MEMORY_INIT_file_b("/home/lennart/Documents/bachelor-thesis/hardware-tang/0_array_ref_424832.mem"),
    .n_elements(256),
    .data_size(8),
    .address_space_begin(MEM_var_424832_424721),
    .address_space_rangesize(256),
    .BUS_PIPELINED(1),
    .BRAM_BITSIZE(32),
    .PRIVATE_MEMORY(1),
    .USE_SPARSE_MEMORY(1),
    .BITSIZE_proxy_in1(32),
    .PORTSIZE_proxy_in1(2),
    .BITSIZE_proxy_in2(32),
    .PORTSIZE_proxy_in2(2),
    .BITSIZE_proxy_in3(6),
    .PORTSIZE_proxy_in3(2),
    .BITSIZE_proxy_sel_LOAD(1),
    .PORTSIZE_proxy_sel_LOAD(2),
    .BITSIZE_proxy_sel_STORE(1),
    .PORTSIZE_proxy_sel_STORE(2),
    .BITSIZE_proxy_out1(32),
    .PORTSIZE_proxy_out1(2)) array_424832_0 (.out1({null_out_signal_array_424832_0_out1_1,
      out_ARRAY_1D_STD_BRAM_NN_0_i0_array_424832_0}),
    .Sout_Rdata_ram({null_out_signal_array_424832_0_Sout_Rdata_ram_1,
      null_out_signal_array_424832_0_Sout_Rdata_ram_0}),
    .Sout_DataRdy({null_out_signal_array_424832_0_Sout_DataRdy_1,
      null_out_signal_array_424832_0_Sout_DataRdy_0}),
    .proxy_out1({null_out_signal_array_424832_0_proxy_out1_1,
      null_out_signal_array_424832_0_proxy_out1_0}),
    .clock(clock),
    .reset(reset),
    .in1({8'b00000000,
      8'b00000000}),
    .in2({32'b00000000000000000000000000000000,
      out_ui_pointer_plus_expr_FU_32_32_32_55_i0_fu_md5_424721_424833}),
    .in3({6'b000000,
      out_conv_out_const_1_7_6}),
    .in4({1'b0,
      out_const_2}),
    .sel_LOAD({1'b0,
      fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_LOAD}),
    .sel_STORE({1'b0,
      fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_STORE}),
    .S_oe_ram({1'b0,
      1'b0}),
    .S_we_ram({1'b0,
      1'b0}),
    .S_addr_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .S_Wdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .Sin_Rdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .S_data_ram_size({6'b000000,
      6'b000000}),
    .Sin_DataRdy({1'b0,
      1'b0}),
    .proxy_in1({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in2({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in3({6'b000000,
      6'b000000}),
    .proxy_sel_LOAD({1'b0,
      1'b0}),
    .proxy_sel_STORE({1'b0,
      1'b0}));
  ARRAY_1D_STD_BRAM_NN #(.BITSIZE_in1(8),
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
    .BITSIZE_S_oe_ram(1),
    .PORTSIZE_S_oe_ram(2),
    .BITSIZE_S_we_ram(1),
    .PORTSIZE_S_we_ram(2),
    .BITSIZE_out1(32),
    .PORTSIZE_out1(2),
    .BITSIZE_S_addr_ram(32),
    .PORTSIZE_S_addr_ram(2),
    .BITSIZE_S_Wdata_ram(32),
    .PORTSIZE_S_Wdata_ram(2),
    .BITSIZE_Sin_Rdata_ram(32),
    .PORTSIZE_Sin_Rdata_ram(2),
    .BITSIZE_Sout_Rdata_ram(32),
    .PORTSIZE_Sout_Rdata_ram(2),
    .BITSIZE_S_data_ram_size(6),
    .PORTSIZE_S_data_ram_size(2),
    .BITSIZE_Sin_DataRdy(1),
    .PORTSIZE_Sin_DataRdy(2),
    .BITSIZE_Sout_DataRdy(1),
    .PORTSIZE_Sout_DataRdy(2),
    .MEMORY_INIT_file_a("/home/lennart/Documents/bachelor-thesis/hardware-tang/array_ref_425349.mem"),
    .MEMORY_INIT_file_b("/home/lennart/Documents/bachelor-thesis/hardware-tang/0_array_ref_425349.mem"),
    .n_elements(256),
    .data_size(8),
    .address_space_begin(MEM_var_425349_424721),
    .address_space_rangesize(256),
    .BUS_PIPELINED(1),
    .BRAM_BITSIZE(32),
    .PRIVATE_MEMORY(1),
    .USE_SPARSE_MEMORY(1),
    .BITSIZE_proxy_in1(32),
    .PORTSIZE_proxy_in1(2),
    .BITSIZE_proxy_in2(32),
    .PORTSIZE_proxy_in2(2),
    .BITSIZE_proxy_in3(6),
    .PORTSIZE_proxy_in3(2),
    .BITSIZE_proxy_sel_LOAD(1),
    .PORTSIZE_proxy_sel_LOAD(2),
    .BITSIZE_proxy_sel_STORE(1),
    .PORTSIZE_proxy_sel_STORE(2),
    .BITSIZE_proxy_out1(32),
    .PORTSIZE_proxy_out1(2)) array_425349_0 (.out1({null_out_signal_array_425349_0_out1_1,
      out_ARRAY_1D_STD_BRAM_NN_1_i0_array_425349_0}),
    .Sout_Rdata_ram({null_out_signal_array_425349_0_Sout_Rdata_ram_1,
      null_out_signal_array_425349_0_Sout_Rdata_ram_0}),
    .Sout_DataRdy({null_out_signal_array_425349_0_Sout_DataRdy_1,
      null_out_signal_array_425349_0_Sout_DataRdy_0}),
    .proxy_out1({null_out_signal_array_425349_0_proxy_out1_1,
      null_out_signal_array_425349_0_proxy_out1_0}),
    .clock(clock),
    .reset(reset),
    .in1({8'b00000000,
      8'b00000000}),
    .in2({32'b00000000000000000000000000000000,
      out_ui_pointer_plus_expr_FU_32_32_32_55_i2_fu_md5_424721_425350}),
    .in3({6'b000000,
      out_conv_out_const_1_7_6}),
    .in4({1'b0,
      out_const_2}),
    .sel_LOAD({1'b0,
      fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_LOAD}),
    .sel_STORE({1'b0,
      fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_STORE}),
    .S_oe_ram({1'b0,
      1'b0}),
    .S_we_ram({1'b0,
      1'b0}),
    .S_addr_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .S_Wdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .Sin_Rdata_ram({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .S_data_ram_size({6'b000000,
      6'b000000}),
    .Sin_DataRdy({1'b0,
      1'b0}),
    .proxy_in1({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in2({32'b00000000000000000000000000000000,
      32'b00000000000000000000000000000000}),
    .proxy_in3({6'b000000,
      6'b000000}),
    .proxy_sel_LOAD({1'b0,
      1'b0}),
    .proxy_sel_STORE({1'b0,
      1'b0}));
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
  constant_value #(.BITSIZE_out1(2),
    .value(2'b11)) const_14 (.out1(out_const_14));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1100)) const_15 (.out1(out_const_15));
  constant_value #(.BITSIZE_out1(6),
    .value(6'b110000)) const_16 (.out1(out_const_16));
  constant_value #(.BITSIZE_out1(31),
    .value(31'b1100111010001010010001100000001)) const_17 (.out1(out_const_17));
  constant_value #(.BITSIZE_out1(32),
    .value(32'b11101111110011011010101110001001)) const_18 (.out1(out_const_18));
  constant_value #(.BITSIZE_out1(4),
    .value(4'b1111)) const_19 (.out1(out_const_19));
  constant_value #(.BITSIZE_out1(1),
    .value(1'b1)) const_2 (.out1(out_const_2));
  constant_value #(.BITSIZE_out1(8),
    .value(8'b11111110)) const_20 (.out1(out_const_20));
  constant_value #(.BITSIZE_out1(32),
    .value(32'b11111111111111111111111111111111)) const_21 (.out1(out_const_21));
  constant_value #(.BITSIZE_out1(9),
    .value(MEM_var_424832_424721)) const_22 (.out1(out_const_22));
  constant_value #(.BITSIZE_out1(9),
    .value(MEM_var_425349_424721)) const_23 (.out1(out_const_23));
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
    .BITSIZE_out1(5)) conv_out_ARRAY_1D_STD_BRAM_NN_1_i0_array_425349_0_32_5 (.out1(out_conv_out_ARRAY_1D_STD_BRAM_NN_1_i0_array_425349_0_32_5),
    .in1(out_ARRAY_1D_STD_BRAM_NN_1_i0_array_425349_0));
  UUdata_converter_FU #(.BITSIZE_in1(7),
    .BITSIZE_out1(6)) conv_out_const_1_7_6 (.out1(out_conv_out_const_1_7_6),
    .in1(out_const_1));
  UUdata_converter_FU #(.BITSIZE_in1(9),
    .BITSIZE_out1(32)) conv_out_const_22_9_32 (.out1(out_conv_out_const_22_9_32),
    .in1(out_const_22));
  UUdata_converter_FU #(.BITSIZE_in1(9),
    .BITSIZE_out1(32)) conv_out_const_23_9_32 (.out1(out_conv_out_const_23_9_32),
    .in1(out_const_23));
  UUdata_converter_FU #(.BITSIZE_in1(1),
    .BITSIZE_out1(64)) conv_out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0_1_64 (.out1(out_conv_out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0_1_64),
    .in1(out_u_assign_conn_obj_0_ASSIGN_UNSIGNED_FU_u_assign_0));
  UUdata_converter_FU #(.BITSIZE_in1(31),
    .BITSIZE_out1(32)) conv_out_u_assign_conn_obj_1_ASSIGN_UNSIGNED_FU_u_assign_1_31_32 (.out1(out_conv_out_u_assign_conn_obj_1_ASSIGN_UNSIGNED_FU_u_assign_1_31_32),
    .in1(out_u_assign_conn_obj_1_ASSIGN_UNSIGNED_FU_u_assign_1));
  UUdata_converter_FU #(.BITSIZE_in1(29),
    .BITSIZE_out1(32)) conv_out_u_assign_conn_obj_2_ASSIGN_UNSIGNED_FU_u_assign_2_29_32 (.out1(out_conv_out_u_assign_conn_obj_2_ASSIGN_UNSIGNED_FU_u_assign_2_29_32),
    .in1(out_u_assign_conn_obj_2_ASSIGN_UNSIGNED_FU_u_assign_2));
  ui_plus_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(1),
    .BITSIZE_out1(64)) fu_md5_424721_424752 (.out1(out_ui_plus_expr_FU_64_0_64_49_i0_fu_md5_424721_424752),
    .in1(out_reg_0_reg_0),
    .in2(out_const_2));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424767 (.out1(out_ui_plus_expr_FU_32_32_32_48_i0_fu_md5_424721_424767),
    .in1(out_reg_15_reg_15),
    .in2(out_reg_3_reg_3));
  ui_fshl_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_in3(5),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_424721_424770 (.out1(out_ui_fshl_expr_FU_32_32_32_32_36_i0_fu_md5_424721_424770),
    .in1(out_ui_plus_expr_FU_32_32_32_48_i1_fu_md5_424721_424774),
    .in2(out_ui_plus_expr_FU_32_32_32_48_i1_fu_md5_424721_424774),
    .in3(out_reg_13_reg_13));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424774 (.out1(out_ui_plus_expr_FU_32_32_32_48_i1_fu_md5_424721_424774),
    .in1(out_reg_14_reg_14),
    .in2(out_BMEMORY_CTRLN_24_i0_BMEMORY_CTRLN_24_i0));
  ui_ternary_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_md5_424721_424778 (.out1(out_ui_ternary_plus_expr_FU_32_32_32_32_58_i0_fu_md5_424721_424778),
    .in1(out_reg_10_reg_10),
    .in2(out_reg_1_reg_1),
    .in3(out_ARRAY_1D_STD_BRAM_NN_0_i0_array_424832_0));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424790 (.out1(out_ui_bit_xor_expr_FU_32_32_32_33_i0_fu_md5_424721_424790),
    .in1(out_ui_bit_ior_expr_FU_32_32_32_31_i0_fu_md5_424721_424794),
    .in2(out_reg_4_reg_4));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424794 (.out1(out_ui_bit_ior_expr_FU_32_32_32_31_i0_fu_md5_424721_424794),
    .in1(out_reg_3_reg_3),
    .in2(out_ui_bit_xor_expr_FU_32_0_32_32_i0_fu_md5_424721_424797));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424797 (.out1(out_ui_bit_xor_expr_FU_32_0_32_32_i0_fu_md5_424721_424797),
    .in1(out_reg_2_reg_2),
    .in2(out_const_21));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424800 (.out1(out_ui_bit_xor_expr_FU_32_32_32_33_i1_fu_md5_424721_424800),
    .in1(out_ui_bit_xor_expr_FU_32_32_32_33_i2_fu_md5_424721_424803),
    .in2(out_reg_2_reg_2));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424803 (.out1(out_ui_bit_xor_expr_FU_32_32_32_33_i2_fu_md5_424721_424803),
    .in1(out_reg_4_reg_4),
    .in2(out_reg_3_reg_3));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424805 (.out1(out_ui_bit_ior_expr_FU_32_32_32_31_i1_fu_md5_424721_424805),
    .in1(out_ui_bit_and_expr_FU_32_32_32_26_i0_fu_md5_424721_424809),
    .in2(out_ui_bit_and_expr_FU_32_32_32_26_i1_fu_md5_424721_424811));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424809 (.out1(out_ui_bit_and_expr_FU_32_32_32_26_i0_fu_md5_424721_424809),
    .in1(out_reg_2_reg_2),
    .in2(out_reg_3_reg_3));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424811 (.out1(out_ui_bit_and_expr_FU_32_32_32_26_i1_fu_md5_424721_424811),
    .in1(out_reg_4_reg_4),
    .in2(out_ui_bit_xor_expr_FU_32_0_32_32_i1_fu_md5_424721_424814));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424814 (.out1(out_ui_bit_xor_expr_FU_32_0_32_32_i1_fu_md5_424721_424814),
    .in1(out_reg_2_reg_2),
    .in2(out_const_21));
  ui_bit_ior_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424816 (.out1(out_ui_bit_ior_expr_FU_32_32_32_31_i2_fu_md5_424721_424816),
    .in1(out_ui_bit_and_expr_FU_32_32_32_26_i2_fu_md5_424721_424820),
    .in2(out_ui_bit_and_expr_FU_32_32_32_26_i3_fu_md5_424721_424825));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424820 (.out1(out_ui_bit_and_expr_FU_32_32_32_26_i2_fu_md5_424721_424820),
    .in1(out_reg_2_reg_2),
    .in2(out_ui_bit_xor_expr_FU_32_0_32_32_i2_fu_md5_424721_424823));
  ui_bit_xor_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424823 (.out1(out_ui_bit_xor_expr_FU_32_0_32_32_i2_fu_md5_424721_424823),
    .in1(out_reg_3_reg_3),
    .in2(out_const_21));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_424825 (.out1(out_ui_bit_and_expr_FU_32_32_32_26_i3_fu_md5_424721_424825),
    .in1(out_reg_4_reg_4),
    .in2(out_reg_3_reg_3));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_md5_424721_424833 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_55_i0_fu_md5_424721_424833),
    .in1(out_reg_8_reg_8),
    .in2(out_ui_lshift_expr_FU_32_0_32_37_i0_fu_md5_424721_425470));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(32)) fu_md5_424721_424857 (.out1(out_UUdata_converter_FU_13_i0_fu_md5_424721_424857),
    .in1(out_reg_0_reg_0));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(32)) fu_md5_424721_424868 (.out1(out_UUdata_converter_FU_15_i0_fu_md5_424721_424868),
    .in1(out_reg_0_reg_0));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(32)) fu_md5_424721_424873 (.out1(out_UUdata_converter_FU_17_i0_fu_md5_424721_424873),
    .in1(out_reg_0_reg_0));
  UUdata_converter_FU #(.BITSIZE_in1(64),
    .BITSIZE_out1(30)) fu_md5_424721_424878 (.out1(out_UUdata_converter_FU_19_i0_fu_md5_424721_424878),
    .in1(out_reg_0_reg_0));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_md5_424721_425307 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_55_i1_fu_md5_424721_425307),
    .in1(in_port_Pd458),
    .in2(out_ui_lshift_expr_FU_32_0_32_37_i1_fu_md5_424721_425472));
  ui_bit_and_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(4),
    .BITSIZE_out1(4)) fu_md5_424721_425317 (.out1(out_ui_bit_and_expr_FU_8_0_8_27_i0_fu_md5_424721_425317),
    .in1(out_ASSIGN_UNSIGNED_FU_14_i0_fu_md5_424721_425320),
    .in2(out_const_19));
  ASSIGN_UNSIGNED_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(4)) fu_md5_424721_425320 (.out1(out_ASSIGN_UNSIGNED_FU_14_i0_fu_md5_424721_425320),
    .in1(out_ui_minus_expr_FU_32_32_32_43_i0_fu_md5_424721_425516));
  ui_bit_and_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(4),
    .BITSIZE_out1(4)) fu_md5_424721_425322 (.out1(out_ui_bit_and_expr_FU_8_0_8_27_i1_fu_md5_424721_425322),
    .in1(out_ui_plus_expr_FU_8_0_8_50_i0_fu_md5_424721_425325),
    .in2(out_const_19));
  ui_plus_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(3),
    .BITSIZE_out1(4)) fu_md5_424721_425325 (.out1(out_ui_plus_expr_FU_8_0_8_50_i0_fu_md5_424721_425325),
    .in1(out_ASSIGN_UNSIGNED_FU_16_i0_fu_md5_424721_425330),
    .in2(out_const_13));
  ASSIGN_UNSIGNED_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(4)) fu_md5_424721_425330 (.out1(out_ASSIGN_UNSIGNED_FU_16_i0_fu_md5_424721_425330),
    .in1(out_ui_bit_ior_concat_expr_FU_29_i2_fu_md5_424721_425509));
  ui_bit_and_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(4),
    .BITSIZE_out1(4)) fu_md5_424721_425334 (.out1(out_ui_bit_and_expr_FU_8_0_8_27_i2_fu_md5_424721_425334),
    .in1(out_ui_plus_expr_FU_8_0_8_51_i0_fu_md5_424721_425337),
    .in2(out_const_19));
  ui_plus_expr_FU #(.BITSIZE_in1(4),
    .BITSIZE_in2(1),
    .BITSIZE_out1(4)) fu_md5_424721_425337 (.out1(out_ui_plus_expr_FU_8_0_8_51_i0_fu_md5_424721_425337),
    .in1(out_ASSIGN_UNSIGNED_FU_18_i0_fu_md5_424721_425342),
    .in2(out_const_2));
  ASSIGN_UNSIGNED_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(4)) fu_md5_424721_425342 (.out1(out_ASSIGN_UNSIGNED_FU_18_i0_fu_md5_424721_425342),
    .in1(out_ui_bit_ior_concat_expr_FU_30_i0_fu_md5_424721_425499));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_md5_424721_425350 (.out1(out_ui_pointer_plus_expr_FU_32_32_32_55_i2_fu_md5_424721_425350),
    .in1(out_reg_9_reg_9),
    .in2(out_ui_lshift_expr_FU_32_0_32_37_i2_fu_md5_424721_425476));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(31),
    .BITSIZE_out1(32)) fu_md5_424721_425373 (.out1(out_ui_plus_expr_FU_32_0_32_44_i0_fu_md5_424721_425373),
    .in1(out_reg_2_reg_2),
    .in2(out_const_17));
  ui_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_425374 (.out1(out_ui_plus_expr_FU_32_0_32_45_i0_fu_md5_424721_425374),
    .in1(out_reg_16_reg_16),
    .in2(out_const_18));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_in3(1),
    .BITSIZE_out1(32),
    .OFFSET_PARAMETER(1)) fu_md5_424721_425375 (.out1(out_ui_bit_ior_concat_expr_FU_29_i0_fu_md5_424721_425375),
    .in1(out_ui_lshift_expr_FU_32_0_32_38_i1_fu_md5_424721_425541),
    .in2(out_ui_bit_and_expr_FU_1_0_1_25_i0_fu_md5_424721_425544),
    .in3(out_const_2));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_in3(1),
    .BITSIZE_out1(32),
    .OFFSET_PARAMETER(1)) fu_md5_424721_425376 (.out1(out_ui_bit_ior_concat_expr_FU_29_i1_fu_md5_424721_425376),
    .in1(out_ui_lshift_expr_FU_32_0_32_38_i2_fu_md5_424721_425554),
    .in2(out_ui_bit_and_expr_FU_1_0_1_25_i1_fu_md5_424721_425557),
    .in3(out_const_2));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(3),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_md5_424721_425378 (.out1(out_ui_pointer_plus_expr_FU_32_0_32_52_i0_fu_md5_424721_425378),
    .in1(in_port_Pd459),
    .in2(out_const_4));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_md5_424721_425380 (.out1(out_ui_pointer_plus_expr_FU_32_0_32_53_i0_fu_md5_424721_425380),
    .in1(in_port_Pd459),
    .in2(out_const_5));
  ui_pointer_plus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(4),
    .BITSIZE_out1(32),
    .LSB_PARAMETER(0)) fu_md5_424721_425382 (.out1(out_ui_pointer_plus_expr_FU_32_0_32_54_i0_fu_md5_424721_425382),
    .in1(in_port_Pd459),
    .in2(out_const_15));
  read_cond_FU #(.BITSIZE_in1(1)) fu_md5_424721_425410 (.out1(out_read_cond_FU_22_i0_fu_md5_424721_425410),
    .in1(out_reg_12_reg_12));
  ui_lt_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(5),
    .BITSIZE_out1(1)) fu_md5_424721_425465 (.out1(out_ui_lt_expr_FU_64_0_64_40_i0_fu_md5_424721_425465),
    .in1(out_reg_0_reg_0),
    .in2(out_const_6));
  ui_view_convert_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_md5_424721_425468 (.out1(out_ui_view_convert_expr_FU_5_i0_fu_md5_424721_425468),
    .in1(out_addr_expr_FU_4_i0_fu_md5_424721_425482));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_424721_425470 (.out1(out_ui_lshift_expr_FU_32_0_32_37_i0_fu_md5_424721_425470),
    .in1(out_ui_cond_expr_FU_32_32_32_32_34_i6_fu_md5_424721_425634),
    .in2(out_const_3));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_424721_425472 (.out1(out_ui_lshift_expr_FU_32_0_32_37_i1_fu_md5_424721_425472),
    .in1(out_ui_cond_expr_FU_32_32_32_32_34_i8_fu_md5_424721_425638),
    .in2(out_const_3));
  ui_view_convert_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_md5_424721_425474 (.out1(out_ui_view_convert_expr_FU_7_i0_fu_md5_424721_425474),
    .in1(out_addr_expr_FU_6_i0_fu_md5_424721_425488));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_424721_425476 (.out1(out_ui_lshift_expr_FU_32_0_32_37_i2_fu_md5_424721_425476),
    .in1(out_ui_cond_expr_FU_32_32_32_32_34_i6_fu_md5_424721_425634),
    .in2(out_const_3));
  ui_eq_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(7),
    .BITSIZE_out1(1)) fu_md5_424721_425478 (.out1(out_ui_eq_expr_FU_64_0_64_35_i0_fu_md5_424721_425478),
    .in1(out_ui_plus_expr_FU_64_0_64_49_i0_fu_md5_424721_424752),
    .in2(out_const_8));
  addr_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_md5_424721_425482 (.out1(out_addr_expr_FU_4_i0_fu_md5_424721_425482),
    .in1(out_conv_out_const_22_9_32));
  addr_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) fu_md5_424721_425488 (.out1(out_addr_expr_FU_6_i0_fu_md5_424721_425488),
    .in1(out_conv_out_const_23_9_32));
  ui_lt_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(6),
    .BITSIZE_out1(1)) fu_md5_424721_425491 (.out1(out_ui_lt_expr_FU_64_0_64_41_i0_fu_md5_424721_425491),
    .in1(out_reg_0_reg_0),
    .in2(out_const_7));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_424721_425496 (.out1(out_ui_lshift_expr_FU_32_0_32_37_i3_fu_md5_424721_425496),
    .in1(out_UUdata_converter_FU_17_i0_fu_md5_424721_424873),
    .in2(out_const_3));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_in3(2),
    .BITSIZE_out1(32),
    .OFFSET_PARAMETER(2)) fu_md5_424721_425499 (.out1(out_ui_bit_ior_concat_expr_FU_30_i0_fu_md5_424721_425499),
    .in1(out_ui_lshift_expr_FU_32_0_32_37_i4_fu_md5_424721_425570),
    .in2(out_ui_bit_and_expr_FU_8_0_8_28_i0_fu_md5_424721_425573),
    .in3(out_const_3));
  ui_lt_expr_FU #(.BITSIZE_in1(64),
    .BITSIZE_in2(6),
    .BITSIZE_out1(1)) fu_md5_424721_425501 (.out1(out_ui_lt_expr_FU_64_0_64_42_i0_fu_md5_424721_425501),
    .in1(out_reg_0_reg_0),
    .in2(out_const_16));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_424721_425506 (.out1(out_ui_lshift_expr_FU_32_0_32_38_i0_fu_md5_424721_425506),
    .in1(out_UUdata_converter_FU_15_i0_fu_md5_424721_424868),
    .in2(out_const_2));
  ui_bit_ior_concat_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_in3(1),
    .BITSIZE_out1(32),
    .OFFSET_PARAMETER(1)) fu_md5_424721_425509 (.out1(out_ui_bit_ior_concat_expr_FU_29_i2_fu_md5_424721_425509),
    .in1(out_ui_lshift_expr_FU_32_0_32_38_i3_fu_md5_424721_425586),
    .in2(out_ui_bit_and_expr_FU_1_0_1_25_i2_fu_md5_424721_425589),
    .in3(out_const_2));
  ui_lshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_424721_425513 (.out1(out_ui_lshift_expr_FU_32_0_32_39_i0_fu_md5_424721_425513),
    .in1(out_UUdata_converter_FU_13_i0_fu_md5_424721_424857),
    .in2(out_const_14));
  ui_minus_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(32),
    .BITSIZE_out1(32)) fu_md5_424721_425516 (.out1(out_ui_minus_expr_FU_32_32_32_43_i0_fu_md5_424721_425516),
    .in1(out_ui_lshift_expr_FU_32_0_32_39_i0_fu_md5_424721_425513),
    .in2(out_UUdata_converter_FU_13_i0_fu_md5_424721_424857));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(31),
    .PRECISION(32)) fu_md5_424721_425534 (.out1(out_ui_rshift_expr_FU_32_0_32_56_i0_fu_md5_424721_425534),
    .in1(out_reg_3_reg_3),
    .in2(out_const_2));
  ui_plus_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(31),
    .BITSIZE_out1(31)) fu_md5_424721_425538 (.out1(out_ui_plus_expr_FU_32_0_32_46_i0_fu_md5_424721_425538),
    .in1(out_ui_rshift_expr_FU_32_0_32_56_i0_fu_md5_424721_425534),
    .in2(out_const_11));
  ui_lshift_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_424721_425541 (.out1(out_ui_lshift_expr_FU_32_0_32_38_i1_fu_md5_424721_425541),
    .in1(out_ui_plus_expr_FU_32_0_32_46_i0_fu_md5_424721_425538),
    .in2(out_const_2));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_md5_424721_425544 (.out1(out_ui_bit_and_expr_FU_1_0_1_25_i0_fu_md5_424721_425544),
    .in1(out_reg_3_reg_3),
    .in2(out_const_2));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(31),
    .PRECISION(32)) fu_md5_424721_425548 (.out1(out_ui_rshift_expr_FU_32_0_32_56_i1_fu_md5_424721_425548),
    .in1(out_reg_4_reg_4),
    .in2(out_const_2));
  ui_plus_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(28),
    .BITSIZE_out1(31)) fu_md5_424721_425551 (.out1(out_ui_plus_expr_FU_32_0_32_47_i0_fu_md5_424721_425551),
    .in1(out_ui_rshift_expr_FU_32_0_32_56_i1_fu_md5_424721_425548),
    .in2(out_const_9));
  ui_lshift_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_424721_425554 (.out1(out_ui_lshift_expr_FU_32_0_32_38_i2_fu_md5_424721_425554),
    .in1(out_ui_plus_expr_FU_32_0_32_47_i0_fu_md5_424721_425551),
    .in2(out_const_2));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_md5_424721_425557 (.out1(out_ui_bit_and_expr_FU_1_0_1_25_i1_fu_md5_424721_425557),
    .in1(out_reg_4_reg_4),
    .in2(out_const_2));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(30),
    .PRECISION(32)) fu_md5_424721_425561 (.out1(out_ui_rshift_expr_FU_32_0_32_57_i0_fu_md5_424721_425561),
    .in1(out_ui_lshift_expr_FU_32_0_32_37_i3_fu_md5_424721_425496),
    .in2(out_const_3));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(30),
    .PRECISION(32)) fu_md5_424721_425565 (.out1(out_ui_rshift_expr_FU_32_0_32_57_i1_fu_md5_424721_425565),
    .in1(out_UUdata_converter_FU_17_i0_fu_md5_424721_424873),
    .in2(out_const_3));
  ui_plus_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(30),
    .BITSIZE_out1(30)) fu_md5_424721_425567 (.out1(out_ui_plus_expr_FU_32_32_32_48_i2_fu_md5_424721_425567),
    .in1(out_ui_rshift_expr_FU_32_0_32_57_i0_fu_md5_424721_425561),
    .in2(out_ui_rshift_expr_FU_32_0_32_57_i1_fu_md5_424721_425565));
  ui_lshift_expr_FU #(.BITSIZE_in1(30),
    .BITSIZE_in2(2),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_424721_425570 (.out1(out_ui_lshift_expr_FU_32_0_32_37_i4_fu_md5_424721_425570),
    .in1(out_ui_plus_expr_FU_32_32_32_48_i2_fu_md5_424721_425567),
    .in2(out_const_3));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(2),
    .BITSIZE_out1(2)) fu_md5_424721_425573 (.out1(out_ui_bit_and_expr_FU_8_0_8_28_i0_fu_md5_424721_425573),
    .in1(out_UUdata_converter_FU_17_i0_fu_md5_424721_424873),
    .in2(out_const_14));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(31),
    .PRECISION(32)) fu_md5_424721_425578 (.out1(out_ui_rshift_expr_FU_32_0_32_56_i2_fu_md5_424721_425578),
    .in1(out_ui_lshift_expr_FU_32_0_32_38_i0_fu_md5_424721_425506),
    .in2(out_const_2));
  ui_rshift_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(31),
    .PRECISION(32)) fu_md5_424721_425581 (.out1(out_ui_rshift_expr_FU_32_0_32_56_i3_fu_md5_424721_425581),
    .in1(out_UUdata_converter_FU_15_i0_fu_md5_424721_424868),
    .in2(out_const_2));
  ui_plus_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(31),
    .BITSIZE_out1(31)) fu_md5_424721_425583 (.out1(out_ui_plus_expr_FU_32_32_32_48_i3_fu_md5_424721_425583),
    .in1(out_ui_rshift_expr_FU_32_0_32_56_i2_fu_md5_424721_425578),
    .in2(out_ui_rshift_expr_FU_32_0_32_56_i3_fu_md5_424721_425581));
  ui_lshift_expr_FU #(.BITSIZE_in1(31),
    .BITSIZE_in2(1),
    .BITSIZE_out1(32),
    .PRECISION(32)) fu_md5_424721_425586 (.out1(out_ui_lshift_expr_FU_32_0_32_38_i3_fu_md5_424721_425586),
    .in1(out_ui_plus_expr_FU_32_32_32_48_i3_fu_md5_424721_425583),
    .in2(out_const_2));
  ui_bit_and_expr_FU #(.BITSIZE_in1(32),
    .BITSIZE_in2(1),
    .BITSIZE_out1(1)) fu_md5_424721_425589 (.out1(out_ui_bit_and_expr_FU_1_0_1_25_i2_fu_md5_424721_425589),
    .in1(out_UUdata_converter_FU_15_i0_fu_md5_424721_424868),
    .in2(out_const_2));
  lut_expr_FU #(.BITSIZE_in1(5),
    .BITSIZE_out1(1)) fu_md5_424721_425608 (.out1(out_lut_expr_FU_20_i0_fu_md5_424721_425608),
    .in1(out_const_6),
    .in2(out_ui_lt_expr_FU_64_0_64_40_i0_fu_md5_424721_425465),
    .in3(out_ui_lt_expr_FU_64_0_64_41_i0_fu_md5_424721_425491),
    .in4(out_ui_lt_expr_FU_64_0_64_42_i0_fu_md5_424721_425501),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(30),
    .BITSIZE_in3(32),
    .BITSIZE_out1(30)) fu_md5_424721_425614 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i0_fu_md5_424721_425614),
    .in1(out_ui_lt_expr_FU_64_0_64_40_i0_fu_md5_424721_425465),
    .in2(out_UUdata_converter_FU_19_i0_fu_md5_424721_424878),
    .in3(out_UUdata_converter_FU_17_i0_fu_md5_424721_424873));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(32),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_md5_424721_425617 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i1_fu_md5_424721_425617),
    .in1(out_ui_lt_expr_FU_64_0_64_40_i0_fu_md5_424721_425465),
    .in2(out_ui_bit_ior_expr_FU_32_32_32_31_i2_fu_md5_424721_424816),
    .in3(out_ui_bit_ior_expr_FU_32_32_32_31_i1_fu_md5_424721_424805));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(30),
    .BITSIZE_in3(4),
    .BITSIZE_out1(30)) fu_md5_424721_425620 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i2_fu_md5_424721_425620),
    .in1(out_ui_lt_expr_FU_64_0_64_40_i0_fu_md5_424721_425465),
    .in2(out_UUdata_converter_FU_19_i0_fu_md5_424721_424878),
    .in3(out_ui_bit_and_expr_FU_8_0_8_27_i2_fu_md5_424721_425334));
  lut_expr_FU #(.BITSIZE_in1(8),
    .BITSIZE_out1(1)) fu_md5_424721_425623 (.out1(out_lut_expr_FU_21_i0_fu_md5_424721_425623),
    .in1(out_const_20),
    .in2(out_ui_lt_expr_FU_64_0_64_40_i0_fu_md5_424721_425465),
    .in3(out_ui_lt_expr_FU_64_0_64_41_i0_fu_md5_424721_425491),
    .in4(out_ui_lt_expr_FU_64_0_64_42_i0_fu_md5_424721_425501),
    .in5(1'b0),
    .in6(1'b0),
    .in7(1'b0),
    .in8(1'b0),
    .in9(1'b0));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(32),
    .BITSIZE_in3(30),
    .BITSIZE_out1(30)) fu_md5_424721_425626 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i3_fu_md5_424721_425626),
    .in1(out_lut_expr_FU_20_i0_fu_md5_424721_425608),
    .in2(out_UUdata_converter_FU_15_i0_fu_md5_424721_424868),
    .in3(out_ui_cond_expr_FU_32_32_32_32_34_i0_fu_md5_424721_425614));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(32),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_md5_424721_425629 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i4_fu_md5_424721_425629),
    .in1(out_lut_expr_FU_20_i0_fu_md5_424721_425608),
    .in2(out_ui_bit_xor_expr_FU_32_32_32_33_i1_fu_md5_424721_424800),
    .in3(out_ui_cond_expr_FU_32_32_32_32_34_i1_fu_md5_424721_425617));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(4),
    .BITSIZE_in3(30),
    .BITSIZE_out1(30)) fu_md5_424721_425632 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i5_fu_md5_424721_425632),
    .in1(out_lut_expr_FU_20_i0_fu_md5_424721_425608),
    .in2(out_ui_bit_and_expr_FU_8_0_8_27_i1_fu_md5_424721_425322),
    .in3(out_ui_cond_expr_FU_32_32_32_32_34_i2_fu_md5_424721_425620));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(30),
    .BITSIZE_in3(32),
    .BITSIZE_out1(30)) fu_md5_424721_425634 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i6_fu_md5_424721_425634),
    .in1(out_lut_expr_FU_21_i0_fu_md5_424721_425623),
    .in2(out_ui_cond_expr_FU_32_32_32_32_34_i3_fu_md5_424721_425626),
    .in3(out_UUdata_converter_FU_13_i0_fu_md5_424721_424857));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(32),
    .BITSIZE_in3(32),
    .BITSIZE_out1(32)) fu_md5_424721_425636 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i7_fu_md5_424721_425636),
    .in1(out_lut_expr_FU_21_i0_fu_md5_424721_425623),
    .in2(out_ui_cond_expr_FU_32_32_32_32_34_i4_fu_md5_424721_425629),
    .in3(out_ui_bit_xor_expr_FU_32_32_32_33_i0_fu_md5_424721_424790));
  ui_cond_expr_FU #(.BITSIZE_in1(1),
    .BITSIZE_in2(30),
    .BITSIZE_in3(4),
    .BITSIZE_out1(30)) fu_md5_424721_425638 (.out1(out_ui_cond_expr_FU_32_32_32_32_34_i8_fu_md5_424721_425638),
    .in1(out_lut_expr_FU_21_i0_fu_md5_424721_425623),
    .in2(out_ui_cond_expr_FU_32_32_32_32_34_i5_fu_md5_424721_425632),
    .in3(out_ui_bit_and_expr_FU_8_0_8_27_i0_fu_md5_424721_425317));
  register_SE #(.BITSIZE_in1(64),
    .BITSIZE_out1(64)) reg_0 (.out1(out_reg_0_reg_0),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_33_reg_0_0_0_0),
    .wenable(wrenable_reg_0));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_1 (.out1(out_reg_1_reg_1),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_34_reg_1_0_0_0),
    .wenable(wrenable_reg_1));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_10 (.out1(out_reg_10_reg_10),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_cond_expr_FU_32_32_32_32_34_i7_fu_md5_424721_425636),
    .wenable(wrenable_reg_10));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_11 (.out1(out_reg_11_reg_11),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_32_32_55_i1_fu_md5_424721_425307),
    .wenable(wrenable_reg_11));
  register_SE #(.BITSIZE_in1(1),
    .BITSIZE_out1(1)) reg_12 (.out1(out_reg_12_reg_12),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_eq_expr_FU_64_0_64_35_i0_fu_md5_424721_425478),
    .wenable(wrenable_reg_12));
  register_STD #(.BITSIZE_in1(5),
    .BITSIZE_out1(5)) reg_13 (.out1(out_reg_13_reg_13),
    .clock(clock),
    .reset(reset),
    .in1(out_conv_out_ARRAY_1D_STD_BRAM_NN_1_i0_array_425349_0_32_5),
    .wenable(wrenable_reg_13));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_14 (.out1(out_reg_14_reg_14),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_ternary_plus_expr_FU_32_32_32_32_58_i0_fu_md5_424721_424778),
    .wenable(wrenable_reg_14));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_15 (.out1(out_reg_15_reg_15),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_fshl_expr_FU_32_32_32_32_36_i0_fu_md5_424721_424770),
    .wenable(wrenable_reg_15));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_16 (.out1(out_reg_16_reg_16),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_plus_expr_FU_32_32_32_48_i0_fu_md5_424721_424767),
    .wenable(wrenable_reg_16));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_17 (.out1(out_reg_17_reg_17),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_bit_ior_concat_expr_FU_29_i0_fu_md5_424721_425375),
    .wenable(wrenable_reg_17));
  register_STD #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_18 (.out1(out_reg_18_reg_18),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_bit_ior_concat_expr_FU_29_i1_fu_md5_424721_425376),
    .wenable(wrenable_reg_18));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_2 (.out1(out_reg_2_reg_2),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_44_reg_2_0_0_0),
    .wenable(wrenable_reg_2));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_3 (.out1(out_reg_3_reg_3),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_45_reg_3_0_0_0),
    .wenable(wrenable_reg_3));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_4 (.out1(out_reg_4_reg_4),
    .clock(clock),
    .reset(reset),
    .in1(out_MUX_46_reg_4_0_0_0),
    .wenable(wrenable_reg_4));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_5 (.out1(out_reg_5_reg_5),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_0_32_52_i0_fu_md5_424721_425378),
    .wenable(wrenable_reg_5));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_6 (.out1(out_reg_6_reg_6),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_0_32_53_i0_fu_md5_424721_425380),
    .wenable(wrenable_reg_6));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_7 (.out1(out_reg_7_reg_7),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_pointer_plus_expr_FU_32_0_32_54_i0_fu_md5_424721_425382),
    .wenable(wrenable_reg_7));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_8 (.out1(out_reg_8_reg_8),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_view_convert_expr_FU_5_i0_fu_md5_424721_425468),
    .wenable(wrenable_reg_8));
  register_SE #(.BITSIZE_in1(32),
    .BITSIZE_out1(32)) reg_9 (.out1(out_reg_9_reg_9),
    .clock(clock),
    .reset(reset),
    .in1(out_ui_view_convert_expr_FU_7_i0_fu_md5_424721_425474),
    .wenable(wrenable_reg_9));
  // io-signal post fix
  assign OUT_CONDITION_md5_424721_425410 = out_read_cond_FU_22_i0_fu_md5_424721_425410;

endmodule

// FSM based controller description for md5
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module controller_md5(done_port,
  fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_STORE,
  fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_LOAD,
  fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_STORE,
  fuselector_BMEMORY_CTRLN_24_i0_LOAD,
  fuselector_BMEMORY_CTRLN_24_i0_STORE,
  fuselector_BMEMORY_CTRLN_24_i1_LOAD,
  fuselector_BMEMORY_CTRLN_24_i1_STORE,
  selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0,
  selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1,
  selector_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0,
  selector_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0,
  selector_MUX_33_reg_0_0_0_0,
  selector_MUX_34_reg_1_0_0_0,
  selector_MUX_44_reg_2_0_0_0,
  selector_MUX_45_reg_3_0_0_0,
  selector_MUX_46_reg_4_0_0_0,
  selector_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0,
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
  wrenable_reg_2,
  wrenable_reg_3,
  wrenable_reg_4,
  wrenable_reg_5,
  wrenable_reg_6,
  wrenable_reg_7,
  wrenable_reg_8,
  wrenable_reg_9,
  OUT_CONDITION_md5_424721_425410,
  clock,
  reset,
  start_port);
  // IN
  input OUT_CONDITION_md5_424721_425410;
  input clock;
  input reset;
  input start_port;
  // OUT
  output done_port;
  output fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_LOAD;
  output fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_STORE;
  output fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_LOAD;
  output fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_STORE;
  output fuselector_BMEMORY_CTRLN_24_i0_LOAD;
  output fuselector_BMEMORY_CTRLN_24_i0_STORE;
  output fuselector_BMEMORY_CTRLN_24_i1_LOAD;
  output fuselector_BMEMORY_CTRLN_24_i1_STORE;
  output selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0;
  output selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1;
  output selector_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0;
  output selector_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0;
  output selector_MUX_33_reg_0_0_0_0;
  output selector_MUX_34_reg_1_0_0_0;
  output selector_MUX_44_reg_2_0_0_0;
  output selector_MUX_45_reg_3_0_0_0;
  output selector_MUX_46_reg_4_0_0_0;
  output selector_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0;
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
  output wrenable_reg_2;
  output wrenable_reg_3;
  output wrenable_reg_4;
  output wrenable_reg_5;
  output wrenable_reg_6;
  output wrenable_reg_7;
  output wrenable_reg_8;
  output wrenable_reg_9;
  parameter [7:0] S_0 = 8'b00000001,
    S_1 = 8'b00000010,
    S_2 = 8'b00000100,
    S_3 = 8'b00001000,
    S_4 = 8'b00010000,
    S_5 = 8'b00100000,
    S_6 = 8'b01000000,
    S_7 = 8'b10000000;
  reg [7:0] _present_state=S_0, _next_state;
  reg done_port;
  reg fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_LOAD;
  reg fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_STORE;
  reg fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_LOAD;
  reg fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_STORE;
  reg fuselector_BMEMORY_CTRLN_24_i0_LOAD;
  reg fuselector_BMEMORY_CTRLN_24_i0_STORE;
  reg fuselector_BMEMORY_CTRLN_24_i1_LOAD;
  reg fuselector_BMEMORY_CTRLN_24_i1_STORE;
  reg selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0;
  reg selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1;
  reg selector_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0;
  reg selector_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0;
  reg selector_MUX_33_reg_0_0_0_0;
  reg selector_MUX_34_reg_1_0_0_0;
  reg selector_MUX_44_reg_2_0_0_0;
  reg selector_MUX_45_reg_3_0_0_0;
  reg selector_MUX_46_reg_4_0_0_0;
  reg selector_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0;
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
    fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_LOAD = 1'b0;
    fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_STORE = 1'b0;
    fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_LOAD = 1'b0;
    fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_STORE = 1'b0;
    fuselector_BMEMORY_CTRLN_24_i0_LOAD = 1'b0;
    fuselector_BMEMORY_CTRLN_24_i0_STORE = 1'b0;
    fuselector_BMEMORY_CTRLN_24_i1_LOAD = 1'b0;
    fuselector_BMEMORY_CTRLN_24_i1_STORE = 1'b0;
    selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0 = 1'b0;
    selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1 = 1'b0;
    selector_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0 = 1'b0;
    selector_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0 = 1'b0;
    selector_MUX_33_reg_0_0_0_0 = 1'b0;
    selector_MUX_34_reg_1_0_0_0 = 1'b0;
    selector_MUX_44_reg_2_0_0_0 = 1'b0;
    selector_MUX_45_reg_3_0_0_0 = 1'b0;
    selector_MUX_46_reg_4_0_0_0 = 1'b0;
    selector_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0 = 1'b0;
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
          selector_MUX_33_reg_0_0_0_0 = 1'b1;
          selector_MUX_45_reg_3_0_0_0 = 1'b1;
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
          fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_LOAD = 1'b1;
          fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_LOAD = 1'b1;
          wrenable_reg_0 = 1'b1;
          wrenable_reg_10 = 1'b1;
          wrenable_reg_11 = 1'b1;
          wrenable_reg_12 = 1'b1;
          _next_state = S_2;
        end
      S_2 :
        begin
          fuselector_BMEMORY_CTRLN_24_i0_LOAD = 1'b1;
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
          selector_MUX_34_reg_1_0_0_0 = 1'b1;
          selector_MUX_44_reg_2_0_0_0 = 1'b1;
          selector_MUX_46_reg_4_0_0_0 = 1'b1;
          wrenable_reg_1 = 1'b1;
          wrenable_reg_16 = 1'b1;
          wrenable_reg_2 = 1'b1;
          wrenable_reg_3 = 1'b1;
          wrenable_reg_4 = 1'b1;
          if (OUT_CONDITION_md5_424721_425410 == 1'b1)
            begin
              _next_state = S_5;
              selector_MUX_34_reg_1_0_0_0 = 1'b0;
              selector_MUX_44_reg_2_0_0_0 = 1'b0;
              selector_MUX_46_reg_4_0_0_0 = 1'b0;
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
          fuselector_BMEMORY_CTRLN_24_i0_STORE = 1'b1;
          fuselector_BMEMORY_CTRLN_24_i1_STORE = 1'b1;
          selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1 = 1'b1;
          selector_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0 = 1'b1;
          selector_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0 = 1'b1;
          wrenable_reg_17 = 1'b1;
          wrenable_reg_18 = 1'b1;
          _next_state = S_6;
        end
      S_6 :
        begin
          fuselector_BMEMORY_CTRLN_24_i0_STORE = 1'b1;
          fuselector_BMEMORY_CTRLN_24_i1_STORE = 1'b1;
          selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0 = 1'b1;
          selector_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0 = 1'b1;
          _next_state = S_7;
          done_port = 1'b1;
        end
      S_7 :
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

// Top component for md5
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module _md5(clock,
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
  wire OUT_CONDITION_md5_424721_425410;
  wire done_delayed_REG_signal_in;
  wire done_delayed_REG_signal_out;
  wire fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_LOAD;
  wire fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_STORE;
  wire fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_LOAD;
  wire fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_STORE;
  wire fuselector_BMEMORY_CTRLN_24_i0_LOAD;
  wire fuselector_BMEMORY_CTRLN_24_i0_STORE;
  wire fuselector_BMEMORY_CTRLN_24_i1_LOAD;
  wire fuselector_BMEMORY_CTRLN_24_i1_STORE;
  wire selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0;
  wire selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1;
  wire selector_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0;
  wire selector_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0;
  wire selector_MUX_33_reg_0_0_0_0;
  wire selector_MUX_34_reg_1_0_0_0;
  wire selector_MUX_44_reg_2_0_0_0;
  wire selector_MUX_45_reg_3_0_0_0;
  wire selector_MUX_46_reg_4_0_0_0;
  wire selector_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0;
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
  wire wrenable_reg_2;
  wire wrenable_reg_3;
  wire wrenable_reg_4;
  wire wrenable_reg_5;
  wire wrenable_reg_6;
  wire wrenable_reg_7;
  wire wrenable_reg_8;
  wire wrenable_reg_9;
  
  controller_md5 Controller_i (.done_port(done_delayed_REG_signal_in),
    .fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_LOAD(fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_STORE(fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_STORE),
    .fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_LOAD(fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_STORE(fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_STORE),
    .fuselector_BMEMORY_CTRLN_24_i0_LOAD(fuselector_BMEMORY_CTRLN_24_i0_LOAD),
    .fuselector_BMEMORY_CTRLN_24_i0_STORE(fuselector_BMEMORY_CTRLN_24_i0_STORE),
    .fuselector_BMEMORY_CTRLN_24_i1_LOAD(fuselector_BMEMORY_CTRLN_24_i1_LOAD),
    .fuselector_BMEMORY_CTRLN_24_i1_STORE(fuselector_BMEMORY_CTRLN_24_i1_STORE),
    .selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0(selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0),
    .selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1(selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1),
    .selector_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0(selector_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0),
    .selector_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0(selector_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0),
    .selector_MUX_33_reg_0_0_0_0(selector_MUX_33_reg_0_0_0_0),
    .selector_MUX_34_reg_1_0_0_0(selector_MUX_34_reg_1_0_0_0),
    .selector_MUX_44_reg_2_0_0_0(selector_MUX_44_reg_2_0_0_0),
    .selector_MUX_45_reg_3_0_0_0(selector_MUX_45_reg_3_0_0_0),
    .selector_MUX_46_reg_4_0_0_0(selector_MUX_46_reg_4_0_0_0),
    .selector_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0(selector_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0),
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
    .wrenable_reg_2(wrenable_reg_2),
    .wrenable_reg_3(wrenable_reg_3),
    .wrenable_reg_4(wrenable_reg_4),
    .wrenable_reg_5(wrenable_reg_5),
    .wrenable_reg_6(wrenable_reg_6),
    .wrenable_reg_7(wrenable_reg_7),
    .wrenable_reg_8(wrenable_reg_8),
    .wrenable_reg_9(wrenable_reg_9),
    .OUT_CONDITION_md5_424721_425410(OUT_CONDITION_md5_424721_425410),
    .clock(clock),
    .reset(reset),
    .start_port(start_port));
  datapath_md5 #(.MEM_var_424832_424721(256),
    .MEM_var_425349_424721(256)) Datapath_i (.Mout_oe_ram(Mout_oe_ram),
    .Mout_we_ram(Mout_we_ram),
    .Mout_addr_ram(Mout_addr_ram),
    .Mout_Wdata_ram(Mout_Wdata_ram),
    .Mout_data_ram_size(Mout_data_ram_size),
    .OUT_CONDITION_md5_424721_425410(OUT_CONDITION_md5_424721_425410),
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
    .fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_LOAD(fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_STORE(fuselector_ARRAY_1D_STD_BRAM_NN_0_i0_STORE),
    .fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_LOAD(fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_LOAD),
    .fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_STORE(fuselector_ARRAY_1D_STD_BRAM_NN_1_i0_STORE),
    .fuselector_BMEMORY_CTRLN_24_i0_LOAD(fuselector_BMEMORY_CTRLN_24_i0_LOAD),
    .fuselector_BMEMORY_CTRLN_24_i0_STORE(fuselector_BMEMORY_CTRLN_24_i0_STORE),
    .fuselector_BMEMORY_CTRLN_24_i1_LOAD(fuselector_BMEMORY_CTRLN_24_i1_LOAD),
    .fuselector_BMEMORY_CTRLN_24_i1_STORE(fuselector_BMEMORY_CTRLN_24_i1_STORE),
    .selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0(selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_0),
    .selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1(selector_MUX_10_BMEMORY_CTRLN_24_i0_1_0_1),
    .selector_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0(selector_MUX_13_BMEMORY_CTRLN_24_i1_0_0_0),
    .selector_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0(selector_MUX_14_BMEMORY_CTRLN_24_i1_1_0_0),
    .selector_MUX_33_reg_0_0_0_0(selector_MUX_33_reg_0_0_0_0),
    .selector_MUX_34_reg_1_0_0_0(selector_MUX_34_reg_1_0_0_0),
    .selector_MUX_44_reg_2_0_0_0(selector_MUX_44_reg_2_0_0_0),
    .selector_MUX_45_reg_3_0_0_0(selector_MUX_45_reg_3_0_0_0),
    .selector_MUX_46_reg_4_0_0_0(selector_MUX_46_reg_4_0_0_0),
    .selector_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0(selector_MUX_9_BMEMORY_CTRLN_24_i0_0_0_0),
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

// Minimal interface for function: md5
// This component has been derived from the input source code and so it does not fall under the copyright of PandA framework, but it follows the input source code copyright, and may be aggregated with components of the BAMBU/PANDA IP LIBRARY.
// Author(s): Component automatically generated by bambu
// License: THIS COMPONENT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
`timescale 1ns / 1ps
module md5(clk,
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
  
  _md5 _md5_i0 (.done_port(done_port),
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


