{ config, pkgs, ... }:

{
  # ----------------------------
  # 🖥 Terminal emulator
  # ----------------------------
  programs.alacritty.enable = true;
  home.file.".config/alacritty/alacritty.yml".text = ''
    window:
      padding:
        x: 8
        y: 8
      dynamic_title: true
    font:
      normal:
        family: Monospace
        size: 12.0
    scrolling:
      history: 10000
      multiplier: 3
    cursor:
      style: Block
      blink: true
    colors:
      primary:
        background: '0x1d1f21'
        foreground: '0xc5c8c6'
  '';
}
