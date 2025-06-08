{ pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ./idapro.nix { })
  ];
}
