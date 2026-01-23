{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
    shellAbbrs = {
      nrs = "sudo nixos-rebuild switch --flake .";
      nrb = "sudo nixos-rebuild build --flake .";
      ncu = "sudo nix-collect-garbage -d";
      nopt = "nix-store --optimise";

      ndg = "sudo nix-env --delete-generations old";
    };
    shellAliases = {
      ll = "ls -l";
      gs = "git status";
    };
    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "bass"; src = pkgs.fishPlugins.bass.src; }
    ];
  };
}
