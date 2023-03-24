#!/usr/bin/env bash

# RUSTFLAGS="--emit=llvm-ir" cargo build --release
rm -rf target
cargo rustc --release -- --emit=llvm-ir -C overflow-checks=off -C no-vectorize-loops -C target-cpu=generic -C panic=abort -C opt-level=s   -C linker-plugin-lto=on -C embed-bitcode=on -C lto=fat -C llvm-args="--opaque-pointers=false"
cp target/release/deps/bambu_build_demo-*.ll md5.ll
bambu --clock-name=clk --compiler=I386_CLANG12 -Os --simulator=VERILATOR md5.ll --top-fname=md5 --simulate --generate-tb=test-md5.xml