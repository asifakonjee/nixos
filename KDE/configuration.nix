# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let 
  openbangla-keyboard-overlay = final: prev: {
  	openbangla-keyboard = prev.fcitx5-openbangla-keyboard.overrideAttrs
  	(old: {
  	 version = "develop-2023-11-05";
  	 src = final.fetchFromGitHub {
  	 owner = "asifakonjee";
  	 repo = "openbangla-keyboard";
  	 rev = "73012424cfb4db310250836e63cd87ac84106c1b"; 
  	 hash = "sha256-3moWzvuCD952sJGQct97k3Ls05S1ZavWhtH4LEdjUTI=";
  	 fetchSubmodules = true;
  	};
  	});
  };

in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.dbus.enable = true;
  boot.loader.timeout = 1;
  boot.plymouth = {
  	enable = true;
  	theme = "bgrt";
  };
  boot.kernelParams = [ "quiet"];


  networking.hostName = "Linux"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  nixpkgs.overlays = [ openbangla-keyboard-overlay ];
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ 
    fcitx5-m17n
    openbangla-keyboard 
    ];
   };

#  i18n.inputMethod = {
#      enabled = "ibus";
#      ibus.engines = with pkgs.ibus-engines; [ 
#      m17n
#      openbangla-keyboard 
#      ];
#     };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  services.xserver.desktopManager.plasma5.enable = true;
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
  	elisa
  	oxygen
  ];
  programs.dconf.enable = true; # GTK themes are not applied in Wayland   applications


  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };
  services.system-config-printer.enable = true;


  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

# Bluetooth
#  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.asifakonjee = {
    isNormalUser = true;
    description = "Dr. Asifur Rahman Akonjee";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #firefox
    #kate
    #thunderbird
    ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "asifakonjee";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  (import /etc/nixos/scripts/ibus-toggle-layout.nix { inherit pkgs; })
  bat
#  blueman
  brave
  eza
  figlet
  firefox-wayland
  fontpreview
  fzf
  foot
  ffmpeg
  git
  gimp
  htop
  libreoffice-fresh
  libsixel
  libsForQt5.qtstyleplugin-kvantum
  libsForQt5.plasma-wayland-protocols
  libsForQt5.sddm
  localsend
  lsix
  micro
  mpv
  neofetch
  obs-studio
  qbittorrent
  sddm
  system-config-printer
  wireplumber
  zsh  
  ];

  # Fonts
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
  	font-awesome
#  	nerdfonts
  ];

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
  system.stateVersion = "23.11"; # Did you read the comment?

}
