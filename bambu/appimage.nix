{ pkgs ? import <nixpkgs> { } }:
with pkgs;
let
  bambu_appimage = fetchurl {
    url = "https://release.bambuhls.eu/appimage/bambu-0.9.8.AppImage";
    sha256 = "sha256-L0NMLu1GZ4ss8Hq/Mnav/5zZd6CbgSGetWFfaTi6R6U=";
  };
  extracted_appimage = pkgs.appimageTools.extract { inherit name src; };


in
with pkgs;
appimageTools.wrapType2 rec {
  name = "bambu";
  src = bambu_appimage;

  # runScript = ''env ARGV0="bambu" COOL="${pkgs.appimageTools.extract { inherit name src; }}" /bin/sh --'';
  # runScript = ''env ARGV0="bambu" /bin/sh --'';
  # runScript = ''env ARGV0="bambu" APPIMAGE_SILENT_INSTALL=1 APPDIR=${pkgs.appimageTools.extract { inherit name src; }} OWD=$PWD ${pkgs.appimageTools.extract { inherit name src; }}/AppRun '';
  runScript = ''env ARGV0="bambu" LLVM_SYMBOLIZER_PATH=${llvmPackages_12.llvm}/bin/llvm-symbolizer APPIMAGE_SILENT_INSTALL=1 APPDIR=${pkgs.appimageTools.extract { inherit name src; }} OWD=$PWD ${pkgs.appimageTools.extract { inherit name src; }}/AppRun '';
  extraPkgs = pkgs: with pkgs; [
    # Bambu needs a testing framework
    verilator
    # Lets also pack icarus verilog
    verilog
    # Bambu clang to process llvm
    # llvmPackages_12.clang
    # clang_multi
    # llvmPackages_12.clang_multi
    (wrapClangMulti llvmPackages_12.clang)
    llvmPackages_12.llvm

    # Bambu requires glibc to compile verilator files
    glibc.static
    glibc.dev
    glibc_multi
    glibc_multi.dev
  ];
}
