BUILD_DIR = build/
OUT_DIR = results/

RUST_DIR = rust-hls-experiments/
CPP_DIR = cpp-hls-experiments/

include $(RUST_DIR)Makefile
include $(CPP_DIR)Makefile

ALL_DESIGNS = $(RUST_DESIGNS) $(CPP_DESIGNS)

RUST_VERILOG_FILES = $(addprefix $(BUILD_DIR), $(addsuffix .v, $(RUST_DESIGNS)))
CPP_VERILOG_FILES = $(addprefix $(BUILD_DIR), $(addsuffix .v, $(CPP_DESIGNS)))
RUST_TESTRESULT_FILES = $(addprefix $(BUILD_DIR),$(addsuffix .testresult,$(RUST_DESIGNS)))
CPP_TESTRESULT_FILES = $(addprefix $(BUILD_DIR),$(addsuffix .testresult,$(CPP_DESIGNS)))

VERILOG_FILES = $(RUST_VERILOG_FILES) $(CPP_VERILOG_FILES)
TESTRESULT_FILES = $(RUST_TESTRESULT_FILES) $(CPP_TESTRESULT_FILES)

YOSYS_JSON_FILES = $(addprefix $(BUILD_DIR),$(addsuffix -build.json,$(ALL_DESIGNS)))
NEXTPNR_REPORT_FILES = $(addprefix $(BUILD_DIR),$(addsuffix -report.json,$(ALL_DESIGNS)))

ALL_REPORTS = $(BUILD_DIR)all_reports.json
ALL_TESTRESULTS = $(BUILD_DIR)all_testresults.json
ADDITIONAL_INFORMATION = $(BUILD_DIR)additional_information.json
ALL_DATA = all_data.json

CLEAN_FILES += $(BUILD_DIR) $(ALL_DATA)

all: data

verilog: $(VERILOG_FILES)
testresults: $(TESTRESULT_FILES)
reports: $(NEXTPNR_REPORT_FILES)
data: $(ALL_DATA)

# Copy verilog files to build directory
$(RUST_VERILOG_FILES) : $(BUILD_DIR)%.v: $(RUST_DIR)%.v
	mkdir -p $(BUILD_DIR)
	cp $< $@

$(CPP_VERILOG_FILES) : $(BUILD_DIR)%.v: $(CPP_DIR)%.v
	mkdir -p $(BUILD_DIR)
	cp $< $@

$(RUST_TESTRESULT_FILES) : $(BUILD_DIR)%.testresult: $(RUST_DIR)%.testresult
	mkdir -p $(BUILD_DIR)
	cp $< $@

$(CPP_TESTRESULT_FILES) : $(BUILD_DIR)%.testresult: $(CPP_DIR)%.testresult
	mkdir -p $(BUILD_DIR)
	cp $< $@

# Synthesize with yosys
$(YOSYS_JSON_FILES) : $(BUILD_DIR)%-build.json : $(BUILD_DIR)%.v
	yosys -p "synth_ecp5 -json $@ -top `bash ./get-top-module.sh $<`" $<

# Place and route with nextpnr
$(NEXTPNR_REPORT_FILES) : $(BUILD_DIR)%-report.json : $(BUILD_DIR)%-build.json
	nextpnr-ecp5 --45k --speed 6 --json $< --report $@.tmp
	cat $@.tmp | jq > $@

$(ALL_REPORTS) : $(NEXTPNR_REPORT_FILES) scripts/combine_reports.sh
	bash scripts/combine_reports.sh $(NEXTPNR_REPORT_FILES) > $@

$(ALL_TESTRESULTS) : $(TESTRESULT_FILES) scripts/combine_testresults.sh
	bash scripts/combine_testresults.sh $(TESTRESULT_FILES) > $@

$(ADDITIONAL_INFORMATION) : scripts/generate_additional_information.sh Makefile
	bash scripts/generate_additional_information.sh $(ALL_DESIGNS) > $@
	grep _marker_ $@ && rm -f $@ && exit 1 || true

$(ALL_DATA) : $(ALL_REPORTS) $(ALL_TESTRESULTS) $(ADDITIONAL_INFORMATION)
	bash scripts/merge_json_files.sh $^ > $@

clean:
	rm -rf $(CLEAN_FILES)