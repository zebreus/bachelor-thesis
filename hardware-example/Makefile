
rotate.bin: rotate.v rotate.pcf
	yosys -q -p "synth_ice40 -json rotate.json" rotate.v
	nextpnr-ice40 --hx1k --json rotate.json --pcf rotate.pcf --asc rotate.asc
	icepack rotate.asc rotate.bin

flash: rotate.bin
	iceprog rotate.bin

clean:
	rm -f rotate.json rotate.asc rotate.bin abc.history

obj_dir/Vrotate: rotate.v addition.v
	verilator --cc --exe --build --trace -j 0  sim_main.cpp rotate.v

sim: obj_dir/Vrotate
	./obj_dir/Vrotate