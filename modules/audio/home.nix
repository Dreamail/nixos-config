{
  lib,
  config,
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.pavucontrol ];
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
    windowrule = [ "float, class:org.pulseaudio.pavucontrol" ];
    bindl = [
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];
    bindel = [
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    ];
  };
}
