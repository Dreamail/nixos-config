{pkgs, ...}: {
  home.packages = with pkgs; [
    nautilus
    nautilus-python
  ];
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "float,class:org.gnome.NautilusPreviewer"
    ];
  };
}
