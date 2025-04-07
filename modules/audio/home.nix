{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.pavucontrol];
  programs.waybar.settings.mainBar = lib.mkIf config.programs.waybar.enable {
    pulseaudio = {
      on-click = "uwsm app -- pavucontrol -t 3";
      on-click-middle = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
    };
    "pulseaudio#microphone" = {
      on-click = "uwsm app -- pavucontrol -t 4";
      on-click-middle = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
    };
  };

  wayland.windowManager.hyprland.settings = {
    windowrule = ["float, class:org.pulseaudio.pavucontrol"];
  };
}
