# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.timeout =1;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "Linux"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Dhaka";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      m17n
      openbangla-keyboard
    ];
   };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Services
  services.xserver = {
  	enable = true;
  	displayManager.sddm = {
  		wayland.enable = true;
  		theme = "sddm-chili-theme";
  	};
  };
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "asifakonjee";

  # Hyprland
  programs.hyprland = {
  	enable = true;
  	xwayland = {
  		enable = true;
  	};
  };

  # Bluetooth
  services.blueman.enable = true;
  security.polkit.enable = true;

  # Enable Sound
  sound.enable = true;
  hardware.bluetooth.enable = true;
  services.pipewire = {
  	enable = true;
  	alsa.enable = true;
  	alsa.support32Bit = true;
  	pulse.enable = true;
  	jack.enable = true;
  	wireplumber.enable = true;  	
  };

  # Enable touchpad support
  services.xserver.libinput.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
     enable = true;
     drivers = [ pkgs.hplip ];
    };

  services.system-config-printer.enable = true;

  # Enable Locate
  # services.locate.enable = true;
  # services.locate.package = pkgs.mlocate;

  # Environmental Variables
  environment.variables = {
  	QT_QPA_PLATFORMTHEME = "qt5ct";
  	QT_QPA_PLATFORM = "xcb obs";
  };
  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.asifakonjee = {
    isNormalUser = true;
    description = "Dr. Asifur Rahman Akonjee";
    extraGroups = [ "networkmanager" "wheel" "video" "kvm" ];
    packages = with pkgs; [];
  };

  # ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  
  # Enable automatic login for the user.
  # services.getty.autologinUser = "asifakonjee";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Thunar
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
  thunar-archive-plugin
  thunar-media-tags-plugin
  thunar-volman 
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    alacritty
    bat
    bibata-cursors
    blueman
    brightnessctl
    calcure
    cargo
    cmake
    dunst
    eww-wayland
    eza
    figlet
    firefox-wayland
    fontpreview
    fzf
    foot
    ffmpeg
    gcc
    geany
    gimp
    git
    glibc
    gnumake
    grim
    gtk3
    hplip
    htop
    hyprland
    jp2a
    jq
    kora-icon-theme
    libreoffice-fresh
    libsixel
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    libsForQt5.gwenview
    libsForQt5.qt5.qtgraphicaleffects
    libvirt
    lsd
    meson
    micro
    mpv
    neofetch
    networkmanager_dmenu
    ninja
    networkmanagerapplet
    nwg-look
    obs-studio
    (pkgs.wrapOBS {
    	plugins = with pkgs.obs-studio-plugins; [
    		wlrobs
    	];
    })
    pavucontrol
    pipewire
    polkit_gnome
    qemu_kvm
    qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
    ranger
    ripgrep
    rofi-wayland
    rustup
    sddm
    sddm-chili-theme
    slurp
    swaybg
    swayidle
    swaylock-effects
    system-config-printer
    tldr
    unzip
    virt-viewer
    waybar
    wayland-protocols
    wayland-utils
    wezterm
    wf-recorder
    wl-clipboard
    wget
    wireplumber
    wl-color-picker
    wofi
    wlroots
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-utils
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xwayland
    ydotool
    zoxide
    zsh   
  ];

  # Fonts
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
  	font-awesome
  	nerdfonts
  ];

  # Other Services
  services.dbus.enable = true;
  xdg.portal = {
  	enable = true;
  	wlr.enable = true;
  	extraPortals = [
  		pkgs.xdg-desktop-portal-gtk
  	];
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # Nix Package Overlays
  nixpkgs.overlays = [
  	(self: super: {
  		waybar = super.waybar.overrideAttrs (oldAttrs: {
  			mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true "];
  		});
  	})
  ];

}
