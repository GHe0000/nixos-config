{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [
      numpy
      numba
      scipy
      matplotlib
      ipython
      sympy
      pip
    ]))
  ];
}
