{pkgs, ...}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    open = true;
    dynamicBoost.enable = true;
  };

  hardware.graphics = {
    extraPackages = [pkgs.intel-vaapi-driver];
    extraPackages32 = [pkgs.driversi686Linux.intel-vaapi-driver];
  };
}
