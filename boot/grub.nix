{ config, pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        efiSupport = true;
        device = "nodev";
        useOSProber = false;
        default = "saved";
        extraEntries = ''
menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-20A4-5216' {
	savedefault
	insmod part_gpt
	insmod fat
	search --no-floppy --fs-uuid --set=root 20A4-5216
	chainloader /efi/Microsoft/Boot/bootmgfw.efi
}
        '';
      };
    };
    supportedFilesystems = [ "ntfs" ];
  };
}
