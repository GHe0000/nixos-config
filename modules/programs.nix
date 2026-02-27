{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    gcc
    clang
    gnumake
    gdb
    ninja
    cmake

    git
    fastfetch
    wget
    curl

    btop
    chromium

    alsa-utils
  ];

}
