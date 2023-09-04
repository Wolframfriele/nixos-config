{
  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      # package.disabled = true;
      # format = ''
      #   [  ](bg:#769ff0 fg:#161616)\
      #   $directory\
      #   [](fg:#769ff0 bg:#464646)\
      #   $git_branch\
      #   $git_status\
      #   [](fg:#464646 bg:#202020)\
      #   $nodejs\
      #   $rust\
      #   $golang\
      #   $python\
      #   [](fg:#202020 bg:#0f0f0f)\
      #   $time\
      #   [ ](fg:#0f0f0f)\
      #   \n$character'';
      #
      # directory = {
      #   style = "bold fg:#161616 bg:#769ff0";
      #   format = "[ $path ]($style)";
      #   truncation_length = 3;
      #   truncation_symbol = "…/";
      # };
      #
      # git_branch = {
      #   symbol = "";
      #   style = "bg:#464646";
      #   format = "[[ $symbol $branch ](fg:#769ff0 bg:#464646)]($style) ";
      # };
      #
      # git_status = {
      #   style = "bg:#394260";
      #   ahead = "⇡$count";
      #   format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#464646)]($style) ";
      # };
    };
  };
}

