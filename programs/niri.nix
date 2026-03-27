{ pkgs, ... }:

{
  wayland.systemd.target = "niri-session.target";

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home.packages = with pkgs; [
    brightnessctl
    foot
    fuzzel
    playerctl
    swaylock
    wireplumber
    wl-clipboard
    xwayland-satellite
  ];

  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;
}
