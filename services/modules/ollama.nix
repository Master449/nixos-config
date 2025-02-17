{ config, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    environmentVariables = {
      HCC_AMDGPU_TARGET = "gfx1101";
      #ROCR_VISIBLE_DEVICES = "6ef143c4c9eca53d";
    };
    rocmOverrideGfx = "11.0.0";
  };
}
