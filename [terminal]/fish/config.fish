if status is-interactive
    set -xg DOTFILES_PATH ~/dotfiles
    set -xg VARIABLES_PATH ~/dotfiles/.variables

    source "$DOTFILES_PATH/[terminal]/fish/setenv.fish"

    if test "$AUTORUN_HYPRLAND" = "true"
        if test (tty) = '/dev/tty1'
            if not pgrep -x 'Hyprland' >/dev/null
                clear && Hyprland >/dev/null 2>&1
            end
        end
    end

    starship init fish | source


    alias ls 'ls --color=auto'
    alias grep 'grep --color=auto'
    alias diff 'diff --color=auto'
    alias ip 'ip --color=auto'
    alias ssh 'kitten ssh'
    alias rm 'trash -v'

    alias vim 'nvim'
    alias vi 'nvim'

    alias jetbra 'notify-send "Jetbra command ran" && sudo ~/.config/dotfiles/scripts/jetbra'

    alias l 'lsd --group-dirs first'
    alias ll 'lsd -lh --group-dirs first'
    alias lll 'lsd -lAh --group-dirs first'

    alias gr 'cd /'
    alias gc 'cd ~/.config'
    alias gd 'cd ~/Downloads'
    alias gp 'cd ~/Projects'

    alias g 'cd-original "$(cat $VARIABLES_PATH/lastcd)"'
    alias gg 'cd (fd --type d --follow -E node_modules -E vendor -E /proc -E /run -E /srv -E /sys -E /lib -E /lib64 -E /sbin -E /bin -E /mnt | fzf --exact)'

    function ggg
        set -l selected_path (cat $VARIABLES_PATH/histcd | sort -u | while read -la line; if test -d "$line"; echo "$line"; end; end | fzf --exact)
        if test -n "$selected_path"
            cd "$selected_path"
        end
    end

    functions -c cd cd-original
    function cd
        cd-original $argv
        echo "$(pwd)" > "$VARIABLES_PATH/lastcd"
        echo "$(pwd)" >> "$VARIABLES_PATH/histcd"
    end

    function pc
        switch $argv[1]
            case "i" "install"
                pikaur -S --nodiff --noedit $argv[2..-1]
            case "remove" "r"
                pikaur -Rns $argv[2..-1]
            case "update" "u"
                sudo pikaur -Syu --nodiff --noedit && jetbra
            case "search" "s"
                pikaur -Ss $argv[2..-1]
            case "list" "ls"
                pikaur -Q | grep (string join \| $argv[2..-1])
            case "info" "i"
                pikaur -Qi $argv[2..-1]
            case "clear"
                pikaur -Scc
            case "*"
                echo "Usage: pc [(i|install) | (r|remove) | (u|update) | (s|search) | (ls|list) | info | clear] [packages...]"
        end
    end

    functions --erase fish_greeting
end

# pnpm
set -gx PNPM_HOME "/home/yabai/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
