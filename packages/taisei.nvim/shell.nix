{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;
mkShell {
  name = "pvz.nvim";
  env = {
    ZSTD_INCDIR = "${zstd.dev}/include";
    ZSTD_LIBDIR = "${zstd.out}/lib";
  };
  buildInputs = [
    kaitai-struct-compiler
    perl

    zstd

    taisei
  ];
}
