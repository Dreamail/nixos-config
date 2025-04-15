{
  homeModule = { };
  nixosModule = {
    # workaround for run0 <https://github.com/NixOS/nixpkgs/issues/361592>
    security.pam.services.systemd-run0 = {
      setEnvironment = true;
      pamMount = false;
    };
  };
}
