{
  description = "NixOS Config For Dreamail's Devices";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-patcher.url = "github:gepbird/nixpkgs-patcher";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    hyprland = {
      url = "github:Dreamail/Hyprland/sync-xwl-clipboard";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    solaar = {
      url = "github:Svenum/Solaar-Flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    winapps = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:winapps-org/winapps";
    };
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
