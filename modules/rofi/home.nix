{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.formats.rasi) mkLiteral;

  colors = config.catppuccin-nix.theme.colors;
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun";
      show-icons = true;
      display-drun = " ";
      drun-display-format = "{name}";
      run-command = "uwsm app -- {cmd}";
    };
    font = "JetBrainsMono Nerd Font 10";
    theme = let
      hypr_border = config.wayland.windowManager.hyprland.settings.decoration.rounding;
    in
      lib.mkForce {
        window = {
          enabled = true;
          height = mkLiteral "40em";
          width = mkLiteral "25em";
          spacing = mkLiteral "0em";
          padding = mkLiteral "0em";
          border-radius = mkLiteral "${toString (hypr_border * 3)}px";
          fullscreen = false;
          cursor = "default";
          transparency = "real";
          border-color = mkLiteral (colors.maroon.hex + "40");
          background-color = mkLiteral (colors.base.hex + "b3");
        };
        mainbox = {
          enabled = true;
          spacing = mkLiteral "0em";
          padding = mkLiteral "1em";
          orientation = mkLiteral "vertical";
          children = ["inputbar" "listbox"];
          background-color = mkLiteral "transparent";
        };

        inputbar = {
          enabled = true;
          spacing = mkLiteral "0em";
          padding = mkLiteral "2em";
          border-radius = mkLiteral "${toString (hypr_border * 2)}px ${toString (hypr_border * 2)}px 0em 0em";
          children = ["entry"];
          background-color = mkLiteral (colors.base.hex + "b3");
        };
        entry = {
          enabled = true;
          spacing = mkLiteral "0em";
          padding = mkLiteral "0.8em";
          border-radius = mkLiteral "3em";
          text-color = mkLiteral colors.text.hex;
          background-color = mkLiteral (colors.surface0.hex + "b3");
        };
        listbox = {
          spacing = mkLiteral "0em";
          padding = mkLiteral "0em";
          border-radius = mkLiteral "0em 0em ${toString (hypr_border * 2)}px ${toString (hypr_border * 2)}px";
          children = ["listview"];
          background-color = mkLiteral (colors.base.hex + "b3");
        };
        listview = {
          enabled = true;
          spacing = mkLiteral "0.4em";
          padding = mkLiteral "1em";
          cursor = "default";
          layout = mkLiteral "vertical";
          columns = 1;
          lines = 9;
          cycle = true;
          dynamic = true;
          scrollbar = false;
          reverse = false;
          expand = false;
          fixed-height = true;
          fixed-columns = true;
          text-color = mkLiteral "transparent";
          background-color = mkLiteral (colors.base.hex + "b3");
        };

        element = {
          enabled = true;
          spacing = mkLiteral "1em";
          padding = mkLiteral "0.5em 0.5em 0.5em 1.5em";
          border-radius = mkLiteral "${toString (hypr_border * 2)}px";
          cursor = mkLiteral "pointer";
          text-color = mkLiteral colors.text.hex;
          background-color = mkLiteral "transparent";
        };
        "element selected.normal" = {
          text-color = mkLiteral colors.maroon.hex;
          background-color = mkLiteral (colors.red.hex + "80");
        };
        element-icon = {
          size = mkLiteral "2em";
          cursor = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
          background-color = mkLiteral "transparent";
        };
        element-text = {
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
          cursor = mkLiteral "inherit";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
        };

        error-message = {
          text-color = mkLiteral colors.text.hex;
          background-color = mkLiteral (colors.base.hex + "b3");
          text-transform = mkLiteral "capitalize";
          children = ["textbox"];
        };

        textbox = {
          text-color = mkLiteral "inherit";
          background-color = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.5";
        };
      };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, A, exec, pkill -x rofi || uwsm app -- rofi -show drun"
      "$mainMod, Tab, exec, pkill -x rofi || uwsm app -- rofi -show window"
    ];
    layerrule = [
      "blur, rofi"
      "ignorezero, rofi"
    ];
  };

  catppuccin.rofi.enable = false; # We use nixlang module
}
