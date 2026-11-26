{ host, ... }: {
  imports = [ ./hosts/${host}.nix ];

  home.username = "dave";
  home.homeDirectory = "/home/dave";

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
