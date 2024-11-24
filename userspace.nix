{ config, pkgs, ... }:
{
  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
  
  users.users = {
    david = {
      description = "David Flowers";
      isNormalUser = true;
      extraGroups = [ "wheel" "admin" "networkmanager" "samba" "docker" "libvirtd" "libvirt" "kvm" ];
      shell = pkgs.zsh;
      packages = with pkgs; [];
    };
  };
}
