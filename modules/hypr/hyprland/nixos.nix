{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  # use patch to support scaling xwayland windows
  hyprland-patch = pkgs.fetchpatch {
    name = "hyprland-hidpi-xprop.patch";
    url = "https://patch-diff.githubusercontent.com/raw/hyprwm/Hyprland/pull/6446.patch";
    hash = "sha256-60g1EvEoa/733teiMSdUCxfgrwfc/JgWTcDN49D74V4=";
  };
  xwayland-patch = pkgs.fetchpatch {
    name = "xwayland-hidpi-xprop.patch";
    url = "https://aur.archlinux.org/cgit/aur.git/plain/hidpi.patch?h=xorg-xwayland-hidpi-xprop";
    hash = "sha256-wAsBSyp0B52jC586lDWBV6TTkLuQqEr3juOEus83GTo=";
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
        patches = [ hyprland-patch ];
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
