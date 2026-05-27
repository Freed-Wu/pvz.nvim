{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;
mkShell {
  name = "pvz.nvim";
  buildInputs = [
    kaitai-struct-compiler
    perl

    pvz-portable
  ];
}
