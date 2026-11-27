{ config, pkgs, ... }:

let
  chaoticFlake = (config.inputs.flake-compat {
    src = builtins.fetchTarball {
      url = "https://github.com/chaotic-cx/nyx/archive/nyxpkgs-unstable.tar.gz";
    };
  }).defaultNix;

  chaoticPkgs = import chaoticFlake.inputs.nixpkgs {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
    overlays = [ chaoticFlake.overlays.default ];
  };
in
{
  imports = [
    ./pkg-flake-compat.nix
  ];

  inputs.chaotic = chaoticFlake;
  inputs.chaoticPkgs = chaoticPkgs;

  nix.settings = {
    extra-substituters = [ "https://nyx-cache.chaotic.cx/" ];
    extra-trusted-public-keys = [ "nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk=" ];
  };
}
