{ inputs, pkgs, nix-colors, fenix, ... }:
{
  nixpkgs.overlays = [ fenix.overlays.default ];
  imports = [
    ../../features/desktop/hyprland/os.nix
  ];

  users = {
    mutableUsers = false;
    users.sebastien = {
      isNormalUser = true;
      description = "sebastien";
      extraGroups = [ "networkmanager" "wheel" "audio" ];
      packages = with pkgs; [ nushell starship ];
      shell = pkgs.nushell;

      # TODO: CHANGE THIS!
      initialPassword = "pswrd";
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs nix-colors fenix; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.sebastien = import ../../home-manager/gamma;
  };
}
