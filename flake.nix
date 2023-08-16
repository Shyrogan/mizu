{
  description = "Lightweight, minimalist NixOS configuration for my machines";
  inputs = {
    # Latest nix version
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    # Hardware
    hardware.url = "github:nixos/nixos-hardware";
    # Impermanence
    impermanence.url = "github:nix-community/impermanence";
    # Nix colors
    nix-colors.url = "github:misterio77/nix-colors";
    # HyperWM
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Spicetify
    spicetify-nix.url = github:the-argus/spicetify-nix;
    # Rust
    fenix.url = "github:nix-community/fenix/monthly";
  };

  outputs = { self, nixpkgs, nix-colors, fenix, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
    in
    rec {
      packages.x86_64-linux.default = fenix.packages.x86_64-linux.default.toolchain;
      nixosConfigurations = {
        gamma = lib.nixosSystem {
          specialArgs = { inherit inputs outputs nix-colors fenix; };
          modules = [
            ./hosts/gamma
          ];
        };
      };
    };
}
