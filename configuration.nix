{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix   # 🖥 Hardware scan
    ./modules/system/basics.nix
    ./modules/system/desktop.nix
    ./modules/system/security.nix
    ./modules/system/audio-print.nix
    ./modules/system/users.nix
    ./modules/system/cli.nix
    ./modules/system/network.nix
    ./modules/system/nix.nix
    ./modules/system/version.nix
  ];
}
