
  {pkgs, hyprland, ...}: {
  imports = [
    hyprland.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    wl-clipboard
    # networkmanagerapplet
    pavucontrol
    grim 
    slurp 
    # inputs.hyprland-contrib.packages.x86_64-linux.grimblast 
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      # Setup monitors
      #monitor=,preferred,auto,auto
      monitor=eDP-1,1920x1080@60,3840x1080,1
      monitor=DP-2,3840x2160@60,0x0,1

      # Execute your favorite apps at launch
      # exec-once = ~/.config/hypr/scripts/xdg-portal-hyprland # Make sure the correct portal is running
      # exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP # Wayland magic (screen sharing etc.)
      # exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP # More wayland magic (screen sharing etc.)
      # exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 # used for user sudo graphical elevation

      exec-once = blueman-applet # Systray app for BT
      exec-once = nm-applet --indicator # Systray app for Network/Wifi
      exec-once = waybar

      exec-once = swayidle 
      #-w timeout 30 "hyprctl dispatch dpms"

      # exec = ~/.config/hypr/scripts/bgaction # Sets the background based on theme

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = yes
              tap-to-click = no
              clickfinger_behavior = 1
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 4
          gaps_out = 8
          border_size = 1
          col.active_border=rgb(cdd6f4)
          col.inactive_border = rgba(595959aa)

          layout = master
      }

      misc {
          disable_hyprland_logo = yes

          mouse_move_enables_dpms = true
          key_press_enables_dpms = true
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 2
          blur = no
          blur_size = 7
          blur_passes = 1
          blur_new_optimizations = on
          blur_xray = true

          blurls = lockscreen

          drop_shadow = false
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = yes

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.2, 0.8, 0.2, 1.

          animation = windows, 1, 2, myBezier,
          animation = windowsOut, 1, 2, default, popin 80%
          animation = border, 1, 5, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 2, myBezier, slidevert
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = false
          orientation = right
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
      }

      # windowrule v1
      #windowrule = float, ^(kitty)$
      windowrule = float,^(pavucontrol)$
      windowrule = float,^(blueman-manager)$
      windowrule = float,^(nm-connection-editor)$
      windowrule = float,^(thunar)$
      windowrule = float, title:^(btop)$
      windowrule = float, title:^(update-sys)$

      # windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # rules below would make the specific app transparent
      windowrulev2 = opacity 1 1,class:^(kitty)$
      windowrulev2 = animation popin,class:^(kitty)$,title:^(update-sys)$
      windowrulev2 = animation popin,class:^(thunar)$
      windowrulev2 = opacity 1 1,class:^(thunar)$
      windowrulev2 = opacity 1 1,class:^(VSCodium)$
      windowrulev2 = animation popin,class:^(chromium)$
      windowrulev2 = animation slide,class:^(wofi)$
      windowrulev2 = move 100%-433 53,class:^(wofi)$,title:^(clippick)$

      # workspace rules
      workspace = 4, monitor:eDP-1, default:true
      workspace = 5, monitor:DP-2, default:true

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Q, killactive, # close the active window
      bind = $mainMod, L, exec, swaylock # Lock the screen
      bind = $mainMod, M, exec, wlogout --protocol layer-shell # show the logout window
      bind = $mainMod SHIFT, M, exit, # Exit Hyprland all together no (force quit Hyprland)

      bind = $mainMod, E, exec, anyrun # Show the graphical app launcher
      bind = $mainMod, T, exec, kitty  # open the terminal
      bind = $mainMod, F, exec, firefox # Execute firefox
      bind = $mainMod, B, exec, thunar # Show the graphical file browser

      bind = $mainMod, V, togglefloating, # Allow a window to float
      # bind = $mainMod, P, pseudo, # dwindle
      # bind = $mainMod, J, togglesplit, # dwindle
      bind = $mainMod, S, exec, grim -g "$(slurp)"# - | swappy -f - # take a screenshot

      # Bind Audio keys
      binde=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
      binde=, XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-
      bind =, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind =, XF86AudioPlay, exec, playerctl play-pause
      bind =, XF86AudioNext, exec, playerctl next
      bind =, XF86AudioPrev, exec, playerctl previous
      bind =, XF86audiostop, exec, playerctl stop

      # Bind Brightness keys
      binde=, XF86MonBrightnessDown, exec, brightnessctl set 5%-
      binde=, XF86MonBrightnessUp, exec, brightnessctl set +5%
      
      # Move focus with mainMod + arrow keys
      bind = $mainMod, A, layoutmsg, swapwithmaster master
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # trigger when the switch is turning off                     
      # bindl = , switch:off:Lid Switch,exec, ~/.config/hypr/scripts/open-laptop
      # trigger when the switch is turning on
      # bindl = , switch:on:Lid Switch,exec,hyprctl keyword monitor "eDP-1, disable"
''

    ;
  };

  systemd.user.sessionVariables = {
    "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
    "MOZ_ENABLE_WAYLAND" = "1"; # for firefox to run on wayland
    "MOZ_WEBRENDER" = "1";

    # for hyprland with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
    # "LIBVA_DRIVER_NAME" = "nvidia";
    # "XDG_SESSION_TYPE" = "wayland";
    # "GBM_BACKEND" = "nvidia-drm";
    # "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    # "WLR_NO_HARDWARE_CURSORS" = "1";
    # "WLR_EGL_NO_MODIFIRES" = "1";
  };

}
