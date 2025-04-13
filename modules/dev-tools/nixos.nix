{pkgs, ...}: {
  imports = [
    ./clash-verge.nix
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
  ];
}
