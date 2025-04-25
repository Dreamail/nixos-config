{
  stdenv,
  bash,
  endpoint ? "",
  user ? "",
  pass ? "",
}:
stdenv.mkDerivation {
  pname = "SyncClipboard-Script";
  version = "0.0.1";
  src = ./.;
  installPhase = ''
    mkdir -p $out/bin
    cp syncclipboard-script.sh $out/bin
    chmod +x $out/bin/syncclipboard-script.sh
    substituteInPlace $out/bin/syncclipboard-script.sh \
      --replace-fail "bash" "${bash}/bin/bash" \
      --replace-fail "{{ ENDPOINT_PLACEHOLDER }}" "${endpoint}" \
      --replace-fail "{{ USER_PLACEHOLDER }}" "${user}" \
      --replace-fail "{{ PASS_PLACEHOLDER }}" "${pass}"
  '';
}
