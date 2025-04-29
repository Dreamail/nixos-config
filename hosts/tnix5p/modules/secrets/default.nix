{
  homeModule = { };
  nixosModule =
    { inputs, ... }:
    {
      age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      age.secrets.tailscale-authkey.file = "${inputs.mysecrets}/tailscale-authkey-tnix5p.age";
    };
}
