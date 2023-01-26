RUSTC ?= rustc

all:
	echo "Hello World"

lib.ll: src/lib.rs
	rustc --emit=llvm-ir --crate-type=lib src/lib.rs  -C overflow-checks=off -C no-vectorize-loops -C target-cpu=generic -C panic=abort -C opt-level=s

addition.v: lib.ll
	nix run .#bambu-appimage -- lib.ll --top-fname=addition --compiler=I386_CLANG12

recursive_addition.v: lib.ll
	nix run .#bambu-appimage -- lib.ll --top-fname=recursive_addition --compiler=I386_CLANG12

# bubble_sort.v: lib.ll
# 	nix run .#bambu-appimage -- lib.ll --top-fname=bubble_sort --compiler=I386_CLANG12

# min_max_mut_refs.v: lib.ll
# 	nix run .#bambu-appimage -- lib.ll --top-fname=min_max_mut_refs --compiler=I386_CLANG12

clean:
	rm -f lib.ll addition.v HLS_output synthesize_Synthesis_*.sh