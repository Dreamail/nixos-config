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
    url = "https://github.com/hyprwm/Hyprland/commit/5a712257e12837b9dc21cdf71fa1b8433897cd19.patch";
    hash = "sha256-RgkSai/esZ1wTILalhCXxWo3S/MN7thLN8b/eWgdNh8=";
  };
  hyprland-always-copy-xwl-patch = pkgs.fetchpatch {
    name = "hyprland-always-copy-xwl.patch";
    url = "https://github.com/hyprwm/Hyprland/commit/104493dfb42e8229f593e995ef38af9e40ded66c.patch";
    hash = "sha256-s6H2RkTHKLDcOfJraQDwF6vwI/qz5svC6BdGxQpX4SM=";
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
        patches = [
          hyprland-hidpi-patch
          hyprland-always-copy-xwl-patch
        ];
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
