{ pkgs, ... }: {
  imports = [
    ./pgr-rust.nix
  ];

  home.packages = with pkgs; [
    jetbrains.rust-rover
  ];
}
