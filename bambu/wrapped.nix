{ pkgs ? import <nixpkgs> { }, bambu }:
with pkgs;
pkgs.runCommand "bambu-wrapped"
{
  buildInputs = [ pkgs.makeWrapper ];
} ''
  mkdir $out
  ln -s ${bambu}/* $out
  rm $out/bin
  mkdir $out/bin
  ln -s ${bambu}/bin/* $out/bin
  for f in $out/bin/*; do
    if [ -f "$f" ]; then
        wrapProgram "$f" \
          --suffix LDFLAGS " " "-L${glibc.static}/lib" \
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
            verilog
          ]}
    fi
  done

''
