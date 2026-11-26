{ pkgs, ... }: {
  programs.nix-your-shell.enable = true;

  home = {
    packages = with pkgs; [
      bat
      eza
      libarchive
    ];

    shellAliases = {
      da = "date +'%Y-%m-%dT%H:%M:%S%z'";
      ls = "eza -l --color=always --group-directories-first";
      la = "eza -al --color=always --group-directories-first";
      cat = "bat -p";
      se = "sudo -E nvim";
      archive = "bsdtar -acvf";
      lsblkp = "lsblk -o NAME,FSTYPE,TYPE,SIZE,UUID,PARTUUID,MAJ:MIN,RM,RO,MOUNTPOINTS";
      gmn = "xdg-open 'https://gemini.google.com/app?=' & disown";
      update = "sudo nixos-rebuild switch";
      pkgq = "nix-store -q --requisites /run/current-system | cut -d'-' -f2- | grep -i";
      ssh-github = "ssh-agent -c | source && ssh-add ~/.ssh/github";
    };

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      CLICOLOR = "1";
      HISTCONTROL = "erasedups:ignoredups:ignorespace";
      WLR_DRM_DEVICES = "/dev/dri/card0";
      LS_COLORS = "no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:";
    };

    sessionPath = [
      "$HOME/.bin"
      "$HOME/.local/bin"
      "$HOME/.cargo/bin"
    ];
  };
}
