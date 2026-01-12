{ pkgs, host, ... }:

let
  gamepad-keybind-daemon-pkg =
    pkgs.writers.writePython3Bin "gamepad-keybind-daemon"
      {
        libraries = [
          pkgs.python3Packages.evdev
          pkgs.python3Packages.pyudev
        ];
      }
      ''
        import sys
        import shlex
        import select
        import subprocess
        from evdev import InputDevice, ecodes, list_devices
        import pyudev


        if len(sys.argv) != 3:
            print("Usage: BUTTON1[,BUTTON2,...] COMMAND")
            sys.exit(1)

        buttons_arg = sys.argv[1]
        command_arg = sys.argv[2]

        BUTTONS = []
        for btn_name in buttons_arg.split(","):
            if btn_name in ecodes.__dict__:
                BUTTONS.append(ecodes.__dict__[btn_name])
            else:
                print(f"Unknown button: {btn_name}")
                sys.exit(1)

        COMMAND = shlex.split(command_arg)


        def is_gamepad_with_buttons(dev):
            try:
                caps = dev.capabilities()
            except OSError:
                return False
            if ecodes.EV_KEY not in caps:
                return False
            for btn in BUTTONS:
                if btn in caps[ecodes.EV_KEY]:
                    return True
            return False


        devices = {}
        for path in list_devices():
            try:
                dev = InputDevice(path)
            except OSError:
                continue
            if is_gamepad_with_buttons(dev):
                devices[dev.fd] = dev
                print(f"Listening on: {dev.path} ({dev.name})")

        context = pyudev.Context()
        monitor = pyudev.Monitor.from_netlink(context)
        monitor.filter_by(subsystem='input')
        monitor.start()
        monitor_fd = monitor.fileno()

        while True:
            rlist = list(devices.values()) + [monitor_fd]
            readable, _, _ = select.select(rlist, [], [])

            for obj in readable:
                if obj == monitor_fd:
                    device_event = monitor.poll(timeout=0)
                    if device_event is None:
                        continue
                    if device_event.action == 'add' and device_event.device_node:
                        try:
                            dev = InputDevice(device_event.device_node)
                        except OSError:
                            continue
                        if is_gamepad_with_buttons(dev):
                            devices[dev.fd] = dev
                            print(f"Plugged: {dev.path} ({dev.name})")
                    elif device_event.action == 'remove':
                        for fd, dev in list(devices.items()):
                            if dev.path == device_event.device_node:
                                print(f"Removed: {dev.path} ({dev.name})")
                                devices.pop(fd, None)
                else:
                    dev = obj
                    try:
                        for event in dev.read():
                            if event.type == ecodes.EV_KEY and event.value == 1:
                                if event.code in BUTTONS:
                                    subprocess.run(COMMAND)
                    except OSError:
                        devices.pop(dev.fd, None)
      '';
  gamepad-keybind-daemon = "${gamepad-keybind-daemon-pkg}/bin/gamepad-keybind-daemon";

  gamepad-mode-key-action-pkg = pkgs.writeShellScriptBin "gamepad-mode-key-action" ''
    pidof steam 2>/dev/null && echo "Steam is already running pid:$(pidof steam)" && exit

    hyprctl dispatch workspace 9 1>/dev/null
    hyprctl dispatch exec "[workspace 9]" "steam -bigpicture" 1>/dev/null

    notify-send -c gaming 'Launching steam...' --icon '/home/${host.username}/.assets/icons/steam.png'
  '';
  gamepad-mode-key-action = "${gamepad-mode-key-action-pkg}/bin/gamepad-mode-key-action";
in
{
  wayland.windowManager.hyprland.settings.exec-once = [
    # Listens for gamepad events (hotplug supported) and launches Steam on BTN_MODE if not running
    "uwsm app -- ${gamepad-keybind-daemon} BTN_MODE ${gamepad-mode-key-action}"
  ];
}
