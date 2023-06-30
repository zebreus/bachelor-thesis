RUST_DIR ?= 

RUST_DESIGNS += minmax_rust_size
RUST_DESIGNS += minmax_rust_speed
RUST_DESIGNS += minmax_idiom_size
RUST_DESIGNS += minmax_idiom_speed
RUST_DESIGNS += keccak_rust_size
RUST_DESIGNS += keccak_rust_speed
RUST_DESIGNS += keccak_idiom_size
RUST_DESIGNS += keccak_idiom_speed
RUST_DESIGNS += md5_rust_size
RUST_DESIGNS += md5_rust_speed

CLEAN_FILES += $(addprefix $(RUST_DIR),$(addsuffix .v,$(RUST_DESIGNS)) $(addsuffix .testresult,$(RUST_DESIGNS))) $(wildcard $(addprefix $(RUST_DIR),$(addsuffix /*.v,$(RUST_DESIGNS)) $(addsuffix /*.csv,$(RUST_DESIGNS))))

verilog-rust: $(addprefix $(RUST_DIR),$(addsuffix .v,$(RUST_DESIGNS)) $(addsuffix .testresult,$(RUST_DESIGNS)))

$(RUST_DIR)%.v $(RUST_DIR)%.testresult : $(RUST_DIR)%/Cargo.toml $(wildcard $(RUST_DIR)%/src/*.rs)
	cd $(RUST_DIR)$* && cargo run
	cp $(RUST_DIR)$*/$*.v $(RUST_DIR)$*.v
	cp $(RUST_DIR)$*/result-tests-individual.csv $(RUST_DIR)$*.testresult

clean-rust:
	rm -rf $(CLEAN_FILES)