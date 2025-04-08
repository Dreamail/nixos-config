{
  stdenv,
  fetchFromGitHub,
  librime,
}:
stdenv.mkDerivation rec {
  name = "rime-frost";
  version = "0.0.5-f17ab9f";
  src = fetchFromGitHub {
    owner = "gaboolic";
    repo = "rime-frost";
    rev = "f17ab9f113f912843536c9f87051f72ea677d3bd";
    hash = "sha256-iJeG+O5Nhku+irtikf3E8fCOGe1nmO7skcFiTP6gJEg=";
  };
  buildInputs = [librime];
  buildPhase = ''
    rime_deployer --build .
    rm user.yaml
  '';
  installPhase = ''
    mkdir -p $out/share/rime-data/
    cp -a * $out/share/rime-data/
  '';
}
