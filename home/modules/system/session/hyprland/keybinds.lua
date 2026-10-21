------------------------ other ------------------------

hl.bind("SUPER + ALT + F1",
    hl.dsp.exec_cmd(
        "hyprctl -j activewindow > /tmp/.windowinfo && kitty --single-instance --class kitty-windowinfo sh -c 'cat /tmp/.windowinfo | moor -no-linenumbers'"
    )
)

hl.bind("SUPER + SHIFT + F11", hl.dsp.exec_cmd("hyprctl reload config-only"))
hl.bind("SUPER + SHIFT + F12", hl.dsp.exec_cmd("systemctl --user restart wayle"))

hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("uwsm app -- run-powermenu"))

hl.bind("SUPER + L", hl.dsp.exec_cmd(nix.binPath .. "/switch-layout 0 && loginctl lock-session"))



------------------------ utilities ------------------------

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("uwsm app -- kitty --single-instance"))

hl.bind("SUPER + V", hl.dsp.exec_cmd("uwsm app -- copyq show"))

hl.bind("SUPER + S", hl.dsp.exec_cmd("uwsm app -- fuzzel"))

hl.bind("SUPER + E", hl.dsp.exec_cmd("uwsm app -- nemo"))

hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("uwsm app -- hyprpicker --autocopy --no-fancy --render-inactive"))



------------------------ workspace-specific ------------------------

hl.bind("SUPER + W", hl.dsp.exec_cmd("run-on-workspace '21' 'uwsm app -- vivaldi'"))
hl.bind("SUPER + SHIFT + W", hl.dsp.window.move({ workspace = 21 }))

hl.bind("SUPER + A", hl.dsp.exec_cmd("run-on-workspace '22' 'uwsm app -- vivaldi --incognito'"))
hl.bind("SUPER + SHIFT + A", hl.dsp.window.move({ workspace = 22 }))

hl.bind("SUPER + X", hl.dsp.exec_cmd("run-on-workspace '25' 'uwsm app -- Telegram'"))
hl.bind("SUPER + SHIFT + X", hl.dsp.window.move({ workspace = 25 }))

hl.bind("SUPER + F3",
    hl.dsp.exec_cmd(
        "run-on-workspace '36' 'uwsm app -- spotify --enable-features=UseOzonePlatform --ozone-platform-hint=wayland'"
    )
)

hl.bind("SUPER + F4", hl.dsp.exec_cmd("run-on-workspace '39' 'uwsm app -- obs'"))

hl.bind("SUPER + TAB", hl.dsp.exec_cmd("run-on-workspace 'special:aichat' 'uwsm app -- chromium --app=https://chatgpt.com/'"))



------------------------ audio & bluetooth ------------------------

hl.bind("SUPER + G", hl.dsp.exec_cmd("uwsm app -- run-sink-selector"))

hl.bind("SUPER + SHIFT + G", hl.dsp.exec_cmd("uwsm app -- pavucontrol"))

hl.bind("SUPER + ALT + G", hl.dsp.exec_cmd("uwsm app -- blueman-manager"))



------------------------ screenshot ------------------------

hl.bind("Print", hl.dsp.exec_cmd(nix.binPath .. "/screenshot --screen"))
hl.bind("SUPER + ALT + S", hl.dsp.exec_cmd(nix.binPath .. "/screenshot --win"))
hl.bind("SUPER + CTRL + S", hl.dsp.exec_cmd(nix.binPath .. "/screenshot --screen"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(nix.binPath .. "/screenshot --area"))
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd(nix.binPath .. "/screenshot --ocr-area"))



------------------------ focus control & groups control ------------------------

hl.bind("ALT + Tab",
    hl.dsp.exec_cmd(
        "hyprctl activewindow -j | jq -e '.grouped | length > 1' && hyprctl dispatch 'hl.dsp.group.next()' || hyprctl dispatch 'hl.dsp.window.cycle_next()'"
    )
)

hl.bind("SUPER + mouse_up",
    hl.dsp.exec_cmd(
        "hyprctl activewindow -j | jq -e '.grouped | length > 1' && hyprctl dispatch 'hl.dsp.group.next()' || hyprctl dispatch 'hl.dsp.window.cycle_next()'"
    )
)

hl.bind("SUPER + mouse_down",
    hl.dsp.exec_cmd(
        "hyprctl activewindow -j | jq -e '.grouped | length > 1' && hyprctl dispatch 'hl.dsp.group.prev()' || hyprctl dispatch 'hl.dsp.window.cycle_next({ next = false })'"
    )
)

hl.bind("SUPER + escape", hl.dsp.focus({ monitor = "+1" }))



------------------------ workspace focus ------------------------

hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))

hl.bind("SUPER + F1", hl.dsp.focus({ workspace = 9 }))
hl.bind("SUPER + F2", hl.dsp.focus({ workspace = 10 }))

hl.bind("SUPER + CTRL + escape",
    function()
        local w = hl.get_active_workspace();

        if not w then return end;

        hl.dispatch(
            hl.dsp.workspace.move({ workspace = w.id, monitor = "+1" })
        )
    end
)



------------------------ window control ------------------------

hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.kill())

hl.bind("SUPER + D", hl.dsp.layout("togglesplit"))

hl.bind("SUPER + T", hl.dsp.group.toggle())
hl.bind("SUPER + SHIFT + T", hl.dsp.group.lock_active({ action = "toggle" }))


hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + SHIFT + P", hl.dsp.window.pin())


hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

hl.bind("SUPER + SHIFT + left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind("SUPER + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })


hl.bind("SUPER + CTRL + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + CTRL + right", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + CTRL + down", hl.dsp.window.move({ direction = "d" }))
hl.bind("SUPER + CTRL + left", hl.dsp.window.move({ direction = "l" }))


hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + SHIFT + F1", hl.dsp.window.move({ workspace = 9 }))
hl.bind("SUPER + SHIFT + F2", hl.dsp.window.move({ workspace = 10 }))

hl.bind("SUPER + SHIFT + escape", hl.dsp.window.move({ monitor = "+1" }))



------------------------ keyboard layout ------------------------

hl.bind("ALT + SHIFT + 1", hl.dsp.exec_cmd(nix.binPath .. "/switch-layout 0"))
hl.bind("ALT + SHIFT + 2", hl.dsp.exec_cmd(nix.binPath .. "/switch-layout 1"))
hl.bind("ALT + SHIFT + 3", hl.dsp.exec_cmd(nix.binPath .. "/switch-layout 2"))



------------------------ functional keys ------------------------

hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

hl.bind("XF86AudioForward", hl.dsp.exec_cmd("playerctl position 5+"))
hl.bind("XF86AudioRewind", hl.dsp.exec_cmd("playerctl position 5-"))


hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(nix.binPath .. "/brightness --dec"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(nix.binPath .. "/brightness --inc"), { repeating = true })


hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(nix.binPath .. "/volume --inc"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(nix.binPath .. "/volume --dec"), { repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(nix.binPath .. "/volume --toggle-mic"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(nix.binPath .. "/volume --toggle"))

hl.bind("F21", hl.dsp.exec_cmd(nix.binPath .. "/volume --toggle-mic"))