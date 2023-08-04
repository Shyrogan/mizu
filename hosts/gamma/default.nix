# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports = [
    # NixOS generated
    ./hardware-configuration.nix

    # Building home-manager while building NixOS
    inputs.home-manager.nixosModules.home-manager

    # AMD config
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    # Mizu
    ../common
    ../../user/sebastien/os.nix
    ./bootloader.nix
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "gamma";
  networking.networkmanager.enable = true;

  services.getty.autologinUser = "sebastien";
  
  environment.systemPackages = with pkgs; [
    git
    vscode
  ];

  system.stateVersion = "23.05";

}
