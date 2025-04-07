{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, C, exec, uwsm app -- code"
    ];
  };
}
