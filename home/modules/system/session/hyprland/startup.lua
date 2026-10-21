hl.on("hyprland.start",
    function()
        hl.exec_cmd("echo $HYPRLAND_INSTANCE_SIGNATURE > /tmp/HYPRLAND_INSTANCE_SIGNATURE")

        hl.exec_cmd("systemctl --user start hyprpolkitagent")

        hl.exec_cmd("hyprlock --grace 0 --immediate-render --no-fade-in")


        hl.exec_cmd("uwsm app -- udiskie --automount --notify --smart-tray")
        hl.exec_cmd("uwsm app -- tailscale systray --theme dark:nobg")
        hl.exec_cmd("uwsm app -- copyq --start-server")


        hl.exec_cmd("run-on-workspace 'special:hidden' 'uwsm app -- nemo ~/.local/share/nemo' --silent")
        hl.exec_cmd("run-on-workspace 'special:hidden' 'uwsm app -- kitty --single-instance sh' --silent")

        hl.exec_cmd("run-on-workspace '25' 'uwsm app -- Telegram' --silent")
        hl.exec_cmd("run-after-keyring run-on-workspace '21' 'uwsm app -- vivaldi' --silent")

        hl.exec_cmd("run-after-keyring uwsm app -- chromium --app=https://chatgpt.com/")
    end
)
