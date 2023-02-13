module top
    (
        input clk,
        output [5:0] led
    );
    
    reg [23:0] clockCounter = 0;
    localparam WAIT_TIME = 13500000;
    reg [5:0] ledCounter = 0;
    
    always @(posedge clk) begin
        clockCounter <= clockCounter + 1;
        if (clockCounter == WAIT_TIME) begin
            clockCounter <= 0;
            ledCounter <= ledCounter + 1;
        end
    end
    
    assign led = ~ledCounter;
endmodule