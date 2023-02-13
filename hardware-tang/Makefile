
SOURCES := counter.v

PWD = $(shell pwd)
YOSYS     = yosys
NEXTPNR   = nextpnr-gowin
GOWINPACK = gowin_pack
# tag::bambu[] 
BAMBU     = bambu
# end::bambu[]
# tag::clang[]
CLANG     = clang++
# end::clang[]
# tag::verilator[] 
VERILATOR = verilator
# end::verilator[]
# tag::hide[]
TARGETS += state_test.v state_test.native.log state_test.wavejson state_test_b.wavejson state_test_c.wavejson
doc: $(TARGETS)
# end::hide[]

.EXTRA_PREREQS:=Makefile
all: top.fs
# tag::bambu[] 

%.v: %.cpp
	$(BAMBU) $< --top-fname=$(basename $(notdir $<)) --clock-name=clk --compiler=I386_CLANG12 -Os
# end::bambu[]
# tag::clang[] 

%: %.cpp
	$(CLANG) -D TEST_CPP $< -o $@

%.native.log: %
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
	rm -f *.json *.fs *.pack

.PHONY: %-tangnano-prog clean all