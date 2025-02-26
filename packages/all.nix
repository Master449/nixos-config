{ config, pkgs, ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    vivaldi = pkgs.vivaldi.overrideAttrs (oldAttrs: {
      dontWrapQtApps = false;
      dontPatchELF = true;
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.kdePackages.wrapQtAppsHook ];
    });
  };

  environment.systemPackages = with pkgs; [
    obsidian
    base16-schemes
    discord
    cifs-utils
    onlyoffice-desktopeditors
    p7zip
    prismlauncher
    python312
    qdirstat
    rustc
    starship
    syncthing
    wine
    winetricks
    xdelta
    wl-clipboard
    vivaldi
    vlc
    bat
    btop
    curl
    fastfetch
    fzf
    git
    htop
    pciutils
    usbutils
    neovim
    tailscale
    wget
    zsh
    virt-manager
  ];
}
