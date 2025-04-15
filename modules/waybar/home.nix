{
  lib,
  pkgs,
  ...
}:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        output = [ "*" ];
        mod = "dock";
        height = 31;
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;
        reload_style_on_change = true;

        modules-left = [
          "custom/padd"
          "custom/l_end"
          "cpu"
          "memory"
          "battery"
          "custom/r_end"
          "custom/l_end"
          "hyprland/workspaces"
          "custom/r_end"
          "custom/padd"
        ];
        modules-right = [
          "custom/padd"
          "custom/l_end"
          "privacy"
          "tray"
          "custom/r_end"
          "custom/l_end"
          "backlight"
          "network"
          "pulseaudio"
          "pulseaudio#microphone"
          "custom/r_end"
          "custom/l_end"
          "clock"
          "custom/r_end"
          "custom/l_end"
          "custom/notification"
          "custom/r_end"
          "custom/padd"
        ];

        cpu = {
          format = "󰍛 {usage}%";
          format-alt = "{icon0}{icon1}{icon2}{icon3}";
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
          interval = 10;
          rotate = 0;
        };
        memory = {
          format = "󰾆 {used}GB";
          format-alt = "󰾆 {percentage}%";
          format-c = " {used}GB";
          format-h = "󰓅 {used}GB";
          format-m = "󰾅 {used}GB";
          interval = 30;
          max-length = 10;
          rotate = 0;
          states = {
            c = 90;
            h = 60;
            m = 30;
          };
          tooltip = true;
          tooltip-format = "󰾆 {percentage}%\n {used:0.1f}GB/{total:0.1f}GB";
        };
        battery = {
          format = "{icon} {capacity}%";
          format-alt = "{time} {icon}";
          format-charging = " {capacity}%";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          format-plugged = " {capacity}%";
          rotate = 0;
          states = {
            critical = 20;
            good = 95;
            warning = 30;
          };
        };

        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
          disable-scroll = false;
          on-click = "activate";
          on-scroll-down = "hyprctl dispatch workspace +1";
          on-scroll-up = "hyprctl dispatch workspace -1";
          persistent-workspaces = { };
          rotate = 0;
        };

        privacy = {
          icon-size = 14;
          icon-spacing = 5;
          modules = [
            {
              tooltip = true;
              tooltip-icon-size = 24;
              type = "screenshare";
            }
            {
              tooltip = true;
              tooltip-icon-size = 24;
              type = "audio-in";
            }
          ];
          transition-duration = 250;
        };
        tray = {
          icon-size = 18;
          rotate = 0;
          spacing = 5;
        };

        backlight = {
          format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          min-length = 6;
          rotate = 0;
        };
        network = {
          format-alt = "<span foreground='#99ffdd'> {bandwidthDownBytes}</span> <span foreground='#ffcc66'> {bandwidthUpBytes}</span>";
          format-disconnected = "󰖪 ";
          format-ethernet = "󰈀 ";
          format-linked = "󰈀 {ifname} (No IP)";
          format-wifi = " ";
          interval = 2;
          rotate = 0;
          tooltip = true;
          tooltip-format = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
          tooltip-format-disconnected = "Disconnected";
        };
        pulseaudio = {
          format = "{icon} {volume}";
          format-icons = {
            car = "";
            default = [
              ""
              ""
              ""
            ];
            hands-free = "";
            headphone = "";
            headset = "";
            phone = "";
            portable = "";
          };
          format-muted = "󰖁 {volume}";
          rotate = 0;
          scroll-step = 1;
          tooltip-format = "{icon} {desc} // {volume}%";
        };
        "pulseaudio#microphone" = {
          format = "{format_source} {source_volume}";
          format-source = "";
          format-source-muted = "󰍭";
          rotate = 0;
          scroll-step = 1;
          tooltip-format = "{format_source} {source_desc} // {source_volume}%";
        };

        clock = {
          format = " {:%R 󰃭 %m·%d}";
          rotate = 0;
          tooltip-format = "<span>{calendar}</span>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              today = "<span color='#ff6699'><b>{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "custom/notification" = {
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          min-length = 2;
          tooltip = false;
          escape = true;
        };

        "custom/padd" = {
          format = "  ";
          interval = "once";
          tooltip = false;
        };
        "custom/l_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
        "custom/r_end" = {
          format = " ";
          interval = "once";
          tooltip = false;
        };
      };
    };
    style = ''
      * {
          border: none;
          border-radius: 0px;
          font-family: "JetBrainsMono Nerd Font";
          font-weight: bold;
          font-size: 10px;
          min-height: 10px;
      }

      window#waybar {
          background: alpha(@base, 0);
      }

      tooltip {
          background: alpha(@base, 0.8);
          color: alpha(@text, 0.8);
          border-radius: 7px;
          border-width: 0px;
      }

      #workspaces button {
          box-shadow: none;
      	  text-shadow: none;
          padding: 0px;
          border-radius: 9px;
          margin-top: 3px;
          margin-bottom: 3px;
          margin-left: 0px;
          padding-left: 3px;
          padding-right: 3px;
          margin-right: 0px;
          color: alpha(@text, 0.8);
          animation: ws_normal 20s ease-in-out 1;
      }

      #workspaces button.active {
          background: alpha(@red, 0.4);
          color: @pink;
          margin-left: 3px;
          padding-left: 12px;
          padding-right: 12px;
          margin-right: 3px;
          animation: ws_active 20s ease-in-out 1;
          transition: all 0.4s cubic-bezier(.55,-0.68,.48,1.682);
      }


      #taskbar button {
          box-shadow: none;
      	  text-shadow: none;
          padding: 0px;
          border-radius: 9px;
          margin-top: 3px;
          margin-bottom: 3px;
          margin-left: 0px;
          padding-left: 3px;
          padding-right: 3px;
          margin-right: 0px;
          color: @pink;
          animation: tb_normal 20s ease-in-out 1;
      }

      #taskbar button.active {
          background: alpha(@red, 0.4);
          color: @pink;
          margin-left: 3px;
          padding-left: 12px;
          padding-right: 12px;
          margin-right: 3px;
          animation: tb_active 20s ease-in-out 1;
          transition: all 0.4s cubic-bezier(.55,-0.68,.48,1.682);
      }

      #tray menu * {
          min-height: 16px
      }

      #tray menu separator {
          min-height: 10px
      }

      #backlight,
      #battery,
      #clock,
      #cpu,
      #memory,
      #network,
      #custom-notification,
      #privacy,
      #pulseaudio,
      #taskbar,
      #tray,
      #window,
      #workspaces,
      #custom-l_end,
      #custom-r_end,
      #custom-sl_end,
      #custom-sr_end,
      #custom-rl_end,
      #custom-rr_end {
          color: alpha(@text, 0.8);
          background: alpha(@base, 0.6);
          opacity: 1;
          margin: 4px 0px 4px 0px;
          padding-left: 4px;
          padding-right: 4px;
      }

      #workspaces,
      #taskbar {
          padding: 0px;
      }

      #custom-r_end {
          border-radius: 0px 21px 21px 0px;
          margin-right: 9px;
          padding-right: 3px;
      }

      #custom-l_end {
          border-radius: 21px 0px 0px 21px;
          margin-left: 9px;
          padding-left: 3px;
      }

      #custom-sr_end {
          border-radius: 0px;
          margin-right: 9px;
          padding-right: 3px;
      }

      #custom-sl_end {
          border-radius: 0px;
          margin-left: 9px;
          padding-left: 3px;
      }

      #custom-rr_end {
          border-radius: 0px 7px 7px 0px;
          margin-right: 9px;
          padding-right: 3px;
      }

      #custom-rl_end {
          border-radius: 7px 0px 0px 7px;
          margin-left: 9px;
          padding-left: 3px;
      }
    '';
  };
  fonts.fontconfig.enable = lib.mkDefault true;
  home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  wayland.windowManager.hyprland.settings = {
    layerrule = [ "blur, waybar" ];
  };

  catppuccin.waybar = {
    enable = true;
  };
}
