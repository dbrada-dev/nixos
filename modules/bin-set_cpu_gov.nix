{ pkgs, ... }:

let
  set-cpu-gov = pkgs.writeShellApplication {
    name = "set-cpu-gov";
    runtimeInputs = [ pkgs.coreutils ];
    text = ''
      if [[ "$EUID" -ne 0 ]]; then
        echo "Error: set-cpu-gov must be run with sudo." >&2
        exit 1
      fi

      GOV="''${1:-}"
      AVAIL_FILE="/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors"

      if [[ ! -f "$AVAIL_FILE" ]]; then
        echo "Error: cpufreq is not supported on this hardware." >&2
        exit 1
      fi

      case "$GOV" in
        performance|powersave|schedutil)
          if ! grep -qw "$GOV" "$AVAIL_FILE"; then
            echo "Error: '$GOV' not available. Supported: $(cat "$AVAIL_FILE")" >&2
            exit 1
          fi
          echo "$GOV" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
          ;;
        *)
          echo "Usage: sudo set-cpu-gov {performance|powersave|schedutil}" >&2
          exit 1
          ;;
      esac
    '';
  };
in
{
  environment.systemPackages = [ set-cpu-gov ];
  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/set-cpu-gov performance";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/set-cpu-gov powersave";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
