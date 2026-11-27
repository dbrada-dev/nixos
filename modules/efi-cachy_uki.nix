{ config, pkgs, lib, ... }:

{
  imports = [
    ./pkg-chaotic.nix
    ./sys-grub.nix
  ];

  boot.kernelPackages = pkgs.linuxPackagesFor config.inputs.chaoticPkgs.linux_cachyos;

  boot.loader.grub = {
    extraEntries = lib.mkBefore ''
      menuentry "NixOS CachyOS (UKI)" {
        insmod part_gpt
        insmod fat
        search --no-floppy --file --set=root /EFI/nixos-cachy.efi
        chainloader /EFI/nixos-cachy.efi
      }
    '';

    extraPrepareConfig = ''
      UKI_DIR="/boot/efi/EFI"
      UKI_OUT="$UKI_DIR/nixos-cachy.efi"
      TOPLEVEL="/nix/var/nix/profiles/system"

      mkdir -p "$UKI_DIR"

      CMDLINE="$(cat "$TOPLEVEL/kernel-params") init=$(readlink -f "$TOPLEVEL")/init"

      ${pkgs.systemdUkify}/bin/ukify build \
        --linux="$TOPLEVEL/kernel" \
        --initrd="$TOPLEVEL/initrd" \
        --cmdline="$CMDLINE" \
        --stub="${pkgs.systemd}/lib/systemd/boot/efi/linuxx64.efi.stub" \
        --output="$UKI_OUT.tmp"

      mv -f "$UKI_OUT.tmp" "$UKI_OUT"
    '';
  };
}
