{ pkgs, ... }:
{
  imports = [
    ./terminal/nixos.nix
    ./clash-verge.nix
    ./charles/nixos.nix
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
  ];
}
