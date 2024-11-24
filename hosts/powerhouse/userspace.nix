{ lib, config, pkgs, ... }:

{
  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  # This has to be here sadly
  programs.steam.enable = true;
  programs.dconf.enable = true; 
  
  users.users.david = {
    description = "David Flowers";
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvirt" "libvirtd" "input" ];
    isNormalUser = true;
    packages = with pkgs; [
      bambu-studio
      cifs-utils
      discord
      dolphin
      fastfetch
      jdk17
      lutris
      obsidian
      prismlauncher
      qbittorrent
      steam
      tailscale
      virt-manager
      vivaldi
      yakuake
      vlc
      vscode
    ];
    shell = pkgs.zsh;
  };  
}
