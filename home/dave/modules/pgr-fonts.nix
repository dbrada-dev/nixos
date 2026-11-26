{ pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    liberation_ttf
    corefonts
  ];

  fonts.fontconfig.enable = true;
}
