{ lib, config, pkgs, ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    vivaldi = pkgs.vivaldi.overrideAttrs (oldAttrs: {
      dontWrapQtApps = false;
      dontPatchELF = true;
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.kdePackages.wrapQtAppsHook ];
    });
  };
  environment.systemPackages = with pkgs; [
    discord
    cifs-utils
    nvtopPackages.full
    onlyoffice-desktopeditors
    p7zip
    python312
    qdirstat
    rustc
    starship
    syncthing
    tor-browser
    wine
    winetricks
    xdelta
    wl-clipboard
    vivaldi
  ];
}
