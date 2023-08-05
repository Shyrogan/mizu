{ inputs, pkgs }:
{
  nixpkgs.overlays = [ fenix.overlays.default ];
  home.pakcages = with pkgs; [
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly
  ];
}
