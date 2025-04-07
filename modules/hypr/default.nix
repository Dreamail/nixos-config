{
  homeModule = {
    imports = [
      ./hyprland/home.nix
      ./hyprpolkitagent/home.nix
      ./hypridle/home.nix
      ./hyprlock/home.nix
      ./hyprpaper/home.nix
    ];
  };
  nixosModule = {
    imports = [
      ./hyprland/nixos.nix
    ];
  };
}
