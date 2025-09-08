{ config, pkgs, ... }:

{
  # ----------------------------
  # 🖥 Desktop Environment
  # ----------------------------
  services.xserver.enable = true;              # 🖥 Enable X server
  services.displayManager.sddm.enable = true;  # 🔑 SDDM login manager
  services.desktopManager.plasma6.enable = true; # 🖱 KDE Plasma 6

  services.xserver.xkb = {
    layout = "dk";     # ⌨️ Keyboard layout
    variant = "";
  };
  console.keyMap = "dk-latin1";                # 🖥 Console keyboard
}
