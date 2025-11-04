{
  lib,
  config,
  ...
}:
let
  colors = config.catppuccin-nix.theme.colors;
in
{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "highest";
      control-center-margin-top = 0;
      control-center-margin-bottom = 0;
      control-center-margin-right = 0;
      control-center-margin-left = 0;
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = true;
      relative-timestamps = true;
      control-center-width = 500;
      control-center-height = 600;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-action = true;
      hide-on-clear = false;
      script-fail-notify = true;
      widgets = [
        "inhibitors"
        "title"
        "dnd"
        "mpris"
        "notifications"
      ];
      widget-config = {
        inhibitors = {
          text = "Inhibitors";
          button-text = "Clear All";
          clear-all-button = true;
        };
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 5;
          text = "Label Text";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
          autohide = true;
          blur = true;
        };
      };
    };
    style = ''
      * {
        all: unset;
        font-size: 14px;
        font-family: "JetBrains Mono Nerd Font";
        transition: 200ms;
      }

      trough highlight {
        background: ${colors.text.hex};
      }

      scale {
        margin: 0 7px;
      }

      scale trough {
        margin: 0rem 1rem;
        min-height: 8px;
        min-width: 70px;
        border-radius: 12.6px;
      }

      trough slider {
        margin: -10px;
        border-radius: 12.6px;
        box-shadow: 0 0 2px rgba(0, 0, 0, 0.8);
        transition: all 0.2s ease;
        background-color: ${colors.blue.hex};
      }

      trough slider:hover {
        box-shadow:
          0 0 2px rgba(0, 0, 0, 0.8),
          0 0 8px ${colors.blue.hex};
      }

      trough {
        background-color: ${colors.surface0.hex};
      }

      /* notifications */

      .notification-background {
        box-shadow:
          0 0 8px 0 rgba(0, 0, 0, 0.8),
          inset 0 0 0 1px ${colors.surface1.hex};
        border-radius: 12.6px;
        margin: 18px;
        background: alpha(${colors.mantle.hex}, .9);
        color: ${colors.text.hex};
        padding: 0;
      }

      .notification-background .notification {
        padding: 7px;
        border-radius: 12.6px;
      }

      .notification-background .notification.critical {
        box-shadow: inset 0 0 7px 0 ${colors.red.hex};
      }

      .notification .notification-content {
        margin: 7px;
      }

      .notification .notification-content overlay {
        /* icons */
        margin: 4px;
      }

      .notification .notification-content .image {
        border-radius: 12.6px;
        margin-right: 5px;
      }

      .notification-content .summary {
        color: ${colors.text.hex};
      }

      .notification-content .time {
        color: ${colors.subtext0.hex};
      }

      .notification-content .body {
        color: ${colors.subtext1.hex};
      }

      .notification > *:last-child > * {
        min-height: 3.4em;
      }

      .notification-background .close-button {
        margin: 7px;
        padding: 2px;
        border-radius: 6.3px;
        color: ${colors.base.hex};
        background-color: ${colors.red.hex};
      }

      .notification-background .close-button:hover {
        background-color: ${colors.maroon.hex};
      }

      .notification-background .close-button:active {
        background-color: ${colors.pink.hex};
      }

      .notification .notification-action {
        border-radius: 7px;
        color: ${colors.text.hex};
        box-shadow: inset 0 0 0 1px ${colors.surface1.hex};
        margin: 4px;
        padding: 8px;
        font-size: 0.2rem; /* controls the button size not text size*/
      }

      .notification .notification-action {
        background-color: ${colors.surface0.hex};
      }

      .notification .notification-action:hover {
        background-color: ${colors.surface1.hex};
      }

      .notification .notification-action:active {
        background-color: ${colors.surface2.hex};
      }

      .notification.critical progress {
        background-color: ${colors.red.hex};
      }

      .notification.low progress,
      .notification.normal progress {
        background-color: ${colors.blue.hex};
      }

      .notification progress,
      .notification trough,
      .notification progressbar {
        border-radius: 12.6px;
        padding: 3px 0;
      }
      /* control center */

      .control-center {
        box-shadow:
          0 0 8px 0 rgba(0, 0, 0, 0.8),
          inset 0 0 0 1px ${colors.surface0.hex};
        border-radius: 12.6px;
        margin: 18px;
        background-color: alpha(${colors.base.hex}, .55);
        color: ${colors.text.hex};
        padding: 14px;
      }

      .control-center .notification-background {
        border-radius: 12.6px;
        box-shadow: inset 0 0 0 1px ${colors.surface1.hex};
        margin: 4px 10px;
      }

      .control-center .notification-background .notification {
        border-radius: 12.6px;
      }

      .control-center .notification-background .notification.low {
        opacity: 0.8;
      }

      .control-center .widget-title > label {
        color: ${colors.text.hex};
        font-size: 1.3em;
      }

      .control-center .widget-title button {
        border-radius: 7px;
        color: ${colors.text.hex};
        background-color: alpha(${colors.surface0.hex}, .4);
        box-shadow: inset 0 0 0 1px ${colors.surface1.hex};
        padding: 8px;
      }

      .control-center .widget-title button:hover {
        background-color: ${colors.surface1.hex};
      }

      .control-center .widget-title button:active {
        background-color: ${colors.surface2.hex};
      }

      .control-center .notification-group {
        margin-top: 10px;
      }

      scrollbar slider {
        margin: -3px;
        opacity: 0.8;
      }

      scrollbar trough {
        margin: 2px 0;
      }

      /* dnd */

      .widget-dnd {
        margin-top: 15px;
        border-radius: 8px;
        font-size: 1.1rem;
      }

      .widget-dnd > switch {
        font-size: initial;
        border-radius: 8px;
        background: alpha(${colors.surface0.hex}, .5);
        border: 1px solid ${colors.surface1.hex};
        box-shadow: none;
      }

      .widget-dnd > switch:checked {
        background: alpha(${colors.blue.hex}, .4);
      }

      .widget-dnd > switch slider {
        background: alpha(${colors.surface1.hex}, .4);
        border-radius: 8px;
      }

      /* mpris */

      .widget-mpris-player {
        margin: 16px 20px;
        background: ${colors.surface0.hex};
        border-radius: 12.6px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.75);
        color: #cdd6f4;
      }

      .mpris-overlay {
        background-color: ${colors.surface0.hex};
        opacity: 0.9;
        padding: 15px 10px;
      }

      .mpris-background {
        filter: blur(8px);
      }

      .widget-mpris-album-art {
        -gtk-icon-size: 100px;
        border-radius: 12.6px;
        margin: 0 10px;
      }

      .widget-mpris-title {
        font-size: 1.2rem;
        color: ${colors.text.hex};
      }

      .widget-mpris-subtitle {
        font-size: 1rem;
        color: ${colors.subtext1.hex};
      }

      .widget-mpris button {
        border-radius: 12.6px;
        color: ${colors.text.hex};
        margin: 0 5px;
        padding: 2px;
      }

      .widget-mpris button image {
        -gtk-icon-size: 1.8rem;
      }

      .widget-mpris button:hover {
        background-color: ${colors.surface0.hex};
      }

      .widget-mpris button:active {
        background-color: ${colors.surface1.hex};
      }

      .widget-mpris button:disabled {
        opacity: 0.5;
      }

      .widget-menubar > box > .menu-button-bar > button > label {
        font-size: 3rem;
        padding: 0.5rem 2rem;
      }

      .widget-menubar > box > .menu-button-bar > :last-child {
        color: $red;
      }

      .power-buttons button:hover,
      .powermode-buttons button:hover,
      .screenshot-buttons button:hover {
        background: ${colors.surface0.hex};
      }

      .control-center .widget-label > label {
        color: ${colors.text.hex};
        font-size: 2rem;
      }

      .widget-buttons-grid {
        padding-top: 1rem;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button label {
        font-size: 2.5rem;
      }

      .widget-volume {
        padding: 1rem 0;
      }

      .widget-volume label {
        color: ${colors.sapphire.hex};
        padding: 0 1rem;
      }

      .widget-volume trough highlight {
        background: ${colors.sapphire.hex};
      }

      .widget-backlight trough highlight {
        background: ${colors.yellow.hex};
      }

      .widget-backlight label {
        font-size: 1.5rem;
        color: ${colors.yellow.hex};
      }

      .widget-backlight .KB {
        padding-bottom: 1rem;
      }
    '';
  };

  programs.waybar.settings.mainBar."custom/notification" = lib.mkIf config.programs.waybar.enable {
    return-type = "json";
    exec-if = "which swaync-client";
    exec = "swaync-client -swb";
    on-click = "uwsm app -- swaync-client -t -sw";
    on-click-middle = "swaync-client -d -sw";
    on-click-right = "swaync-client -C -sw";
  };

  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "blur, swaync-control-center"
      "blur, swaync-notification-window"
      "ignorezero, swaync-control-center"
      "ignorezero, swaync-notification-window"
      "ignorealpha 0.5, swaync-control-center"
      "ignorealpha 0.5, swaync-notification-window"
    ];
  };
}
