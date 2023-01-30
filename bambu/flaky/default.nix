{ pkgs ? import <nixpkgs> { } }:
let

  # unwrapped-static-gcc-8 = pkgs.gcc8.cc.overrideAttrs (finalAttrs: previousAttrs:
  #   {
  #     enableMultilib = true;
  #     enablePlugins = true;
  #     name = "unwrapped-static-gcc-8";
  #     staticCompiler = true;
  #   });
  # wrapped-static-gcc-8 = pkgs.lowPrio (pkgs.wrapCC (unwrapped-gcc8-with-plugins));

  gcc8-multi = (pkgs.wrapCCMulti pkgs.gcc8);

  gcc8-multi-env = pkgs.overrideCC pkgs.stdenv gcc8-multi;

  overlay = self: super: {
    gcc = pkgs.gcc8;
    stdenv = pkgs.gcc8Stdenv;
  };

  pkgs-with-gcc8 = pkgs.extend overlay;


  # gcc8-with-multilib-and-plugins = pkgs.lowPrio (pkgs.wrapCC (unwrapped-gcc8-with-multilib-and-plugins));
  # unwrapped-gcc8-with-plugins = pkgs.gcc8.cc.overrideAttrs (finalAttrs: previousAttrs:
  #   {
  #     enablePlugins = true;
  #   });


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
    # ignoreCollisions = true;
    # buildInputs = [ pkgs.llvmPackages_11.clang ];

    postBuild = ''
      ln -s ${llvmPackages.clang.cc}/bin/clang-cpp $out/bin/clang-cpp
    '';
  };

  clang-with-llvm-11 = combineClangAndLLVM pkgs.pkgsi686Linux.llvmPackages_11;

  # multi_clang = pkgs.llvmPackages_11.clang.override
  #   {
  #     gccForLibs = pkgs.gccForLibs; # the cc attribute is the *un*wrapped compiler we require
  #   };





  # older_boost = pkgs.boost.overrideAttrs (finalAttrs: previousAttrs:
  #   {
  #     stdenv = gcc8-multi-env;
  #   });


  # Problems:
  # 1. Non posix /nix/store/wim4mqpn8lxhhr10p2kd070hyj152lil-bash-5.1-p16/bin/bash shebangs
  # 2. 32bit gcc
  # 3. llvm tools expected in clang directory

in
with pkgs;
gcc8-multi-env.mkDerivation rec {
  # llvmPackages_12.stdenv.mkDerivation rec {
  # gcc_multi.stdenv.mkDerivation rec {
  pname = "bambu";
  version = "0.9.8";

  src = fetchFromGitHub {
    owner = "zebreus";
    repo = "PandA-bambu";
    rev = "1443238db2168b91c7d7527e2f3800323cfb91d2";
    sha256 = "sha256-KH+kAQN9MX8/pcyEym+im1jw/R22lo8WJuHUyiHrQms=";
  };

  nativeBuildInputs = [
    # breakpointHook
    fish
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

    gcc8-multi
    # llvmPackages_11.clang
    # llvmPackages_11.clang.cc.dev

    # multi_clang
    # multi_clang.cc.dev

    # clang_with_llvm
    # cool_clang
    # cool_clang.cc.libllvm
    # pkgs.clang_multi.cc.libllvm
    # pkgs.clang_multi.cc.libllvm
  ];

  enableParallelBuilding = true;

  buildInputs = [
    # clang_with_llvm
    pkgs.pkgsi686Linux.llvmPackages_11.clang
    pkgs.pkgsi686Linux.llvmPackages_11.clang.cc.dev
    pkgs.pkgsi686Linux.buddy

    buddy

    # Maybe a normal boost is enough?
    pkgs-with-gcc8.boost
    pkgs-with-gcc8.boost.dev

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

  # patchPhase = ''
  #   # patch shebangs in all files using grep and sed
  #   echo bash bash bash
  #     # export MULTI={clang_with_llvm}
  #     # echo multi $MULTI
  #   echo ${bash}
  #   # find . -type f -exec sed -i 's|/nix/store/wim4mqpn8lxhhr10p2kd070hyj152lil-bash-5.1-p16/bin/bash|/nix/store/wim4mqpn8lxhhr10p2kd070hyj152lil-bash-5.1-p16/nix/store/wim4mqpn8lxhhr10p2kd070hyj152lil-bash-5.1-p16/bin/bash|g' {} +

  #   # export THING={gcc8-with-multilib-and-plugins}/bin/gcc
  #   # echo $THING
  #   # exit 1
  #   echo {unwrapped-gcc8-with-multilib-and-plugins}
  #   echo {gcc8-with-multilib-and-plugins}
  #   echo {gcc8}


  #   # find . -type f -exec sed -i 's|/usr/local/bin/gcc-7|/usr/local/bin/gcc-7 {gcc7}/bin/gcc|g' {} +
  #   # find . -type f -exec sed -i 's|/usr/local/bin/gcc-8|/usr/local/bin/gcc-8 {gcc8-with-multilib-and-plugins}/bin/gcc|g' {} +
  #   # find . -type f -exec sed -i 's|/usr/local/bin/gcc-9|/usr/local/bin/gcc-9 {gcc9}/bin/gcc|g' {} +
  #   # find . -type f -exec sed -i 's|/usr/bin/clang-8|/usr/bin/clang-8 {llvmPackages_8.clang}/bin/clang|g' {} +
  #   # Add the correct options for building the plugin with clang.

  # '';
  # Important for clang plugin
  # find . -type f -exec sed -i 's|EXTRA_CLANG_OPTIONS=|EXTRA_CLANG_OPTIONS="-isystem ${llvmPackages_11.libclang.dev}/include -isystem ${llvmPackages_11.libclang}/include -L${llvmPackages_11.libclang.dev}/lib -L${llvmPackages_11.libclang}/lib -stdlib=libc++ -I${unwrapped-gcc8-with-multilib-and-plugins}/include/c++/8.5.0 -I${unwrapped-gcc8-with-multilib-and-plugins}/include/c++/8.5.0/x86_64-unknown-linux-gnu"|g' {} +

  patchPhase = ''
    # Patch all calls to bash
    find . -type f -exec sed -i 's|/bin/bash|${bash}/bin/bash|g' {} +
  '';


  # Working plugin command
  # /nix/store/vcnx58n9f27p1dwnfxznni8rs68xgdm0-my-packages/bin/clang++ -I/build/source/etc/clang_plugin/ -I/nix/store/kzf7caq6grrh0gjchwajv9v264vfwlr9-llvm-11.1.0-dev/include -std=c++14   -fno-exceptions -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -std=c++14 -O2 -DNDEBUG -I/nix/store/0ammdv24jk6iz35gd7psha0li6g6k5d4-clang-11.1.0-dev/include -I/nix/store/6zka9igv5cif9k4h6zf37y9sjlnbq8n3-clang-11.1.0/include -L/nix/store/0ammdv24jk6iz35gd7psha0li6g6k5d4-clang-11.1.0-dev/lib -L/nix/store/6zka9igv5cif9k4h6zf37y9sjlnbq8n3-clang-11.1.0/lib -c plugin_test.cpp -o plugin_test.o -std=c++14 -fPIC -stdlib=libc++ -I/nix/store/glgacj4wx4cn6cb3d2jnwnwzmijv0da7-gcc-8.5.0/include/c++/8.5.0 -I/nix/store/glgacj4wx4cn6cb3d2jnwnwzmijv0da7-gcc-8.5.0/include/c++/8.5.0/x86_64-unknown-linux-gnu -isystem/nix/store/0ammdv24jk6iz35gd7psha0li6g6k5d4-clang-11.1.0-dev/include

  configurePhase = ''
    make -f Makefile.init
    
    mkdir -p ./build
    cd ./build

    export CLANG_11=${clang-with-llvm-11}/bin/clang
    export GCC_8=${gcc8-multi}/bin/gcc
    env LD_LIBRARY_PATH=${gmp}/lib:$LD_LIBRARY_PATH

    ../configure --prefix=$out \
      --build=x86_64-linux --target=x86_64-linux --host=x86_64-linux \
      --with-clang11=$CLANG_11 \
      --with-gcc8=$GCC_8 \
      --enable-shared=yes \
      --disable-static \
      --disable-allstatic \
      --enable-bambu \
      --program-prefix="" \
      --program-suffix="" \
      LDFLAGS="$NIX_LDFLAGS_FOR_TARGET" \
      CFLAGS="$NIX_CFLAGS_COMPILE_FOR_TARGET"
  '';

  buildPhase = ''
    make -j''${NIX_BUILD_CORES:-1}
  '';

  meta = with stdenv.lib; {
    description = "A Basic High Level Synthesis System Using LLVM";
  };
}
