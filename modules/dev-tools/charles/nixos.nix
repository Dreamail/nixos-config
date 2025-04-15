{
  inputs,
  pkgs,
  ...
}:
let
  charles-hidpi = pkgs.charles.overrideAttrs (previousAttrs: {
    nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [ pkgs.makeWrapper ];
    installPhase =
      previousAttrs.installPhase
      + ''
        wrapProgram $out/bin/charles \
          --set _JAVA_OPTIONS "-Dsun.java2d.uiScale=2" \
          --run "export XCURSOR_SIZE=\''${HIDPI_XPROP:+\''$((\''${XCURSOR_SIZE} * 2))}"
      '';
  });
in
{
  environment.systemPackages = [ charles-hidpi ];

  security.pki.certificateFiles = [
    "${inputs.mysecrets}/charles-ca/charles-proxy-ssl-proxying-certificate.pem"
  ];
}
