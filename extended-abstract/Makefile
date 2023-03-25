PWD = $(shell pwd)
ASCIIDOCTOR     = asciidoctor
VCD_TO_WAVEDROM     = vcd2wavedrom
DOCKER = docker

TARGETS_WITHOUT_HTML += 
TARGETS += $(TARGETS_WITHOUT_HTML) index.html

.EXTRA_PREREQS:=Makefile
all: index.html

SCSS_FILES = $(wildcard styles/*.scss) $(wildcard styles/*/*.scss) $(wildcard styles/*/*/*.scss)

Readme.css: $(SCSS_FILES)
	cd styles ; sass --update --sourcemap=none thesis.scss:../Readme.css

index.html: Readme.adoc Readme.css $(TARGETS_WITHOUT_HTML)
	$(ASCIIDOCTOR) -r asciidoctor-diagram Readme.adoc -o index.html

Readme.pdf: Readme.adoc Readme.css $(TARGETS_WITHOUT_HTML)
	$(DOCKER) run -i --rm --volume=$(PWD):"/usr/app" -u $(shell id -u):$(shell id -g) ggrossetie/asciidoctor-web-pdf:latest Readme.adoc

%.wavejson: %.vcd
	$(VCD_TO_WAVEDROM) -i $< | sed 's/TOP\.//' | jq '.signal = (.signal | map(select(.name | length < 30)))' > $@

clean:
	rm -rf *.json *.fs *.pack *.vcd *.png obj_dir HLS_output *.mem *.ll synthesize_*.sh simulate_*.sh bambu_results_*.xml memory_allocation_*.xml a.out

dist-clean: clean
	rm -rf $(TARGETS)

.PHONY: clean all dist-clean