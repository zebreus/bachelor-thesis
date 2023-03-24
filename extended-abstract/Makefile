PWD = $(shell pwd)
ASCIIDOCTOR     = asciidoctor
VCD_TO_WAVEDROM     = asciidoctor

TARGETS_WITHOUT_HTML += 
TARGETS += $(TARGETS_WITHOUT_HTML) index.html

.EXTRA_PREREQS:=Makefile
all: index.html

index.html: Readme.adoc $(TARGETS_WITHOUT_HTML)
	$(ASCIIDOCTOR) -r asciidoctor-diagram Readme.adoc -o index.html

%.wavejson: %.vcd
	$(VCD_TO_WAVEDROM) -i $< | sed 's/TOP\.//' | jq '.signal = (.signal | map(select(.name | length < 30)))' > $@

clean:
	rm -rf *.json *.fs *.pack *.vcd *.png obj_dir HLS_output *.mem *.ll synthesize_*.sh simulate_*.sh bambu_results_*.xml memory_allocation_*.xml a.out

dist-clean: clean
	rm -rf $(TARGETS)

.PHONY: clean all dist-clean