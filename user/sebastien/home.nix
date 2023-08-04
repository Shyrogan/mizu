{ inputs, pkgs, nix-colors, ... }:
{
  imports = [
    ../../modules/home-manager
    ../../features/terminal
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "sebastien";
    homeDirectory = "/home/sebastien";

    packages = [
      pkgs.fira-code
    ];

    sessionVariables = {
      TERMINAL = "kitty";
    };

    persistence = {
      "/persist/home/sebastien" = {
        directories = [
          "Documents"
          "Downloads"
          "Pictures"
          "Videos"
          ".local/bin"
        ];
        allowOther = true;
      };
    };

    stateVersion = "23.05";
  };
}