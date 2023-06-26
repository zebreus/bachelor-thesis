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

CLEAN_FILES += $(BUILD_DIR)

all: reports

verilog: $(VERILOG_FILES)
testresults: $(TESTRESULT_FILES)

reports: $(NEXTPNR_REPORT_FILES)

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

clean:
	rm -rf $(CLEAN_FILES)