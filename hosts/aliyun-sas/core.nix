{ inputs, lib, ... }:
{
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
    timeoutStyle = "hidden";
  };

  networking = {
    hostName = "aliyun-sas";
    networkmanager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = lib.mkForce [ "https://mirrors.cernet.edu.cn/nix-channels/store" ];
  };

  time.timeZone = "Asia/Shanghai";

  services.openssh.enable = true;
  services.qemuGuest.enable = true;
  services.cloud-init = {
    enable = true;
    network.enable = true;
    settings = {
      disable_root = false;
      syslog_fix_perms = "root:root";
      preserve_hostname = true;
      datasource_list = [ "AliYun" ];
      datasource.AliYun = {
        support_xen = false;
        timeout = 5;
        max_wait = 60;
      };
    };
  };

  users.users.root.openssh.authorizedKeys.keys = (import "${inputs.mysecrets}/public-keys.nix").users;

  system.stateVersion = "24.05";
}
