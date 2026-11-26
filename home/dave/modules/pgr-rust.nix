{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      gcc
      rustup
    ];
    sessionPath = [
      "$HOME/.cargo/bin"
    ];
  };
}
