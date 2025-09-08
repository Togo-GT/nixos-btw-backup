{ config, pkgs, ... }:

{
  # ----------------------------
  # 🔒 Security / SSH / sudo
  # ----------------------------
  services.openssh.enable = true;              # 🟢 SSH server
  services.openssh.settings = {
    PermitRootLogin = "no";                    # ❌ Disable root login
    PasswordAuthentication = false;            # 🔒 Disable password auth
  };

  security.sudo.wheelNeedsPassword = false;    # 🟢 Wheel group sudo without password
}
