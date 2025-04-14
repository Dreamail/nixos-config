{pkgs, ...}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    open = true;
    dynamicBoost.enable = true;
  };

  hardware.graphics = {
    extraPackages = [pkgs.intel-media-driver];
    extraPackages32 = [pkgs.driversi686Linux.intel-media-driver];
  };
}
