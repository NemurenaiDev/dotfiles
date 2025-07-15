{
  home.file.".config/fuzzel/fuzzel.ini".force = true;
  home.file.".config/fuzzel/fuzzel.ini".text = ''
    font=JetBrainsMono Nerd Font Mono:weight=bold:size=13
    fields=name,generic,comment,categories,filename,keywords
    line-height=30
    terminal=kitty
    prompt="❯  " 
    layer=top
    lines=8
    width=50

    [colors]
    text=f8f8f2ff
    match=8be9fdff
    border=bd93f9ff
    selection=44475aff
    background=282a36aa
    selection-text=f8f8f2ff
    selection-match=8be9fdff
  '';
}
