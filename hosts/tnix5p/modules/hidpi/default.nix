let
  scaling = 1.67;
in {
  homeModule = {};
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
