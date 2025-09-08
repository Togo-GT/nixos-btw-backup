{ config, pkgs, ... }:

{
  # ----------------------------
  # 🌐 Netværk & Crypto
  # ----------------------------
  programs.mtr.enable = true;                  # 📡 Network diagnostics

  programs.gnupg.agent = {
    enable = true;                             # 🔑 GPG agent
    enableSSHSupport = true;                   # 🔑 SSH support
  };

  # ----------------------------
  # 🔥 Firewall
  # ----------------------------
  networking.firewall.allowedTCPPorts = [ 22 80 443 ]; # 🔒 TCP ports
  networking.firewall.allowedUDPPorts = [ 53 ];        # 🔒 UDP ports
}
