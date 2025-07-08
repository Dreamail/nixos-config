{
  homeModule =
    { pkgs, ... }:
    {
      services.copyq = {
        enable = true;
        forceXWayland = false;
        package = pkgs.copyq.overrideAttrs (old: {
          nativeBuildInputs = if old ? nativeBuildInputs then old.nativeBuildInputs else [] ++ [ pkgs.makeWrapper ];
          postInstall = if old ? postInstall then old.postInstall else "" + ''
            wrapProgram "$out/bin/copyq" --prefix PATH : ${pkgs.htmlq}/bin
          '';
        });
      };

      wayland.windowManager.hyprland.settings = {
        windowrule = [
          "float, class:com.github.hluk.copyq"
          "move cursor 0 +5%, class:com.github.hluk.copyq"
          "size 25% 50%, class:com.github.hluk.copyq"
        ];
        bind = [ "$mainMod, V, exec, copyq toggle" ];
      };
    };
  nixosModule = { };
}
