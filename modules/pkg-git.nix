{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      git
    ];

    etc."gitconfig".text = ''
      [init]
      defaultBranch = main
      [core]
      autocrlf = input
    '';
  };
}
