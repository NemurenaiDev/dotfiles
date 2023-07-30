import subprocess
import os
import sys

groups = [
    ["us"],
    ["ua", "ru"]
]

variables = os.path.expanduser("~/.config/hypr/scripts/variables/keyboard-layout-status")

try:
    with open(variables, 'r') as file:
        lines = file.readlines()
        currentGroup = int(lines[0].strip())
        currentLayout = int(lines[1].strip())
        lastSelectedLayouts = [int(layout.strip()) for layout in lines[2:]]
        # Ensure lastSelectedLayouts has the same length as groups
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


def set_layout(layout):
    command = f"hyprctl keyword input:kb_layout {layout}"
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error: {e}\nCommand: {e.cmd}\nOutput: {e.output}")


def save_layout_status():
    with open(variables, 'w') as file:
        file.write(f"{currentGroup}\n")
        file.write(f"{currentLayout}\n")
        for layout in lastSelectedLayouts:
            file.write(f"{layout}\n")


if __name__ == "__main__":
    function_name = sys.argv[1]

    if function_name == "init":
        init()
    elif function_name == "next":
        next()
    elif function_name == "next-group":
        next_group()
    else:
        print("Unknown action")
