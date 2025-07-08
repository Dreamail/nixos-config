{ config, ... }:
{
  programs.clash-verge = {
    enable = true;
    autoStart = true;
    tunMode = true;
    serviceMode = false;
  };
  # Temp fix for clash-verge service mode
  # See: https://github.com/NixOS/nixpkgs/issues/420460
  systemd.services.clash-verge = {
    enable = true;
    description = "Clash Verge Service Mode";
    serviceConfig = {
      ExecStart = "${config.programs.clash-verge.package}/bin/clash-verge-service";
      Restart = "on-failure";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
