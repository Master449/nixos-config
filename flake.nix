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
            ./modules/gpu.nix
          ./modules/kernel/virtualization.nix
          ./hosts/powerhouse/hardware-configuration.nix
          ./hosts/powerhouse/userspace.nix
        ];
      };
      chronos = stable-system {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          { networking.hostName = "chronos"; }
          ./configuration.nix
          ./boot/grub.nix
          ./modules/services/homelab-services.nix
          ./modules/kernel/virtualization.nix
          ./hosts/powerhouse/hardware-configuration.nix
        ];
      };
    };
  };
}
