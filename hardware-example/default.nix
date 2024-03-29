{ pkgs ? import <nixpkgs> { }
}:

with pkgs;
stdenv.mkDerivation {
  pname = "hardware-example";
  version = "0.0.0";

  src = ./.;

  buildInputs = [
    yosys
    nextpnrWithGui
    icestorm
    python3
    verilator
  ];

  installPhase = ''
    mkdir -p $out
    cp rotate.bin $out

    mkdir -p $out/bin
    cat <<EOF > $out/bin/flash-program.sh
    #!/bin/bash
    ${icestorm}/bin/iceprog $out/rotate.bin
    EOF
    chmod a+x $out/bin/flash-program.sh
  '';



  meta = {
    description = "Example project for deploying to icestick";
    mainProgram = "flash-program.sh";
  };
}
