{
  inputs,
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

  catppuccin.hyprland.enable = true;
}
