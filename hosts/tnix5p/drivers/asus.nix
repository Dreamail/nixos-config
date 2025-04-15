{
  lib,
  pkgs,
  ...
}:
{
  services.supergfxd.enable = true;
  services.asusd = {
    enable = true;
    enableUserService = true;
  };
  services.logind.killUserProcesses = true;

  # linux-g14 form https://gitlab.com/dragonn/linux-g14
  boot.kernelPackages = pkgs.linuxPackagesFor (
    pkgs.linux_6_13.override {
      argsOverride =
        let
          g14 = pkgs.fetchFromGitLab {
            owner = "dragonn";
            repo = "linux-g14";
            rev = "83010b4bc2a12fe18ab3532b6eea60e90db18d91";
            hash = "sha256-ShKxLGb7tO97onL3AopNBMnN6Yoa0Eri2eHct0zS9y0=";
          };
        in
        rec {
          src = pkgs.fetchurl {
            url = "mirror://kernel/linux/kernel/v${lib.versions.major version}.x/linux-${version}.tar.xz";
            sha256 = "3a39b62038b7ac2f43d26a1f84b4283e197804e1e817ad637e9a3d874c47801d";
          };
          version = "6.13.7";
          modDirVersion = "6.13.7";

          kernelPatches = [
            {
              name = "sys-kernel_arch-sources-g14_files-0004-more-uarches-for-kernel-6.8-rc4+";
              patch = builtins.fetchurl {
                name = "lite-more-x86-64-ISA-levels-for-kernel-6.8-rc4+.patch";
                url = "https://raw.githubusercontent.com/graysky2/kernel_compiler_patch/refs/heads/master/lite-more-x86-64-ISA-levels-for-kernel-6.8-rc4%2B.patch";
                sha256 = "a6045647f030f2686b2c42075569a40ca9833f559dcd2cdebd01b1964e7388cd";
              };
            }
            {
              name = "acpi-proc-idle-skip-dummy-wait";
              patch = "${g14}/0001-acpi-proc-idle-skip-dummy-wait.patch";
            }
            # {
            #   name = "platform-x86-amd-pmf-Add-quirk-for-ROG-Ally-X";
            #   patch = "${g14}/0001-platform-x86-amd-pmf-Add-quirk-for-ROG-Ally-X.patch";
            # }
            {
              name = "asus-patch-series";
              patch = "${g14}/asus-patch-series.patch";
            }
            {
              name = "acpi-x86-s2idle-Add-ability-to-configure-wakeup-by-A";
              patch = "${g14}/0070-acpi-x86-s2idle-Add-ability-to-configure-wakeup-by-A.patch";
            }
            {
              name = "hid-asus-change-the-report_id-used-for-HID-LED-co";
              patch = "${g14}/v2-0002-hid-asus-change-the-report_id-used-for-HID-LED-co.patch";
            }
            # {
            #   name = "workaround_hardware_decoding_amdgpu";
            #   patch = "${g14}/0040-workaround_hardware_decoding_amdgpu.patch";
            # }
            # {
            #   name = "amdgpu-adjust_plane_init_off_by_one.patch";
            #   patch = "${g14}/0081-amdgpu-adjust_plane_init_off_by_one.patch";
            # }
            # {
            #   name = "amd-add-GA605W-H706-quirks";
            #   patch = "${g14}/0082-amd-add-GA605W-H706-quirks.patch";
            # }
            {
              name = "enable-steam-deck-hdr";
              patch = "${g14}/0084-enable-steam-deck-hdr.patch";
            }
            # {
            #   name = "HID-amd_sfh-Add-support-for-tablet-mode";
            #   patch = "${g14}/PATCH-0-1-HID-amd_sfh-Add-support-for-tablet-mode.patch";
            # }
            # {
            #   name = "sys-kernel_arch-sources-g14_files-0047-asus-nb-wmi-Add-tablet_mode_sw-lid-flip";
            #   patch = "${g14}/sys-kernel_arch-sources-g14_files-0047-asus-nb-wmi-Add-tablet_mode_sw-lid-flip.patch";
            # }
            # {
            #   name = "sys-kernel_arch-sources-g14_files-0048-asus-nb-wmi-fix-tablet_mode_sw_int";
            #   patch = "${g14}/sys-kernel_arch-sources-g14_files-0048-asus-nb-wmi-fix-tablet_mode_sw_int.patch";
            # }
            {
              name = "linux-g14-config";
              patch = null;
              structuredExtraConfig = with lib.kernel; {
                # CONFIG_PINCTRL_AMD = yes;
                # CONFIG_X86_AMD_PSTATE = yes;
                # CONFIG_AMD_PMC = module;

                CONFIG_MODULE_COMPRESS_NONE = no;
                CONFIG_MODULE_COMPRESS_ZSTD = yes;

                ## SET default LRU parameters
                CONFIG_LRU_GEN = yes;
                CONFIG_LRU_GEN_ENABLED = yes;
                CONFIG_LRU_GEN_STATS = no;
                CONFIG_NR_LRU_GENS = 7;
                CONFIG_TIERS_PER_GEN = 4;

                # DISABLE not need modules on ROG laptops
                # XXX: I'm going to make an opinionated decision here and save everyone some compilation time
                # XXX: on drivers almost no-one is going to use; if you need any of theese turn them on in myconfig
                CONFIG_INFINIBAND = no;
                CONFIG_DRM_NOUVEAU = no;
                CONFIG_PCMCIA_WL3501 = no;
                CONFIG_PCMCIA_RAYCS = no;
                CONFIG_IWL3945 = no;
                CONFIG_IWL4965 = no;
                CONFIG_IPW2200 = no;
                CONFIG_IPW2100 = no;
                CONFIG_FB_NVIDIA = no;
                CONFIG_SENSORS_ASUS_EC = no;
                CONFIG_SENSORS_ASUS_WMI_EC = no;

                # select slightly more sane block device driver options; NVMe really should be built in
                CONFIG_RAPIDIO = no;
                CONFIG_CDROM = module;
                CONFIG_PARIDE = no;

                # bake in s0ix debugging parameters so we get useful problem reports re: suspend
                # CONFIG_CMDLINE_BOOL = yes;
                # CONFIG_CMDLINE = "ibt=off pm_debug_messages amd_pmc.dyndbg=\"+p\" acpi.dyndbg=\"file drivers/acpi/x86/s2idle.c +p\"";
                # CMDLINE_OVERRIDE = no;

                # enable back EFI_HANDOVER_PROTOCOL and EFI_STUB
                CONFIG_EFI_HANDOVER_PROTOCOL = yes;
                CONFIG_EFI_STUB = yes;

                # try to fix stuttering on some ROG laptops
                CONFIG_HW_RANDOM_TPM = no;

                # enable SCHED_CLASS_EXT
                CONFIG_SCHED_CLASS_EXT = yes;

                # enable CONFIG_ASUS_ARMOURY
                CONFIG_ASUS_WMI_BIOS = yes;
                CONFIG_HID_ASUS_ALLY = module;
                CONFIG_ASUS_ARMOURY = yes;
                CONFIG_ASUS_WMI_DEPRECATED_ATTRS = yes;
                CONFIG_DRM_AMD_COLOR_STEAMDECK = yes;
              };
            }
          ];
        };
    }
  );
}
