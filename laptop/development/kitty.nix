{ pkgs, ... }:{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;      
    };

    settings =
      {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        tab_bar_edge = "top";     # tab bar on top
        confirm_os_window_close = 0;
      };
    extraConfig = ''

      # fzf search of scrollback buffers
      map ctrl+f launch --type=overlay --stdin-source=@screen_scrollback ${pkgs.fzf}/bin/fzf --no-sort --no-mouse --exact -i
      
      ## name:     Oxocarbon 
      ## author:   Nyoom-engineering (https://github.com/nyoom-engineering)
      ## license:  MIT
      ## upstream: https://github.com/nyoom-engineering/oxocarbon.nvim
      ## blurb:    A dark and light Neovim theme, inspired by IBM Carbon.



      # The basic colors
      foreground              #f2f4f8
      background              #161616
      selection_foreground    #161616
      selection_background    #464646

      # Cursor colors
      cursor                  #f2f4f8
      cursor_text_color       #2a2a2a

      # URL underline color when hovering with mouse
      url_color               #33b1ff
      
      # Colors for marks (marked text in the terminal)
      mark1_foreground #161616
      mark1_background #08bdba
      mark2_foreground #161616
      mark2_background #be95ff
      mark3_foreground #161616
      mark3_background #ee5396

      # The 16 terminal colors

      # black
      color0 #202020
      color8 #464646

      # red
      color1 #ee5396
      color9 #ff7eb6

      # green
      color2  #42be65
      color10 #08bdba

      # yellow
      color3  #FAE3B0
      color11 #ffe9b6

      # blue
      color4  #33b1ff
      color12 #78a9ff

      # magenta
      color5  #d0a9e5
      color13 #c7a0dc

      # cyan
      color6  #3ddbd9
      color14 #3ddbd9

      # white
      color7  #f2f4f8
      color15 #ffffff
    '';
  };
}
