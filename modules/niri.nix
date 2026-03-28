{ config, pkgs, inputs, ... }:

{
programs.niri.enable = true;

environment.systemPackages = with pkgs; [
   bibata-cursors
   inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default 
   kdePackages.kirigami
   kdePackages.qqc2-desktop-style
   kdePackages.kirigami.unwrapped
  ];

services.input-remapper.enable = true;
}
