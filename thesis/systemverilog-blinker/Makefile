ICARUS_VERILOG = iverilog
VVP = vvp

blinker.vvp: blinker.sv blinker_tb.sv
	$(ICARUS_VERILOG) -g2012 -o blinker.vvp blinker.sv blinker_tb.sv

.PHONY: test

test: blinker.vvp
	$(VVP) blinker.vvp