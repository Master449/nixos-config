{ config, pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    listenOptions = [ "2375" ];
  };
}

