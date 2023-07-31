import subprocess
import os
import sys

groups = [
    ["us"],
    ["ua", "ru"]
]

variables = os.path.expanduser("~/.config/hypr/scripts/variables/keyboard-layout-status")
kb_name_file = os.path.expanduser("~/.config/hypr/scripts/variables/keyboard-layout-kb-name")

try:
    with open(variables, 'r') as file:
        lines = file.readlines()
        currentGroup = int(lines[0].strip())
        currentLayout = int(lines[1].strip())
        lastSelectedLayouts = [int(layout.strip()) for layout in lines[2:]]
        lastSelectedLayouts.extend([0] * (len(groups) - len(lastSelectedLayouts)))
    with open(kb_name_file, 'r') as file:
        kb_name = str(file.readline())
except Exception as e:
    currentGroup = 0
    currentLayout = 0
    lastSelectedLayouts = [0] * len(groups)
    kb_name = ""


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

def set_layout(layout):
    shell_exec(f"hyprctl keyword input:kb_layout us,{layout}")
    shell_exec(f"hyprctl switchxkblayout {kb_name} 1")


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
