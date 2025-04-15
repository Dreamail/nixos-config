{
  lib,
  pkgs,
  ...
}:
{
  # Fonts
  fonts.fontconfig.enable = lib.mkDefault true;
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];
}
