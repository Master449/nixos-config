{ config, pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #nix.nixPath = [ 
  #  "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
  #  "nixos-config=/home/david/Documents/github/nixos-config/configuration.nix" 
  #  "/nix/var/nix/profiles/per-user/root/channels"
  #];

  system.stateVersion = "24.11";
  
  nixpkgs.config.allowUnfree = true;
}
