{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    qemu
    spice-gtk
    virt-viewer
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  systemd.services.virtnetworkd.path = with pkgs; [
    dnsmasq
    iptables
    iproute2
  ];

  programs.virt-manager.enable = true;

  systemd.sockets.virtnetworkd.wantedBy = [ "sockets.target" ];
  systemd.sockets.virtqemud.wantedBy = [ "sockets.target" ];
}
