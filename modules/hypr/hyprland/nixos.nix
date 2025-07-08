{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  # use patch to support scaling xwayland windows
  hyprland-hidpi-patch = pkgs.fetchpatch {
    name = "hyprland-hidpi-xprop.patch";
    url = "https://github.com/hyprwm/Hyprland/commit/48d3a4996db860ed9607eaad4cd73ad5228ca83e.patch";
    hash = "sha256-HJZpHvv0KTzhfw0vgGYrs06yMUCvKSh2QrpE7cXKzCE=";
  };
  xwayland-patch = pkgs.fetchpatch {
    name = "xwayland-hidpi-xprop.patch";
    url = "https://aur.archlinux.org/cgit/aur.git/plain/hidpi.patch?h=xorg-xwayland-hidpi-xprop";
    hash = "sha256-e1Yv2s9rDV5L0sVlwbsjmlgzOv8csCrPQ9aZSuZuEDQ=";
  };
  xwayland = pkgs.xwayland.overrideAttrs (previousArgs: {
    patches = [ xwayland-patch ];
    mesonFlags = previousArgs.mesonFlags ++ [
      (lib.mesonBool "xvfb" false)
      (lib.mesonBool "xdmcp" false)
    ];
  });
in
{
  nix.settings = {
    # Hyprland cachix
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;

    package =
      (inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland.overrideAttrs {
        patches = [ hyprland-hidpi-patch ];
      }).override
        {
          inherit xwayland;
        };
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  environment.systemPackages = [ xwayland ]; # add patched xwayland to path, idkw it cant be added automatically in hyprland drv

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
