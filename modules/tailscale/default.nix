{
  homeModule = { };
  nixosModule =
    { inputs, config, ... }:
    let
      domain = (import "${inputs.mysecrets}/aliyun.nix").domain;
    in
    {
      services.tailscale = {
        enable = true;
        useRoutingFeatures = "both";
        openFirewall = true;
        extraUpFlags = [
          "--login-server"
          "https://hs.${domain}"
        ];
        extraSetFlags = [ "--advertise-exit-node" ];
        authKeyFile = config.age.secrets.tailscale-authkey.path;
      };
    };
}
