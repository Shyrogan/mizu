{ pkgs, ... }:
{
  home.packages = with pkgs; [ firefox google-chrome ];
  home.sessionVariables =
    {
      DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
    };
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "x-scheme-handler/qute" = [ "firefox.desktop" ];
  };
}
