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
      hypr-box = new-system {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
            ./configuration.nix
            ./boot/grub.nix
            ./desktops/hyprland.nix
            ./modules/virtualization.nix
            ./userspace.nix
        ];
      };
    };
  };
}
