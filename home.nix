{ config, pkgs, ... }:

{
  imports = [
    ./programs/git.nix
    ./programs/fish.nix
    ./programs/nixvim.nix
    ./programs/speedynote.nix
    ./programs/python.nix
  ];

  home.username = "ghe";
  home.homeDirectory = "/home/ghe";

  home.packages = with pkgs; [
    kdePackages.kate
    texlive.combined.scheme-full

    lyx
    imagemagick
    # (python3.withPackages (ps: with ps; [
    #   numpy
    #   numba
    #   scipy
    #   matplotlib
    #   ipython
    #   sympy
    #   pip
    # ]))

    grc
  ];
  
  fonts.fontconfig.enable = true;
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
