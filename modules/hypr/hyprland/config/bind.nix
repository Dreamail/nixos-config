{
  "$mainMod" = "SUPER";
  bind = [
    # Window actions
    "$mainMod, Q, killactive"
    "$mainMod, W, togglefloating"

    # Switch workspace
    "$mainMod, 1, workspace, 1"
    "$mainMod, 2, workspace, 2"
    "$mainMod, 3, workspace, 3"
    "$mainMod, 4, workspace, 4"
    "$mainMod, 5, workspace, 5"
    "$mainMod, 6, workspace, 6"
    "$mainMod, 7, workspace, 7"
    "$mainMod, 8, workspace, 8"
    "$mainMod, 9, workspace, 9"
    "$mainMod, 0, workspace, 10"
    "$mainMod, S, togglespecialworkspace"

    # Move to workspace
    "$mainMod+Shift, 1, movetoworkspace, 1"
    "$mainMod+Shift, 2, movetoworkspace, 2"
    "$mainMod+Shift, 3, movetoworkspace, 3"
    "$mainMod+Shift, 4, movetoworkspace, 4"
    "$mainMod+Shift, 5, movetoworkspace, 5"
    "$mainMod+Shift, 6, movetoworkspace, 6"
    "$mainMod+Shift, 7, movetoworkspace, 7"
    "$mainMod+Shift, 8, movetoworkspace, 8"
    "$mainMod+Shift, 9, movetoworkspace, 9"
    "$mainMod+Shift, 0, movetoworkspace, 10"
    "$mainMod+Shift, S, movetoworkspace, special"
    "$mainMod+Shift+Alt, S, movetoworkspace, +0" # move out of special

    # Move to workspace silently
    "$mainMod+Alt, 1, movetoworkspacesilent, 1"
    "$mainMod+Alt, 2, movetoworkspacesilent, 2"
    "$mainMod+Alt, 3, movetoworkspacesilent, 3"
    "$mainMod+Alt, 4, movetoworkspacesilent, 4"
    "$mainMod+Alt, 5, movetoworkspacesilent, 5"
    "$mainMod+Alt, 6, movetoworkspacesilent, 6"
    "$mainMod+Alt, 7, movetoworkspacesilent, 7"
    "$mainMod+Alt, 8, movetoworkspacesilent, 8"
    "$mainMod+Alt, 9, movetoworkspacesilent, 9"
    "$mainMod+Alt, 0, movetoworkspacesilent, 10"
    "$mainMod+Alt, S, movetoworkspacesilent, special"
    "$mainMod+Alt, S, movetoworkspacesilent, +0" # move out of special
  ];

  bindm = [
    # Window actions
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];
}
