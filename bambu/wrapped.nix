{ pkgs ? import <nixpkgs> { } }:
with pkgs;
pkgs.runCommand "bambu-wrapped"
{
  buildInputs = [ pkgs.makeWrapper ];
  meta.mainProgram = "bambu";
} ''
  mkdir $out
  ln -s ${bambu-unwrapped}/* $out
  rm $out/bin
  mkdir $out/bin
  ln -s ${bambu-unwrapped}/bin/* $out/bin
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
