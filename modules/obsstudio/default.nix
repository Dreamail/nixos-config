{
  homeModule = { };
  nixosModule =
    { pkgs, ... }:
    let
      pyenv = pkgs.python3.withPackages (
        ps: with ps; [
          pyperclip
          pypinyin
          qrcode
          requests
          websockets
          pillow
        ]
      );
    in
    {
      programs.obs-studio = {
        enable = true;
        package =
          (pkgs.obs-studio.override {
            cudaSupport = true;
            python3 = pyenv;
          }).overrideAttrs
            (old: {
              preFixup =
                (if old ? preFixup then old.preFixup else "")
                + ''
                  qtWrapperArgs+=(
                    --prefix PATH : ${pyenv}/bin
                  )
                '';
            });

        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
          obs-vaapi
          obs-vkcapture
        ];
      };
    };
}
