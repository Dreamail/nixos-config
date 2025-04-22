{
  homeModule =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # Web Browser
        firefox

        # Chinese IMs
        (callPackage ./pkgs/qq.nix { })
        (callPackage ./pkgs/wechat.nix { })

        (nur.repos.novel2430.wpsoffice-365.overrideAttrs (previousAttrs: {
          installPhase =
            previousAttrs.installPhase
            + ''
              sed -i "2i export XCURSOR_SIZE=\''${HIDPI_XPROP:+\''$((\''${XCURSOR_SIZE} * 2))}" $out/bin/{wps,wpp,et,wpspdf,misc,wpsclouddisk}
            '';
        }))
      ];

      wayland.windowManager.hyprland.settings = {
        windowrulev2 = [
          "noblur, class:wechat, title:wechat"
          "noborder, class:wechat, title:wechat"
          "noshadow, class:wechat, title:wechat"

          "noblur, class:wpsoffice, title:wpsoffice"
          "noborder, class:wpsoffice, title:wpsoffice"
          "noshadow, class:wpsoffice, title:wpsoffice"

          "float, class:QQ"
          "center, class:QQ"
          "size 70% 80%, class:QQ, title:QQ"
          "float, class:wechat"
          "center, class:wechat, title:微信"
          "size 70% 80%, class:wechat, title:微信"
        ];
      };
    };
  nixosModule =
    { inputs, ... }:
    {
      nixpkgs.overlays = [
        inputs.nur.overlays.default
      ];
    };
}
