{ pkgs, ... }:
{
  imports = [
    ./terminal/nixos.nix
    ./clash-verge.nix
    ./charles/nixos.nix
    ./docker.nix
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
    "dotnet-runtime-6.0.36"
  ];
}
