`include "md5.v"

module top
    (
        input clk,
        output reg [5:0] led,
        output reg [7:0] logic_analyzer
    );

    initial led = 0;
    initial logic_analyzer = 0;

    reg [7:0] slowCounter = 0;
    always @(posedge clk) begin
        slowCounter <= slowCounter + 1;
    end
    wire slowClock = slowCounter[7];
    
    wire  done;
    wire [1:0] read_enable;
    wire [1:0] write_enable;
    wire [63:0] current_address;
    wire [63:0] current_write_data;
    wire [11:0] current_data_size;

    reg [63:0] current_read_data = 0;

    wire start;
    wire [1:0] data_ready;

    md5 state_test_inst (
        .clk(slowClock),
        .reset(1),
        .start_port(start),
        .Pd458(32'h40000000),
        .Pd459(32'h40000100),
        .Pd460(32'h40000200),
        .M_Rdata_ram(current_read_data),
        .M_DataRdy(data_ready),

        .done_port(done),
        .Mout_oe_ram(read_enable),
        .Mout_we_ram(write_enable),
        .Mout_addr_ram(current_address),
        .Mout_Wdata_ram(current_write_data),
        .Mout_data_ram_size(current_data_size)
    );

    assign data_ready = write_enable != 0 ? 3 : 0;

    reg [10:0] done_countdown;

    reg [1:0] received_correct_hash = 0;

    assign start = done_countdown == 0 && done != 1 ? 1 : 0;

    always @(posedge slowClock) begin
        if(done == 1) begin
            done_countdown <= 200;
        end
        else begin
            if (done_countdown != 0) begin
                done_countdown <= done_countdown - 1;
            end
            else begin
                done_countdown <= 0;
            end
        end

        if (read_enable[0] == 1 & current_address[31:0] == 32'h40000000) begin
            current_read_data[31:0] <= 32'h00000080;
        end
        else begin
            current_read_data[31:0] <= 32'h00000000;
        end

        if (read_enable[1] == 1 & current_address[63:32] == 32'h40000000) begin
            current_read_data[63:32] <= 32'h00000080;
        end
        else begin
            current_read_data[63:32] <= 32'h00000000;
        end

        if (write_enable == 3) begin
            if(current_write_data == 64'h04b2008fd98c1dd4)
                received_correct_hash[0] <= 1;
            else
                received_correct_hash[0] <= received_correct_hash[0];

            if(current_write_data == 64'h7e42f8ec980980e9)
                received_correct_hash[1] <= 1;
            else
                received_correct_hash[1] <= received_correct_hash[1];
        end

        if (received_correct_hash = 2'b11) begin
            led <= 6'b100111;
            done_forever <= 1;
        end
        else begin
            led <= 6'b010000;
            done_forever <= 0;
        end

        if (write_enable != 0) begin
            logic_analyzer <= current_write_data[39:32];
            // logic_analyzer <= current_write_data[7:0];
        end
        else begin
            logic_analyzer <= 8'h00000000;
        end
    end

endmodule
