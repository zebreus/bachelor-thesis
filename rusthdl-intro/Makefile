
PWD = $(shell pwd)

ASCIIDOCTOR = asciidoctor
CARGO = cargo

ASCIIDOC_REQS += blinky.vcd
TARGETS += $(TARGETS_WITHOUT_HTML) index.html

.EXTRA_PREREQS:=Makefile
all: $(TARGETS)

blinky.vcd:
	$(CARGO) run

index.html: Readme.adoc blinky.vcd
	$(ASCIIDOCTOR) -r asciidoctor-diagram Readme.adoc -o index.html

clean: 
	rm -rf target blinky.vcd

dist-clean: clean
	rm -rf index.html

.PHONY: dist-clean clean all