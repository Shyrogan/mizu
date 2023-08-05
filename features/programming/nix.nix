{ pkgs, ... }:
{
  home.packages = with pkgs; [ rnix-lsp nixpkgs-fmt ];
}
