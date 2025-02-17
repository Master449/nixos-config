{ config, pkgs, ... }:
{
  stylix.enable = true;
  stylix.image = ./wallpapers/me-n-babu.png;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
}
