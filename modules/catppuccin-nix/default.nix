let
  module = {
    lib,
    config,
    ...
  }:
    with lib; let
      cfg = config.catppuccin-nix;

      palette = importJSON ./palette.json;
    in {
      options.catppuccin-nix = {
        flavor = mkOption {
          type = types.enum [
            "latte"
            "frappe"
            "macchiato"
            "mocha"
          ];
          default = "mocha";
        };
        theme = mkOption {
          type = types.attrs;
          default = palette.mocha;
          defaultText = "Depend on catppucccin-nix.flavor";
        };
      };

      config = {
        catppuccin-nix.theme =
          if cfg.flavor == "latte"
          then palette.latte
          else if cfg.flavor == "frappe"
          then palette.frappe
          else if cfg.flavor == "macchiato"
          then palette.macchiato
          else palette.mocha;

        catppuccin.flavor = cfg.flavor;
      };
    };
in {
  homeModule = module;
  nixosModule = module;
}
