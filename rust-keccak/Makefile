.ONESHELL:
.EXTRA_PREREQS:=Makefile

RUSTFLAGS = --emit=llvm-bc -C overflow-checks=off -C no-vectorize-loops -C target-cpu=generic -C panic=abort -C opt-level=3 -C linker-plugin-lto=on -C embed-bitcode=on -C lto=fat -C llvm-args=--opaque-pointers=false
BAMBUFLAGS = --compiler=I386_CLANG16 -O3

keccak.ll: src/keccak.rs src/lib.rs Cargo.toml Cargo.lock
	export RUSTFLAGS='$(RUSTFLAGS)'
	LLVM_BITCODE_FILES=($$(cargo build --release -Z unstable-options --build-plan | jq '.invocations[].outputs[]' -r | grep -Po "^.*\.rlib$$" | sed -E 's/lib([^\/]*)\.rlib/\1\.bc /' | tr -d '\n'))
	cargo build --release -Z unstable-options
	LLVM_BITCODE_FILES=($$(echo "$${LLVM_BITCODE_FILES[@]}"  | tr '\n\r' ' ' | xargs -d ' ' ls -d 2>/dev/null))
	llvm-link --opaque-pointers=false panic.ll "$${LLVM_BITCODE_FILES[@]}"  | llvm-dis --opaque-pointers=false -o keccak.ll

keccak.v: keccak.ll
	bambu --simulator=ICARUS keccak.ll --top-fname=keccak --clock-name=clk --generate-tb=test.xml --simulate $(BAMBUFLAGS)

clean:
	rm -rf keccak.ll keccak.v bambu_results* *array_ref* HLS_output synthesize_* simulate_* results.txt