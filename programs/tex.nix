{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    texlive.combined.scheme-full
    lyx
    python3
    imagemagick
  ];
  fonts.fontconfig.enable = true;
}
