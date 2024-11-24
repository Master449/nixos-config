{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
      ./disks.nix
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/78564d96-0edf-4fd6-9a93-9915b675cd3c";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2928-FF96";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  
  fileSystems."/mnt/WD1" = 
    { device = "/dev/disk/by-uuid/5dab6e68-c75f-4d09-9472-6ffb8df4ee93";
      fsType = "ext4";
    };
  
  fileSystems."/mnt/WD2" = 
    { device = "/dev/disk/by-uuid/f64b104f-9553-4081-a48a-30c3af6b815a";
      fsType = "ext4";
    };

  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  swapDevices = [ ];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
