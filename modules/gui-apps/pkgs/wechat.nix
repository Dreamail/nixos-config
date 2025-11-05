{
  appimageTools,
  fetchurl,
  wechat-data ? "\${HOME}/WeChat_Data",
}:
let
  pname = "wechat-linux";
  version = "4.1.0.13";
  appimage = fetchurl {
    url = "https://github.com/Dreamail/wechat-appimages/releases/download/v${version}/WeChatLinux_x86_64.AppImage";
    hash = "sha256-+r5Ebu40GVGG2m2lmCFQ/JkiDsN/u7XEtnLrB98602w=";
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
    export QT_QPA_PLATFORM=xcb
    if [[ ''${XMODIFIERS} =~ fcitx ]]; then
      export QT_IM_MODULE=fcitx
      export GTK_IM_MODULE=fcitx
    elif [[ ''${XMODIFIERS} =~ ibus ]]; then
      export QT_IM_MODULE=ibus
      export GTK_IM_MODULE=ibus
      export IBUS_USE_PORTAL=1
    fi

    export XCURSOR_SIZE=''${HIDPI_XPROP:+''$((''${XCURSOR_SIZE} * 2))}

    mkdir -p ${wechat-data}/home
    mkdir -p ${wechat-data}/xwechat_files
  '';
  extraBwrapArgs = [
    "--tmpfs /home"
    "--tmpfs /root"
    "--bind ${wechat-data}/home \${HOME}"
    "--bind ${wechat-data}/xwechat_files ${wechat-data}/xwechat_files"
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
  unsharePid = true;
  unshareNet = false;
  unshareUts = true;
  unshareCgroup = true;
  privateTmp = true;

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons
    cp -r ${src}/wechat.desktop $out/share/applications

    substituteInPlace $out/share/applications/wechat.desktop \
      --replace-quiet 'Exec=AppRun %U' "Exec=$out/bin/wechat-linux" \
      --replace-quiet 'Name=wechat' "Name=WeChat"
  '';
}
