{ config, pkgs, ... }:
{
  imports = [
    ./modules/ssh.nix
    ./modules/vpn.nix
    ./modules/steam.nix
    ./modules/ollama.nix
  ];
}
