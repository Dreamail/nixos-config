{
  inputs,
  user,
  isVM ? false,
  ...
}:
let
  lib = inputs.nixpkgs.lib;

  module_paths = [
    # platform related config modules
    ./modules/hyprland
    ./modules/backlight
    ./modules/power

    ../../modules/secrets

    # common modules
    ../../modules/security
    ../../modules/catppuccin-nix
    ../../modules/theme
    #../../modules/sddm use greetd with autologin instead
    ../../modules/greetd
    ../../modules/hypr
    ../../modules/waybar
    ../../modules/rofi
    ../../modules/wlogout
    ../../modules/backlight
    ../../modules/audio
    ../../modules/networkmanager
    ../../modules/bluetooth
    ../../modules/upower
    ../../modules/swaync
    ../../modules/nautilus
    ../../modules/copyq
    ../../modules/screenshot
    ../../modules/kdeconnect
    ../../modules/fcitx5

    ../../modules/dev-tools
    ../../modules/game
    ../../modules/gui-apps
  ];
  modules = lib.forEach module_paths (x: import x);

  nixosModules = lib.forEach modules (x: x.nixosModule);
  homeModules = lib.forEach modules (x: x.homeModule);
in
lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs user isVM; };
  modules = [
    ./core.nix

    inputs.catppuccin.nixosModules.catppuccin
    inputs.agenix.nixosModules.default

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs user isVM; };

      home-manager.users.${user.name} = {
        imports = [
          inputs.catppuccin.homeManagerModules.catppuccin
          inputs.nix-index-database.hmModules.nix-index
          inputs.agenix.homeManagerModules.default
        ] ++ homeModules;

        home.username = user.name;
        home.homeDirectory = "/home/${user.name}";

        home.stateVersion = "24.11";
      };
    }
  ] ++ nixosModules;
}
