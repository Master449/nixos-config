{ config, pkgs, ... }:
{
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [ 
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=/home/david/nixos-config/configuration.nix" 
    "/nix/var/nix/profiles/per-user/root/channels"
  ];
  
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    bat
    btop
    curl
    fastfetch
    fzf
    git
    htop
    kitty
    pciutils
    usbutils
    neovim
    tailscale
    wget
    zsh
    virt-manager
  ];
  
  services.flatpak.enable = true;
  
  programs.zsh.enable = true;
  
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
