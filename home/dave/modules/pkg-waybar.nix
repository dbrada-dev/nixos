{ ... }: {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        mod = "dock";
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;
        height = 0;

        modules-left = [
          "clock"
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "tray"
          "hyprland/language"
          "backlight"
          "battery"
          "pulseaudio"
          "pulseaudio#microphone"
          "bluetooth"
          "network"
        ];

        "hyprland/language" = {
          format = {};
          format-en = "US";
        };

        "hyprland/window" = {
          format = "{}";
        };

        "hyprland/workspaces" = {
          on-scroll-up = "hyprctl dispatch \"hl.dsp.focus({workspace = 'r+1'})\"";
          on-scroll-down = "hyprctl dispatch \"hl.dsp.focus({workspace = 'r-1'})\"";
          all-outputs = true;
          on-click = "activate";
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
            "6" = [ ];
            "7" = [ ];
            "8" = [ ];
            "9" = [ ];
            "10" = [ ];
          };
        };

        tray = {
          icon-size = 13;
          spacing = 10;
        };

        clock = {
          format = "{:%Y-%m-%d %H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [ "󰃞" "󰃟" "󰃠" ];
          on-scroll-up = "brightnessctl set 1%+";
          on-scroll-down = "brightnessctl set 1%-";
          min-length = 6;
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [ "󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          tooltip = false;
          format-muted = "󰝟 Muted";
          on-click = "pamixer -t";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          scroll-step = 5;
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋎";
            headset = "󰋎";
            phone = "󰏲";
            portable = "󰏲";
            car = "󰄄";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭 Muted";
          on-click = "pamixer --default-source -t";
          on-scroll-up = "pamixer --default-source -i 5";
          on-scroll-down = "pamixer --default-source -d 5";
          scroll-step = 5;
        };

        bluetooth = {
          format-on = "󰂯";
          format-off = "󰂲";
          format-disabled = "";
          format-connected = "󰂱 {num_connections}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          on-click = "foot bluetui";
        };

        network = {
          format-wifi = "{essid} {icon}";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          format-ethernet = "󰈀";
          format-linked = "{ifname} 󰈀";
          format-disconnected = "󰤫";
          tooltip-format = "{ifname} via {gwaddr}";
          on-click = "foot wlctl";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: Cartograph CF Nerd Font, monospace;
        font-weight: bold;
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(21, 18, 27, 0);
        color: #cdd6f4;
      }

      tooltip {
        background: #1e1e2e;
        border-radius: 10px;
        border-width: 2px;
        border-style: solid;
        border-color: #11111b;
      }

      #workspaces button {
        padding: 5px;
        color: #313244;
        margin-right: 5px;
      }

      #workspaces button.active {
        color: #a6adc8;
      }

      #workspaces button.focused {
        color: #a6adc8;
        background: #eba0ac;
        border-radius: 10px;
      }

      #workspaces button.urgent {
        color: #11111b;
        background: #a6e3a1;
        border-radius: 10px;
      }

      #workspaces button:hover {
        background: #11111b;
        color: #cdd6f4;
        border-radius: 10px;
      }

      #window,
      #clock,
      #battery,
      #language,
      #pulseaudio,
      #network,
      #workspaces,
      #tray,
      #bluetooth,
      #backlight {
        background: #000000;
        border-color: #1A1A1A;
        border-style: solid;
        padding: 0px 10px;
        margin: 0px 0px;
        margin-top: 3px;
        border-width: 1px;
        color: #E0E0E0;
      }

      #language {
        border-radius: 10px 0px 0px 10px;
        border-right: 0px;
      }

      #clock {
        border-radius: 10px;
        margin-left: 3px;
      }

      #workspaces {
        border-radius: 10px;
        margin-left: 10px;
        padding-right: 0px;
        padding-left: 5px;
      }

      #window {
        border-radius: 10px;
        margin-left: 60px;
        margin-right: 60px;
      }

      #tray {
        border-radius: 10px;
        margin-right: 10px;
      }

      #battery {
        border-left: 0px;
        border-right: 0px;
      }

      #backlight {
        border-left: 0px;
        border-right: 0px;
      }

      #pulseaudio {
        border-left: 0px;
        border-right: 0px;
      }

      #pulseaudio.microphone {
        border-left: 0px;
        border-right: 0px;
      }

      #bluetooth {
        border-left: 0px;
        border-right: 0px;
      }

      #network {
        border-radius: 0px 10px 10px 0px;
        border-left: 0px;
        margin-right: 3px;
        padding-right: 15px;
      }
    '';
  };
}
