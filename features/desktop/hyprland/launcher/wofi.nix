{ nix-colors, config, lib, pkgs, ... }:
let inherit (config.colorscheme) colors kind;
in {
  programs.wofi = {
    enable = true;
    package = pkgs.wofi;
    settings = {
      image_size = 24;
      columns = 1;
      allow_images = true;
      insensitive = true;
      run-always_parse_args = true;
      run-cache_file = "/dev/null";
      run-exec_search = true;
      width = 400;
      height = 300;
    };
    style = ''
      * {
        font-family: ${config.fontProfiles.regular.family};
      }

      window {
        background-color: rgba(${nix-colors.lib.conversions.hexToRGBString ", " colors.base00}, 0.8);
        border-radius: 8px;
        border: 1.5px solid #${colors.base04};
      }

      #text {
        margin-left: 5px;
        color: #${colors.base06};
      }

      #input {
        border: none;
        margin: 5px;
        background-color: transparent;
        color: #${colors.base05};
      }

      #outer-box {
        margin: 5px;
        background-color: transparent;
      }

      #entry {
        border: none;
      }

      #entry:focus {
        border: none;
      }

      #entry:selected {
        background-color: rgba(${nix-colors.lib.conversions.hexToRGBString ", " colors.base0B}, 0.95);
        border-radius: 5px;
        border: none;
      }
    '';
  };
}
