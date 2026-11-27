{ device, lib, pkgs,  ... }:

let
  customEntries = device.boot-entries or {};

  mkGrubEntry = name: entry:
    let
      efiPath = "/${lib.removePrefix "/" entry.path}";
      title = entry.label or name;
      searchCmd =
        if (entry.nix-efi or false) then
          "search --no-floppy --file --set=root ${efiPath}"
        else
          "search --no-floppy --fs-uuid --set=root ${entry.uuid}";
    in
    ''
      menuentry "${title}" {
        insmod part_gpt
        insmod fat
        ${searchCmd}
        chainloader ${efiPath}
      }
    '';

  biosEntry = ''
    menuentry "UEFI Firmware Settings" --id "uefi-firmware" {
      fwsetup
    }
  '';

  deviceEntries = lib.concatStringsSep "\n" (
    (lib.mapAttrsToList mkGrubEntry customEntries) ++ [ biosEntry ]
  );
in
{
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    useOSProber = false;
    enableCryptodisk = true;
    extraEntriesBeforeNixOS = false;
    configurationLimit = 5;

    mirroredBoots = [
      {
        path = "/boot/efi";
        efiSysMountPoint = "/boot/efi";
        devices = [ "nodev" ];
      }
    ];

    extraEntries = deviceEntries;

    extraInstallCommands = ''
      if [ -f /boot/efi/EFI/NixOS-boot-efi/grubx64.efi ]; then
        ${pkgs.coreutils}/bin/mkdir -p /boot/efi/EFI/BOOT /boot/efi/EFI/nixos-grub
        ${pkgs.coreutils}/bin/cp -f /boot/efi/EFI/NixOS-boot-efi/grubx64.efi /boot/efi/EFI/BOOT/BOOTX64.EFI
        ${pkgs.coreutils}/bin/rm -rf /boot/efi/EFI/nixos-grub
        ${pkgs.coreutils}/bin/mv -f /boot/efi/EFI/NixOS-boot-efi /boot/efi/EFI/nixos-grub
      fi
    '';
  };
}
