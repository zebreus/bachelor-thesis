module blinker_tb ();
  reg clock = 1'b0;
  always #1 clock <= ~clock;

  wire blinker;

  Blinker UUT (
      .clock  (clock),
      .blinker(blinker)
  );

  initial begin
    $display("Testing blinker");
    for (int i = 0; i < 20; i++) begin
      assert (blinker == 1'b0);
      #20;
      assert (blinker == 1'b1);
      #20;
    end
    $display("Blinker blinks correctly!");

    $finish();
  end
endmodule
