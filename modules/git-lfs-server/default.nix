{
  homeModule = { };
  nixosModule =
    { inputs, pkgs, ... }:
    let
      server = pkgs.callPackage ./lfs-test-server.nix { };
      domain = (import "${inputs.mysecrets}/aliyun.nix").domain;
      cfg = {
        host = "git-lfs.${domain}";
        port = 9080;
        user = "git-lfs-server";
        group = "git-lfs-server";
        home = "/var/lib/git-lfs-server";
      };
    in
    {
      users.users.${cfg.user} = {
        isSystemUser = true;
        inherit (cfg) group home;
        createHome = true;
      };

      users.groups.${cfg.group} = { };

      systemd.services."git-lfs-server" = {
        description = "Git LFS Server";
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
          ExecStart = "${server}/bin/lfs-test-server";
          Restart = "on-failure";
          Type = "simple";
          User = cfg.user;
          Group = cfg.group;
          WorkingDirectory = cfg.home;
        };
        environment = {
          LFS_LISTEN = "tcp://:${toString cfg.port}";
          LFS_HOST = "localhost:${toString cfg.port}";
          LFS_METADB = "lfs.db";
          LFS_CONTENTPATH = "lfs-content";
          LFS_EXTORIGIN = "https://${cfg.host}";
          LFS_ADMINUSER = "admin";
          LFS_ADMINPASS = "selena2lfs";
        };
      };

      services.nginx.virtualHosts = {
        "git-lfs.${domain}" = {
          addSSL = true;
          useACMEHost = domain;
          locations."/" = {
            proxyPass = "http://127.0.0.1:${toString cfg.port}";
          };
          extraConfig = ''
            client_max_body_size 1G;
          '';
        };
      };
    };
}
