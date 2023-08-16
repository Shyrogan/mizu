{ pkgs, fenix, ... }:
{
  home.packages = with pkgs; [
    (fenix.default.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly
  ];
}
