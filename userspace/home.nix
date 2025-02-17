{ config, pkgs, ... }:
{
  home.username = "david";
  home.homeDirectory = "/home/david";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  
  stylix = { 
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-dark.yaml";
    targets.kde.enable = true;
    image = ./wallpapers/me-n-babu.png;
  };
}
