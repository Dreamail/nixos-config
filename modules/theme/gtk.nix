{pkgs, ...}: {
  # Gtk Theme
  gtk = {
    enable = true;
    theme = {
      name = "Colloid-Red-Dark-Compact-Catppuccin";
      package = pkgs.colloid-gtk-theme.override {
        themeVariants = ["red"];
        colorVariants = ["dark"];
        sizeVariants = ["compact"];
        tweaks = ["catppuccin" "black" "rimless"];
      };
    };
    iconTheme = {
      name = "Colloid-Red-Catppuccin";
      package = pkgs.colloid-icon-theme.override {
        schemeVariants = ["catppuccin"];
        colorVariants = ["red"];
      };
    };
  };
}
