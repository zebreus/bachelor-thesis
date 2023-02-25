`include "mdfive.v"


module top
    (
        input clk,
        output [5:0] led,
        output [7:0] logic_analyzer
    );


    reg [7:0] slowCounter = 0;
    always @(posedge clk) begin
        slowCounter <= slowCounter + 1;
    end
    wire slowClock = slowCounter[7];


    reg [5:0] ledCounterBuffer = 6'b000111;

    wire [5:0] ledCounter;
    reg [30:0] clockCounter = 0;
    
    wire  done;
    wire read_enable;
    wire write_enable;
    wire [63:0] current_address;
    wire [63:0] current_write_data;
    wire [11:0] current_data_size;



    reg [63:0] current_read_data = 0;
    wire data_ready;

    reg [31:0] a = 0;
    reg [31:0] b = 0;
    reg [31:0] c = 0;
    reg [31:0] d = 0;

    mdfive state_test_inst (
        .clk(slowClock),
        .reset(1),
        .start_port(1),
        .Pd458(32'h40000000),
        .Pd459(32'h40000100),
        .M_Rdata_ram(current_read_data),
        .M_DataRdy(data_ready),

        .done_port(done),
        .Mout_oe_ram(read_enable),
        .Mout_we_ram(write_enable),
        .Mout_addr_ram(current_address),
        .Mout_Wdata_ram(current_write_data),
        .Mout_data_ram_size(current_data_size)
    );

    reg got_correct_hash_first_part = 0;
    reg got_correct_hash_second_part = 0;

    always @(posedge slowClock) begin
        if (read_enable == 1) begin
            if (current_address == 63'h0000000040000000) begin
                current_read_data <= 63'h0000000000000080;
            end
            else begin
                current_read_data <= 63'h0000000000000000;

            end
        end
        else begin
            current_read_data <= 63'h0000000000000000;
        end
    end
    
    // Log write enable
    always @(posedge slowClock) begin
        if (write_enable == 1) begin
            logic_analyzer_counter[2] <= 1;
            send_data <= 64'h04b2008fd98c1dd4;
        end
        else begin
            logic_analyzer_counter[2] <= 0;
        end
    end

    reg [63:0] send_data = 64'h04b2008fd98c1dd4;
    reg [63:0] send_data_b = 64'h04b2008fd98c1dd4;
    reg [6:0] current_bit;
    reg send_done;
    reg prepare_sending;

    wire notSoSlowClock = slowCounter[5];

    always begin
            logic_analyzer_counter[6] <= notSoSlowClock;
    end

    wire current_bit_value  = 0;
    always @(posedge notSoSlowClock) begin
        if (send_done) begin
            logic_analyzer_counter[5] <= 1;
        end
        if (!send_done && prepare_sending) begin
            logic_analyzer_counter[5] <= 0;
        end
        if (!send_done && !prepare_sending) begin
            logic_analyzer_counter[5] <= send_data_b[current_bit];
            current_bit <= current_bit + 1;
            if(current_bit == 63) begin
                send_done <= 1;
                current_bit <= 0;
            end
        end
        if (slowClock && write_enable == 1 && send_done) begin
            prepare_sending <= 1;
            send_done <= 0;
        end
    end

    

    // Mark as correct
    always @(posedge slowClock) begin
        if (current_write_data == 64'h04b2008fd98c1dd4) begin
            got_correct_hash_first_part <= 1;
            logic_analyzer_counter[1] <= 1;
        end
        if (current_write_data == 64'h7e42f8ec980980e9) begin
            got_correct_hash_second_part <= 1;
            logic_analyzer_counter[0] <= 1;
        end
    end

    // Enable LEDs, if we got both parts of the correct result
    always @(posedge slowClock) begin
        if (got_correct_hash_first_part == 1 && got_correct_hash_second_part == 1) begin
            ledCounterBuffer <= 6'b010101;
        end
    end
    
    assign led = ledCounterBuffer;

    reg [7:0] logic_analyzer_counter = 0;
    // always @(posedge clk) begin
    //     logic_analyzer_counter <= logic_analyzer_counter + 1;
    // end    

    assign logic_analyzer = logic_analyzer_counter;
endmodule