{
  monitor = [
    "Virtual-1,2560x1600@165,auto,1.67"
  ];
  env = [
    "AQ_DRM_DEVICES,/dev/dri/card0"
  ];

  bind = [
    "$mainMod, T, exec, uwsm app -- kitty"
    "$mainMod, Delete, exit,"
  ];
}
