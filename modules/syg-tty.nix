{ ... }: {
  services.xserver.xkb = {
    layout = "cz";
    variant = "coder";
    options = "caps:swapescape";
  };
  console.useXkbConfig = true;
}
