{ config, lib, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      secondary = {
        mode = "dock";
        layer = "top";
        height = 32;
        width = 100;
        margin = "6";
        position = "bottom";
        modules-center = (lib.optionals config.wayland.windowManager.sway.enable [
          "sway/workspaces"
          "sway/mode"
        ]) ++ (lib.optionals config.wayland.windowManager.hyprland.enable [
          "wlr/workspaces"
        ]);

        "wlr/workspaces" = {
          on-click = "activate";
        };
      };
    };
    style = let inherit (config.colorscheme) colors; in /* css */ ''
      * {
        font-family: ${config.fontProfiles.regular.family}, ${config.fontProfiles.monospace.family};
        font-size: 12pt;
        padding: 0 8px;
      }

      .modules-right {
        margin-right: -15px;
      }

      .modules-left {
        margin-left: -15px;
      }

      window#waybar.top {
        opacity: 0.95;
        padding: 0;
        background-color: #${colors.base00};
        border: 2px solid #${colors.base0C};
        border-radius: 10px;
      }
      window#waybar.bottom {
        opacity: 0.90;
        background-color: #${colors.base00};
        border: 2px solid #${colors.base0C};
        border-radius: 10px;
      }

      window#waybar {
        color: #${colors.base05};
      }

      #workspaces button {
        background-color: #${colors.base01};
        color: #${colors.base05};
        margin: 4px;
      }
      #workspaces button.hidden {
        background-color: #${colors.base00};
        color: #${colors.base04};
      }
      #workspaces button.focused,
      #workspaces button.active {
        background-color: #${colors.base0A};
        color: #${colors.base00};
      }

      #clock {
        background-color: #${colors.base0C};
        color: #${colors.base00};
        padding-left: 15px;
        padding-right: 15px;
        margin-top: 0;
        margin-bottom: 0;
        border-radius: 10px;
      }

      #custom-menu {
        background-color: #${colors.base0C};
        color: #${colors.base00};
        padding-left: 15px;
        padding-right: 22px;
        margin-left: 0;
        margin-right: 10px;
        margin-top: 0;
        margin-bottom: 0;
        border-radius: 10px;
      }
      #custom-hostname {
        background-color: #${colors.base0C};
        color: #${colors.base00};
        padding-left: 15px;
        padding-right: 18px;
        margin-right: 0;
        margin-top: 0;
        margin-bottom: 0;
        border-radius: 10px;
      }
      #tray {
        color: #${colors.base05};
      }
    '';
  };
}
