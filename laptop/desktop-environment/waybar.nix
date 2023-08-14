{ pkgs, ... }:

{
  home.packages = with pkgs; [ 
    wlogout
    brightnessctl
    btop
    blueman
    libnotify
  ];

  # services.playerctld.enable = true;

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true"] ;} );
    settings = {
      mainBar = {
        margin = "0";
        layer = "top";
        position = "top";
        mode = "dock";
        height = 42;
        spacing = 6;
        modules-left = [ "custom/nix" "wlr/workspaces" "temperature" "cpu" "memory" "disk" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "backlight" "tray" "battery" "custom/powerbutton" ];

        
        "wlr/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          sort-by-number = true;
          format-icons = {
            "4" = " 󰭹 ";
            "5" = "  ";
            "6" = "  ";
            "10" = "  ";
          };
          persistent_workspaces = {
            "4" = [];
            "5" = [];
            "6" = [];
            "10" = [];
          };
        };

        # mpris = {
        #   format = "{status_icon}<span weight='bold'>{artist}</span> | {title}";
        #   status-icons = {
        #     playing = "󰎈 ";
        #     paused =  "󰏤 ";
        #     stopped = "󰓛 ";
        #   };
        # };

        "custom/nix" = {
          format = " 󱄅 ";
        };

        "wlr/taskbar" = {
          on-click = "activate";
        };
 
        # "network#interface" = {
        #   format-ethernet = "󰣶  {ifname}";
        #   format-wifi = "󰖩 {ifname}";
        #   tooltip = true;
        #   tooltip-format = "{ipaddr}";
        # };
        #
        # "network#speed" = {
        #   format = "⇡{bandwidthUpBits} ⇣{bandwidthDownBits}";
        # };

        cpu = {
          interval = 10;
          format = " {usage}%";
          on-click = "kitty --start-as=fullscreen --title btop sh -c 'btop'";
        };

        memory = {
          interval = 30;
          format = " {}%";
          max-length = 10;
          tooltip = true;
          tooltip-format = "Memory - {used:0.1f}GB used";
          on-click = "kitty --start-as=fullscreen --title btop sh -c 'btop'";
        };

        disk = {
          interval = 30;
          format = "󰋊 {percentage_used}%";
          path = "/";
          tooltip = true;
          tooltip-format = "HDD - {used} used out of {total} on {path} ({percentage_used}%)";
          on-click = "kitty --start-as=fullscreen --title btop sh -c 'btop'";
        };

        temperature = {
          interval = 10;
          thermal-zone = 7;
          format = "{icon} {temperatureC}°C";
          format-icons = [ "" "" "" "󰈸" ];
          critical-threshold = 80;
          format-critical = " {temperatureC}°C";
        };

        # backlight = {
        #   format = "{icon} {percent}%";
        #   format-icons = [ "󰃜" "󰃛" "󰃚 " ];
        # };

        backlight = {
          # device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [ "󰃞" "󰃟" "󰃠" ];
          on-scroll-up = "brightnessctl set 5%+";
          on-scroll-down = "brightnessctl set 5%-";
          min-length = 6;
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };

        clock = {
          format = "{:%H:%M}";
          # format-alt = "󰃭  {:%Y-%m-%d}";
          tooltip = true;
          tooltip-format = "{:  %A, %Y-%m-%d, Week %U}";
        };

        # "custom/notification" = {
        #   exec = "~/.config/waybar/scripts/dunst.sh";
        #   tooltip = false;
        #   on-click = "dunstctl set-paused toggle";
        #   restart-interval = 1;
        # };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "";
          on-click = "pamixer -t";
          on-click-right = "pavucontrol";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          scroll-step = 5;
          format-icons = {
            headphone = "";
            headset = "";
            default = [ "" "" "" ];
          };
        };

        "custom/powerbutton" = {
            format = "";
            on-click = "sh -c '(sleep 0.5s; wlogout --protocol layer-shell)' & disown";
            tooltip = false;
        };

        tray = {
          icon-size = 16;
          spacing = 8;
        };
      };
    };

    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMono Nerd Font";
          font-weight: bold;
          font-size: 16px;
          min-height: 0;
      }

      window#waybar {
          background: rgba(46, 46, 46, 0);
          color: #f2f4f8;
      }

      tooltip {
          background: #2a2a2a;
          opacity: 0.8;
          border-radius: 5px;
          border-width: 2px;
          border-style: solid;
          border-color: #2a2a2a;
      }

      tooltip label {
          color: #f2f4f8;
      }

      #workspaces button {
          padding: 5px;
          color: #343434;
          margin-right: 5px;
      }

      #workspaces button.active {
          color: #5f5f5f;
      }

      #workspaces button.focused {
          color: #5f5f5f;
          background: #08bdba;
          border-radius: 10px;
      }

      #workspaces button.urgent {
          color: #161616;
          background: #ee5396;
          border-radius: 10px;
      }

      #workspaces button:hover {
          background: #161616;
          color: #f2f4f8;
          border-radius: 10px;
      }

      #custom-nix,
      #custom-lock_screen,
      #custom-light_dark,
      #custom-powerbutton,
      #custom-power_profile,
      #custom-weather,
      #window,
      #cpu,
      #disk,
      #custom-updates,
      #memory,
      #clock,
      #battery,
      #pulseaudio,
      #network,
      #tray,
      #temperature,
      #workspaces,
      #backlight {
          background: #2a2a2a;
          opacity: 0.9;
          padding: 0px 10px;
          margin: 0px 0px;
          margin-top: 8px;
          border: 0px;
      }

      #tray,
      #custom-lock_screen,
      #temperature,
      #backlight,
      #custom-launch_nix,
      #cpu {
          border-radius: 5px 0px 0px 5px;
      }

      #custom-light_dark,
      #custom-powerbutton,
      #workspaces,
      #pulseaudio.microphone,
      #battery,
      #disk {
          border-radius: 0px 5px 5px 0px;
          margin-right: 8px;
      }

      #temperature.critical {
          color: #ee5396;
      }


      #workspaces {
          padding-right: 0px;
          padding-left: 5px;
      }

      #custom-power_profile {
          color: #f2f4f8;
          border-left: 0px;
          border-right: 0px;
      }

      #window {
          border-radius: 5px;
          margin-left: 8px;
          margin-right: 8px;
      }

      #custom-nix {
          color: #78a9ff;
          margin-left: 8px;
          border-right: 0px;
      }

      #pulseaudio {
          color: #f2f4f8;
          border-left: 0px;
          border-right: 0px;
      }

      #pulseaudio.microphone {
          color: #f2f4f8;
          border-left: 0px;
          border-right: 0px;
      }

      #battery {
          color: #f2f4f8;
          border-left: 0px;
      }

    '';
  };

  # xdg.configFile."waybar/scripts/dunst.sh" = {
  #   text = ''
  #   COUNT=$(dunstctl count waiting)
  #   ENABLED="󰂚 "
  #   DISABLED="󰂛 "
  #   if [ $COUNT != 0 ]; then DISABLED="󱅫 "; fi
  #   if dunstctl is-paused | grep -q "false"; then
  #     echo $ENABLED
  #   else
  #     echo $DISABLED
  #   fi
  #   '';
  #   executable = true;
  # };
}
