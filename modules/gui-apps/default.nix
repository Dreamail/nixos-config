{
  homeModule = {pkgs, ...}: {
    home.packages = with pkgs; [
      # Web Browser
      firefox

      # Chinese IMs
      (callPackage ./pkgs/qq.nix {})
      (callPackage ./pkgs/wechat.nix {})
    ];

    wayland.windowManager.hyprland.settings = {
      windowrulev2 = [
        "noblur, class:wechat, title:wechat"
        "noborder, class:wechat, title:wechat"
        "noshadow, class:wechat, title:wechat"
      ];
    };
  };
  nixosModule = {inputs, ...}: {};
}
