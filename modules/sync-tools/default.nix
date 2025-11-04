{
  homeModule =
    { pkgs, ... }:
    let
      syncclipboard-script = pkgs.callPackage ./syncclipboard-script {
        endpoint = "https://alist.fan2tao.top/dav";
        user = "clipboard";
        pass = "pai2clipboard";
      };
    in
    {
      home.packages = with pkgs; [
        localsend
        syncclipboard-script
      ];

      wayland.windowManager.hyprland.settings = {
        exec-once = [ "uwsm app -- localsend_app --hidden" ];
        windowrulev2 = [
          "float, class:localsend_app"
          "center, class:localsend_app"
          "size 60% 60%, class:localsend_app"
        ];
      };
    };
  nixosModule = {
    networking.firewall = rec {
      allowedTCPPorts = [ 53317 ];
      allowedUDPPorts = allowedTCPPorts;
    };
  };
}
