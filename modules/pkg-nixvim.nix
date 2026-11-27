{ config, ... }: 

let
  flake-compat = import ./nix-flake-compat.nix;
  nixvim = (flake-compat {
    src = builtins.fetchTarball
      "https://github.com/nix-community/nixvim/archive/main.tar.gz";
  }).defaultNix;
in
{
  imports = [
    nixvim.nixosModules.nixvim
  ];

  inputs.nixvim = (config.inputs.flake-compat { src = nixvim; }).defaultNix;
}
