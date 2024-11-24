{
  description = "Configuration Changer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.05";
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
          { networking.hostName = "powerhouse"; }
          ./configuration.nix
          ./boot/grub.nix
          ./desktops/hyprland.nix
          ./services/ssh.nix
          ./services/vpn.nix
          ./kernel/gpu.nix
          ./kernel/virtualization.nix
          ./kernel/audio.nix
          ./hosts/powerhouse/hardware-configuration.nix
          ./hosts/powerhouse/userspace.nix
          { security.rtkit.enable = true; }
        ];
      };
      chronos = stable-system {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          { networking.hostName = "chronos"; }
          ./configuration.nix
          ./boot/grub.nix
          ./services/homelab.nix
          ./kernel/virtualization.nix
          ./hosts/powerhouse/hardware-configuration.nix
        ];
      };
    };
  };
}
