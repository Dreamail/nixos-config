{
  homeModule = {
    services.network-manager-applet.enable = true;

    wayland.windowManager.hyprland.settings = {
      windowrule = [ "float, class:nm-connection-editor" ];
    };
  };
  nixosModule = { };
}
