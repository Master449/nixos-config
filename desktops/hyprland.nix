{ lib, config, pkgs, ... }:

{ 
  services.displayManager = {
    sddm.enable = true;
    autoLogin.enable = true;
    autoLogin.user = "david";
    sddm.wayland.enable = true;
  };

  #  services.xserver.enable = true;

  programs.hyprland = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    hyprlock
    hyprshot
    hyprpaper
    rofi-wayland
    waybar
    pw-volume
    yazi
  ];

  security = {
    polkit.enable = true;
    pam.services.hyprlock = {};
  };
}
