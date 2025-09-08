{ config, pkgs, ... }:

{
  # ----------------------------
  # 👤 Users
  # ----------------------------
  users.users.gt = {
    isNormalUser = true;                       # 🧑‍💻 Normal user
    description = "gt";
    extraGroups = [ "networkmanager" "wheel" ]; # 👥 User groups
    packages = with pkgs; [
      kdePackages.kate   # ✍️ KDE editor
    ];
  };

  programs.firefox.enable = true;              # 🌐 Firefox
}
