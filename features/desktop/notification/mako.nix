{ config, ... }:
let inherit (config.colorscheme) colors kind;
in {
  services.mako = {
    enable = true;
    font = "${config.fontProfiles.regular.family} 12";
    padding = "10,20";
    anchor = "top-center";
    width = 400;
    height = 150;
    borderSize = 2;
    defaultTimeout = 12000;
    backgroundColor = "#${colors.base00}55";
    borderColor = "#${colors.base03}dd";
    textColor = "#${colors.base05}dd";
  };
}
