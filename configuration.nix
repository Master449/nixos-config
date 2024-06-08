{ config, pkgs, ... }:
{
  imports = [ 
    ./hardware-configuration.nix 
    ./userspace.nix 
    ./desktops/plasma6.nix
#    ./desktops/gnome.nix
    ./modules/virtualization.nix
    ./modules/samba.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [ 
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos-unstable"
    "nixos-config=/home/david/Documents/nixos-config/configuration.nix" 
    "/nix/var/nix/profiles/per-user/root/channels"
  ];
  
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

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    btop
    curl
    xdelta
    git
    htop
    jdk17
    kitty
    killall
    lutris
    neofetch
    neovim
    nvtopPackages.full
    p7zip
    python312
    tailscale
    wget
    wl-clipboard
    wine
    winetricks
    zsh
  ];
  
  nixpkgs.config.packageOverrides = pkgs: {
    vivaldi = pkgs.vivaldi.overrideAttrs (oldAttrs: {
      dontWrapQtApps = false;
      dontPatchELF = true;
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.kdePackages.wrapQtAppsHook ];
    });
  };

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  networking.hostName = "nixbox";
  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;
  
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services = {
    printing.enable = true;
    flatpak.enable = true;
    tailscale.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xserver.videoDrivers = [ "amdgpu" ];
  };

  time.timeZone = "America/Chicago";
  
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;
  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11"; # Did you read the comment?
}
