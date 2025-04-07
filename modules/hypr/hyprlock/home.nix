{
  config,
  pkgs,
  ...
}: let
  paper = (import ../hyprpaper/paper.nix pkgs).paper;
in
  with config.wayland.windowManager.hyprland.settings; {
    programs.hyprlock = {
      enable = true;
      settings = {
        background = {
          monitor = "";
          path = "${paper}";
          blur_size = decoration.blur.size;
          blur_passes = decoration.blur.passes;
        };
        label = [
          {
            monitor = "";
            text = "cmd[update:1000] echo \"<b><big> $(date +\"%H:%M\") </big></b>\"";
            color = "$maroon";
            font_size = 150;
            font_family = "JetBrains Mono Nerd Font";
            shadow_passes = 3;
            shadow_size = 4;

            position = "0, -280";
            halign = "center";
            valign = "top";
          }
          {
            monitor = "";
            text = "cmd[update:18000000] echo \"<b><big> \"$(date +'%A')\" </big></b>\"";
            color = "$pink";
            font_size = 40;
            font_family = "JetBrains Mono Nerd Font";

            position = "0, -520";
            halign = "center";
            valign = "top";
          }
          {
            monitor = "";
            text = "cmd[update:18000000] echo \"<b> \"$(date +'%d %b')\" </b>\"";
            color = "$pink";
            font_size = 25;
            font_family = "JetBrains Mono Nerd Font";

            position = "0, -580";
            halign = "center";
            valign = "top";
          }
          {
            monitor = "";
            text = "cmd[update:18000000] echo \"<b><big> $(cat /sys/class/power_supply/BAT0/capacity) </big>Remaining</b>\"";
            color = "$pink";
            font_size = 20;
            font_family = "JetBrains Mono Nerd Font";

            position = "0, 50";
            halign = "center";
            valign = "bottom";
          }
        ];
        input-field = {
          monitor = "";
          size = "250, 50";
          outline_thickness = 3;

          dots_size = 0.26;
          dots_spacing = 0.64;
          dots_center = true;
          dots_rouding = -1;

          rounding = 22;
          outer_color = "$flamingo";
          inner_color = "$rosewater";
          font_color = "$maroon";
          fade_on_empty = true;
          placeholder_text = "<i>Password...</i>";

          position = "0, 130";
          halign = "center";
          valign = "bottom";
        };
      };
    };
    catppuccin.hyprlock = {
      enable = true;
      useDefaultConfig = false;
    };

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "uwsm app -- hyprlock || uwsm stop" # autologin into hyprlock
      ];
      bind = [
        "$mainMod, L, exec, uwsm app -- hyprlock"
      ];
    };
    services.hypridle.settings = {
      general = {
        lock_cmd = "pidof hyprlock || uwsm app -- hyprlock";
      };
    };
  }
