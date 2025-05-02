{
  homeModule = { };
  nixosModule = {
    services.tailscale.extraSetFlags = [ "--netfilter-mode=off" ];
  };
}
