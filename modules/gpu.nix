{ config, lib, pkgs, ... }:
with lib;

let 
  hostname = config.networking.hostName;
in
{
  config = mkMerge [
    (mkIf (hostname == "powerhouse") {
      services.xserver.videoDrivers = [ "amdgpu" ];
    })
    (mkIf (hostname == "chronos") {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware = {
        opengl.enable = true;
          nvidia = {
          modesetting.enable = true;
          powerManagement.enable = false;
          powerManagement.finegrained = false;
          nvidiaPersistenced = true;
          open = false;
          nvidiaSettings = true;
         package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
      };
    })
  ];
}
