{
  lib,
  config,
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.brightnessctl ];
  programs.waybar.settings.mainBar.backlight = lib.mkIf config.programs.waybar.enable {
    on-scroll-down = "brightnessctl set 1%-";
    on-scroll-up = "brightnessctl set 1%+";
  };

  services.wluma.enable = true;

  wayland.windowManager.hyprland.settings = {
    bindel = [
      ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
    ];
  };
}
