{
  inputs,
  pkgs,
  ...
}:
let
  osu-lazer-bin-wayland =
    inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin.override
      (previous: {
        command_prefix = "env SDL_VIDEODRIVER=wayland ${previous.gamemode}/bin/gamemoderun";
      });
in
{
  home.packages = [
    osu-lazer-bin-wayland
    (pkgs.callPackage ./tosu {})
  ];
}
