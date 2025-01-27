{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ base16-schemes ];
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

  stylix.image = ~/Pictures/me-n-babu.png;
}
