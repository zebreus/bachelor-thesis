module counter( clock, count );
  input   clock;
  output  [7:0] count;

  reg     [7:0] internal_counter;
  initial internal_counter = 8'b0;

  assign count = internal_counter;

  always @ (posedge clock)
  begin
    internal_counter <= internal_counter + 1;
  end
 
endmodule