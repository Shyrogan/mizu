{ inputs, nix-colors, ... }:
{
  imports = [
    nix-colors.homeManagerModules.default
    inputs.impermanence.nixosModules.home-manager.impermanence
    ../../user/sebastien/home.nix
    ../../features/desktop/hyprland
    ../../features/desktop
    ../../features/programming
  ];
  monitors = [
    {
      name = "DP-1";
      width = 2560;
      height = 1440;
      x = 1920;
      primary = true;
      refreshRate = 144;
    }
    {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      noBar = true;
      workspace = "5";
    }
  ];
}
