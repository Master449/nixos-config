{ config, pkgs, ... }:
{
  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [ "192.168.1.127" ];
  networking.nameservers = [ "192.168.1.127" ];
}
