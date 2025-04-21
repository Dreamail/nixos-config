{ inputs, ... }:
let
  lib = inputs.nixpkgs-mirror.lib;

  module_paths = [ ];
  modules = lib.forEach module_paths (x: import x);

  nixosModules = lib.forEach modules (x: x.nixosModule);
in
lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs; };
  modules = [
    inputs.disko.nixosModules.disko
    ./disko-config.nix
    ./hardware-configuration.nix
    ./core.nix
  ] ++ nixosModules;
}
