if status is-interactive
    set -xg DOTFILES_PATH ~/Hyprland
    set -xg VISUAL nvim
    set -xg EDITOR nvim

    source "$DOTFILES_PATH/fish/setenv.fish"

    if test (tty) = "/dev/tty1"
        if not pgrep -x "Hyprland" >/dev/null
            Hyprland
        end
    end


    starship init fish | source

    alias lf='cd $(~/.config/hypr/scripts/lfcd)'

    alias ssh 'kitten ssh'
    alias ls 'ls --color=auto'
    alias grep 'grep --color=auto'
    alias diff 'diff --color=auto'
    alias ip 'ip --color=auto'

    alias vim 'nvim'
    alias vi 'nvim'

    alias l 'lsd'
    alias ll 'lsd -lh'
    alias lll 'lsd -lAh'

    alias c 'clear'

    alias dc 'docker-compose'
    alias dc-start 'dc down && dc build && dc up -d && clear && dc up'


#     function fish_greeting
#         echo "$(pfetch)"
#     end
    functions --erase fish_greeting
end
