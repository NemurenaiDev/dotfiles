import subprocess
import json
import os
import sys

groups = [
    ["us"],
    ["ua", "ru"]
]

variables = os.path.expanduser("/tmp/keyboard-layout-status")

try:
    with open(variables, 'r') as file:
        lines = file.readlines()
        currentGroup = int(lines[0].strip())
        currentLayout = int(lines[1].strip())
        lastSelectedLayouts = [int(layout.strip()) for layout in lines[2:]]
        lastSelectedLayouts.extend([0] * (len(groups) - len(lastSelectedLayouts)))
except Exception as e:
    currentGroup = 0
    currentLayout = 0
    lastSelectedLayouts = [0] * len(groups)


def init():
    global currentGroup, currentLayout
    currentGroup = 0
    currentLayout = lastSelectedLayouts[currentGroup]
    set_layout(groups[currentGroup][currentLayout])
    save_layout_status()


def get():
    print(groups[currentGroup][currentLayout].upper())


def next():
    global currentGroup, currentLayout
    currentLayout = (currentLayout + 1) % len(groups[currentGroup])
    set_layout(groups[currentGroup][currentLayout])
    save_layout_status()


def next_group():
    global currentGroup, currentLayout
    lastSelectedLayouts[currentGroup] = currentLayout
    currentGroup = (currentGroup + 1) % len(groups)
    currentLayout = lastSelectedLayouts[currentGroup]
    set_layout(groups[currentGroup][currentLayout])
    save_layout_status()


def shell_exec(command):
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        return result.stdout
    except subprocess.CalledProcessError as e:
        return f"Error: {e}\nCommand: {e.cmd}\nOutput: {e.output}"


def get_keyboard_names():
    try:
        command_output = subprocess.check_output(["hyprctl", "-j", "devices"])
        device_info = json.loads(command_output)
        return [keyboard.get("name") for keyboard in device_info.get("keyboards", [])]

    except subprocess.CalledProcessError as e:
        print(f"Error executing hyprctl: {e}")
        return []


def set_layout(layout):
    shell_exec(f"hyprctl keyword input:kb_layout us,{layout}")
    try:
        keyboard_names = get_keyboard_names()
        for keyboard_name in keyboard_names:
            shell_exec(f"hyprctl switchxkblayout {keyboard_name} 1")
    except subprocess.CalledProcessError as e:
        print(f"Error executing hyprctl: {e}")


def save_layout_status():
    with open(variables, 'w') as file:
        file.write(f"{currentGroup}\n")
        file.write(f"{currentLayout}\n")
        for layout in lastSelectedLayouts:
            file.write(f"{layout}\n")


if __name__ == "__main__":
    action = sys.argv[1]

    if action == "init":
        init()
    elif action == "get":
        get()
    elif action == "next":
        next()
    elif action == "next-group":
        next_group()
    else:
        print("Unknown action")
