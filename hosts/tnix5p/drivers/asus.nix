{
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      supergfxctl = prev.supergfxctl.overrideAttrs (previousAttrs: {
        patches = [ ./supergfxctl.patch ];
      });
    })
  ];
  services.supergfxd = {
    enable = true;
    settings = {
      mode = "Hybrid";
      vfio_enable = false;
      vfio_save = false;
      always_reboot = false;
      no_logind = false;
      logout_timeout_s = 180;
      hotplug_type = "Asus";
    };
  };
  services.asusd = {
    enable = true;
    enableUserService = true;
  };
  boot.kernelParams = [ "acpi_backlight=nvidia_wmi_ec" ];

  # linux-g14 form https://gitlab.com/dragonn/linux-g14
  boot.kernelPackages = pkgs.linuxPackagesFor (
    pkgs.linux_6_15.override {
      argsOverride =
        let
          g14 = pkgs.fetchFromGitLab {
            owner = "dragonn";
            repo = "linux-g14";
            rev = "d234698be87ecf7d7d345261df22cbb0b5f1cad1";
            hash = "sha256-M1tapIixkqxZt9Uds1M49iaFWf7sruVxH570dd3wrJA=";
          };
        in
        rec {
          stdenv = pkgs.stdenvAdapters.addAttrsToDerivation {
            # Hacky way to add patch flags so that the patches can be applied correctly
            patchFlags = [
              "-Np1"
              "-F150"
            ];
          } pkgs.stdenv;

          src = pkgs.fetchurl {
            url = "mirror://kernel/linux/kernel/v${lib.versions.major version}.x/linux-${version}.tar.xz";
            hash = "sha256-Dq/WJ7YC9Y1zkX0A5PwxlroYy6Z99plaQqp0dE2O+hY=";
          };
          version = "6.15.4";
          modDirVersion = "6.15.4";

          ignoreConfigErrors = true;

          kernelPatches = [
            {
              name = "sys-kernel_arch-sources-g14_files-0004-more-uarches-for-kernel-6.15";
              patch = "${g14}/sys-kernel_arch-sources-g14_files-0004-more-uarches-for-kernel-6.15.patch";
            }
            {
              name = "acpi-proc-idle-skip-dummy-wait";
              patch = "${g14}/0001-acpi-proc-idle-skip-dummy-wait.patch";
            }
            {
              name = "asus-patch-series";
              patch = "${g14}/asus-patch-series.patch";
            }
            {
              name = "0004-asus-armoury_improve_xgm_support.patch";
              patch = "${g14}/0004-asus-armoury_improve_xgm_support.patch";
            }
            {
              name = "0003-asus-armoury_make_xg_mobile_plug-and-play.patch";
              patch = "${g14}/0003-asus-armoury_make_xg_mobile_plug-and-play.patch";
            }
            {
              name = "0002-auto-brigthness.patch";
              patch = "${g14}/0002-auto-brigthness.patch";
            }
            {
              name = "acpi-x86-s2idle-Add-ability-to-configure-wakeup-by-A";
              patch = "${g14}/0070-acpi-x86-s2idle-Add-ability-to-configure-wakeup-by-A.patch";
            }
            {
              name = "hid-asus-change-the-report_id-used-for-HID-LED-co";
              patch = "${g14}/v2-0002-hid-asus-change-the-report_id-used-for-HID-LED-co.patch";
            }
            {
              name = "PATCH-v3-0-5-Improvements-to-S5-power-consumption.patch";
              patch = "${g14}/PATCH-v3-0-5-Improvements-to-S5-power-consumption.patch";
            }
            {
              name = "PATCH-mm-Add-Kcompressd-for-accelerated-memory-compression.patch";
              patch = "${g14}/PATCH-mm-Add-Kcompressd-for-accelerated-memory-compression.patch";
            }
            {
              name = "linux-g14-config";
              patch = null;
              structuredExtraConfig = with lib.kernel; {
                # PINCTRL_AMD = yes;
                # X86_AMD_PSTATE = yes;
                # AMD_PMC = module;

                ## SET default LRU parameters
                LRU_GEN = yes;
                LRU_GEN_ENABLED = yes;
                LRU_GEN_STATS = no;

                # DISABLE not need modules on ROG laptops
                # XXX: I'm going to make an opinionated decision here and save everyone some compilation time
                # XXX: on drivers almost no-one is going to use; if you need any of theese turn them on in myconfig
                INFINIBAND = lib.mkForce no;
                DRM_NOUVEAU = no;
                IWL3945 = no;
                IWL4965 = no;
                IPW2200 = no;
                IPW2100 = no;
                FB_NVIDIA = no;
                SENSORS_ASUS_EC = no;

                # select slightly more sane block device driver options; NVMe really should be built in
                RAPIDIO = no;
                CDROM = module;

                # bake in s0ix debugging parameters so we get useful problem reports re: suspend
                # CMDLINE_BOOL = yes;
                # CMDLINE = "ibt=off pm_debug_messages amd_pmc.dyndbg=\"+p\" acpi.dyndbg=\"file drivers/acpi/x86/s2idle.c +p\"";
                # CMDLINE_OVERRIDE = no;

                # enable back EFI_HANDOVER_PROTOCOL and EFI_STUB
                EFI_HANDOVER_PROTOCOL = yes;
                EFI_STUB = yes;

                # try to fix stuttering on some ROG laptops
                HW_RANDOM_TPM = no;

                # enable SCHED_CLASS_EXT
                SCHED_CLASS_EXT = yes;

                # enable ASUS_ARMOURY
                ASUS_ARMOURY = module;
              };
            }
          ];
        };
    }
  );
}
