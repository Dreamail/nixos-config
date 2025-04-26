{ inputs, ... }:
let
  lib = inputs.nixpkgs-mirror.lib;

  module_paths = [
    ../../modules/nginx
    ../../modules/vaultwarden
  ];
  modules = lib.forEach module_paths (x: import x);

  nixosModules = lib.forEach modules (x: x.nixosModule);
in
lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs; };
  modules = [
    inputs.disko.nixosModules.disko
    inputs.agenix.nixosModules.default
    {
      age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    }
    ./disko-config.nix
    ./hardware-configuration.nix
    ./core.nix
  ] ++ nixosModules;
}
