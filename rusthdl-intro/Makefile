
PWD = $(shell pwd)

ASCIIDOCTOR = asciidoctor
CARGO = cargo

ASCIIDOC_REQS += blinky.vcd
TARGETS += $(TARGETS_WITHOUT_HTML) index.html

.EXTRA_PREREQS:=Makefile
all: $(TARGETS)

blinky.vcd blinky.v:
	$(CARGO) run

blinky_top.v: blinky.v
	csplit blinky.v /endmodule/1
	rm xx01
	mv xx00 blinky_top.v

index.html: Readme.adoc blinky.vcd blinky_top.v
	$(ASCIIDOCTOR) -r asciidoctor-diagram Readme.adoc -o index.html

clean: 
	rm -rf target blinky.vcd blinky.v blinky_top.v

dist-clean: clean
	rm -rf index.html

.PHONY: dist-clean clean all