{
  homeModule = {pkgs, ...}: {
    home.packages = [pkgs.hyprshot];
    wayland.windowManager.hyprland.settings = {
      bind = [
        ", Print, exec, hyprshot hyprshot -m output -m active -z -o $HOME/Screenshots"
        "$mainMod Shift, S, exec, hyprshot -m region -z -o $HOME/Screenshots"
      ];
    };
  };
  nixosModule = {};
}
