{ inputs, pkgs, ... }:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModule
  ];

  home.packages = [ pkgs.spotify ];

  programs.spicetify = {
    enable = true;
    theme = theme = spicePkgs.themes.catppuccin-mocha;

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle # shuffle+ (special characters are sanitized out of ext names)
      hidePodcasts
    ];
  };
}
