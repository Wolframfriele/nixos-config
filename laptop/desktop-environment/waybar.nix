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
        height = 42;
        spacing = 6;
        modules-left = [ "custom/nix" "temperature" "cpu" "memory" "disk" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "backlight" "tray" "battery" "custom/powerbutton" ];

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
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };

        clock = {
          format = "{:%H:%M}";
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
          border-radius: 5px;
      }

      #tray,
      #custom-lock_screen,
      #temperature,
      #backlight,
      #custom-launch_nix,
      #cpu {
          border-radius: 5px;
      }

      #custom-light_dark,
      #custom-powerbutton,
      #workspaces,
      #pulseaudio.microphone,
      #battery,
      #disk {
          border-radius: 5px;
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
          border-radius: 5px;
      }

      #pulseaudio {
          color: #f2f4f8;
          border-left: 0px;
          border-right: 0px;
          border-radius: 5px;
      }

      #pulseaudio.microphone {
          color: #f2f4f8;
          border-left: 0px;
          border-right: 0px;
          border-radius: 5px;
      }

      #battery {
          color: #f2f4f8;
          border-left: 0px;
      }

      #battery.critical {
          color: #ee5396;
      }
      
      #battery.warning {
        /* color: #F8BD96; */
        color: #be95ff;

      }
    '';
  };
}
