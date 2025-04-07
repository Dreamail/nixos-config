{pkgs, ...}: {
  programs.kitty.enable = true;
  catppuccin.kitty.enable = true;

  home.packages = [pkgs.zsh-powerlevel10k];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "sudo"
        "git"
      ];
    };
    initExtraFirst = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${./.p10k.zsh}
    '';
  };
  programs.nix-index.enable = true;

  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, T, exec, uwsm app -- kitty"
    ];
  };
}
