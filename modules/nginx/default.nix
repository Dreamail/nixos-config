{
  homeModele = { };
  nixosModule =
    {
      inputs,
      pkgs,
      config,
      ...
    }:
    let
      aliyun = (import "${inputs.mysecrets}/aliyun.nix");
      email = aliyun.email;
      domain = aliyun.domain;
      beian = aliyun.beian;
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
        virtualHosts."${domain}" = {
          addSSL = true;
          useACMEHost = domain;
          serverAliases = [ "www.${domain}" ];
          root = pkgs.writeTextDir "index.html" ''
            <!DOCTYPE html>
            <html lang="zh-CN">
              <meta charset="UTF-8">
              <a href="https://beian.miit.gov.cn/" target="_blank">${beian}</a>
            </html>
          '';
        };
      };
    };
}
