let
  scaling = 1.67;
in {
  homeModule = {
    xdg.configFile."environment.d/20-wechat-scaling.conf".text = ''
      WECHAT_SCALE_FACTOR=${toString scaling}
    '';
  };
  nixosModule = {
    nixpkgs.overlays = [
      (self: super: {
        steam = super.steam.override {
          extraEnv = {
            STEAM_FORCE_DESKTOPUI_SCALING = scaling;
          };
        };
      })
    ];
  };
}
