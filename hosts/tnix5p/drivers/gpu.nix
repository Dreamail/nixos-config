{ pkgs, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    dynamicBoost.enable = true;
  };

  hardware.graphics = {
    extraPackages = [ pkgs.intel-media-driver ];
    extraPackages32 = [ pkgs.driversi686Linux.intel-media-driver ];
  };

  boot.initrd.kernelModules = [
    "i915"
  ];

  systemd.globalEnvironment = {
    __EGL_VENDOR_LIBRARY_FILENAMES="${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json:${pkgs.mesa_i686}/share/glvnd/egl_vendor.d/50_mesa.json";
    VK_ICD_FILENAMES="${pkgs.mesa}/share/vulkan/icd.d/intel_icd.x86_64.json:${pkgs.mesa_i686}/share/vulkan/icd.d/intel_icd.i686.json";
  };
}
