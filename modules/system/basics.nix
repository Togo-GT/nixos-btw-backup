{ config, pkgs, ... }:

{
  # ----------------------------
  # 💻 System Basics
  # ----------------------------
  boot.loader.grub.enable = true;             # 🥧 Enable GRUB
  boot.loader.grub.device = "/dev/sda";       # 💽 GRUB device
  boot.loader.grub.useOSProber = true;        # 🔍 Detect OS

  networking.hostName = "nixos-btw";          # 🌐 Hostname
  networking.networkmanager.enable = true;    # 📶 NetworkManager

  time.timeZone = "Europe/Copenhagen";        # ⏰ Timezone

  # Locale: English system with Danish formatting 🇩🇰
  i18n.defaultLocale = "en_DK.UTF-8";
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
}
