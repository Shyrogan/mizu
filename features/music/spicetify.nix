{ inputs, pkgs, config, ... }:
let
  inherit (config.colorscheme) colors kind;
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModule
  ];

  wayland.windowManager.hyprland.settings.windowrule = [
    "opacity 0.85 0.85, ^(Spotify)$"
  ];

  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle # shuffle+ (special characters are sanitized out of ext names)
      hidePodcasts
    ];

    colorScheme = "custom";
    customColorScheme = {
      text = "a9b1d6";
      subtext = "c0caf5";
      nav-active-text = "2ac3de";
      tab-active-text = "2ac3de";
      main = "1a1b26";
      sidebar = "16161e";
      player = "16161e";
      card = "16161e";
      shadow = "16161e";
      main-secondary = "16161e";
      button = "2ac3de";
      button-secondary = "a9b1d6";
      button-active = "2ac3de";
      button-disabled = "a9b1d6";
      nav-active = "27384e";
      play-button = "a9b1d6";
      tab-active = "27384e";
      notification = "414868";
      notification-error = "ff0000";
      playback-bar = "2ac3de";
      misc = "000000";
    };
  };
}
