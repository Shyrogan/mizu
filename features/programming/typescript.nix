{ pkgs, ... }:
{
  home.packages = with pkgs; [ nodePackages_latest.typescript-language-server ];
}
