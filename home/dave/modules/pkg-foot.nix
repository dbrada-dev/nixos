{ ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "MesloLGS Nerd Font:size=12";
      };

      colors-dark = {
        background = 111111;
        alpha = 0.7;
      };

      key-bindings = {
        font-reset = "Control+0";
        font-increase = "Control+equal";
        font-decrease = "Control+minus";
      };

      bell = {
        visual="no";
        system="no";
        urgent="no";
      };
    };
  };
}
