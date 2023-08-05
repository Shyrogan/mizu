{ config, ... }:
let inherit (config.colorscheme) colors kind;
in {
  services.mako = {
    enable = true;
    font = "${config.fontProfiles.regular.family} 12";
    anchor = "bottom-right";
    width = 300;
    height = 100;
    borderSize = 2;
    defaultTimeout = 5000;
    backgroundColor = "#${colors.base00}55";
    borderColor = "#${colors.base02}dd";
    textColor = "#${colors.base05}dd";
    margin = "0";
  };
}
