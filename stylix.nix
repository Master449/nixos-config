{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ base16-schemes ];
  
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  stylix.image = ./wallpapers/me-n-babu.png;

  stylix.targets.kde.enable = true;
}
