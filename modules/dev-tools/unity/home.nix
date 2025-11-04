{ pkgs, ... }:
let
  unityhub-libxml2-fixed = pkgs.callPackage ./unityhub.nix { 
    extraPkgs = pkgs: [ pkgs.uv ];
  };
  unityhub-hidpi = unityhub-libxml2-fixed.overrideAttrs (previousAttrs: {
    nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [ pkgs.makeWrapper ];
    installPhase =
      previousAttrs.installPhase
      + ''
        wrapProgram $out/opt/unityhub/unityhub \
          --run "export XCURSOR_SIZE=\''${HIDPI_XPROP:+\''$((\''${XCURSOR_SIZE} * 2))}"
      '';
  });
in
{
  home.packages = with pkgs; [
    unityhub-hidpi
    unityhub-hidpi.fhsEnv
    mono
    dotnet-sdk
    dotnetPackages.Nuget
  ];
}
