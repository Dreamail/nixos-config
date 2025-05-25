{ pkgs, ... }:
let
  jbt-hidpi = pkgs.jetbrains-toolbox.overrideAttrs (previousAttrs: {
    nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [ pkgs.makeWrapper ];
    installPhase =
      previousAttrs.installPhase
      + ''
        wrapProgram $out/bin/jetbrains-toolbox \
          --run "export XCURSOR_SIZE=\''${HIDPI_XPROP:+\''$((\''${XCURSOR_SIZE} * 2))}"
      '';
  });
in
{
  home.packages = [ jbt-hidpi ];
}
