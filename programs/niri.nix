{ pkgs, ... }:

{
  wayland.systemd.target = "niri-session.target";

  qt = {
    enable = true;
    platformTheme.name = "kde";
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    XDG_MENU_PREFIX = "plasma-";
  };

  home.packages = with pkgs; [
    brightnessctl
    # alacritty
    # fuzzel
    playerctl
    # swaylock
    wireplumber
    wl-clipboard
    xwayland-satellite

    kdePackages.plasma-integration
    kdePackages.plasma-workspace
  ];

  # services.swayidle = {
  #   enable = true;
  #   systemdTarget = "niri-session.target";
  #   events = [
  #     {
  #       event = "lock";
  #       command = "noctalia-shell ipc call lockScreen lock";
  #     }
  #     {
  #       event = "before-sleep";
  #       command = "noctalia-shell ipc call lockScreen lock";
  #     }
  #   ];
  # };
  services.swayidle = {
    enable = true;
    systemdTarget = "niri-session.target";
    events = {
      lock = "noctalia-shell ipc call lockScreen lock";
      before-sleep = "noctalia-shell ipc call lockScreen lock";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    config.common.default = "kde";
  };

  xdg.configFile."menus/applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  xdg.configFile."niri/config.kdl".source = ../configs/niri.kdl;
}
