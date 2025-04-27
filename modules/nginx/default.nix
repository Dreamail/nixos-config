{
  homeModele = { };
  nixosModule =
    { inputs, config, ... }:
    let
      aliyun = (import "${inputs.mysecrets}/aliyun.nix");
      email = aliyun.email;
      domain = aliyun.domain;
    in
    {
      age.secrets.acme-alidns.file = "${inputs.mysecrets}/acme-alidns.age";
      security.acme = {
        acceptTerms = true;
        defaults.email = email;
        certs.${domain} = {
          domain = "*.${domain}";
          group = "nginx";
          dnsProvider = "alidns";
          environmentFile = config.age.secrets.acme-alidns.path;
        };
      };
      services.nginx = {
        enable = true;
        recommendedGzipSettings = true;
      };
    };
}
