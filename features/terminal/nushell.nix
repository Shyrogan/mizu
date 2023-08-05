{
  programs.nushell = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
    };
    configFile = {
      text = ''
        $env.config = {
          show_banner: false
        }
      '';
    };
  };
}
