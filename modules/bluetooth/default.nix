{
  homeModule = {
    services.blueman-applet.enable = true;

    wayland.windowManager.hyprland.settings = {
      windowrule = [ "float, class:.blueman-manager-wrapped" ];
    };
  };
  nixosModule = {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
  };
}
