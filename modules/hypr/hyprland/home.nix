{
  lib,
  config,
  isVM,
  ...
}:
{
  imports = [ ./hidpi-xprop.nix ];

  wayland.windowManager.hyprland = {
    enable = true;
    # set the flake package
    package = null;
    portalPackage = null;

    settings = import ./config {
      inherit lib isVM;
    };
  };

  # make `home.sessionVariables` accessible for uwsm
  systemd.user.sessionVariables = config.home.sessionVariables;

  catppuccin.hyprland.enable = true;
}
