{
  description = "Configuration Changer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { ... }@inputs: 
  let 
    unstable-system = inputs.nixpkgs.lib.nixosSystem;
    stable-system = inputs.nixpkgs-stable.lib.nixosSystem;
  in {
    homeConfigurations."david" = inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inherit inputs; };
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      modules = [ inputs.stylix.homeManagerModules.stylix ./userspace/home.nix ];
    };
    nixosConfigurations = {
      powerhouse = unstable-system {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          inputs.stylix.nixosModules.stylix
          { networking.hostName = "powerhouse"; }
          { security.rtkit.enable = true; }
          { system.stateVersion = "24.11"; }
          # Configuration
          ./configuration.nix
          
          # Userspace
          ./userspace/main.nix

          # Packages
          ./packages/all.nix
          ./packages/host-specific.nix

          # Services
          ./services/ssh.nix
          ./services/vpn.nix
          ./services/steam.nix
          ./services/ollama.nix
          ./services/virtualization.nix

          # System
          ./system/boot/grub.nix
          ./system/hardware/gpu.nix
          ./system/hardware/audio.nix
          ./system/disk-layouts/powerhouse/hardware-configuration.nix
          ./system/networking/network-manager.nix
          ./system/desktops/hyprland.nix
          ./system/stylix.nix
        ];
      };
      chronos = unstable-system {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          { networking.hostName = "think"; }
          { system.stateVersion = "24.11"; }
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
          ./configuration.nix
          ./userspace.nix
          ./boot/grub.nix
            #./services/homelab.nix
            #./packages/chronos.nix
          ./networking/network-manager.nix
            #./networking/homelab-firewall.nix
          ./kernel/gpu.nix
            #./kernel/virtualization.nix
          ./kernel/audio.nix
            #./hardware/chronos/hardware-configuration.nix
        ];
      };
    };
  };
}
