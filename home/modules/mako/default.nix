{ monitors, ... }:

{
  home.file.".config/mako/config".force = true;
  home.file.".config/mako/config".text = ''
    output=${monitors.central}
    max-history=100
    sort=+time
    on-touch=dismiss
    on-button-left=dismiss
    on-button-middle=none
    on-button-right=dismiss-all
    anchor=bottom-right
    font=JetBrainsMono Nerd Font Mono
    width=400
    height=100
    margin=5
    padding=10
    border-size=1
    border-radius=10
    icons=1
    max-icon-size=64
    icon-location=left
    markup=1
    actions=1
    history=1
    text-alignment=left
    default-timeout=5000
    ignore-timeout=0
    max-visible=5
    layer=overlay
    background-color=#1e1e2e
    text-color=#cdd6f4
    border-color=#b4befe
    progress-color=#89b4fa

    # [mode=do-not-disturb]
    # invisible=true


    [urgency=low]
    default-timeout=3000
    anchor=bottom-left

    [urgency=normal]
    default-timeout=5000
    anchor=bottom-left

    [urgency=high]
    # invisible=false
    default-timeout=0
    anchor=bottom-left
    border-color=#eb6f92


    [category=im.received]
    border-color=#89b4fa
    default-timeout=16000

    [category=adjustments]
    # invisible=false
    text-color=#f7f7f7
    text-alignment=right
    default-timeout=2000
    anchor=bottom-center
    padding=2,4
    max-icon-size=24
    width=175

    [category=error]
    # invisible=false
    border-size=2
    border-color=#e64553
    default-timeout=10000
    anchor=bottom-right


    [app-name=Zen]
    # invisible=true
    default-timeout=16000
    anchor=bottom-left
    border-color=#FF7456

    [app-name=Spotify]
    invisible=false
    default-timeout=5000
    border-color=#a6e3a1
  '';
}
