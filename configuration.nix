{ config, pkgs, ... }:

let
  cros-ucm = pkgs.fetchFromGitHub {
    owner = "WeirdTreeThing";
    repo = "alsa-ucm-conf-cros";
    rev = "standalone";
    hash = "sha256-3TpzjmWuOn8+eIdj0BUQk2TeAU7BzPBi3FxAmZ3zkN8=";
  };

  merged-ucm = pkgs.runCommand "alsa-ucm-merged" {} ''
    mkdir -p $out/ucm2
    cp -rL ${pkgs.alsa-ucm-conf}/share/alsa/ucm2/* $out/ucm2/
    chmod -R u+w $out/ucm2
    if [ -d "${cros-ucm}/ucm2" ]; then
      cp -rL ${cros-ucm}/ucm2/* $out/ucm2/
    fi
    if [ -d "${cros-ucm}/overrides" ]; then
      mkdir -p $out/ucm2/conf.d
      cp -rL ${cros-ucm}/overrides/* $out/ucm2/conf.d/
    fi
  '';
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Mirrors
  nix.settings.substituters = [
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    "https://mirrors.ustc.edu.cn/nix-channels/store"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.enableAllFirmware = true;

  boot.extraModprobeConfig = ''
    options snd-intel-dspcfg dsp_driver=4
    options snd-soc-avs ignore_fw_version=1
    options snd-soc-avs obsolete_card_names=1
  '';

  environment.sessionVariables.ALSA_CONFIG_UCM2 = "${merged-ucm}/ucm2";

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;

    wireplumber.extraConfig."51-increase-headroom" = {
      "monitor.alsa.rules" = [
        {
          matches = [ { "node.name" = "~alsa_output.*"; } ];
          actions = {
            update-props = {
              "api.alsa.headroom" = 2048;
            };
          };
        }
      ];
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ghe = {
    isNormalUser = true;
    description = "Guotao He";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    gcc
    clang
    gnumake
    gdb
    ninja
    cmake

    neovim
    git
    fastfetch
    wget
    curl

    btop
    chromium

    alsa-utils
  ];
  
  # Shell
  programs.fish.enable = true; 
  
  # VPN
  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  # Fcitx + Rime
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      qt6Packages.fcitx5-chinese-addons

      fcitx5-gtk
      kdePackages.fcitx5-qt

      fcitx5-material-color
    ];
  };

  # TLP
  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    };
  };


  # Keymap
  # 修复按键映射
  services.udev.extraHwdb = ''
    evdev:atkbd:dmi:*
      KEYBOARD_KEY_d8=leftmeta
      KEYBOARD_KEY_db=capslock
  '';

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      source-han-sans
      source-han-serif
      nerd-fonts.fira-code
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif CJK SC" "Source Han Serif SC" ];
        sansSerif = [ "Noto Sans CJK SC" "Source Han Sans SC" ];
        monospace = [ "FiraCode Nerd Font" "Noto Sans Mono CJK SC" ];
      };
    };
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.11";

}
