{
  home.file.".config/fastfetch/config.jsonc".force = true;
  home.file.".config/fastfetch/config.jsonc".text = ''
    {
        "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
        "logo": {
            "padding": {
                "top": 2
            }
        },
        "display": {
            "separator": " -> ",
            "color": "blue"
        },
        "modules": [
            {
                "type": "custom",
                "format": "┌──────────────────────────────────────────────────────────────────────┐",
                "outputColor": "90"
            },
            {
                "type": "os",
                "key": " OS",
                "keyColor": "yellow"
            },
            {
                "type": "kernel",
                "key": "│ ├",
                "keyColor": "yellow"
            },
            {
                "type": "packages",
                "key": "│ ├󰏖",
                "keyColor": "yellow"
            },
            {
                "type": "shell",
                "key": "│ └",
                "keyColor": "yellow"
            },
            {
                "type": "wm",
                "key": " WM",
                "keyColor": "blue"
            },
            {
                "type": "lm",
                "key": "│ ├󰧨",
                "keyColor": "blue"
            },
            {
                "type": "wmtheme",
                "key": "│ ├󰉼",
                "keyColor": "blue"
            },
            {
                "type": "icons",
                "key": "│ ├󰀻",
                "keyColor": "blue"
            },
            {
                "type": "terminal",
                "key": "│ ├",
                "keyColor": "blue"
            },
            {
                "type": "wallpaper",
                "key": "│ └󰸉",
                "keyColor": "blue"
            },
            {
                "type": "host",
                "key": "󰌢 PC",
                "keyColor": "green"
            },
            {
                "type": "cpu",
                "key": "│ ├󰻠",
                "keyColor": "green"
            },
            {
                "type": "gpu",
                "key": "│ ├󰍛",
                "keyColor": "green"
            },
            {
                "type": "display",
                "key": "│ ├󰍹",
                "keyColor": "green"
            },
            {
                "type": "disk",
                "key": "│ ├",
                "keyColor": "green"
            },
            {
                "type": "memory",
                "key": "│ ├󰑭",
                "keyColor": "green"
            },
            {
                "type": "swap",
                "key": "│ ├󰓡",
                "keyColor": "green"
            },
            {
                "type": "uptime",
                "key": "│ └󰅐",
                "keyColor": "green"
            },
            {
                "type": "sound",
                "key": " SND",
                "keyColor": "cyan"
            },
            {
                "type": "player",
                "key": "│ ├󰥠",
                "keyColor": "cyan"
            },
            {
                "type": "media",
                "key": "│ └󰝚",
                "keyColor": "cyan"
            },
            {
                "type": "custom",
                "format": "└──────────────────────────────────────────────────────────────────────┘",
                "outputColor": "90"
            }
        ]
    }
  '';
}
