{ pkgs, ... }:
{
  services.xsettingsd = {
    enable = true;
    settings = {
      "Gdk/UnscaledDPI" = 98304;
      "Gdk/WindowScalingFactor" = 2;
    };
  };
  home.packages = with pkgs.xorg; [
    xrdb
    xprop
  ];
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "echo \"Xft.dpi: 192\" | xrdb -merge && xprop -root -format _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2"
    ];
    xwayland.use_nearest_neighbor = false;
  };
  home.sessionVariables.HIDPI_XPROP = 1; # for xwayland app detecting scaling
}
