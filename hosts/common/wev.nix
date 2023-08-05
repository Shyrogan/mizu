{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.wev
  ];
}
