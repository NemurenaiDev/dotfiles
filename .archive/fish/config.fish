set -xg DOTFILES_PATH ~/.config/dotfiles
set -xg VARIABLES_PATH ~/.config/dotfiles/.variables
set -xg PNPM_HOME /home/yabai/.local/share/pnpm
set -xg VISUAL nano
set -xg EDITOR nano

source "$DOTFILES_PATH/terminal/fish/functions.fish"


alias grep "grep --color=auto"
alias diff "diff --color=auto"
alias ip "ip --color=auto"
alias ls "lsd --group-dirs first"

alias vi "nano"
alias vim "nano"
alias nvim "nano"

alias l "lsd --literal --icon always --color always --group-dirs first"
alias ll "lsd -lh --literal --icon always --color always --group-dirs first --date +%x\ %T"
alias lll "lsd -lAh --literal --icon always --color always --group-dirs first --date +%x\ %T"

alias rm "trash -v"
alias ff "fastfetch"
alias wlcp "wl-copy"
alias ssh "kitten ssh"
alias hypr "hyprctl dispatch"
alias ncdu "ncdu --exclude Remote --exclude /proc --exclude /mnt --exclude /run"
alias hist "history | fzf | tr -d \"\n\" | wl-copy"

alias projadd "$DOTFILES_PATH/scripts/projects add"
alias projrem "$DOTFILES_PATH/scripts/projects rem"

alias thunar "exec thunar . &"
alias codeapi "/usr/bin/code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland"
alias code "/usr/bin/code --new-window --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland"


# if test "$AUTORUN_HYPRLAND" = "true"
    if test (tty) = "/dev/tty1"
        if not pgrep -x "Hyprland" >/dev/null
            clear && Hyprland >/dev/null 2>&1
        end
    end
# end


if status is-interactive
    # starship init fish | source

    alias g "oldcd \"$(cat $VARIABLES_PATH/lastcd)\""
    function gg
        set -l selected_path (cat $VARIABLES_PATH/histcd | sort -u | while read -la line; if test -d "$line"; echo "$line"; end; end | fzf --exact)
        if test -n "$selected_path"
            cd "$selected_path"
        end
    end
    alias ggg "cd (fd --type d --follow -E node_modules -E vendor -E /proc -E /run -E /srv -E /sys -E /lib -E /lib64 -E /sbin -E /bin -E /mnt | fzf --exact)"

    function cd
        oldcd $argv
        echo "$(pwd)" > "$VARIABLES_PATH/lastcd"
        echo "$(pwd)" >> "$VARIABLES_PATH/histcd"
        lsd --literal --group-dirs first
    end
end


if test $("$DOTFILES_PATH/scripts/get-terminal") = "code"
    if test $(pwd) = "$HOME"
        oldcd "$HOME/Projects"
        set -l project (~/.config/dotfiles/scripts/projects get | fzf --ansi --border --margin=30% --preview-window border-left --preview "l (resolve_tilda {})")
        if test "$project" != ""
            oldcd (resolve_tilda "$project")
            codeapi --reuse-window . &>/dev/null
            sleep 1
            echo "Something went wrong if you see this message. This project may already be opened in another instance"
            echo
        end
    else
        if status is-interactive
            cbonsai --live --life=54 --time=0.001 --message="$(hyprctl splash)"
        end
    end
end
