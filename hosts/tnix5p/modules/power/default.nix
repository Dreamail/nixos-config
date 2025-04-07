{
  homeModule = {};
  nixosModule = {
    powerManagement.resumeCommands = ''
      rmmod r8169
      modprobe r8169
    '';
    boot.kernelParams = [
      "mem_sleep_default=deep"
    ];
    services.logind.powerKey = "ignore";
    services.logind.lidSwitch = "suspend-then-hibernate";
    services.logind.lidSwitchExternalPower = "lock";
  };
}
