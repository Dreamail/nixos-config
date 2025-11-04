{
  inputs,
  pkgs,
  ...
}:
let
  osu-lazer-bin-wayland =
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin.override
      (previous: {
        command_prefix = "env -u VK_ICD_FILENAMES -u __EGL_VENDOR_LIBRARY_FILENAMES SDL_VIDEODRIVER=wayland __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only VK_ICD_FILENAMES=/nix/store/qh9yzr4hdyq6adjkb1apsi24533czqx3-nvidia-x11-580.76.05-6.15.4/share/vulkan/icd.d/nvidia_icd.x86_64.json";
      });
in
{
  home.packages = [
    osu-lazer-bin-wayland
    (pkgs.callPackage ./tosu {})
  ];
}
