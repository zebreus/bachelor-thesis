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
  # or wrapType1
  name = "bambu";
  src = bambu_appimage;

  # runScript = ''env ARGV0="bambu" COOL="${pkgs.appimageTools.extract { inherit name src; }}" /bin/sh --'';
  # runScript = ''env ARGV0="bambu" appimage-exec.sh -d -w ${pkgs.appimageTools.extract { inherit name src; }} --'';
  runScript = ''env ARGV0="bambu" APPIMAGE_SILENT_INSTALL=1 APPDIR=${pkgs.appimageTools.extract { inherit name src; }} OWD=$PWD ${pkgs.appimageTools.extract { inherit name src; }}/AppRun '';
  extraPkgs = pkgs: with pkgs; [ ];
}
