{ lib, ... }:

let
  device-data = builtins.fromTOML (builtins.readFile ./device.toml);
in
{
  imports = [
    ./hosts/${device-data.host}/config.nix
  ];

  options.inputs = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.unspecified;
    default = {};
  };

  config = {
    inputs = {};

    _module.args = {
      device = device-data;
    };

    nixpkgs.hostPlatform = device-data.system;

    nix.nixPath = [
      "nixos-config=/etc/nixos/configuration.nix"
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
  };
}
