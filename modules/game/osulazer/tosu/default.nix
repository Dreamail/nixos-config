{
  fetchFromGitHub,
  fetchurl,
  stdenv,
  makeWrapper,
  nodejs,
  pnpm,
  python3,
}:
let
  nodejs-header = fetchurl {
    url = "https://nodejs.org/download/release/v${nodejs.version}/node-v${nodejs.version}-headers.tar.gz";
    sha256 = "sha256-SqhZxBPmyFUAFb4WsKVd+FNYpw5KwfBK0j7kLoVmwTw=";
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "tosu";
  version = "4.11.0";

  src = fetchFromGitHub {
    owner = "tosuapp";
    repo = "tosu";
    tag = "v${finalAttrs.version}";
    hash = "sha256-3YDlbs9w3B0Jp+RbLEwkOKY4TQ5WKWg2yj+W5cA738o=";
  };

  nativeBuildInputs = [
    nodejs
    pnpm.configHook
    python3
    makeWrapper
  ];

  pnpmDeps = pnpm.fetchDeps {
    inherit (finalAttrs)
      pname
      version
      src
      ;
    fetcherVersion = 1;
    hash = "sha256-sWSj834k6nBczf2iWHTqvFLeNzyPFJwdlYdO3DZ54iE=";
  };

  env = {
    NIX_CFLAGS_COMPILE = "-Wno-error=format-security";
    NPM_CONFIG_TARBALL = "${nodejs-header}";
  };

  buildPhase = ''
    pnpm install --frozen-lockfile --no-color --stream

    pnpm run -C packages/tosu genver
    pnpm run -C packages/tosu ts:compile
    pnpm run -C packages/tosu compile:prepare-htmls
  '';

  installPhase = ''
    mkdir -p $out/share/tosu
    cp -r packages/tosu/dist/* $out/share/tosu/

    makeWrapper ${nodejs}/bin/node $out/bin/tosu \
      --add-flags "$out/share/tosu/index.js" \
      --run "mkdir -p \''${XDG_CONFIG_HOME}/tosu; cd \''${XDG_CONFIG_HOME}/tosu"
  '';

  fixupPhase = ''
    substituteInPlace $out/share/tosu/index.js \
      --replace-fail '__filename,"../../../assets"' '__dirname,"assets"'
  '';
})
