RUSTC ?= rustc

all:
	echo "Hello World"

lib.ll: src/lib.rs
	rustc --emit=llvm-ir --crate-type=lib src/lib.rs -O

addition.v: lib.ll
	nix run .#bambu-appimage -- lib.ll --top-fname=addition --compiler=I386_CLANG12

clean:
	rm -f lib.ll addition.v HLS_output synthesize_Synthesis_*.sh