{
  description = "Configuration Changer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    stylix.url = "github:danth/stylix";
  };

  outputs = { ... }@inputs: 
  let 
    unstable-system = inputs.nixpkgs.lib.nixosSystem;
    stable-system = inputs.nixpkgs-stable.lib.nixosSystem;
  in {
    nixosConfigurations = {
      powerhouse = unstable-system {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          inputs.stylix.nixosModules.stylix
          { networking.hostName = "powerhouse"; }
          { security.rtkit.enable = true; }
          ./configuration.nix
          ./stylix.nix
          ./userspace.nix
          ./boot/grub.nix
          ./desktops/gnome.nix
          ./packages/powerhouse.nix  
          ./networking/network-manager.nix
          ./services/ssh.nix
          ./services/vpn.nix
          ./services/steam.nix
          ./kernel/gpu.nix
          ./kernel/virtualization.nix
          ./kernel/audio.nix
          ./hardware/powerhouse/hardware-configuration.nix
        ];
      };
      chronos = stable-system {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          { networking.hostName = "chronos"; }
          { system.stateVersion = "24.05"; }
          ./configuration.nix
          ./userspace.nix
          ./boot/systemd.nix
          ./services/homelab.nix
          ./packages/chronos.nix
          ./networking/network-manager.nix
          ./networking/homelab-firewall.nix
          ./kernel/gpu.nix
          ./kernel/virtualization.nix
          ./kernel/audio.nix
          ./hardware/chronos/hardware-configuration.nix
        ];
      };
    };
  };
}
