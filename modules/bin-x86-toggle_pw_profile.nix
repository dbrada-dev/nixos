{ lib, pkgs, ... }:

let
  power-profile = pkgs.writeShellApplication {
    name = "power-profile";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.libnotify
      pkgs.power-profiles-daemon
    ];
    text = ''
      set_profile() {
        local TARGET_MODE="$1"
        local CPU_GOV

        case "$TARGET_MODE" in
          power-saver | balanced)
            CPU_GOV="powersave"
            ;;
          performance)
            CPU_GOV="performance"
            ;;
          *)
            echo "Invalid profile: $TARGET_MODE (expected: power-saver, balanced, performance)" >&2
            exit 1
            ;;
        esac

        sudo /run/current-system/sw/bin/set-cpu-gov "$CPU_GOV"

        if powerprofilesctl set "$TARGET_MODE"; then
          notify-send -t 2000 "Power profile: $TARGET_MODE" "Preference: $TARGET_MODE\nGovernor: $CPU_GOV"
        else
          if [ "$TARGET_MODE" = "performance" ]; then
            sudo /run/current-system/sw/bin/set-cpu-gov "powersave"
            powerprofilesctl set "balanced"
            notify-send -t 5000 "Power profile $TARGET_MODE unavailable" "Fallback to:\nPreference: balanced\nGovernor: powersave" --icon=dialog-error
          else
            notify-send -t 5000 "Power profile error" "Failed to switch power profile"
          fi
        fi
      }

      toggle_profile() {
        local CURRENT_MODE
        CURRENT_MODE=$(powerprofilesctl get)

        if [ "$CURRENT_MODE" = "power-saver" ]; then
          set_profile "balanced"
        elif [ "$CURRENT_MODE" = "balanced" ]; then
          set_profile "performance"
        else
          set_profile "power-saver"
        fi
      }

      # Default to toggling if no flags are passed
      if [ $# -eq 0 ]; then
        toggle_profile
        exit 0
      fi

      while getopts "gs:t" opt; do
        case "$opt" in
          g)
            powerprofilesctl get
            ;;
          s)
            set_profile "$OPTARG"
            ;;
          t)
            toggle_profile
            ;;
          *)
            echo "Usage: power-profile [-g | -s <power-saver|balanced|performance> | -t]" >&2
            exit 1
            ;;
        esac
      done
    '';
  };
in
{
  imports = [
    ./bin-set_cpu_gov.nix
  ];

  config = lib.mkIf pkgs.stdenv.hostPlatform.isx86_64 {
    services.power-profiles-daemon.enable = true;
    environment.systemPackages = [ power-profile ];
  };
}
