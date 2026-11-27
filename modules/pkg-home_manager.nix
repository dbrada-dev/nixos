{ config, device, ... }:

let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in 
{
  imports = [
    "${home-manager}/nixos"
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inputs = config.inputs;
      host = device.host;
    };
  };
}
