{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodePackages_latest.typescript-language-server
    nodePackages_latest.prettier
    nodePackages_latest.eslint
    nodePackages_latest.pnpm
    nodejs_18
  ];
}
