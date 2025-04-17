{
  homeModule = { };
  nixosModule =
    { pkgs, user, ... }:
    let
      tty = "tty1";
      username = user.name;
      command = "${pkgs.uwsm}/bin/uwsm start default";
    in
    {
      security.pam.services.autologin = {
        allowNullPassword = true;
        startSession = true;
      };

      # This prevents nixos-rebuild from killing greetd by activating getty again
      systemd.services."autovt@${tty}".enable = false;

      # Enable desktop session data
      services.displayManager.enable = true;

      systemd.services.autologin = {
        aliases = [ "display-manager.service" ];

        unitConfig = {
          Wants = [
            "systemd-user-sessions.service"
          ];
          After = [
            "systemd-user-sessions.service"
            "getty@${tty}.service"
            "plymouth-quit-wait.service"
          ];
          Conflicts = [
            "getty@${tty}.service"
          ];
        };

        serviceConfig = {
          ExecStart = "${(pkgs.callPackage ./pkg.nix { })}/bin/autologin ${username} ${command}";

          Restart = "on-success";

          IgnoreSIGPIPE = false;
          SendSIGHUP = true;
          TimeoutStopSec = "30s";
          KeyringMode = "shared";

          Type = "idle";
        };

        # Don't kill a user session when using nixos-rebuild
        restartIfChanged = false;

        wantedBy = [ "graphical.target" ];
      };

      systemd.defaultUnit = "graphical.target";
    };
}
