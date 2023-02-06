BUILD_DIR = build
OUT_DIR = results
SOURCE_DIR = src

RUSTC ?= rustc
CLANG ?= clang++
BAMBU ?= nix run github:zebreus/bachelor-thesis\#bambu --

RUST_FLAGS = --emit=llvm-ir --crate-type=lib -C overflow-checks=off -C no-vectorize-loops -C target-cpu=generic -C panic=abort
CLANG_FLAGS = -S -emit-llvm

RUST_FLAGS_SIZE = $(RUST_FLAGS) -C opt-level=s
RUST_FLAGS_SPEED = $(RUST_FLAGS) -C opt-level=3
CLANG_FLAGS_SIZE = $(CLANG_FLAGS)
CLANG_FLAGS_SPEED = $(CLANG_FLAGS)

BAMBU_FLAG_SPEED = -O5
BAMBU_FLAG_SIZE = -Os

BAMBU_FLAGS = --simulate --simulator=VERILATOR --no-clean
BAMBU_FLAGS_CLANG = $(BAMBU_FLAGS) --compiler=I386_CLANG12
BAMBU_FLAGS_GCC = $(BAMBU_FLAGS) --compiler=I386_GCC8

BAMBU_FLAGS_FULL = --top-fname=min_max_rust_idiomatic --compiler=I386_CLANG12 --generate-tb=testbench_llvm.xml

CASES = switch_cpp_direct switch_cpp_size switch_rust_size switch_big_cpp_size

RAW_LOG_FILES = $(addprefix $(BUILD_DIR)/,$(addsuffix .raw.log,$(CASES)))

RESULTS = $(RAW_LOG_FILES)
.SECONDARY:

.EXTRA_PREREQS:=Makefile

all: $(RESULTS)

$(OUT_DIR)/%_speed.ll : $(SOURCE_DIR)/%.rs
	mkdir -p $(OUT_DIR)
	$(RUSTC) $(RUST_FLAGS_SPEED) $< -o $@

$(OUT_DIR)/%_size.ll : $(SOURCE_DIR)/%.rs
	mkdir -p $(OUT_DIR)
	$(RUSTC) $(RUST_FLAGS_SIZE) $< -o $@

$(OUT_DIR)/%_speed.ll : $(SOURCE_DIR)/%.cpp
	mkdir -p $(OUT_DIR)
	$(CLANG) $(CLANG_FLAGS_SPEED) $< -o $@

$(OUT_DIR)/%_size.ll : $(SOURCE_DIR)/%.cpp
	mkdir -p $(OUT_DIR)
	$(CLANG) $(CLANG_FLAGS_SIZE) $< -o $@

$(BUILD_DIR)/%.raw.log $(OUT_DIR)/%.v : $(OUT_DIR)/%.ll
	mkdir -p $(BUILD_DIR)
	mkdir -p $(OUT_DIR)
	$(BAMBU) $< --top-fname=$(subst _speed,,$(subst _size,,$(basename $(notdir $<)))) --generate-tb=$(SOURCE_DIR)/$(subst _speed,,$(subst _size,,$(basename $(notdir $<)))).xml $(BAMBU_FLAGS_CLANG)  2>&1 | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g' | sed 's/[\x01-\x1F\x7F]//g' > $@
	cp $(subst _speed,,$(subst _size,,$(basename $(notdir $<)))).v $(OUT_DIR)/$(basename $(notdir $<)).v

$(BUILD_DIR)/%_direct.raw.log $(BUILD_DIR)/%_direct.v : $(SOURCE_DIR)/%.cpp
	mkdir -p $(BUILD_DIR)
	mkdir -p $(OUT_DIR)
	$(BAMBU) $< --top-fname=$(basename $(notdir $<)) --generate-tb=$(SOURCE_DIR)/$(basename $(notdir $<)).xml $(BAMBU_FLAGS_CLANG) -v5  2>&1 | sed 's,\x1B\[[0-9;]*[a-zA-Z],,g' | sed 's/[\x01-\x1F\x7F]//g' > $@
	cp $(basename $(notdir $<)).v $(OUT_DIR)/$(basename $(notdir $<))_direct.v

clean:
	rm -rf $(BUILD_DIR) HLS_output synthesize_Synthesis_*.sh bambu_results_*.xml simulate_*.sh *.v memory_allocation_*.xml results.txt

clean-all: clean
	rm -rf $(OUT_DIR)