{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    ./programs/git.nix
    ./programs/alacritty.nix
    ./programs/fish.nix
    ./programs/nixvim.nix
    ./programs/lyx.nix
    ./programs/speedynote.nix
    ./programs/python.nix
    ./programs/libreoffice.nix
    ./programs/krdc.nix
    ./programs/niri.nix
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
