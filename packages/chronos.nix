{ lib, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ffmpeg-full
    jellyfin-ffmpeg
    nvtopPackages.nvidia
    nut
    temurin-jre-bin-21
    nodejs_22
    nodePackages_latest.npm
    glances
  ];
}
