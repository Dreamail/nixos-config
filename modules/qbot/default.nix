{
  homeModule = { };
  nixosModule =
    { inputs, ... }:
    let
      domain = (import "${inputs.mysecrets}/aliyun.nix").domain;
    in
    {
      services.nginx.virtualHosts = {
        "qbot.${domain}" = {
          addSSL = true;
          useACMEHost = domain;
          locations."/" = {
            proxyPass = "http://127.0.0.1:10180";
          };
        };
      };
    };
}
