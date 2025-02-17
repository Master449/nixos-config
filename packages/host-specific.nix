{ lib, config, pkgs, ... }:
with lib;

let 
  hostname = config.networking.hostName;
in
{
  config = mkMerge [
    (mkIf (hostname == "powerhouse") {
      environment.systemPackages = with pkgs; [
        bambu-studio
        tor-browser
        home-manager
        xdg-desktop-portal
      ];
    })
    (mkIf (hostname == "thinkpad") {
      environment.systemPackages = with pkgs; [  ];
    })
  ];
}
