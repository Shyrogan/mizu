{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ../launcher/wofi.nix
    ../notification/mako.nix
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
        sensitivity = "-0.6";
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
          "SUPER, 1,       workspace, 1"
          "SUPER, 2,       workspace, 2"
          "SUPER, 3,       workspace, 3"
          "SUPER, 4,       workspace, 4"
          "SUPER, 5,       workspace, 5"
          "SUPER, 6,       workspace, 6"
          "SUPER, 7,       workspace, 7"
          "SUPER, 8,       workspace, 8"
          "SUPER, 9,       workspace, 9"
          "SUPER, 0,       workspace, 10"

          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
          "SUPER SHIFT, 5, movetoworkspace, 5"
          "SUPER SHIFT, 6, movetoworkspace, 6"
          "SUPER SHIFT, 7, movetoworkspace, 7"
          "SUPER SHIFT, 8, movetoworkspace, 8"
          "SUPER SHIFT, 9, movetoworkspace, 9"
          "SUPER SHIFT, 0, movetoworkspace, 10"

          # Screenshots
          ",Print,exec,${grimblast} --notify copy output"
          "SHIFT,Print,exec,${grimblast} --notify copy active"
          "CONTROL,Print,exec,${grimblast} --notify copy screen"
          "SUPER,Print,exec,${grimblast} --notify copy window"
          "ALT,Print,exec,${grimblast} --notify copy area"
        ] ++ # Notification manager
        (lib.optionals config.services.mako.enable [
          "SUPER,w,exec,${makoctl} dismiss"
        ]) ++

        # Launcher
        (lib.optionals config.programs.wofi.enable [
          "SUPER,x,exec,${wofi} -S drun -x 10 -y 10 -W 25% -H 60%"
          "SUPER,d,exec,${wofi} -S run"
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
