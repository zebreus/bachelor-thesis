{ pkgs ? import <nixpkgs> { }
}:

with pkgs;
stdenv.mkDerivation rec {
  pname = "thesis";
  version = "0.0.0";

  src = ./.;

  buildInputs = [
    verilator
  ];

  nativeBuildInputs = [
    # For docs
    asciidoctor-web-pdf
    asciidoctor-js
    graphviz
    gnuplot
    nodePackages.vega-cli
    nodePackages.vega-lite
    pikchr
    python3
    symbolator
    adoptopenjdk-hotspot-bin-15
    nodePackages.wavedrom-cli
    vcd2wavedrom
    sass

    # Utils
    gnumake
    nixpkgs-fmt
    nil
    bambu
    jq

    # For rust
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    fenix.rust-analyzer
    cacert

    # For verilog
    yosys
    nextpnrWithGui
    icestorm
    python3
    verilator
    clang
  ];

  buildPhase = ''
    mkdir -p styles
    mkdir -p images
    make index.html
  '';

  installPhase = ''
    mkdir -p $out
    cp -r *.html *.css images $out

    cp thesis.pdf $out
   
    mkdir -p $out/bin
    cat <<EOF > $out/bin/${pname}.py
    #!/usr/bin/env python3
    
    import http.server

    DIRECTORY = "$out"
    
    class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
        def __init__(self, *args, **kwargs):
            super().__init__(*args, directory=DIRECTORY, **kwargs)

        def end_headers(self):
            self.send_my_headers()
            http.server.SimpleHTTPRequestHandler.end_headers(self)
    
        def send_my_headers(self):
            self.send_header("Cache-Control", "no-cache, no-store, must-revalidate")
            self.send_header("Pragma", "no-cache")
            self.send_header("Expires", "0")
    
    
    if __name__ == '__main__':
        http.server.test(HandlerClass=MyHTTPRequestHandler)
    EOF
    chmod a+x $out/bin/${pname}.py
  '';

  meta.mainProgram = "${pname}.py";
}
