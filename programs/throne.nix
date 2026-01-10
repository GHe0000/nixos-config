{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    #nekoray
    throne
  ];
}
