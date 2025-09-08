{ config, pkgs, ... }:

{
  # ----------------------------
  # 🚀 Nix / Flakes
  # ----------------------------
  nix = {
    package = pkgs.nixVersions.latest;         # 🧪 Latest Nix
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
