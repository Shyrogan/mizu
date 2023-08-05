{ inputs, config, pkgs, lib, ... }:
{
  home.packages = [
    (inputs.replugged-nix-flake.lib.makeDiscordPlugged {
      inherit pkgs;
      themes = {
        tokyo-night = (builtins.fetchTarball "https://github.com/Dyzean/Tokyo-Night/archive/master.tar.gz");
      };
    })
  ];
}
