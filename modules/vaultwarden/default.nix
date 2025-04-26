{
  homeModele = { };
  nixosModule = {inputs, ...}:
    let
      domain = (import "${inputs.mysecrets}/aliyun.nix").domain;
    in
    {
      services.vaultwarden = {
        enable = true;
        config = {
          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = 8222;
          SIGNUPS_ALLOWED = false;
          DOMAIN= "https://bitwarden.${domain}";
        };
      };
      services.nginx = {
        virtualHosts."bitwarden.${domain}" = {
          useACMEHost = domain;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8222";
          };
        };
      };
    };
}
