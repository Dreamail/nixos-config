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

        "float, class:QQ"
        "center, class:QQ"
        "size 70% 80%, class:QQ, title:QQ"
        "float, class:wechat"
        "center, class:wechat, title:微信"
        "size 70% 80%, class:wechat, title:微信"
      ];
    };
  };
  nixosModule = {inputs, ...}: {};
}
