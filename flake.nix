{
  description = "NixOS Config For Dreamail's Devices";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

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

  outputs =
    { nixpkgs, flake-parts, ... }@inputs:
    let
      user = import "${inputs.mysecrets}/tnix5p-user.nix";
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem =
        {
          pkgs,
          system,
          ...
        }:
        {
          formatter = pkgs.nixfmt-tree;
        };
      flake = {
        nixosConfigurations.tnix5p = (import ./hosts/tnix5p) {
          inherit inputs user;
        };
        nixosConfigurations.tnix5p-test = (import ./hosts/tnix5p) {
          inherit inputs user;
          isVM = true;
        };
      };
    };
}
