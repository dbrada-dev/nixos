{ pkgs, ... }: {
  imports = [
    ./pgr-rust.nix
  ];

  home.packages = with pkgs; [
    cargo-generate
    cmake
    espflash
    esp-generate
    espup
    ldproxy
    ninja
    openssl
    pkg-config
    probe-rs-tools
    python3
  ];
  home.sessionPath = [
    "$HOME/.local/share/esp-toolchain/bin"
  ];
}
