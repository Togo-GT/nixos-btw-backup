{ config, pkgs, ... }:

{
  # ----------------------------
  # 🔊 Audio & Printing
  # ----------------------------
  services.printing.enable = true;             # 🖨 Enable CUPS
  services.pulseaudio.enable = false;          # ❌ Disable PulseAudio
  security.rtkit.enable = true;                # 🎵 Realtime audio support

  services.pipewire = {
    enable = true;                             # 🎧 PipeWire audio
    alsa.enable = true;                        # 🔊 ALSA support
    alsa.support32Bit = true;                  # 🖥 32-bit ALSA
    pulse.enable = true;                       # 🔉 Pulse compatibility
  };
}
