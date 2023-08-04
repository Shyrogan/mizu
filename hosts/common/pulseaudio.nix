{ nixpkgs, ... }:
{
  hardware.pulseaudio = {
    enable = true;
    extraConfig = "load-module module-combine-sink";
  };
  nixpkgs.config.pulseaudio = true;
}