{
  lib,
  stdenv,
  makeWrapper,
  makeDesktopItem,
  autoPatchelfHook,
  fetchurl,
  jdk8,

  # use bundled jdk if version > 4.0
  # minimum dependencies
  alsa-lib,
  fontconfig,
  freetype,
  xorg,
  zlib,
  # runtime dependencies
  cups,
  # runtime dependencies for GTK+ Look and Feel
  gtkSupport ? !stdenv.targetPlatform.isGhcjs,
  cairo,
  glib,
  gtk3,
}:

let
  generic =
    {
      version,
      hash,
      platform ? "",
      ...
    }@attrs:
    let
      runtimeDependencies =
        [
          cups
        ]
        ++ lib.optionals gtkSupport [
          cairo
          glib
          gtk3
        ];
      runtimeLibraryPath = lib.makeLibraryPath runtimeDependencies;
      desktopItem = makeDesktopItem {
        categories = [
          "Network"
          "Development"
          "WebDevelopment"
          "Java"
        ];
        desktopName = "Charles";
        exec = "charles %F";
        genericName = "Web Debugging Proxy";
        icon = "charles-proxy";
        mimeTypes = [
          "application/x-charles-savedsession"
          "application/x-charles-savedsession+xml"
          "application/x-charles-savedsession+json"
          "application/har+json"
          "application/vnd.tcpdump.pcap"
          "application/x-charles-trace"
        ];
        name = "Charles";
        startupNotify = true;
      };
    in
    stdenv.mkDerivation {
      pname = "charles";
      inherit version;

      src = fetchurl {
        url = "https://www.charlesproxy.com/assets/release/${builtins.elemAt (builtins.split "b" version) 0}/charles-proxy-${version}${platform}.tar.gz";
        curlOptsList = [
          "--user-agent"
          "Mozilla/5.0"
        ]; # HTTP 104 otherwise
        inherit hash;
      };

      buildInputs = [
        alsa-lib # libasound.so wanted by lib/libjsound.so
        fontconfig
        freetype
        (lib.getLib stdenv.cc.cc) # libstdc++.so.6
        xorg.libX11
        xorg.libXext
        xorg.libXi
        xorg.libXrender
        xorg.libXtst
        zlib
      ];

      nativeBuildInputs = [
        makeWrapper
        autoPatchelfHook
      ];

      installPhase = ''
        ${
          if (lib.versionOlder version "4.0") then
            "JAVA=${jdk8}"
          # use bundled JDK, patches from https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/development/compilers/temurin-bin/jdk-linux-base.nix
          else
            ''
              mkdir -p $out/lib/jdk && cp -a ./lib/jdk/* $out/lib/jdk
              for bin in $( find "$out/lib/jdk" -executable -type f -not -name jspawnhelper ); do
                if patchelf --print-interpreter "$bin" &> /dev/null; then
                  wrapProgram "$bin" --prefix LD_LIBRARY_PATH : "${runtimeLibraryPath}"
                fi
              done
              JAVA=$out/lib/jdk
            ''
        }

        makeWrapper $JAVA/bin/java $out/bin/charles \
          --add-flags "-Xmx1024M -Dcharles.config='~/.charles.config' ${lib.optionalString (lib.versionOlder version "5.0") "-jar $out/share/java/charles.jar"} ${lib.optionalString (lib.versionAtLeast version "5.0") "-XX:+UseZGC -Djava.library.path='$out/share/java' --add-opens java.base/sun.security.ssl=com.charlesproxy --add-opens java.desktop/java.awt.event=com.charlesproxy --add-opens java.base/java.io=com.charlesproxy --add-modules com.jthemedetector,com.formdev.flatlaf --module-path '$out/share/java' -m com.charlesproxy"}"

        for fn in lib/*.jar; do
          install -D -m644 $fn $out/share/java/$(basename $fn)
        done

        mkdir -p $out/share/applications
        ln -s ${desktopItem}/share/applications/* $out/share/applications/

        mkdir -p $out/share/icons
        cp -r icon $out/share/icons/hicolor
      '';

      preFixup =
        if (lib.versionAtLeast version "4.0") then # use bundled JDK
          ''
            find "$out/lib/jdk" -name libfontmanager.so -exec \
              patchelf --add-needed libfontconfig.so {} \;
          ''
        else
          "";

      meta = {
        description = "Web Debugging Proxy";
        homepage = "https://www.charlesproxy.com/";
        maintainers = with lib.maintainers; [
          kalbasit
          kashw2
        ];
        sourceProvenance = with lib.sourceTypes; [ binaryBytecode ];
        license = lib.licenses.unfree;
        platforms = lib.platforms.unix;
      };
    };

in
{
  charles5 = (
    generic {
      version = "5.0.1";
      hash = "sha256-H/WWgYMlglU7cFjcLQ3mlknBXSSPvWgKrrcJFgyV23o=";
      platform = "_x86_64";
    }
  );
  charles5b = (
    generic {
      version = "5.0.2b1";
      hash = "sha256-JpDxbYAWzwqwgysrIv+Fy2ERZH70RwaeRUhLiKk555k=";
      platform = "_x86_64";
    }
  );
  charles4 = (
    generic {
      version = "4.6.8";
      hash = "sha256-AaS+zmQTWsGoLEhyGHA/UojmctE7IV0N9fnygNhEPls=";
      platform = "_amd64";
    }
  );
  charles3 = (
    generic {
      version = "3.12.3";
      hash = "sha256-Wotxzf6kutYv1F6q71eJVojVJsATJ81war/w4K1A848=";
      mainProgram = "charles";
    }
  );
}
