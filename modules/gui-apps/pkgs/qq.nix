{
  appimageTools,
  fetchurl,
  qq-data ? "\${HOME}/QQ_Data",
}:
let
  pname = "qq-linux";
  version = "3.2.16_250401";
  appimage = fetchurl {
    url = "https://dldir1.qq.com/qqfile/qq/QQNT/Linux/QQ_${version}_x86_64_01.AppImage";
    hash = "sha256-M++enPKnFXYxnHjkkHf/0/2xYVvM1VAG8WZeScnLxuU=";
  };
  src = appimageTools.extract {
    src = appimage;
    inherit pname version;
  };
in
appimageTools.wrapAppImage {
  inherit pname version src;
  passthru = {
    src = appimage;
  };

  extraPreBwrapCmds = ''
    mkdir -p ${qq-data}/home
  '';
  extraBwrapArgs = [
    "--tmpfs /home"
    "--tmpfs /root"
    "--bind ${qq-data}/home \${HOME}"
    "--chdir \${HOME}"

    "--ro-bind-try \${HOME}/.fontconfig{,}"
    "--ro-bind-try \${HOME}/.fonts{,}"
    "--ro-bind-try \${HOME}/.config/fontconfig{,}"
    "--ro-bind-try \${HOME}/.local/share/fonts{,}"
    "--ro-bind-try \${HOME}/.icons{,}"
    "--ro-bind-try \${HOME}/.local/share/.icons{,}"
  ];
  chdirToPwd = false;
  unshareUser = true;
  unshareIpc = true;
  unsharePid = false;
  unshareNet = false;
  unshareUts = true;
  unshareCgroup = true;
  privateTmp = true;

  runScript = "appimage-exec.sh -w ${src} -- \${NIXOS_OZONE_WL:+\${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}";

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons
    cp -r ${src}/qq.desktop $out/share/applications

    substituteInPlace $out/share/applications/qq.desktop \
      --replace-quiet 'Exec=AppRun --no-sandbox %U' "Exec=$out/bin/qq-linux" \
      --replace-quiet 'Icon=/opt/QQ/resources/app/512x512.png' "Icon=qq"
  '';
}
