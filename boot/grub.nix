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
        useOSProber = true;
        default = "saved";
        #        extraEntries = ''
        #menuentry 'Windows Boot Manager (on /dev/nvme2n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-7AD6-6B56' {
        #	savedefault
        #	insmod part_gpt
        #	insmod fat
        #	search --no-floppy --fs-uuid --set=root 7AD6-6B56
        #	chainloader /efi/Microsoft/Boot/bootmgfw.efi
        #}
        #'';
      };
    };
    supportedFilesystems = [ "ntfs" ];
  };
}
