module Blinker (
    input  wire clock,
    output wire blinker
);

  parameter DELAY = 10;
  reg [6:0] counter = 0;
  reg state = 0;

  always @(posedge clock) begin
    counter <= counter + 1;
    if (counter == DELAY - 1) begin
      state   <= ~state;
      counter <= 0;
    end
  end

  assign blinker = state;

endmodule
