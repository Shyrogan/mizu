{ config, lib, pkgs, ... }: {
  programs.wofi = {
    enable = true;
    package = pkgs.wofi;
    settings = {
      image_size = 48;
      columns = 3;
      allow_images = true;
      insensitive = true;
      run-always_parse_args = true;
      run-cache_file = "/dev/null";
      run-exec_search = true;
      style = ''
        * {
          font-family: ${config.fontProfiles.regular.family};
        }
      ''
        };
    };
  }
