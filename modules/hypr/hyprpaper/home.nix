{ pkgs, ... }:
let
  paper = (import ./paper.nix pkgs).paper;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "${paper}";
      wallpaper = ", ${paper}";
    };
  };
}
