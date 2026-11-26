{ ... }: {
  imports = [
    ./srv-32bit_graphics.nix
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };
}
