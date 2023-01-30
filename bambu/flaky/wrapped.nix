{ pkgs ? import <nixpkgs> { }, bambu-unwrapped }:
with pkgs;
pkgs.runCommand "bambu"
{
  buildInputs = [ pkgs.makeWrapper ];
} ''
  mkdir $out
  ln -s ${bambu-unwrapped }/* $out
  rm $out/bin
  mkdir $out/bin
  ln -s ${bambu-unwrapped}/bin/* $out/bin
  rm $out/bin/bambu
  # Because we create this ourself, by creating a wrapper
  makeWrapper ${bambu-unwrapped }/bin/bambu $out/bin/bambu \
    --suffix NIX_LDFLAGS " " "-L${glibc.static}/lib"\
    --set PATH ${pkgs.lib.makeBinPath [
      gcc
      verilator
      bash
      gawk
      coreutils
      findutils
      gnumake
      gnused
      gnugrep
    ]}
''
