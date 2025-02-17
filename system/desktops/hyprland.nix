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


  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
  };

  environment.etc."xdg/xdg-desktop-portal/portals.conf".text = ''
    [preferred]
    default=kde
    org.freedesktop.impl.portal.FileChooser=kde
  '';
  
  environment.etc."xdg/xdg-desktop-portal/kde.portal".text = ''
    [portal]
    DBusName=org.freedesktop.impl.portal.desktop.kde
  '';

  environment.systemPackages = with pkgs; [
    kitty
    kdePackages.dolphin
    kdePackages.qtsvg
    papers
    hyprlock
    hyprshot
    hyprpaper
    rofi-wayland
    waybar
    pw-volume
  ];

  security = {
    polkit.enable = true;
    pam.services.hyprlock = {};
  };
}
