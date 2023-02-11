SOURCES       := $(shell find . -name '*.v' -not -name '*_tb.v')

PWD = $(shell pwd)
YOSYS     = yosys
NEXTPNR   = nextpnr-gowin
GOWINPACK = gowin_pack

all: top.fs

top.fs: top.pack
	$(GOWINPACK) -d GW1N-9C -o $@ $^

top.pack: top.json
	$(NEXTPNR) --json top.json --write top.pack --device GW1NR-LV9QN88PC6/I5 --family GW1N-9C --cst tangnano.cst

top.json: $(SOURCES)
	$(YOSYS) -p "synth_gowin -json top.json -top top" $(SOURCES)

prog: top.fs
	openFPGALoader -b tangnano $^

clean:
	rm -f *.json *.fs *.pack

.PHONY: %-tangnano-prog clean all