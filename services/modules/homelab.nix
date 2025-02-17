{ config, pkgs, ... }:
{
  imports = [
    ./ssh.nix
    ./vpn.nix
    ./nginx.nix
    ./docker.nix
  ];
  services = {
    jellyfin = {
      enable = true;
    };
  };
}
