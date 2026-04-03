{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.85;
      };
      terminal = {
        shell = "fish";
      };
      selection = {
        save_to_clipboard = true;
      };
    };
  };
}
