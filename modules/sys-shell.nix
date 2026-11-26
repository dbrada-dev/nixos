{ pkgs, ... }: {
  imports = [
    ./pkg-starship.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      bat
      eza
      libarchive
    ];

    shellAliases = {
      da = "date +'%Y-%m-%dT%H:%M:%S%z'";
      ls = "eza -l --color=always --group-directories-first";
      la = "eza -al --color=always --group-directories-first";
      cat = "bat -p";
      archive = "bsdtar -acvf";
      extract = "bsdtar -xvf";
      lsblkp = "lsblk -o NAME,FSTYPE,TYPE,SIZE,UUID,PARTUUID,MAJ:MIN,RM,RO,MOUNTPOINTS";
    };
  };
}
