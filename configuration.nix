{ ... }:

let
  device-data = builtins.fromTOML (builtins.readFile ./device.toml);

  flake-compat = import (builtins.fetchTarball
    "https://github.com/edolstra/flake-compat/archive/master.tar.gz"
  );

  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";

  nixvim-src = builtins.fetchTarball
    "https://github.com/nix-community/nixvim/archive/main.tar.gz";

  inputs = {
    inherit home-manager;
    inherit flake-compat;
    nixvim = (flake-compat { src = nixvim-src; }).defaultNix;
  };
in
{
  imports = [
    "${home-manager}/nixos"
    inputs.nixvim.nixosModules.nixvim
    ./hosts/${device-data.host}/config.nix
  ];

  nixpkgs.hostPlatform = device-data.system;

  _module.args = {
    inherit inputs;
    host = device-data.host;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit inputs;
      host = device-data.host;
    };
  };

  nix.nixPath = [
    "nixos-config=/etc/nixos/configuration.nix"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];
}
