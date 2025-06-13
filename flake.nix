{
  description = "NixOS Config For Dreamail's Devices";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-mirror.url = "git+https://mirrors.cernet.edu.cn/nixpkgs.git?shallow=1";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      #url = "https://flakehub.com/f/Svenum/Solaar-Flake/0.1.1.tar.gz"; # uncomment line for solaar version 1.1.13
      #url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
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

        nixosConfigurations.aliyun-sas = (import ./hosts/aliyun-sas) {
          inherit inputs;
        };
      };
    };
}
