{
  inputs,
  config,
  isVM,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    # set the flake package
    package = null;
    portalPackage = null;

    settings = import ./config {
      lib = inputs.nixpkgs.lib;
      inherit isVM;
    };
  };

  # make `home.sessionVariables` accessible for uwsm
  systemd.user.sessionVariables = config.home.sessionVariables;

  catppuccin.hyprland.enable = true;
}
