{
  description = "Configuration Changer";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let 
    new-system = nixpkgs.lib.nixosSystem;
  in {
    nixosConfigurations = {
      powerhouse = new-system {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
            # General modules
            ./configuration.nix
            ./boot/grub.nix
            ./desktops/hyprland.nix
            ./modules/kernel/virtualization.nix
            # Host specific modules (I know, I know, theres if statements, shut up)
            ./hosts/powerhouse/hardware-configuration.nix
            ./hosts/powerhouse/userspace.nix
        ];
      };
    };
  };
}
