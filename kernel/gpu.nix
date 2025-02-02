{ config, lib, pkgs, ... }:
with lib;

let 
  hostname = config.networking.hostName;
in
{
  config = mkMerge [
    (mkIf (hostname == "powerhouse") {
      services.xserver.videoDrivers = [ "amdgpu" ];
      hardware.steam-hardware.enable = true;
      hardware.graphics.enable = true;
      hardware.graphics.extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
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
