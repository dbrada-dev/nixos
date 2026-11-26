{ inputs, pkgs, ... }: 

let
  wlctl = (inputs.flake-compat {
    src = builtins.fetchTarball
      "https://github.com/aashish-thapa/wlctl/archive/main.tar.gz";
  }).defaultNix;
in
{
  home.packages = [
    wlctl.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
