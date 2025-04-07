{
  services.wluma.settings = {
    als.none = {};
    output.backlight = [
      {
        capturer = "wayland";
        name = "eDP-1";
        path = "/sys/class/backlight/nvidia_wmi_ec_backlight";
      }
    ];
  };
}
