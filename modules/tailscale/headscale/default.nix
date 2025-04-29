{
  homeModule = { };
  nixosModule =
    {
      inputs,
      lib,
      pkgs,
      ...
    }:
    let
      domain = (import "${inputs.mysecrets}/aliyun.nix").domain;
    in
    {
      services.headscale = {
        enable = true;
        port = 1980;
        settings = {
          server_url = "https://hs.${domain}";
          dns.base_domain = "hs-hosts.${domain}";

          derp.urls = lib.mkForce [ ];
          derp.paths = [
            (pkgs.writeText "derper-sz.yaml" ''
              regions:
                900:
                  regionid: 900
                  regioncode: sz
                  regionname: Shenzhen
                  nodes:
                    - name: aliyun-sas
                      regionid: 900
                      hostname: derp-sz.${domain}
                20:
                  regionid: 20
                  regioncode: hkg
                  regionname: Hong Kong
                  nodes:
                    - name: 20b
                      regionid: 20
                      hostname: derp20b.tailscale.com
                      ipv4: "103.6.84.152"
                      ipv6: "2403:2500:8000:1::ef6"
                    - name: 20c
                      regionid: 20
                      hostname: derp20c.tailscale.com
                      ipv4: "205.147.105.30"
                      ipv6: "2403:2500:8000:1::5fb"
                    - name: 20d
                      regionid: 20
                      hostname: derp20d.tailscale.com
                      ipv4: "205.147.105.78"
                      ipv6: "2403:2500:8000:1::e9a"
            '')
          ];
        };
      };
      services.tailscale.derper = {
        enable = true;
        domain = "derp-sz.${domain}";
        verifyClients = true;
      };

      services.nginx.virtualHosts = {
        "hs.${domain}" = {
          useACMEHost = domain;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:1980";
            proxyWebsockets = true;
          };
        };
        "derp-sz.${domain}" = {
          useACMEHost = domain;
        };
      };
    };
}
