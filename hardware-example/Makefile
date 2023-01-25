
rot.bin: rot.v rot.pcf
	yosys -q -p "synth_ice40 -json rot.json" rot.v
	nextpnr-ice40 --hx1k --json rot.json --pcf rot.pcf --asc rot.asc
	icepack rot.asc rot.bin

flash: rot.bin
	iceprog rot.bin

clean:
	rm -f rot.json rot.asc rot.bin abc.history
