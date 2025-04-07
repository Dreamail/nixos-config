{
  lib,
  user,
  isVM ? false,
  ...
}: {
  imports =
    []
    ++ lib.optionals isVM [./vm.nix]
    ++ lib.optionals (!isVM) [./hardware-configuration.nix ./drivers];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "tnix5p";
    networkmanager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  time.timeZone = "Asia/Shanghai";

  users.users.${user.name} = {
    isNormalUser = true;
    description = user.description;
    initialPassword = user.initialPassword;
    extraGroups = ["wheel" "networkmanager"];
  };

  system.stateVersion = "24.05";
}
