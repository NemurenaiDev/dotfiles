hl.workspace_rule({ workspace = "1", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "2", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "3", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "4", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "5", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "6", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "7", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "8", monitor = nix.monitors.primary, default = true })

hl.workspace_rule({ workspace = "9", monitor = nix.monitors.secondaryOrFallback, default = true })
hl.workspace_rule({ workspace = "10", monitor = nix.monitors.secondaryOrFallback, default = true })

hl.workspace_rule({ workspace = "11", monitor = nix.monitors.secondaryOrFallback, default = true })
hl.workspace_rule({ workspace = "12", monitor = nix.monitors.secondaryOrFallback, default = true })
hl.workspace_rule({ workspace = "13", monitor = nix.monitors.secondaryOrFallback, default = true })
hl.workspace_rule({ workspace = "14", monitor = nix.monitors.secondaryOrFallback, default = true })
hl.workspace_rule({ workspace = "15", monitor = nix.monitors.secondaryOrFallback, default = true })
hl.workspace_rule({ workspace = "16", monitor = nix.monitors.secondaryOrFallback, default = true })
hl.workspace_rule({ workspace = "17", monitor = nix.monitors.secondaryOrFallback, default = true })
hl.workspace_rule({ workspace = "18", monitor = nix.monitors.secondaryOrFallback, default = true })
hl.workspace_rule({ workspace = "19", monitor = nix.monitors.secondaryOrFallback, default = true })
hl.workspace_rule({ workspace = "20", monitor = nix.monitors.secondaryOrFallback, default = true })

hl.workspace_rule({ workspace = "21", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "22", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "23", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "24", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "25", monitor = nix.monitors.primary, default = true, gaps_out = 80 })

hl.workspace_rule({ workspace = "26", monitor = nix.monitors.secondaryOrFallback, default = true })

hl.workspace_rule({ workspace = "27", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "28", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "29", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "30", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "31", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "32", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "33", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "34", monitor = nix.monitors.primary, default = true })
hl.workspace_rule({ workspace = "35", monitor = nix.monitors.primary, default = true })

hl.workspace_rule({ workspace = "36", monitor = nix.monitors.secondaryOrFallback, default = true })
hl.workspace_rule({ workspace = "37", monitor = nix.monitors.secondaryOrFallback, default = true })
hl.workspace_rule({ workspace = "38", monitor = nix.monitors.secondaryOrFallback, default = true })
hl.workspace_rule({ workspace = "39", monitor = nix.monitors.secondaryOrFallback, default = true })

hl.workspace_rule({ workspace = "special:aichat", gaps_out = 50, layout = "scrolling" })





------------------------ other ------------------------

hl.window_rule({ match = { workspace = "w[tv1]" }, border_size = 0 })
hl.window_rule({ match = { float = true }, border_size = 1 })


hl.window_rule({ match = { class = "^chrome-.*-Default$" }, workspace = "special:aichat silent" })


hl.window_rule({ match = { class = "(^$)", title = "(LibreOffice)" }, workspace = "special:hidden silent" })
hl.window_rule({ match = { class = "(^$)", title = "(.*is.sharing.*)" }, workspace = "special:hidden silent" })
hl.window_rule({ match = { class = "(nemo)", title = "(nemo.*/.local/share/nemo)" }, workspace = "special:hidden silent" })



hl.window_rule({ match = { class = "(code)" }, fullscreen_state = "0 2" })

hl.window_rule({ match = { class = "(deluge)" }, suppress_event = "maximize" })

hl.window_rule({ match = { class = "(libreoffice.*)" }, suppress_event = "maximize" })

hl.window_rule({ match = { class = "(Unity)", title = "(UnityEditor.PopupWindow)" }, move = "cursor 0 0" })



hl.window_rule({ match = { class = "(org.telegram.desktop)" }, suppress_event = "maximize" })
hl.window_rule({ match = { class = "(org.telegram.desktop)" }, suppress_event = "fullscreen" })
hl.window_rule({
    match = { class = "(org.telegram.desktop)", title = "(Mini.App.+)" },
    size = "600 765",
    float = true
})
hl.window_rule({
    match = { class = "(org.telegram.desktop)", title = "(Media viewer)" },
    float = true,
    center = true,
    move = "30 50",
    size = "monitor_w-60 monitor_h-80",
})



------------------------ gaming ------------------------

hl.window_rule({ match = { class = "(steam_app_.*)" }, fullscreen = true })

hl.window_rule({
    match = { class = "(net.lutris.Lutris)", title = "(Lutris.+)" },
    float = true,
    center = true,
    size = "1400 800",
})


hl.window_rule({ match = { class = "(Steam|steam)", title = "negative:(Steam|Steam.Big.Picture.Mode)" }, float = true })
hl.window_rule({ match = { class = "(Steam|steam)", title = "(.*Screenshot.*)" }, size = "1600 900" })
hl.window_rule({ match = { class = "", title = "(Steam|steam)" }, center = true })
hl.window_rule({ match = { class = "(Steam|steam)" }, center = true })
hl.window_rule({
    match = { class = "(Steam|steam)", title = "(Steam|Steam.Big.Picture.Mode)" },
    float = false,
    suppress_event = "fullscreen"
})



------------------------ media & docs ------------------------

hl.window_rule({ match = { class = "(soffice)" }, float = true, center = true, size = "1200 720" })


hl.window_rule({
    match = { title = "(.icture.in..icture)" },
    pin = true,
    float = true,
    no_initial_focus = true,
    size = "500 300",
    move = "monitor_w-500-5 monitor_h-300-5",
})

hl.window_rule({
    match = { class = "(org.kde.haruna|org.gnome.eog|mpv)" },
    float = true,
    center = true,
    move = "30 50",
    size = "monitor_w-60 monitor_h-80",
})



------------------------ dialogs ------------------------

hl.window_rule({ match = { class = "(kitty-.*)" }, pin = true, float = true, center = true })

hl.window_rule({ match = { class = "(kitty-project)" }, size = "800 450", stay_focused = true })
hl.window_rule({ match = { class = "(kitty-powermenu)" }, size = "250 200", stay_focused = true })
hl.window_rule({ match = { class = "(kitty-windowinfo)" }, size = "1280 720" })
hl.window_rule({ match = { class = "(kitty-sink-selector)" }, size = "300 200", stay_focused = true })


hl.window_rule({
    match = { class = "(vivaldi.*)", title = "Bitwarden - Vivaldi" },
    float = true,
    center = true,
    size = "500 700"
})


hl.window_rule({
    match = { class = "negative:(com.github.hluk.copyq)", title = "(.*(Confirm).*)" },
    float = true,
    center = true,
    size = "960 300",
})
hl.window_rule({
    match = { class = "negative:(com.github.hluk.copyq)", title = "(.*(Rename|File.*Operation).*)" },
    float = true,
    center = true,
    size = "450 150",
})
hl.window_rule({
    match = { class = "negative:(com.github.hluk.copyq)", title = "(.*(Open.with).*)" },
    float = true,
    center = true,
    size = "720 680",
})
hl.window_rule({
    match = { class = "negative:(com.github.hluk.copyq)", title = "(.*(Upload|Choose|Select|Save.File|Open.File).*)" },
    float = true,
    center = true,
    size = "960 720",
})


hl.window_rule({
    match = { title = "Select what to share" },
    float = true,
    center = true,
    size = "600 350"
})



------------------------ utilities ------------------------

hl.window_rule({
    match = { class = "(com.github.hluk.copyq)" },
    float = true,
    center = true,
    size = "960 720",
    workspace = "current"
})

hl.window_rule({
    match = { class = "(dconf-editor)" },
    float = true,
    center = true,
    size = "1600 900"
})

hl.window_rule({
    match = { class = "(.*nm-.*)" },
    float = true,
    center = true,
})

hl.window_rule({
    match = { class = "(.*blueman.*)" },
    float = true,
    center = true,
})

hl.window_rule({
    match = { class = "(.*(file-roller|FileRoller).*)" },
    float = true,
    center = true,
    size = "960 720",
})

hl.window_rule({
    match = { class = "(.*(blueman|nm-connection-editor).*)" },
    float = true,
    center = true,
    size = "960 720",
})

hl.window_rule({
    match = { class = "(.*(blueman-manager|blueman-services|blueman-sendto).*)" },
    size = "640 480",
})

hl.window_rule({
    match = { class = "(.*(pavucontrol|easyeffects).*)" },
    float = true,
    center = true,
    size = "960 720",
})
