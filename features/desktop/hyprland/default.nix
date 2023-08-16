{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ./launcher/wofi.nix
    ./notification/mako.nix
    ./bar/waybar.nix
  ];
  home.packages = with pkgs;
    [
      swaybg
      grim
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    ];
  programs.nushell.loginFile.text = ''
    if (tty) == "/dev/tty1" {
      exec Hyprland
    }
  '';
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      general = {
        gaps_in = 15;
        gaps_out = 20;
        border_size = 1.5;
        cursor_inactive_timeout = 4;
        "col.active_border" = "0xff${config.colorscheme.colors.base04}";
        "col.inactive_border" = "0xff${config.colorscheme.colors.base02}";
        "col.group_border_active" = "0xff${config.colorscheme.colors.base0B}";
        "col.group_border" = "0xff${config.colorscheme.colors.base04}";
      };

      input = {
        kb_layout = "fr";
      };

      dwindle.split_width_multiplier = 1.35;
      misc.vfr = "on";

      decoration = {
        rounding = 7;
      };

      exec = [
        "${pkgs.swaybg}/bin/swaybg -i /persist/home/sebastien/Pictures/wallpaper.png --mode fill"
      ];

      bind =
        let
          grimblast = "grimblast";
          makoctl = "${config.services.mako.package}/bin/makoctl";
          wofi = "${config.programs.wofi.package}/bin/wofi";
          playerctl = "${config.services.playerctld.package}/bin/playerctl";
        in
        [
          # Basic stuff
          "SUPER, Return,  exec, ${config.home.sessionVariables.TERMINAL}"
          "SUPER, B,       exec, qutebrowser"
          "SUPER, C,       killactive"
          "SUPER, M,       exit"
          "SUPER, V,       togglefloating"
          "SUPER, F,       fullscreen"

          # Movements
          "SUPER, h,       movefocus, l"
          "SUPER, j,       movefocus, dH"
          "SUPER, k,       movefocus, u"
          "SUPER, l,       movefocus, r"

          # Workspaces
          "SUPER, ampersand,   workspace, 1"
          "SUPER, eacute,      workspace, 2"
          "SUPER, quotedbl,    workspace, 3"
          "SUPER, apostrophe,  workspace, 4"
          "SUPER, parenleft,   workspace, 5"
          "SUPER, minus,       workspace, 6"
          "SUPER, egrave,      workspace, 7"
          "SUPER, underscore,  workspace, 8"
          "SUPER, ccedilla,    workspace, 9"
          "SUPER, agrave,      workspace, 10"

          "SUPER SHIFT, ampersand,  movetoworkspace, 1"
          "SUPER SHIFT, eacute,     movetoworkspace, 2"
          "SUPER SHIFT, quotedbl,   movetoworkspace, 3"
          "SUPER SHIFT, apostrophe, movetoworkspace, 4"
          "SUPER SHIFT, parenleft,  movetoworkspace, 5"
          "SUPER SHIFT, minus,      movetoworkspace, 6"
          "SUPER SHIFT, egrave,     movetoworkspace, 7"
          "SUPER SHIFT, underscore, movetoworkspace, 8"
          "SUPER SHIFT, ccedilla,   movetoworkspace, 9"
          "SUPER SHIFT, agrave,     movetoworkspace, 10"

          # Screenshots
          ",Print,exec,${grimblast} --notify copy output"
          "SHIFT,Print,exec,${grimblast} --notify copy active"
          "CONTROL,Print,exec,${grimblast} --notify copy screen"
          "SUPER,Print,exec,${grimblast} --notify copy window"
          "ALT,Print,exec,${grimblast} --notify copy area"
        ] ++
        (lib.optionals config.services.playerctld.enable [
          # Media control
          ",XF86AudioNext,exec,${playerctl} next"
          ",XF86AudioPrev,exec,${playerctl} previous"
          ",XF86AudioPlay,exec,${playerctl} play-pause"
          ",XF86AudioStop,exec,${playerctl} stop"
        ]) ++ # Notification manager
        (lib.optionals config.services.mako.enable [
          "SUPER,w,exec,${makoctl} dismiss"
        ]) ++

        # Launcher
        (lib.optionals config.programs.wofi.enable [
          "SUPER,Space,exec,${wofi} -S drun"
        ]);

      bindm = [
        "SUPER,mouse:273, resizewindow"
        "SUPER,mouse:272, movewindow"
      ];

      monitor = map
        (m:
          let
            resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
            position = "${toString m.x}x${toString m.y}";
          in
          "${m.name},${if m.enabled then "${resolution},${position},1" else "disable"}"
        )
        (config.monitors);
    };
  };
}
