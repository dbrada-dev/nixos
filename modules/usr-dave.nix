{ ... }: {
  users.users.dave = {
    isNormalUser = true;
    description = "Dave";
    extraGroups = [
      "wheel"
      "networkmanager"
      "dialout"
      "libvirtd"
      "kvm"
    ];
  };

  security.sudo.extraRules = [
    {
      users = [ "dave" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-rebuild switch";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  home-manager.users.dave = import ../home/dave/home.nix;
}
