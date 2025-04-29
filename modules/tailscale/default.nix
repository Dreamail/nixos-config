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
        extraUpFlags = [
          "--login-server"
          "https://hs.${domain}"
        ];
        authKeyFile = config.age.secrets.tailscale-authkey.path;
      };
    };
}
