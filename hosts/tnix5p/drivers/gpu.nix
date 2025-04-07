{
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    open = true;
    dynamicBoost.enable = true;
  };
}
