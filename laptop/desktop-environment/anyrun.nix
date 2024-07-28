{ pkgs, anyrun, ... }:


{
  imports = [
    anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;

    config = {
      plugins = with anyrun.packages.${pkgs.system}; [
        applications
        rink
        #randr This one bugged out (should be able to change screen config with it)
        #shell
        # kidex
        # symbols
        #websearch
        #translate
        # anyrun-nixos-options.packages.${pkgs.system}.default
      ];

      width.fraction = 0.3;
      y.fraction = .3;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraCss = ''
      * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 1.3rem;
      }

      #window,
      #match,
      #entry,
      #plugin,
      #main {
        background: transparent;
      }

      .vertical > list > row:first-child {
        margin-top: 5px;
      }

      #match {
        margin: 1px;
        padding: 2px;
        border-radius: 4px;
      }

      #match:selected, #match:hover, #plugin:hover {
        background: rgba(255, 255, 255, .5);
      }

      #entry, #plugin:hover {
        border-radius: 4px;
      }

      box#main {
        background: rgba(0, 0, 0, .9);
        box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .1), 0 0 0 1px rgba(0, 0, 0, .2);
        border-radius: 4px;
        padding: 8px;
      }
    '';
    };
}
