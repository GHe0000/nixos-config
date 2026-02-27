{ config, pkgs, ... }:

{
  imports = [
    ./programs/git.nix
    ./programs/fish.nix
    ./programs/nixvim.nix
    ./programs/lyx.nix
    ./programs/speedynote.nix
    ./programs/python.nix
  ];

  home.username = "ghe";
  home.homeDirectory = "/home/ghe";

  home.packages = with pkgs; [
    kdePackages.kate
    imagemagick
    grc
  ];
  
  fonts.fontconfig.enable = true;
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
