{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodePackages_latest.typescript-language-server
    nodePackages_latest.prettier
    nodePackages_latest.eslint
  ];
}
