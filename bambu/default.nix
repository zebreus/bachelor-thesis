{ pkgs ? import <nixpkgs> { } }:
let
  # mygcc = pkgs.lowPrio (pkgs.wrapCC (pkgs.gcc9.cc.overrideAttrs (finalAttrs: previousAttrs: { enableMultilib = true; enablePlugins = true; })));
  unwrapped-gcc8-with-multilib-and-plugins = pkgs.gcc8.cc.overrideAttrs (finalAttrs: previousAttrs:
    {
      enableMultilib = true;
      enablePlugins = true;
      # name = "gcc-8";
      # staticCompiler = true;

    });

  # gcc8-with-multilib-and-plugins = pkgs.lowPrio (pkgs.wrapCC (unwrapped-gcc8-with-multilib-and-plugins));
  unwrapped-gcc8-with-plugins = pkgs.gcc8.cc.overrideAttrs (finalAttrs: previousAttrs:
    {
      enablePlugins = true;
    });
  wrapped-gcc8-with-plugins = pkgs.lowPrio (pkgs.wrapCC (unwrapped-gcc8-with-plugins));


  clang_with_llvm = pkgs.buildEnv {
    name = "my-packages";
    paths = [
      # pkgs.llvmPackages_11.clang
      pkgs.clang_multi
      pkgs.llvmPackages_11.llvm
      pkgs.llvmPackages_11.llvm.dev
      # pkgs.llvmPackages_11.libclang
    ];
    # ignoreCollisions = true;
    # buildInputs = [ pkgs.llvmPackages_11.clang ];

    postBuild = ''
      ln -s ${pkgs.llvmPackages_11.libclang}/bin/clang-cpp $out/bin/clang-cpp
    '';
  };

  cool-gcc-8 = (pkgs.wrapCCMulti pkgs.gcc8);

  cool-gcc-8-env = pkgs.overrideCC pkgs.stdenv cool-gcc-8;


  # Problems:
  # 1. Non posix /bin/bash shebangs
  # 2. 32bit gcc
  # 3. llvm tools expected in clang directory

in
with pkgs;
stdenv.mkDerivation rec {
  # llvmPackages_12.stdenv.mkDerivation rec {
  # gcc_multi.stdenv.mkDerivation rec {
  pname = "bambu";
  version = "0.9.8";

  src = fetchFromGitHub {
    owner = "ferrandi";
    repo = "PandA-bambu";
    rev = "v0.9.8";
    sha256 = "sha256-t7mhosx81niqJotm0aiqp7GN+OGQnMWcFWzLgSEqMQY=";
  };

  nativeBuildInputs = [
    # breakpointHook

  ];


  buildInputs = [
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

    cool-gcc-8

    # g++ gcc-7
    # g++-7
    # gcc-8
    # g++-8
    # gcc-7-plugin-dev
    # gcc-8-plugin-dev
    # gcc-7-multilib
    # gcc-8-multilib
    # g++-7-multilib
    # g++-8-multilib
    # gcc9
    gcc
    # mygcc
    # gcc8-with-multilib-and-plugins
    # gcc8-with-multilib-and-plugins.bintools
    # gcc8-with-multilib-and-plugins
    # gcc8-with-multilib-and-plugins.libc.bin
    # gcc8-with-multilib-and-plugins.libc.dev
    # gcc8
    # gcc8-with-multilib-and-plugins
    # gcc7
    # gcc_multi
    glibc.static
    glibc.dev
    glibc_multi
    glibc_multi.dev
    glibc_multi.bin
    gfortran7
    gfortran8

    cool-gcc-8
    # gfortran-7
    # gfortran-7-multilib
    # gfortran-8
    # gfortran-8-multilib
    # libclang-6
    # .0-dev
    # clang-6
    # .0
    # libclang-6
    # .0-dev
    # clang-7
    # libclang-7-dev
    # clang-8
    # libclang-8-dev
    # clang-9
    # libclang-9-dev
    # clang-10
    # libclang-10-dev
    # clang-11
    # libclang-11-dev
    # clang-12
    # libclang-12-dev
    # clang_12
    # clang_11
    # clang_10
    # clang_9
    # clang_8
    # clang_7
    llvmPackages_12.libclang
    llvmPackages_12.clang
    llvmPackages_11.libclang
    llvmPackages_11.libclang.dev
    llvmPackages_11.clang
    llvmPackages_10.libclang
    llvmPackages_10.clang
    llvmPackages_9.libclang
    llvmPackages_9.clang
    llvmPackages_8.libclang
    llvmPackages_8.clang
    llvmPackages_7.libclang
    llvmPackages_7.clang

    clang_with_llvm


    buddy # libbdd-dev

    boost
    # boost.lib
    boost.dev
    libmpc
    # libmpc.lib
    # libmpc.dev
    mpfr
    # mpfr.lib
    mpfr.dev
    libxml2
    # libxml2.lib
    libxml2.dev
    lzma
    # lzma.lib
    lzma.dev
    mpfi
    # mpfi.lib
    # mpfi.dev
    zlib
    # zlib.lib
    zlib.dev
    icu
    # icu.lib
    icu.dev
    suitesparse
    # suitesparse.lib
    suitesparse.dev
    glpk
    # glpk.lib
    # glpk.dev
    gmp
    gmpxx
    # gmp.lib
    gmpxx.dev
    gmp.dev
  ];

  patchPhase = ''
    # patch shebangs in all files using grep and sed
    echo bash bash bash
      export MULTI=${clang_with_llvm}
      echo multi $MULTI
    echo ${bash}
    find . -type f -exec sed -i 's|/bin/bash|${bash}/bin/bash|g' {} +

    # export THING={gcc8-with-multilib-and-plugins}/bin/gcc
    # echo $THING
    # exit 1
    echo {unwrapped-gcc8-with-multilib-and-plugins}
    echo {gcc8-with-multilib-and-plugins}
    echo {gcc8}

    
    # find . -type f -exec sed -i 's|/usr/local/bin/gcc-7|/usr/local/bin/gcc-7 {gcc7}/bin/gcc|g' {} +
    # find . -type f -exec sed -i 's|/usr/local/bin/gcc-8|/usr/local/bin/gcc-8 {gcc8-with-multilib-and-plugins}/bin/gcc|g' {} +
    # find . -type f -exec sed -i 's|/usr/local/bin/gcc-9|/usr/local/bin/gcc-9 {gcc9}/bin/gcc|g' {} +
    find . -type f -exec sed -i 's|/usr/bin/clang-8|/usr/bin/clang-8 ${llvmPackages_8.clang}/bin/clang|g' {} +
    # Add the correct options for building the plugin with clang.
    
  '';
  # Important for clang plugin
  # find . -type f -exec sed -i 's|EXTRA_CLANG_OPTIONS=|EXTRA_CLANG_OPTIONS="-isystem ${llvmPackages_11.libclang.dev}/include -isystem ${llvmPackages_11.libclang}/include -L${llvmPackages_11.libclang.dev}/lib -L${llvmPackages_11.libclang}/lib -stdlib=libc++ -I${unwrapped-gcc8-with-multilib-and-plugins}/include/c++/8.5.0 -I${unwrapped-gcc8-with-multilib-and-plugins}/include/c++/8.5.0/x86_64-unknown-linux-gnu"|g' {} +



  # Working plugin command
  # /nix/store/vcnx58n9f27p1dwnfxznni8rs68xgdm0-my-packages/bin/clang++ -I/build/source/etc/clang_plugin/ -I/nix/store/kzf7caq6grrh0gjchwajv9v264vfwlr9-llvm-11.1.0-dev/include -std=c++14   -fno-exceptions -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -std=c++14 -O2 -DNDEBUG -I/nix/store/0ammdv24jk6iz35gd7psha0li6g6k5d4-clang-11.1.0-dev/include -I/nix/store/6zka9igv5cif9k4h6zf37y9sjlnbq8n3-clang-11.1.0/include -L/nix/store/0ammdv24jk6iz35gd7psha0li6g6k5d4-clang-11.1.0-dev/lib -L/nix/store/6zka9igv5cif9k4h6zf37y9sjlnbq8n3-clang-11.1.0/lib -c plugin_test.cpp -o plugin_test.o -std=c++14 -fPIC -stdlib=libc++ -I/nix/store/glgacj4wx4cn6cb3d2jnwnwzmijv0da7-gcc-8.5.0/include/c++/8.5.0 -I/nix/store/glgacj4wx4cn6cb3d2jnwnwzmijv0da7-gcc-8.5.0/include/c++/8.5.0/x86_64-unknown-linux-gnu -isystem/nix/store/0ammdv24jk6iz35gd7psha0li6g6k5d4-clang-11.1.0-dev/include

  configurePhase = ''
    # alias gcc-8=${gcc8}/bin/gcc
    # export ac_gcc6=${gcc6}/bin/gcc

      make -f Makefile.init
    
    # NIX_LDFLAGS_FOR_TARGET = -L${gmp}/lib ...

    # NIX_CFLAGS_COMPILE_FOR_TARGET
    # NIX_CFLAGS_COMPILE 
    # NIX_LDFLAGS
      mkdir -p $out/build

    
      
      cd $out/build
      export CLANG_12=${llvmPackages_12.clang}/bin/clang
      export CLANG_11=${clang_with_llvm}/bin/clang
      export CLANG_8=${llvmPackages_8.clang}/bin/clang
      export CLANG_7=${llvmPackages_7.clang}/bin/clang
      export GCC_7=${gcc7}/bin/gcc
      export GCC_8=${cool-gcc-8}/bin/gcc
      env LD_LIBRARY_PATH=${gmp}/lib:$LD_LIBRARY_PATH
      /build/source/configure  --prefix=$out/opt/panda \
      --build=x86_64-linux --target=x86_64-linux --host=x86_64-linux \
      --with-clang12=$CLANG_12 --with-clang11=$CLANG_11 --with-clang7=$CLANG_7 --with-gcc7=$GCC_7 --with-gcc8=$GCC_8 \
      --enable-shared=true \
      --enable-static=false \
      --disable-allstatic \
      --disable-flopoco \
      --enable-bambu \
      panda_USE_ABSEIL=no \
      LDFLAGS="$NIX_LDFLAGS" CFLAGS="$NIX_CFLAGS_COMPILE"

      # breakpointHook
      echo "eyeyeyeye"

  '';

  buildPhase = ''
    echo BUILDING
    # make
    exit 1
  '';

  meta = with stdenv.lib; {

    description = "A Basic High Level Synthesis System Using LLVM";
  };
}
