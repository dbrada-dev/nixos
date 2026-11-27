{ ... }: {
  imports = [
    ./hardware.nix
    # Users
    ../../modules/usr-dave.nix
    # Packages
    ../../modules/pkg-fish.nix
    ../../modules/pkg-git.nix
    ../../modules/pkg-hyprland.nix
    ../../modules/pkg-mssql.nix
    ../../modules/pkg-neovim_nvchad.nix
    ../../modules/pkg-nix_ld.nix
    ../../modules/pkg-qemu.nix
    ../../modules/pkg-steam.nix
    ## Package groups
    ../../modules/pgr-core_pkgs.nix
    # Services
    ../../modules/srv-bluetooth.nix
    ../../modules/srv-network_manager.nix
    ../../modules/srv-ssh_off.nix
    # System
    ../../modules/sys-experimental.nix
    ../../modules/sys-grub.nix
    ../../modules/sys-locale_prg.nix
    ../../modules/sys-shell.nix
    ../../modules/sys-sudo.nix
    ## System groups
    ../../modules/syg-tty.nix
    ## Kernels
    ../../modules/efi-cachy_uki.nix
    # Scripts
    ../../modules/bin-x86-toggle_pw_profile.nix
  ];

  networking.hostName = "laptop-msi";
  system.stateVersion = "26.05";
}
