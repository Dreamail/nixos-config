{ pkgs, ... }:
{
  nixpkgs-patcher = {
    enable = true;
    settings.patches = with pkgs; [
      (fetchpatch2 {
        name = "unityhub-313.patch";
        url = "https://github.com/NixOS/nixpkgs/pull/422785.diff";
        hash = "sha256-6L7w+wnUjaQYWmER6FwgwXzIZDLXUed4Tw0+TtS9aHc=";
      })
    ];
  };
}
