{
  config,
  pkgs,
  inputs,
  ...
}:

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
    ./programs/overskride.nix
  ];

  home.username = "ghe";
  home.homeDirectory = "/home/ghe";

  home.packages = with pkgs; [
    kdePackages.kate
    imagemagick
    grc
    vlc
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${config.home.homeDirectory}/Desktop";
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Downloads";
    music = "${config.home.homeDirectory}/Music";
    pictures = "${config.home.homeDirectory}/Pictures";
    publicShare = "${config.home.homeDirectory}/Public";
    templates = "${config.home.homeDirectory}/Templates";
    videos = "${config.home.homeDirectory}/Videos";
  };

  fonts.fontconfig.enable = true;
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
