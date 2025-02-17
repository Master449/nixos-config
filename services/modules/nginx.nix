{ config, pkgs, ... }:
{
    nginx = {
      enable = true;
      virtualHosts = {
        "homepage.home".locations."/".proxyPass = "http://192.168.0.109:3000";
        "jellyfin.home".locations."/".proxyPass = "http://192.168.0.109:8096";
        "torrents.home".locations."/".proxyPass = "http://192.168.0.109:8080";
        "uptime.home".locations."/".proxyPass = "http://192.168.0.109:7000";
        "bluemap.home".locations."/".proxyPass = "http://192.168.0.109:8100";
        "mc.home".locations."/".proxyPass = "http://192.168.0.109:25565";
        "speedtest.home".locations."/".proxyPass = "http://192.168.0.109:4000";
      };
      recommendedGzipSettings = true;
    };
}
