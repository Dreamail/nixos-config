{
  description = "NixOS Config For Dreamail's Devices";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    catppuccin.url = "github:catppuccin/nix";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";
    mysecrets = {
      url = "git+ssh://git@github.com/Dreamail/nix-secrets?shallow=1";
      flake = false;
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
  };

  outputs = {...} @ inputs: let
    user = import "${inputs.mysecrets}/tnix5p-user.nix";
  in {
    nixosConfigurations.tnix5p = (import ./hosts/tnix5p) {
      inherit inputs user;
    };
    nixosConfigurations.tnix5p-test = (import ./hosts/tnix5p) {
      inherit inputs user;
      isVM = true;
    };
  };
}
