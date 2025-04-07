{pkgs, ...}: {
  home.pointerCursor = {
    enable = true;
    name = "macOS"; # Turn to catppuccin when gtk4 is fixed
    package = pkgs.apple-cursor;
    size = 24;
    hyprcursor.enable = true;
    x11.enable = true;
    gtk.enable = true;
  };
}
