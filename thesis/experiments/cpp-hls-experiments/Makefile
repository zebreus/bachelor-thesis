CPP_DIR ?= 
cpp_BUILD_DIR = $(CPP_DIR)build

cpp_CPP_DESIGNS = minmax keccak md5

cpp_CLANG_BASE_DESIGNS = $(addsuffix _clang,$(cpp_CPP_DESIGNS))
cpp_GCC_BASE_DESIGNS = $(addsuffix _gcc,$(cpp_CPP_DESIGNS))
cpp_ALL_BASE_DESIGNS = $(cpp_CLANG_BASE_DESIGNS) $(cpp_GCC_BASE_DESIGNS)

cpp_SPEED_DESIGNS = $(addsuffix _speed,$(cpp_ALL_BASE_DESIGNS))
cpp_SIZE_DESIGNS = $(addsuffix _size,$(cpp_ALL_BASE_DESIGNS))
CPP_DESIGNS = $(cpp_SPEED_DESIGNS) $(cpp_SIZE_DESIGNS)

cpp_VERILOG_FILES = $(addprefix $(CPP_DIR),$(addsuffix .v,$(CPP_DESIGNS)))
cpp_TEST_RESULT_FILES = $(addprefix $(CPP_DIR),$(addsuffix .testresult,$(CPP_DESIGNS)))

BAMBU_COMMON_FLAGS = --simulator=VERILATOR --clock-name=clk --channels-type=MEM_ACC_11 --channels-number=1 --target=/home/lennart/Documents/bachelor-thesis/thesis/experiments/device.xml
# --device-name=LFE5U85F8BG756C --lattice-root=/nix/store/xyg72n8f2wzh07b7z7079wlzf7l27ipm-diamond-3.10/diamond
# Results dont seem to be different with device, but simulation requires proprietary IDE. --device-name=LFE5U85F8BG756C

BAMBU_CLANG_SPEED_FLAGS = --compiler=I386_CLANG16 -O3 --std=c++2a
BAMBU_CLANG_SIZE_FLAGS = --compiler=I386_CLANG16 -Os --std=c++2a
BAMBU_GCC_SPEED_FLAGS = --compiler=I386_GCC8 -O3 --std=c++2a
BAMBU_GCC_SIZE_FLAGS = --compiler=I386_GCC8 -Os --std=c++2a

CLEAN_FILES += $(cpp_BUILD_DIR) $(cpp_VERILOG_FILES) $(cpp_TEST_RESULT_FILES)

verilog-cpp: $(cpp_VERILOG_FILES) $(cpp_TEST_RESULT_FILES)

$(CPP_DIR)%_clang_speed.v $(CPP_DIR)%_clang_speed.testresult &: $(CPP_DIR)%.cpp
	mkdir -p $(cpp_BUILD_DIR)/$(basename $(notdir $@))
	cd $(cpp_BUILD_DIR)/$(basename $(notdir $@)) && bambu $(abspath $<) --top-fname=`bash $(abspath $(CPP_DIR)../get-top-module.sh) $*` --generate-tb=$(abspath $(CPP_DIR)$*-testbench.xml) --simulate $(BAMBU_COMMON_FLAGS) $(BAMBU_CLANG_SPEED_FLAGS)
	cp $(cpp_BUILD_DIR)/$(basename $(notdir $@))/`bash $(abspath $(CPP_DIR)../get-top-module.sh) $*`.v $(basename $@).v
	cat $(cpp_BUILD_DIR)/$(basename $(notdir $@))/results.txt | cut -f2 | sed 's/\s*//' | paste -d"," $(CPP_DIR)$*-testnames.txt - | sed 's/^/$(basename $(notdir $@)),/' > $(basename $@).testresult

$(CPP_DIR)%_clang_size.v $(CPP_DIR)%_clang_size.testresult &: $(CPP_DIR)%.cpp
	mkdir -p $(cpp_BUILD_DIR)/$(basename $(notdir $@))
	cd $(cpp_BUILD_DIR)/$(basename $(notdir $@)) && bambu $(abspath $<) --top-fname=`bash $(abspath $(CPP_DIR)../get-top-module.sh) $*` --generate-tb=$(abspath $(CPP_DIR)$*-testbench.xml) --simulate $(BAMBU_COMMON_FLAGS) $(BAMBU_CLANG_SIZE_FLAGS)
	cp $(cpp_BUILD_DIR)/$(basename $(notdir $@))/`bash $(abspath $(CPP_DIR)../get-top-module.sh) $*`.v $(basename $@).v
	cat $(cpp_BUILD_DIR)/$(basename $(notdir $@))/results.txt | cut -f2 | sed 's/\s*//' | paste -d"," $(CPP_DIR)$*-testnames.txt - | sed 's/^/$(basename $(notdir $@)),/' > $(basename $@).testresult

$(CPP_DIR)%_gcc_speed.v $(CPP_DIR)%_gcc_speed.testresult &: $(CPP_DIR)%.cpp
	mkdir -p $(cpp_BUILD_DIR)/$(basename $(notdir $@))
	cd $(cpp_BUILD_DIR)/$(basename $(notdir $@)) && bambu $(abspath $<) --top-fname=`bash $(abspath $(CPP_DIR)../get-top-module.sh) $*` --generate-tb=$(abspath $(CPP_DIR)$*-testbench.xml) --simulate $(BAMBU_COMMON_FLAGS) $(BAMBU_GCC_SPEED_FLAGS)
	cp $(cpp_BUILD_DIR)/$(basename $(notdir $@))/`bash $(abspath $(CPP_DIR)../get-top-module.sh) $*`.v $(basename $@).v
	cat $(cpp_BUILD_DIR)/$(basename $(notdir $@))/results.txt | cut -f2 | sed 's/\s*//' | paste -d"," $(CPP_DIR)$*-testnames.txt - | sed 's/^/$(basename $(notdir $@)),/' > $(basename $@).testresult

$(CPP_DIR)%_gcc_size.v $(CPP_DIR)%_gcc_size.testresult &: $(CPP_DIR)%.cpp
	mkdir -p $(cpp_BUILD_DIR)/$(basename $(notdir $@))
	cd $(cpp_BUILD_DIR)/$(basename $(notdir $@)) && bambu $(abspath $<) --top-fname=`bash $(abspath $(CPP_DIR)../get-top-module.sh) $*` --generate-tb=$(abspath $(CPP_DIR)$*-testbench.xml) --simulate $(BAMBU_COMMON_FLAGS) $(BAMBU_GCC_SIZE_FLAGS)
	cp $(cpp_BUILD_DIR)/$(basename $(notdir $@))/`bash $(abspath $(CPP_DIR)../get-top-module.sh) $*`.v $(basename $@).v
	cat $(cpp_BUILD_DIR)/$(basename $(notdir $@))/results.txt | cut -f2 | sed 's/\s*//' | paste -d"," $(CPP_DIR)$*-testnames.txt - | sed 's/^/$(basename $(notdir $@)),/' > $(basename $@).testresult

clean-cpp:
	rm -rf $(CLEAN_FILES)