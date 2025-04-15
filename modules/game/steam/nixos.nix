{
  lib,
  pkgs,
  ...
}:
{
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      package = pkgs.steam.overrideAttrs (previousAttrs: {
        nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [ pkgs.makeWrapper ];
        buildCommand =
          previousAttrs.buildCommand
          + ''
            wrapProgram $out/bin/steam \
              --run "export XCURSOR_SIZE=\''${HIDPI_XPROP:+\''$((\''${XCURSOR_SIZE} * 2))}"
          '';
      });

      extraPackages = with pkgs; [
        gamescope
        mangohud
      ];
    };
  };
  hardware.xone.enable = true;
}
