{ config, pkgs, ... }:
{
  imports = [ 
    ./hardware-configuration.nix 
    ./boot/grub.nix
    ./userspace.nix 
    ./desktops/plasma6.nix
    ./modules/virtualization.nix
    ./modules/samba.nix
    ];
  
  # ------------------ Nix Settings ---------------

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [ 
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos-unstable"
    "nixos-config=/home/david/Documents/nixos-config/configuration.nix" 
    "/nix/var/nix/profiles/per-user/root/channels"
  ];
  
  nixpkgs.config.allowUnfree = true;
  
  nixpkgs.config.packageOverrides = pkgs: {
    vivaldi = pkgs.vivaldi.overrideAttrs (oldAttrs: {
      dontWrapQtApps = false;
      dontPatchELF = true;
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.kdePackages.wrapQtAppsHook ];
    });
  };
  
  system.stateVersion = "23.11"; # Did you read the comment?

  # ------------------ Packages and Services ---------------

  environment.systemPackages = with pkgs; [
    btop
    cifs-utils
    curl
    xdelta
    git
    htop
    kitty
    neovim
    nvtopPackages.full
    p7zip
    python312
    rustc
    tailscale
    wget
    wl-clipboard
    wine
    winetricks
    zsh
  ];
  
  services = {
    printing.enable = true;
    flatpak.enable = true;
    tailscale.enable = true;
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    resolved.enable = true;
    xserver.videoDrivers = [ "amdgpu" ];
  };

  
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;
  programs.zsh.enable = true;
 
  # ------------------ Hardware Settings ---------------
  
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    steam-hardware.enable = true;
  };

  networking.hostName = "nixbox";
  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;
  
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  
  # ------------------ Locale Settings ---------------

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

  time.timeZone = "America/Chicago";
  

  # ------------------------------------------------
}
