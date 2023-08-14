{ pkgs, ... }:
{
  services.mako = {
    enable = true;
    anchor = "top-center";
    backgroundColor = "#2a2a2a";
    borderColor = "#2a2a2a";
    defaultTimeout = 5000;
    textColor = "#f2f4f8";
    padding = "30";
  };
}
