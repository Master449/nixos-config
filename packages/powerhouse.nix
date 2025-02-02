{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bambu-studio
    tor-browser
  ];
}
