{ pkgs, ... }: {
  imports = [
    # Packages
    ../modules/pkg-fastfetch.nix
    ../modules/pkg-fish.nix
    ../modules/pkg-foot.nix
    ../modules/pkg-git.nix
    ../modules/pkg-hyprland.nix
    ../modules/pkg-hyprlock.nix
    ../modules/pkg-neovim.nix
    ../modules/pkg-rofi.nix
    ../modules/pkg-rust_rover.nix
    ../modules/pkg-starship.nix
    ../modules/pkg-swaync.nix
    ../modules/pkg-waybar.nix
    ../modules/pkg-wlctl.nix
    ../modules/pkg-yazi.nix
    ../modules/pkg-zoxide.nix
    # Package groups
    ../modules/pgr-fonts.nix
    ../modules/pgr-rust.nix
    ../modules/pgr-rust_esp32.nix
    ../modules/pgr-xdg_portals.nix
    # System
    ../modules/sys-shell.nix
  ];

  home.packages = with pkgs; [
    adwaita-icon-theme
    antigravity-cli
    bluetui
    brightnessctl
    ciscoPacketTracer9
    dbeaver-bin
    dotnetCorePackages.sdk_10_0
    exiftool
    fd
    ffmpeg
    ffmpegthumbnailer
    figlet
    file
    firefox
    fzf
    glow
    grimblast
    htop
    imv
    jetbrains.idea
    jetbrains.rider
    jq
    maven
    obsidian
    openjdk25
    pamixer
    poppler-utils
    python3
    ripgrep
    swappy
    swaybg
    swayosd
    unityhub
    util-linux
    vesktop
    whitesur-icon-theme
    wl-clipboard
    wlsunset
    xdg-utils
    zathura
  ];
}
