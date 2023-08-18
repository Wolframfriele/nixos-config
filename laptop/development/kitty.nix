{
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
  };
}
