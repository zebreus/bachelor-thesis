BUILD_DIR = build

CPP_DESIGNS = minmax keccak md5

CLANG_BASE_DESIGNS = $(addsuffix _clang,$(CPP_DESIGNS))
GCC_BASE_DESIGNS = $(addsuffix _gcc,$(CPP_DESIGNS))
ALL_BASE_DESIGNS = $(CLANG_BASE_DESIGNS) $(GCC_BASE_DESIGNS)

SPEED_DESIGNS = $(addsuffix _speed,$(ALL_BASE_DESIGNS))
SIZE_DESIGNS = $(addsuffix _speed,$(ALL_BASE_DESIGNS))
ALL_DESIGNS = $(SPEED_DESIGNS) $(SIZE_DESIGNS)

VERILOG_FILES = $(addsuffix .v,$(ALL_DESIGNS))
TEST_RESULT_FILES = $(addsuffix .testresult,$(ALL_DESIGNS))

BAMBU_COMMON_FLAGS = --simulator=VERILATOR --clock-name=clk --channels-type=MEM_ACC_11 --channels-number=1

BAMBU_CLANG_SPEED_FLAGS = --compiler=I386_CLANG16 -O3
BAMBU_CLANG_SIZE_FLAGS = --compiler=I386_CLANG16 -Os
BAMBU_GCC_SPEED_FLAGS = --compiler=I386_GCC8 -O3
BAMBU_GCC_SIZE_FLAGS = --compiler=I386_GCC8 -Os

all: $(VERILOG_FILES)

%_clang_speed.v %_clang_speed.testresult &: %.cpp
	mkdir -p $(BUILD_DIR)/$(basename $@)
	cd $(BUILD_DIR)/$(basename $@) && bambu ../../$< --top-fname=$* --generate-tb=../../$*-testbench.xml --simulate $(BAMBU_COMMON_FLAGS) $(BAMBU_CLANG_SPEED_FLAGS)
	cp $(BUILD_DIR)/$(basename $@)/*.v $(basename $@).v
	cat $(BUILD_DIR)/$(basename $@)/results.txt | cut -f2 | sed 's/\s*//' | paste -d"," $*-testnames.txt - | sed 's/^/$(basename $@),/' > $(basename $@).testresult

%_clang_size.v %_clang_size.testresult &: %.cpp
	mkdir -p $(BUILD_DIR)/$(basename $@)
	cd $(BUILD_DIR)/$(basename $@) && bambu ../../$< --top-fname=$* $(BAMBU_COMMON_FLAGS) $(BAMBU_CLANG_SIZE_FLAGS)
	cp $(BUILD_DIR)/$(basename $@)/*.v $(basename $@).v
	cat $(BUILD_DIR)/$(basename $@)/results.txt | cut -f2 | sed 's/\s*//' | paste -d"," $*-testnames.txt - | sed 's/^/$(basename $@),/' > $(basename $@).testresult

%_gcc_speed.v %_gcc_speed.testresult &: %.cpp
	mkdir -p $(BUILD_DIR)/$(basename $@)
	cd $(BUILD_DIR)/$(basename $@) && bambu ../../$< --top-fname=$* $(BAMBU_COMMON_FLAGS) $(BAMBU_GCC_SPEED_FLAGS)
	cp $(BUILD_DIR)/$(basename $@)/*.v $(basename $@).v
	cat $(BUILD_DIR)/$(basename $@)/results.txt | cut -f2 | sed 's/\s*//' | paste -d"," $*-testnames.txt - | sed 's/^/$(basename $@),/' > $(basename $@).testresult

%_gcc_size.v %_gcc_size.testresult &: %.cpp
	mkdir -p $(BUILD_DIR)/$(basename $@)
	cd $(BUILD_DIR)/$(basename $@) && bambu ../../$< --top-fname=$* $(BAMBU_COMMON_FLAGS) $(BAMBU_GCC_SIZE_FLAGS)
	cp $(BUILD_DIR)/$(basename $@)/*.v $(basename $@).v
	cat $(BUILD_DIR)/$(basename $@)/results.txt | cut -f2 | sed 's/\s*//' | paste -d"," $*-testnames.txt - | sed 's/^/$(basename $@),/' > $(basename $@).testresult


clean:
	rm -rf $(BUILD_DIR) $(VERILOG_FILES) $(TEST_RESULT_FILES)