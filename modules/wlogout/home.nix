{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.wlogout];
  programs.wlogout = {
    enable = true;
    layout = [
      {
        action = "loginctl lock-session";
        keybind = "l";
        label = "lock";
        text = "Lock";
      }
      {
        action = "uwsm stop";
        keybind = "e";
        label = "logout";
        text = "Logout";
      }
      {
        action = "systemctl suspend";
        keybind = "s";
        label = "suspend";
        text = "Suspend";
      }
      {
        action = "systemctl hibernate";
        keybind = "h";
        label = "hibernate";
        text = "Hibernate";
      }
      {
        action = "systemctl poweroff";
        keybind = "s";
        label = "shutdown";
        text = "Shutdown";
      }
      {
        action = "systemctl reboot";
        keybind = "r";
        label = "reboot";
        text = "Reboot";
      }
    ];
    style = let
      colors = config.catppuccin-nix.theme.colors;
      hypr_border = config.wayland.windowManager.hyprland.settings.decoration.rounding;
      font_size = 28;
      button_width = font_size * 5;
      active_rad = toString (hypr_border * 8);
      button_rad = toString (hypr_border * 5);
      mgn = "268"; #TODO dynamic detect
      hvr = "220";
    in
      lib.mkForce ''
        * {
            background-image: none;
            font-size: ${toString font_size}px;
        }

        window {
            background-color: transparent;
        }

        button {
            color: white;
            background-color: alpha(${colors.base.hex}, 0.8);
            outline-style: none;
            border: none;
            border-width: 0px;
            background-repeat: no-repeat;
            background-position: center;
            background-size: 20%;
            min-width: ${toString button_width}px;
            border-radius: 0px;
            box-shadow: none;
            text-shadow: none;
            animation: gradient_f 20s ease-in infinite;
        }

        button:focus {
            background-color: alpha(${colors.red.hex}, 0.4);
            background-size: 30%;
        }

        button:hover {
            background-color: alpha(${colors.surface2.hex}, 0.4);
            background-size: 40%;
            border-radius: ${active_rad}px;
            animation: gradient_f 20s ease-in infinite;
            transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
        }

        button:hover#lock {
            border-radius: ${active_rad}px;
            margin : ${hvr}px 0px ${hvr}px ${mgn}px;
        }

        button:hover#logout {
            border-radius: ${active_rad}px;
            margin : ${hvr}px 0px ${hvr}px 0px;
        }

        button:hover#suspend {
            border-radius: ${active_rad}px;
            margin : ${hvr}px 0px ${hvr}px 0px;
        }

        button:hover#shutdown {
            border-radius: ${active_rad}px;
            margin : ${hvr}px 0px ${hvr}px 0px;
        }

        button:hover#hibernate {
            border-radius: ${active_rad}px;
            margin : ${hvr}px 0px ${hvr}px 0px;
        }

        button:hover#reboot {
            border-radius: ${active_rad}px;
            margin : ${hvr}px ${mgn}px ${hvr}px 0px;
        }

        #lock {
            background-image: image(url("/home/paichen/.config/wlogout/icons/lock_white.png"));
            border-radius: ${button_rad}px 0px 0px ${button_rad}px;
            margin : ${mgn}px 0px ${mgn}px ${mgn}px;
        }

        #logout {
            background-image: image(url("/home/paichen/.config/wlogout/icons/logout_white.png"));
            border-radius: 0px 0px 0px 0px;
            margin : ${mgn}px 0px ${mgn}px 0px;
        }

        #suspend {
            background-image: image(url("/home/paichen/.config/wlogout/icons/suspend_white.png"));
            border-radius: 0px 0px 0px 0px;
            margin : ${mgn}px 0px ${mgn}px 0px;
        }

        #shutdown {
            background-image: image(url("/home/paichen/.config/wlogout/icons/shutdown_white.png"));
            border-radius: 0px 0px 0px 0px;
            margin : ${mgn}px 0px ${mgn}px 0px;
        }

        #hibernate {
            background-image: image(url("/home/paichen/.config/wlogout/icons/hibernate_white.png"));
            border-radius: 0px 0px 0px 0px;
            margin : ${mgn}px 0px ${mgn}px 0px;
        }

        #reboot {
            background-image: image(url("/home/paichen/.config/wlogout/icons/reboot_white.png"));
            border-radius: 0px ${button_rad}px ${button_rad}px 0px;
            margin : ${mgn}px ${mgn}px ${mgn}px 0px;
        }
      '';
  };

  wayland.windowManager.hyprland.settings = {
    bind = ["$mainMod, Backspace, exec, pkill -x wlogout || uwsm app -- wlogout -b 6 -m 0 -r 0 -c 0 --protocol layer-shell"];
    layerrule = ["blur, logout_dialog"];
  };
}
