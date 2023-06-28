PWD = $(shell pwd)
ASCIIDOCTOR     = asciidoctor -r asciidoctor-kroki -a kroki-server-url=http://localhost:8000
VCD_TO_WAVEDROM     = vcd2wavedrom
ASCIIDOCTOR_WEB_PDF = asciidoctor-web-pdf -r asciidoctor-kroki -a kroki-server-url=http://localhost:8000

VEGA_CHART_FILES = $(shell find charts -name '*.json')
VEGA_DATA_FILES = $(shell find data -type f -name '*.csv') data/minmax_overview.csv
PROCESSED_CHARTS = $(addprefix processed-charts/,$(notdir $(VEGA_CHART_FILES)))

TARGETS += $(TARGETS_WITHOUT_HTML) index.html
TARGETS_WITHOUT_HTML += styles/trailing-scripts.adoc $(PROCESSED_CHARTS) vega-chart.adoc

ALL_DATA_JSON = experiments/all_data.json

.EXTRA_PREREQS:=Makefile
all: index.html

process-charts: $(PROCESSED_CHARTS)

SCSS_FILES = $(wildcard styles/*.scss) $(wildcard styles/*/*.scss) $(wildcard styles/*/*/*.scss)

Readme.css: $(SCSS_FILES)
	cd styles ; sass --update --sourcemap=none thesis.scss:../Readme.css

index.html: Readme.adoc Readme.css $(TARGETS_WITHOUT_HTML) 
	$(ASCIIDOCTOR) -S unsafe Readme.adoc -o index.html

thesis.pdf: Readme.adoc Readme.css $(TARGETS_WITHOUT_HTML) $(PROCESSED_CHARTS)
	$(ASCIIDOCTOR_WEB_PDF) Readme.adoc -o thesis.pdf

$(PROCESSED_CHARTS) : processed-charts/%.vl.json : charts/%.vl.json $(VEGA_DATA_FILES)
	mkdir -p $(dir $@)
	bash process_chart.sh $< > $@
	touch $@

data:
	cd experiments && make data
	make $(VEGA_DATA_FILES)

$(ALL_DATA_JSON):
	cd experiments && make data

$(VEGA_DATA_FILES) &: $(ALL_DATA_JSON) data/make_data.sh
	bash data/make_data.sh $< data

%.wavejson: %.vcd
	$(VCD_TO_WAVEDROM) -i $< | sed 's/TOP\.//' | jq '.signal = (.signal | map(select(.name | length < 30)))' > $@

clean:
	rm -rf *.json *.fs *.pack *.vcd *.png obj_dir HLS_output *.mem *.ll synthesize_*.sh simulate_*.sh bambu_results_*.xml memory_allocation_*.xml a.out

dist-clean: clean
	rm -rf $(TARGETS)

.PHONY: clean all dist-clean process-charts data