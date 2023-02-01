{ pkgs ? import <nixpkgs> { } }:
let

  wrapGcc = gcc: pkgs.runCommand (gcc.name + "-with-libs")
    {
      buildInputs = [ pkgs.makeWrapper ];
    } ''
    mkdir $out
    ln -s ${gcc}/* $out
    rm $out/bin
    mkdir $out/bin
    ln -s ${gcc}/bin/* $out/bin

    for f in $out/bin/*; do
      if [ -f "$f" ]; then
          wrapProgram "$f" \
            --set AR_FOR_TARGET ar \
            --set AS_FOR_TARGET as \
            --set CC_FOR_TARGET gcc \
            --set CXX_FOR_TARGET g++ \
            --set LD_FOR_TARGET ld \
            --set NIX_BINTOOLS_FOR_TARGET ${gcc.bintools} \
            --set NIX_BINTOOLS_WRAPPER_TARGET_TARGET_i686_unknown_linux_gnu 1 \
            --set NIX_CC_FOR_TARGET ${gcc} \
            --set NIX_CC_WRAPPER_TARGET_TARGET_i686_unknown_linux_gnu 1 \
            --set NM_FOR_TARGET nm \
            --set OBJCOPY_FOR_TARGET objcopy \
            --set OBJDUMP_FOR_TARGET objdump \
            --set RANLIB_FOR_TARGET ranlib \
            --set READELF_FOR_TARGET readelf \
            --set SIZE_FOR_TARGET size \
            --set STRINGS_FOR_TARGET strings \
            --set STRIP_FOR_TARGET strip \
            --prefix HOST_PATH ":" ${gcc.bintools}/bin \
            --prefix HOST_PATH ":" ${gcc}/bin \
            --prefix PATH ":" ${gcc.bintools}/bin \
            --prefix PATH ":" ${gcc}/bin \
            --prefix NIX_LDFLAGS_FOR_TARGET " " "-L${pkgs.pkgsi686Linux.buddy}/lib -L${pkgs.libmpc}/lib -L${pkgs.gmp}/lib -L${pkgs.mpfr}/lib -L${pkgs.boost}/lib -L${pkgs.libxml2}/lib -L${pkgs.lzma}/lib -L${pkgs.zlib}/lib -L${pkgs.icu}/lib -L${pkgs.suitesparse}/lib -L${pkgs.mpfi}/lib -L${pkgs.glpk}/lib -L${gcc.cc}/lib" \
            --prefix NIX_CFLAGS_COMPILE_FOR_TARGET " " "-I${pkgs.pkgsi686Linux.buddy}/include -I${pkgs.libmpc}/include -I${pkgs.gmp.dev}/include -I${pkgs.mpfr.dev}/include -I${pkgs.boost.dev}/include -I${pkgs.libxml2.dev}/include -I${pkgs.lzma.dev}/include -I${pkgs.zlib.dev}/include -I${pkgs.icu.dev}/include -I${pkgs.suitesparse.dev}/include -I${pkgs.mpfi}/include -I${pkgs.glpk}/include -I${gcc.cc}/include"
     fi
    done

  '';

  self-wrapped-gcc8 = wrapGcc pkgs.pkgsi686Linux.gcc8;
  self-wrapped-gcc7 = wrapGcc pkgs.pkgsi686Linux.gcc7;


  # Combines clang and llvm binaries into the same directory
  # This is necessary because bambu finds the LLVM tools by searching in the llvm directory
  combineClangAndLLVM = llvmPackages: pkgs.buildEnv {
    name = "clang-with-llvm-" + llvmPackages.release_version;
    paths = [
      llvmPackages.clang
      llvmPackages.clang.cc.dev
      llvmPackages.clang.cc.libllvm
      llvmPackages.clang.cc.libllvm.dev
    ];

    nativeBuildInputs = [ pkgs.makeWrapper ];

    postBuild = ''
      ln -s ${llvmPackages.clang}/bin/clang++ $out/bin/clang-cpp

      for f in $out/bin/*; do
        if [ -f "$f" ]; then
          wrapProgram "$f" \
            --set AR_FOR_TARGET ar \
            --set AS_FOR_TARGET as \
            --set CC_FOR_TARGET gcc \
            --set CXX_FOR_TARGET g++ \
            --set LD_FOR_TARGET ld \
            --set NIX_BINTOOLS_FOR_TARGET ${pkgs.pkgsi686Linux.gcc8.bintools} \
            --set NIX_BINTOOLS_WRAPPER_TARGET_TARGET_i686_unknown_linux_gnu 1 \
            --set NIX_CC_FOR_TARGET ${pkgs.pkgsi686Linux.gcc8} \
            --set NIX_CC_WRAPPER_TARGET_TARGET_i686_unknown_linux_gnu 1 \
            --set NM_FOR_TARGET nm \
            --set OBJCOPY_FOR_TARGET objcopy \
            --set OBJDUMP_FOR_TARGET objdump \
            --set RANLIB_FOR_TARGET ranlib \
            --set READELF_FOR_TARGET readelf \
            --set SIZE_FOR_TARGET size \
            --set STRINGS_FOR_TARGET strings \
            --set STRIP_FOR_TARGET strip \
            --prefix HOST_PATH ":" ${pkgs.pkgsi686Linux.gcc8.bintools}/bin \
            --prefix HOST_PATH ":" ${pkgs.pkgsi686Linux.gcc8}/bin \
            --prefix PATH ":" ${pkgs.pkgsi686Linux.gcc8.bintools}/bin \
            --prefix PATH ":" ${pkgs.pkgsi686Linux.gcc8}/bin \
            --prefix NIX_LDFLAGS_FOR_TARGET " " "-L${llvmPackages.clang}/lib -L${llvmPackages.clang.cc.libllvm}/lib -L${pkgs.pkgsi686Linux.buddy}/lib -L${pkgs.libmpc}/lib -L${pkgs.gmp}/lib -L${pkgs.mpfr}/lib -L${pkgs.boost}/lib -L${pkgs.libxml2}/lib -L${pkgs.lzma}/lib -L${pkgs.zlib}/lib -L${pkgs.icu}/lib -L${pkgs.suitesparse}/lib -L${pkgs.mpfi}/lib -L${pkgs.glpk}/lib  -L${pkgs.pkgsi686Linux.gcc8.cc}/lib" \
            --prefix NIX_CFLAGS_COMPILE_FOR_TARGET " " "-I${llvmPackages.clang.cc.dev}/include -I${llvmPackages.clang.cc.libllvm.dev}/include -I${pkgs.pkgsi686Linux.buddy}/include -I${pkgs.libmpc}/include -I${pkgs.gmp.dev}/include -I${pkgs.mpfr.dev}/include -I${pkgs.boost.dev}/include -I${pkgs.libxml2.dev}/include -I${pkgs.lzma.dev}/include -I${pkgs.zlib.dev}/include -I${pkgs.icu.dev}/include -I${pkgs.suitesparse.dev}/include -I${pkgs.mpfi}/include -I${pkgs.glpk}/include -I${pkgs.pkgsi686Linux.gcc8.cc}/include"
        fi
      done
    '';
  };

  clang-with-llvm-7 = combineClangAndLLVM pkgs.pkgsi686Linux.llvmPackages_7;
  clang-with-llvm-8 = combineClangAndLLVM pkgs.pkgsi686Linux.llvmPackages_8;
  # Clang 9 seems to be broken on upstream
  # clang-with-llvm-9 = combineClangAndLLVM pkgs.pkgsi686Linux.llvmPackages_9;
  clang-with-llvm-10 = combineClangAndLLVM pkgs.pkgsi686Linux.llvmPackages_10;
  clang-with-llvm-11 = combineClangAndLLVM pkgs.pkgsi686Linux.llvmPackages_11;
  clang-with-llvm-12 = combineClangAndLLVM pkgs.pkgsi686Linux.llvmPackages_12;
in
with pkgs;
stdenv.mkDerivation rec {
  pname = "bambu";
  version = "0.9.8";
  enableParallelBuilding = true;

  src = fetchFromGitHub {
    owner = "zebreus";
    repo = "PandA-bambu";
    rev = "1443238db2168b91c7d7527e2f3800323cfb91d2";
    sha256 = "sha256-KH+kAQN9MX8/pcyEym+im1jw/R22lo8WJuHUyiHrQms=";
  };

  nativeBuildInputs = [
    autoconf
    autoconf-archive
    automake

    libtool

    bison
    doxygen
    flex
    graphviz
    verilog
    verilator
  ];


  buildInputs = [
    boost
    boost.dev
    buddy
    libmpc
    mpfr
    mpfr.dev
    libxml2
    libxml2.dev
    lzma
    lzma.dev
    mpfi
    zlib
    zlib.dev
    icu
    icu.dev
    suitesparse
    suitesparse.dev
    glpk
    gmp
    gmp.dev
    gmpxx
    gmpxx.dev
  ];

  patchPhase = ''
    # Patch all calls to bash
    find . -type f -exec sed -i 's|/bin/bash|${bash}/bin/bash|g' {} +
  '';

  configurePhase = ''
    make -f Makefile.init
    
    mkdir -p ./build
    cd ./build

    export CLANG_7=${clang-with-llvm-7}/bin/clang
    export CLANG_8=${clang-with-llvm-8}/bin/clang
    export CLANG_10=${clang-with-llvm-10}/bin/clang
    export CLANG_11=${clang-with-llvm-11}/bin/clang
    export CLANG_12=${clang-with-llvm-12}/bin/clang
    export GCC_7=${self-wrapped-gcc7}/bin/gcc
    export GCC_8=${self-wrapped-gcc8}/bin/gcc

    ../configure --prefix=$out \
      --build=x86_64-linux --target=x86_64-linux --host=x86_64-linux \
      --with-clang7=$CLANG_7 \
      --with-clang8=$CLANG_8 \
      --with-clang10=$CLANG_10 \
      --with-clang11=$CLANG_11 \
      --with-clang12=$CLANG_12 \
      --with-gcc7=$GCC_7 \
      --with-gcc8=$GCC_8 \
      --enable-shared=yes \
      --disable-static \
      --disable-allstatic \
      --enable-bambu \
      --disable-flopoco \
      --program-prefix="" \
      --program-suffix=""
  '';

  buildPhase = ''
    make -j''${NIX_BUILD_CORES:-1}
  '';

  meta = with lib; {
    description = "A research environment for high-level synthesis";
    longDescription = ''
      A research environment to experiment with new ideas across HLS, high-level verification and debugging, FPGA/ASIC design, design flow space exploration, and parallel hardware accelerator design.
    '';
    homepage = "https://panda.dei.polimi.it/";
    license = licenses.gpl3Plus;
    platforms = [
      "x86_64-linux"
    ];
    mainProgram = "bambu";
  };
}
