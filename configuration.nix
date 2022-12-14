# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:

with pkgs;
let 
  my-python-packages = python-packages: with python-packages; [
    numpy
    pandas
    matplotlib
    requests
    mypy
    pyls-black
    pyls-isort
    pyls-mypy
    flake8
    pytest
    flask
  ];
  python-with-my-packages = python3.withPackages my-python-packages;
  RStudio-with-my-packages = rstudioWrapper.override{ packages = with rPackages; [ ggplot2 dplyr xts faraway Hmisc purrr ]; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.desktopManager.gnome.enable = true;
	
  # Enable i3 
  services.xserver = {
    displayManager = {
      defaultSession = "none+i3";
      gdm.enable = true;
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "dk";
    xkbVariant = "winkeys";
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  services.picom = {
    enable = true;
    vSync = true;
  };

  # Garbage collection.
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
    };
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nrbjerg = {
    isNormalUser = true;
    description = "Martin Sig Nørbjerg";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
  };

  # Home manager
  home-manager.users.nrbjerg = { pkgs, ... }: {
    home.packages = [ pkgs.atool pkgs.httpie ];
    programs.zsh = {
      enable = true;
      shellAliases = {
        ll = "exa -l --icons";
        tree = "exa -Tla --icons";
        nix-switch = "nixos-rebuild switch";
      };
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" ];
        theme = "afowler";
      };
    };
  };
  # Shell setup (this is needed even though home manager enables zsh)
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.user = "nrbjerg";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ### CLI utils ###
    alacritty
    wget
    curl
    coreutils
    fd 
    ripgrep
    git
    gh
    neofetch 
    exa
    psmisc # Killall ect.
    thefuck
    libtool
    libvterm

    ### Programming langues & latex. ###
    # Python, R & Latex
    texlive.combined.scheme-full
    texlab
    RStudio-with-my-packages
    python-with-my-packages
    python-language-server

    # C / C++
    cmake
    gnumake
    gcc

    # Rust
    rustc
    rustfmt
    rust-analyzer

    # Haskell
    stack
    ghc
    haskell-language-server
    haskellPackages.fourmolu
    haskellPackages.hlint
    cabal-install

    ### Editors ###
    ((emacsPackagesFor emacs).emacsWithPackages (epkgs: [
      epkgs.vterm
    ]))
    neovim

    ### WM / Ricing ###
    polybar 
    rofi
    i3-gaps
    feh
    picom
    arc-theme
    qogir-icon-theme
    lxappearance
    brightnessctl

    ### Misc ###
    discord
    spotify
    gimp
    gnome.nautilus
    evince
    gnome.gnome-screenshot
  ];

  nixpkgs.config = {
    packageOverrides = pkgs: rec {
       polybar = pkgs.polybar.override {
       	 i3Support = true;
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05";
}
