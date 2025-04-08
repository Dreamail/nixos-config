{pkgs, ...}: {
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        (fcitx5-rime.override {
          rimeDataPkgs = [(callPackage ./rime-frost.nix {})];
        })
      ];
    };
  };

  xdg.configFile."fcitx5/config".source = ./config;
  xdg.configFile."fcitx5/profile".source = ./profile;
}
