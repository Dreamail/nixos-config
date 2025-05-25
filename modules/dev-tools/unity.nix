{ pkgs, ... }:
let
  unityhub-hidpi = pkgs.unityhub.overrideAttrs (previousAttrs: {
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
    mono
    dotnet-sdk
    dotnetPackages.Nuget
  ];
}
