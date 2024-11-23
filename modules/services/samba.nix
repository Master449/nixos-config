{ lib, config, pkgs, ... }:

{
  fileSystems."/mnt/media" = {
    device = "//192.168.5.218/Media";
    fsType = "cifs";
    options = let 
      automount_opts = "username=david,password=Some12hold,x-systemd.automound,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},uid=1000"];
  };
}
