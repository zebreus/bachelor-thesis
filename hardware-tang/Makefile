
PWD = $(shell pwd)
YOSYS     = yosys
NEXTPNR   = nextpnr-gowin
GOWINPACK = gowin_pack
# tag::bambu[] 
BAMBU     = bambu
BAMBU_FLAGS = --clock-name=clk --compiler=I386_CLANG12 -Os --simulator=ICARUS
# end::bambu[]
# tag::clang[]
CLANG     = clang++
# end::clang[]
# tag::verilator[] 
VERILATOR = verilator
# end::verilator[]
# tag::rust[] 
RUSTC = rustc
# end::rust[]
# tag::hide[]

TARGETS_WITHOUT_HTML += state_test.v state_test.native.log state_test.wavejson state_test_b.wavejson state_test_c.wavejson md5.v index.html
TARGETS += $(TARGETS_WITHOUT_HTML) index.html
# end::hide[]

.EXTRA_PREREQS:=Makefile
all: top.fs
# tag::hide[]

index.html: Readme.adoc $(TARGETS_WITHOUT_HTML)
	asciidoctor -r asciidoctor-diagram Readme.adoc -o index.html
# end::hide[]
# tag::rust[]

md5.ll: ../rust-md5/src/md5.rs
	$(RUSTC) --emit=llvm-ir --crate-type=lib -C overflow-checks=off -C no-vectorize-loops -C target-cpu=generic -C panic=abort -C opt-level=s -C llvm-args="--opaque-pointers=false" $< -o $@

%.ll: %.rs
	$(RUSTC) --emit=llvm-ir --crate-type=lib -C overflow-checks=off -C no-vectorize-loops -C target-cpu=generic -C panic=abort -C opt-level=s -C llvm-args="--opaque-pointers=false" $< -o $@
# end::rust[]
# tag::bambu[] 

%.v: %.cpp
	$(BAMBU) $(BAMBU_FLAGS) $< --top-fname=$(basename $(notdir $<))
# end::bambu[]
# tag::rust[] 

%.v: %.ll
	$(BAMBU) $(BAMBU_FLAGS) $< --top-fname=$(basename $(notdir $<))
# end::rust[]
# tag::hide[]

test-md5.log: md5.ll
	$(BAMBU) $(BAMBU_FLAGS) $< --top-fname=md5 --simulate --generate-tb=test-md5.xml > test-md5.log

test-md5.vcd: md5.ll
	$(BAMBU) $(BAMBU_FLAGS) $< --top-fname=md5 --simulate --generate-tb=test-md5.xml --generate-vcd
	cp HLS_output/simulation/test.vcd test-md5.vcd
# end::hide[]
# tag::clang[] 

%-native-executable: %.cpp
	$(CLANG) -D TEST_CPP $< -o $@

%.native.log: %-native-executable
	./$< > $@
# end::clang[] 
# tag::hide[]
V%_b: %.v %_sim_main_b.cpp  
	$(VERILATOR) --cc --exe --build --trace --Wno-width -j 0 $^
	mv obj_dir/V$(notdir $(basename $<)) $@
V%_c: %.v %_sim_main_c.cpp  
	$(VERILATOR) --cc --exe --build --trace --Wno-width -j 0 $^
	mv obj_dir/V$(notdir $(basename $<)) $@
# end::hide[]
# tag::verilator[]

V%: %.v %_sim_main.cpp
	$(VERILATOR) --cc --exe --build --trace --Wno-width -j 0 $^
	mv obj_dir/V$(notdir $(basename $<)) $@

.PRECIOUS: %.vcd
%.vcd: V%
	./$<

%.wavejson: %.vcd
	vcd2wavedrom -i $< | sed 's/TOP\.//' | jq '.signal = (.signal | map(select(.name | length < 30)))' > $@
# end::verilator[]

top.fs: top.pack
	$(GOWINPACK) -d GW1N-9C -o $@ $^

top.pack: top.json
	$(NEXTPNR) --json top.json --write top.pack --device GW1NR-LV9QN88PC6/I5 --family GW1N-9C --cst tangnano.cst

top.json: $(SOURCES)
	$(YOSYS) -p "synth_gowin -json top.json -top top" $(SOURCES)

prog: top.fs
	openFPGALoader -b tangnano $^

clean:
	rm -rf *.json *.fs *.pack *.vcd *.png obj_dir HLS_output *.mem *.ll synthesize_*.sh simulate_*.sh bambu_results_*.xml memory_allocation_*.xml a.out

dist-clean: clean
	rm -rf $(TARGETS)

.PHONY: %-tangnano-prog clean all