BUILD_DIR = build
OUT_DIR = results
SOURCE_DIR = src

RUSTC ?= rustc
BAMBU ?= nix run github:zebreus/bachelor-thesis\#bambu --

RUST_FLAGS = --emit=llvm-ir --crate-type=lib -C overflow-checks=off -C no-vectorize-loops -C target-cpu=generic -C panic=abort

RUST_FLAGS_SIZE = $(RUST_FLAGS) -C opt-level=s
RUST_FLAGS_SPEED = $(RUST_FLAGS) -C opt-level=3

BAMBU_FLAG_SPEED = -O5
BAMBU_FLAG_SIZE = -Os

BAMBU_FLAGS = --simulate --simulator=VERILATOR -v2
BAMBU_FLAGS_CLANG = $(BAMBU_FLAGS) --compiler=I386_CLANG12
BAMBU_FLAGS_GCC = $(BAMBU_FLAGS) --compiler=I386_GCC8

BAMBU_FLAGS_FULL = --top-fname=min_max_rust_idiomatic --compiler=I386_CLANG12 --generate-tb=testbench_llvm.xml

CASES = min_max_cpp_clang_size min_max_cpp_clang_speed min_max_cpp_gcc_size min_max_cpp_gcc_speed min_max_rust_idiomatic_size min_max_rust_idiomatic_speed min_max_rust_size min_max_rust_speed
# The following cases are used for the introduction
INTRO_CASES = min_max_cpp_clang_intro min_max_rust_intro min_max_rust_idiomatic_intro

LOG_FILES = $(addprefix $(OUT_DIR)/,$(addsuffix .log,$(CASES)))
INTRO_LOG_FILES = $(addprefix $(OUT_DIR)/,$(addsuffix .log,$(INTRO_CASES)))

RAW_LOG_FILES = $(addprefix $(BUILD_DIR)/,$(addsuffix .raw.out,$(CASES)))


TOTAL_ESTIMATED_AREA_CSV = $(OUT_DIR)/total_estimated_area.csv
AVERAGE_CYCLES_CSV = $(OUT_DIR)/average_cycles.csv
TOTAL_CYCLES_CSV = $(OUT_DIR)/total_cycles.csv
ESTIMATED_MAX_FREQUENCY_CSV = $(OUT_DIR)/estimated_max_frequency.csv
TEST_RESULTS_CSV = $(OUT_DIR)/test_results.csv
CSV_FILES = $(TOTAL_ESTIMATED_AREA_CSV) $(AVERAGE_CYCLES_CSV) $(TOTAL_CYCLES_CSV) $(ESTIMATED_MAX_FREQUENCY_CSV) $(TEST_RESULTS_CSV)

RESULTS = $(LOG_FILES) $(CSV_FILES) $(INTRO_LOG_FILES) 
.SECONDARY:

all: $(RESULTS)

$(BUILD_DIR)/%_speed.ll : $(SOURCE_DIR)/%.rs
	mkdir -p $(BUILD_DIR)
	$(RUSTC) $(RUST_FLAGS_SPEED) $< -o $@

$(BUILD_DIR)/%_size.ll : $(SOURCE_DIR)/%.rs
	mkdir -p $(BUILD_DIR)
	$(RUSTC) $(RUST_FLAGS_SIZE) $< -o $@

$(BUILD_DIR)/min_max_r%_speed.sh: $(SOURCE_DIR)/min_max_r%.rs $(SOURCE_DIR)/testbench_r%.xml
	mkdir -p $(BUILD_DIR)
	echo "$(RUSTC) $(RUST_FLAGS_SPEED) $< -o $(BUILD_DIR)/$(basename $(notdir $@)).ll" > $@
	echo -ne "$(BAMBU) $(BUILD_DIR)/$(basename $(notdir $@)).ll --top-fname=min_max_r$* --generate-tb=$(word 2,$^) $(BAMBU_FLAGS_CLANG) $(BAMBU_FLAG_SPEED)" >> $@

$(BUILD_DIR)/min_max_r%_size.sh: $(SOURCE_DIR)/min_max_r%.rs $(SOURCE_DIR)/testbench_r%.xml
	mkdir -p $(BUILD_DIR)
	echo "$(RUSTC) $(RUST_FLAGS_SIZE) $< -o $(BUILD_DIR)/$(basename $(notdir $@)).ll" > $@
	echo -ne "$(BAMBU) $(BUILD_DIR)/$(basename $(notdir $@)).ll --top-fname=min_max_r$* --generate-tb=$(word 2,$^) $(BAMBU_FLAGS_CLANG) $(BAMBU_FLAG_SIZE)" >> $@

$(BUILD_DIR)/min_max_rust_idiomatic_intro.sh: $(SOURCE_DIR)/min_max_rust_idiomatic.rs $(SOURCE_DIR)/testbench_rust_idiomatic.xml
	mkdir -p $(BUILD_DIR)
	echo "$(RUSTC) $(RUST_FLAGS) -C opt-level=1 $< -o $(BUILD_DIR)/$(basename $(notdir $@)).ll" > $@
	echo -ne "$(BAMBU) $(BUILD_DIR)/$(basename $(notdir $@)).ll --top-fname=min_max_rust_idiomatic --generate-tb=$(word 2,$^) $(BAMBU_FLAGS_CLANG) -O2" >> $@

$(BUILD_DIR)/min_max_rust_intro.sh: $(SOURCE_DIR)/min_max_rust.rs $(SOURCE_DIR)/testbench_rust.xml
	mkdir -p $(BUILD_DIR)
	echo "$(RUSTC) $(RUST_FLAGS) -C opt-level=0 $< -o $(BUILD_DIR)/$(basename $(notdir $@)).ll" > $@
	echo -ne "$(BAMBU) $(BUILD_DIR)/$(basename $(notdir $@)).ll --top-fname=min_max_rust --generate-tb=$(word 2,$^) $(BAMBU_FLAGS_CLANG) -O2" >> $@

$(BUILD_DIR)/min_max_cpp_gcc.sh: $(SOURCE_DIR)/min_max_cpp.cpp
	mkdir -p $(BUILD_DIR)
	echo -ne "$(BAMBU) $< --top-fname=min_max_cpp --generate-tb=$(SOURCE_DIR)/testbench.xml $(BAMBU_FLAGS_GCC)" > $@

$(BUILD_DIR)/min_max_cpp_clang.sh: $(SOURCE_DIR)/min_max_cpp.cpp
	mkdir -p $(BUILD_DIR)
	echo -ne "$(BAMBU) $< --top-fname=min_max_cpp --generate-tb=$(SOURCE_DIR)/testbench.xml $(BAMBU_FLAGS_CLANG)" > $@

$(BUILD_DIR)/min_max_cpp_clang_intro.sh: $(SOURCE_DIR)/min_max_cpp.cpp
	mkdir -p $(BUILD_DIR)
	echo -ne "$(BAMBU) $< --top-fname=min_max_cpp --generate-tb=$(SOURCE_DIR)/testbench.xml $(BAMBU_FLAGS_CLANG) -O2" > $@

$(BUILD_DIR)/%_speed.sh: $(BUILD_DIR)/%.sh
	cp $< $@
	echo -ne " $(BAMBU_FLAG_SPEED)" >> $@

$(BUILD_DIR)/%_size.sh: $(BUILD_DIR)/%.sh
	cp $< $@
	echo -ne " $(BAMBU_FLAG_SIZE)" >> $@

$(BUILD_DIR)/%.raw.out: $(BUILD_DIR)/%.sh
	sh $< 2>&1 | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g' | sed 's/[\x01-\x1F\x7F]//g' > $@
	
$(OUT_DIR)/%.log: $(BUILD_DIR)/%.raw.out $(BUILD_DIR)/%.sh
	mkdir -p $(OUT_DIR)
	rm -f $@
	cat $(word 2,$^) | sed "s/^/$$ /" >> $@
	echo '' >> $@
	grep -A3 --color=never "Scheduling Information of function" $< >> $@
	echo '' >> $@
	grep -A6 --color=never "Module binding information for" $< >> $@
	echo '' >> $@
	grep -A2 --color=never "Total cycles" $< >> $@

$(TOTAL_ESTIMATED_AREA_CSV): $(LOG_FILES)
	rm -f $@
	echo "id,value" > $@
	for LOGFILE in  $^ ; do \
	    echo -ne "$$(basename --suffix='.log' $$LOGFILE)," >> $@ ; \
		grep --color=never "Total estimated area" $$LOGFILE | sed 's/[^0-9]*//g' >> $@ ; \
	done

$(AVERAGE_CYCLES_CSV): $(LOG_FILES)
	rm -f $@
	echo "id,value" > $@
	for LOGFILE in  $^ ; do \
	    echo -ne "$$(basename --suffix='.log' $$LOGFILE)," >> $@ ; \
		grep --color=never "Average execution" $$LOGFILE | sed 's/[^0-9]*//g' >> $@ ; \
	done

$(TOTAL_CYCLES_CSV): $(LOG_FILES)
	rm -f $@
	echo "id,value" > $@
	for LOGFILE in  $^ ; do \
	    echo -ne "$$(basename --suffix='.log' $$LOGFILE)," >> $@ ; \
		grep --color=never "Total cycles" $$LOGFILE | sed 's/[^0-9]*//g' >> $@ ; \
	done

$(ESTIMATED_MAX_FREQUENCY_CSV): $(LOG_FILES)
	rm -f $@
	echo "id,value" > $@
	for LOGFILE in  $^ ; do \
	    echo -ne "$$(basename --suffix='.log' $$LOGFILE)," >> $@ ; \
		grep --color=never "Estimated max frequency" $$LOGFILE | sed 's/[^0-9.]*//g' >> $@ ; \
	done

$(TEST_RESULTS_CSV): $(RAW_LOG_FILES)
	rm -f $@
	echo "id,num_inputs,cycles" > $@
	for LOGFILE in  $^ ; do \
		grep --color=never "Simulation completed with SUCCESS" $$LOGFILE | sed 's/[^0-9.]*//g' | sed 's/[.]/ /g' | awk '{printf "'$$(basename --suffix='.raw.out' $$LOGFILE)',%d,%d\n", $$1-1, $$2}' >> $@ ; \
	done

clean:
	rm -rf $(BUILD_DIR) HLS_output synthesize_Synthesis_*.sh bambu_results_*.xml simulate_*.sh *.v memory_allocation_*.xml results.txt

clean-all: clean
	rm -rf $(OUT_DIR)