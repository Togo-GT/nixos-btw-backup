{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix # 🖥 Hardware scan results
  ];

  # ---------------------------- 
  # 💻 System Basics 
  # ---------------------------- 
  boot.loader = {
    systemd-boot.enable = true;       # 🆕 Modern bootloader
    efi.canTouchEfiVariables = true;  # 🆕 EFI support
    timeout = 3;                      # ⏱ Boot menu timeout
  };

  networking.hostName = "nixos-btw";  # 🌐 Hostname
  networking.networkmanager.enable = true; # 📶 NetworkManager
  
  time.timeZone = "Europe/Copenhagen"; # ⏰ Timezone
  
  # Locale: English system with Danish formatting 🇩🇰 
  i18n.defaultLocale = "en_DK.UTF-8";
  i18n.supportedLocales = ["en_DK.UTF-8/UTF-8" "da_DK.UTF-8/UTF-8"]; # 🆕 Support both locales
  
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # ---------------------------- 
  # 🖥 Desktop Environment 
  # ---------------------------- 
  services.xserver.enable = true;     # 🖥 Enable X server
  services.displayManager.sddm.enable = true; # 🔑 SDDM login manager
  services.desktopManager.plasma6.enable = true; # 🖱 KDE Plasma 6
  
  services.xserver.xkb = {
    layout = "dk";    # ⌨️ Keyboard layout
    variant = "";
  };
  
  console.keyMap = "dk-latin1";       # 🖥 Console keyboard

  # ---------------------------- 
  # 🔒 Security / SSH / sudo 
  # ---------------------------- 
  services.openssh = {
    enable = true;                    # 🟢 SSH server
    settings = {
      PermitRootLogin = "no";         # ❌ Disable root login
      PasswordAuthentication = false; # 🔒 Disable password auth
      KbdInteractiveAuthentication = false;
      AllowUsers = ["gt"];            # 🆕 Only allow specific user
    };
  };
  
  security.sudo.wheelNeedsPassword = false; # 🟢 Wheel group sudo without password

  # ---------------------------- 
  # 🔊 Audio & Printing 
  # ---------------------------- 
  services.printing.enable = true;    # 🖨 Enable CUPS
  services.printing.drivers = [ pkgs.hplip ]; # 🆕 HP printer support
  
  security.rtkit.enable = true;       # 🎵 Realtime audio support
  
  services.pipewire = {
    enable = true;                    # 🎧 PipeWire audio
    alsa.enable = true;               # 🔊 ALSA support
    alsa.support32Bit = true;         # 🖥 32-bit ALSA
    pulse.enable = true;              # 🔉 Pulse compatibility
    jack.enable = true;               # 🎛️ Jack audio support
  };

  # ---------------------------- 
  # 👤 Users 
  # ---------------------------- 
  users.users.gt = {
    isNormalUser = true;              # 🧑‍💻 Normal user
    description = "gt";
    extraGroups = [ 
      "networkmanager" 
      "wheel" 
      "audio" 
      "video" 
      "scanner" 
      "lp" 
    ]; # 👥 User groups with added permissions
    shell = pkgs.zsh;                 # 🐚 Set default shell
    # openssh.authorizedKeys.keys = [ # 🆕 Uncomment and add your SSH keys
    #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI..."
    # ];
  };

  # Install firefox
  programs.firefox.enable = true;

  # ---------------------------- 
  # 🐚 Shell / Terminal 
  # ---------------------------- 
  programs.zsh = {
    enable = true;                    # 🐚 Aktivér Zsh
    enableCompletion = true;          # ✅ Autocompletion
    autosuggestions.enable = true;    # 💡 Forslag mens du skriver
    syntaxHighlighting.enable = true; # 🎨 Syntax highlighting
    
    ohMyZsh = {
      enable = true;                  # ⚡ Aktivér Oh My Zsh
      theme = "robbyrussell";         # 🎭 Tema
      plugins = [ 
        "git"        # 🌱 Git integration
        "z"          # 📂 Hurtig navigation
        "sudo"       # 🔑 Sudo shortcut
        "autojump"   # 🚀 Hop hurtigt i mapper
        "history-substring-search" # ⏮ Historik-søgning
      ];
    };
  };

  # 🛠 CLI-værktøjer
  environment.systemPackages = with pkgs; [
    # Systemværktøjer
    wget            # 🌐 Downloads
    curl            # 🌐 HTTP requests
    htop            # 📊 Process monitor
    neofetch        # 💻 System info
    tree            # 🌲 Mappeoversigt
    nil             # 🟢 Nix LSP server
    
    # Netværksværktøjer
    nmap            # 🔍 Network exploration
    tcpdump         # 📡 Network analysis
    iperf3          # 🚀 Network performance
    
    # Udviklingsværktøjer
    git             # 🌱 Version control
    gcc             # 🔧 Compiler
    gnumake         # 🛠 Build tool
    python3         # 🐍 Python
    nodejs          # 🟢 Node.js
    
    # Tekstredigering
    vim             # ✍️ Text editor
    nano            # 📝 Simple editor
    
    # Systemanalyse
    pciutils        # 🔍 PCI hardware info
    usbutils        # 🔍 USB device info
    lm_sensors      # 🌡 Temperature monitoring
  ];

  # ---------------------------- 
  # 🌐 Netværk & Crypto 
  # ---------------------------- 
  programs.mtr.enable = true;         # 📡 Network diagnostics
  
  programs.gnupg.agent = {
    enable = true;                    # 🔑 GPG agent
    enableSSHSupport = true;          # 🔑 SSH support
  };

  # ---------------------------- 
  # 🔥 Firewall 
  # ---------------------------- 
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];  # 🔒 TCP ports
    allowedUDPPorts = [ 53 ];         # 🔒 UDP ports
  };

  # ---------------------------- 
  # 🚀 Nix / Flakes 
  # ---------------------------- 
  nix = {
    package = pkgs.nixVersions.latest; # 🧪 Latest Nix
    settings.experimental-features = [ "nix-command" "flakes" ]; # ⚡ Flakes
    
    # 🗑️ Automatisk oprydning
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    
    # 🔧 Optimize storage
    settings.auto-optimise-store = true;
  };

  # ---------------------------- 
  # 🆕 Yderligere forbedringer
  # ---------------------------- 
  
  # Firmware updates
  services.fwupd.enable = true;
  
  # Flatpak support (optional)
  # services.flatpak.enable = true;
  
  # Automatic system upgrades (optional)
  # system.autoUpgrade = {
  #   enable = true;
  #   channel = "https://nixos.org/channels/nixos-25.05";
  #   allowReboot = false;
  # };
  
  # ---------------------------- 
  # ⚡ System version 
  # ---------------------------- 
  system.stateVersion = "25.05";      # 📌 Required
}
