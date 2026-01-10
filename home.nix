{ config, pkgs, ... }:

{
  imports = [
    ./programs/git.nix
    # ./programs/throne.nix
  ];

  home.username = "ghe";
  home.homeDirectory = "/home/ghe";

  home.packages = with pkgs; [
    kdePackages.kate
  ];

  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
