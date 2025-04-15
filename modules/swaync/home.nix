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

      scale trough {
          margin: 0rem 1rem;
          background-color: ${colors.surface0.hex};
          min-height: 8px;
          min-width: 70px;
      }

      slider {
          background-color: ${colors.blue.hex};
      }

      .floating-notifications.background .notification-row .notification-background {
        box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px ${colors.surface0.hex};
        border-radius: 12.6px;
        margin: 18px;
        background-color: alpha(${colors.base.hex}, .55);
        color: ${colors.text.hex};
        padding: 0;
      }

      .floating-notifications.background .notification-row .notification-background .notification {
        padding: 7px;
        border-radius: 12.6px;
      }

      .floating-notifications.background .notification-row .notification-background .notification.critical {
        box-shadow: inset 0 0 7px 0 ${colors.red.hex};
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content {
        margin: 7px;
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content .summary {
        color: ${colors.text.hex};
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content .time {
        color: ${colors.subtext0.hex};
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content .body {
        color: ${colors.text.hex};
      }

      .floating-notifications.background .notification-row .notification-background .notification>*:last-child>* {
        min-height: 3.4em;
      }

      .floating-notifications.background .notification-row .notification-background .notification>*:last-child>* .notification-action {
        border-radius: 7px;
        color: ${colors.text.hex};
        background-color: ${colors.surface0.hex};
        box-shadow: inset 0 0 0 1px ${colors.surface1.hex};
        margin: 7px;
      }

      .floating-notifications.background .notification-row .notification-background .notification>*:last-child>* .notification-action:hover {
        box-shadow: inset 0 0 0 1px ${colors.surface1.hex};
        background-color: ${colors.surface0.hex};
        color: ${colors.text.hex};
      }

      .floating-notifications.background .notification-row .notification-background .notification>*:last-child>* .notification-action:active {
        box-shadow: inset 0 0 0 1px ${colors.surface1.hex};
        background-color: ${colors.sapphire.hex};
        color: ${colors.text.hex};
      }

      .floating-notifications.background .notification-row .notification-background .close-button {
        margin: 7px;
        padding: 2px;
        border-radius: 6.3px;
        background-color: transparent;
      }

      .floating-notifications.background .notification-row .notification-background .close-button:hover {
        background-color: ${colors.maroon.hex};
      }

      .floating-notifications.background .notification-row .notification-background .close-button:active {
        background-color: ${colors.red.hex};
      }

      .control-center {
        box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px ${colors.surface0.hex};
        border-radius: 12.6px;
        margin: 18px;
        background-color: alpha(${colors.base.hex}, .55);
        color: ${colors.text.hex};
        padding: 14px;
      }

      .control-center .widget-title>label {
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
        box-shadow: inset 0 0 0 1px alpha(${colors.surface1.hex}, .4);
        background-color: ${colors.surface2.hex};
        color: ${colors.text.hex};
      }

      .control-center .widget-title button:active {
        box-shadow: inset 0 0 0 1px ${colors.surface1.hex};
        background-color: alpha(${colors.sapphire.hex}, .4);
        color: ${colors.base.hex};
      }

      .control-center .notification-row .notification-background {
        border-radius: 7px;
        color: ${colors.text.hex};
        background-color: alpha(${colors.surface0.hex}, .9);
        box-shadow: inset 0 0 0 1px ${colors.surface1.hex};
        margin-top: 14px;
      }

      .control-center .notification-row .notification-background .notification {
        padding: 7px;
        border-radius: 7px;
      }

      .control-center .notification-row .notification-background .notification.critical {
        box-shadow: inset 0 0 7px 0 ${colors.red.hex};
      }

      .control-center .notification-row .notification-background .notification .notification-content {
        margin: 7px;
      }

      .control-center .notification-row .notification-background .notification .notification-content .summary {
        color: ${colors.text.hex};
      }

      .control-center .notification-row .notification-background .notification .notification-content .time {
        color: ${colors.subtext0.hex};
      }

      .control-center .notification-row .notification-background .notification .notification-content .body {
        color: ${colors.text.hex};
      }

      .control-center .notification-row .notification-background .notification>*:last-child>* {
        min-height: 3.4em;
      }

      .control-center .notification-row .notification-background .notification>*:last-child>* .notification-action {
        border-radius: 7px;
        color: ${colors.text.hex};
        background-color: ${colors.crust.hex};
        box-shadow: inset 0 0 0 1px ${colors.surface1.hex};
        margin: 7px;
      }

      .control-center .notification-row .notification-background .notification>*:last-child>* .notification-action:hover {
        box-shadow: inset 0 0 0 1px ${colors.surface1.hex};
        background-color: ${colors.surface0.hex};
        color: ${colors.text.hex};
      }

      .control-center .notification-row .notification-background .notification>*:last-child>* .notification-action:active {
        box-shadow: inset 0 0 0 1px ${colors.surface1.hex};
        background-color: ${colors.sapphire.hex};
        color: ${colors.text.hex};
      }

      .control-center .notification-row .notification-background .close-button {
        margin: 7px;
        padding: 2px;
        border-radius: 6.3px;
        background-color: transparent;
      }

      .close-button {
        border-radius: 6.3px;
      }

      .control-center .notification-row .notification-background .close-button:hover {
        background-color: ${colors.red.hex};
      }

      .control-center .notification-row .notification-background .close-button:active {
        background-color: ${colors.red.hex};
      }

      .control-center .notification-row .notification-background:hover {
        box-shadow: inset 0 0 0 1px ${colors.surface1.hex};
        background-color: ${colors.overlay1.hex};
        color: ${colors.text.hex};
      }

      .control-center .notification-row .notification-background:active {
        box-shadow: inset 0 0 0 1px ${colors.surface1.hex};
        background-color: ${colors.sapphire.hex};
        color: ${colors.text.hex};
      }

      .notification.critical progress {
        background-color: ${colors.red.hex};
      }

      .notification.low progress,
      .notification.normal progress {
        background-color: ${colors.blue.hex};
      }

      .control-center-dnd {
        margin-top: 5px;
        border-radius: 8px;
        background: ${colors.surface0.hex};
        border: 1px solid ${colors.surface1.hex};
        box-shadow: none;
      }

      .control-center-dnd:checked {
        background: ${colors.surface0.hex};
      }

      .control-center-dnd slider {
        background: ${colors.surface1.hex};
        border-radius: 8px;
      }

      .widget-dnd {
        margin: 0px;
        font-size: 1.1rem;
      }

      .widget-dnd>switch {
        font-size: initial;
        border-radius: 8px;
        background: alpha(${colors.surface0.hex}, .4);
        border: 1px solid ${colors.surface1.hex};
        box-shadow: none;
      }

      .widget-dnd>switch:checked {
        background: alpha(${colors.surface0.hex}, .4);
      }

      .widget-dnd>switch slider {
        background: alpha(${colors.surface1.hex}, .4);
        border-radius: 8px;
        border: 1px solid ${colors.overlay0.hex};
      }

      .widget-mpris .widget-mpris-player {
          background: ${colors.surface0.hex};
          padding: 7px;
      }

      .widget-mpris .widget-mpris-title {
          font-size: 1.2rem;
      }

      .widget-mpris .widget-mpris-subtitle {
          font-size: 0.8rem;
      }

      .widget-menubar>box>.menu-button-bar>button>label {
          font-size: 3rem;
          padding: 0.5rem 2rem;
      }

      .widget-menubar>box>.menu-button-bar>:last-child {
          color: ${colors.red.hex};
      }

      .power-buttons button:hover,
      .powermode-buttons button:hover,
      .screenshot-buttons button:hover {
          background: ${colors.surface0.hex};
      }

      .control-center .widget-label>label {
        color: ${colors.text.hex};
        font-size: 2rem;
      }

      .widget-buttons-grid {
          padding-top: 1rem;
      }

      .widget-buttons-grid>flowbox>flowboxchild>button label {
          font-size: 2.5rem;
      }

      .widget-volume {
          padding-top: 1rem;
      }

      .widget-volume label {
          font-size: 1.5rem;
          color: ${colors.sapphire.hex};
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

      .image {
        padding-right: 0.5rem;
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
