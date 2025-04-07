{
  homeModule = {pkgs, ...}: {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };

    wayland.windowManager.hyprland.settings = {
      windowrule = ["float, class:(org.kde.kdeconnect)(.*)"];
    };
  };
  nixosModule = {
    networking.firewall = rec {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
}
