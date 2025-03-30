{
  services.mako.enable = true;
  services.mako.extraConfig = ''
    maxHistory=100
    sort=+time
    onTouch=dismiss
    onButtonLeft=dismiss
    onButtonMiddle=none
    onButtonRight=dismiss-all
    anchor=bottom-right
    font=JetBrainsMono Nerd Font Mono
    width=400
    height=100
    margin=5
    padding=10
    borderSize=1
    borderRadius=10
    icons=1
    maxIconSize=64
    iconLocation=left
    markup=1
    actions=1
    history=1
    textAlignment=left
    defaultTimeout=5000
    ignoreTimeout=0
    maxVisible=5
    layer=overlay
    backgroundColor=#1e1e2e
    textColor=#cdd6f4
    borderColor=#b4befe
    progressColor=#89b4fa

    [mode=do-not-disturb]
    invisible=1


    [urgency=low]
    default-timeout=3000
    anchor=bottom-left

    [urgency=normal]
    default-timeout=5000
    anchor=bottom-left

    [urgency=high]
    invisible=0
    default-timeout=0
    anchor=bottom-left
    border-color=#eb6f92


    [category=im.received]
    border-color=#89b4fa
    default-timeout=16000

    [category=adjustments]
    invisible=0
    text-color=#f7f7f7
    text-alignment=right
    default-timeout=2000
    anchor=bottom-center
    padding=2,4
    max-icon-size=24
    width=175

    [category=error]
    invisible=0
    border-size=2
    border-color=#e64553
    default-timeout=10000
    anchor=bottom-right


    [app-name=Zen]
    default-timeout=16000
    anchor=bottom-left
    border-color=#FF7456

    [app-name=waybar-updates]
    invisible=true

    [app-name=Spotify]
    default-timeout=5000
    border-color=#a6e3a1

    [app-name=Vivaldi]
    default-timeout=5000
    border-color=#eb6f92
  '';
}
