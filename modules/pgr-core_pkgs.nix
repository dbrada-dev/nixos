{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    curl
    wget
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
  ];
}
