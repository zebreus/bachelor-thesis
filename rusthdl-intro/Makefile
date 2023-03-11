
PWD = $(shell pwd)
YOSYS     = yosys
NEXTPNR   = nextpnr-gowin
GOWINPACK = gowin_pack

ASCIIDOCTOR = asciidoctor
CARGO = cargo

ASCIIDOC_REQS += blinky.vcd
TARGETS += $(TARGETS_WITHOUT_HTML) index.html

.EXTRA_PREREQS:=Makefile
all: $(TARGETS)

blinky.vcd blinky.v counter.v counter_embedded.v:
	$(CARGO) run

blinky_top.v: blinky.v
	csplit blinky.v /endmodule/1
	rm xx01
	mv xx00 blinky_top.v

index.html: Readme.adoc blinky.vcd blinky_top.v counter_embedded.v src/counter.rs src/counter_embedded.rs
	$(ASCIIDOCTOR) -r asciidoctor-diagram Readme.adoc -o index.html

top-%.fs: top-%.pack
	$(GOWINPACK) -d GW1N-9C -o $@ $^

top-%.pack: top-%.json tangnano.cst
	$(NEXTPNR) --json $< --write $@ --device GW1NR-LV9QN88PC6/I5 --family GW1N-9C --cst tangnano.cst

top-counter.json: counter.v
	$(YOSYS) -p "synth_gowin -json $@ -top top" counter.v

top-counter_embedded.json: counter_embedded.v
	$(YOSYS) -p "synth_gowin -json $@ -top top" counter_embedded.v

prog-%: top-%.fs
	openFPGALoader -b tangnano $^

clean: 
	rm -rf target blinky.vcd blinky.v blinky_top.v

dist-clean: clean
	rm -rf index.html

.PHONY: dist-clean clean all