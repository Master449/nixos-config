{ config, lib, pkgs, ... }:
with lib;

let 
  hostname = config.networking.hostName;
in
{
  config = mkMerge [
    (mkIf (hostname == "powerhouse") {
      services.xserver.videoDrivers = [ "amdgpu" ];
      environment.systemPackages = with pkgs; [ nvtopPackages.amd ];
      hardware.steam-hardware.enable = true;
      hardware.graphics.enable = true;
      hardware.graphics.extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    })
    (mkIf (hostname == "think") {
      services.xserver.videoDrivers = [ "intel" ];
      environment.systemPackages = with pkgs; [ nvtopPackages.intel ];
      hardware = {
        opengl.enable = true;
      };
    };
  })
];
}
