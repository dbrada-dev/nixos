{ pkgs, lib, ... }: {
  programs.nix-ld = {
    enable = true;
    libraries = lib.mkAfter (with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
      libxml2
      ncurses5
    ]);
  };
}
