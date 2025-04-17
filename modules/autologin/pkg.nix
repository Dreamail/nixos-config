{
  stdenv,
  fetchFromSourcehut,
  pkg-config,
  meson,
  ninja,
  pam,
}:

stdenv.mkDerivation rec {
  pname = "autologin";
  version = "1.0.0";

  src = fetchFromSourcehut {
    owner = "~kennylevinsen";
    repo = pname;
    rev = version;
    sha256 = "sha256-Cy4v/1NuaiSr5Bl6SQMWk5rga8h1QMBUkHpN6M3bWOc=";
  };

  nativeBuildInputs = [
    pkg-config
    meson
    ninja
  ];

  buildInputs = [
    pam
  ];
}