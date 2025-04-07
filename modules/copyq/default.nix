{
  homeModule = {
    services.copyq = {
      enable = true;
      forceXWayland = false;
    };

    wayland.windowManager.hyprland.settings = {
      windowrule = [
        "float, class:com.github.hluk.copyq"
        "move cursor 0 +5%, class:com.github.hluk.copyq"
        "size 25% 50%, class:com.github.hluk.copyq"
      ];
      bind = ["$mainMod, V, exec, copyq toggle"];
    };
  };
  nixosModule = {};
}
