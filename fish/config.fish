if status is-interactive
    set -xg DOTFILES_PATH ~/Hyprland
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


    function dots-pull
        git -C "$DOTFILES_PATH" pull origin master
    end

    function dots-push
        set -q commit_message $argv[1]; or set commit_message "minor"
        git -C "$DOTFILES_PATH" add .
        git -C "$DOTFILES_PATH" commit -m "$commit_message"
        git -C "$DOTFILES_PATH" push origin master
    end



    set -xg VISUAL nvim
    set -xg EDITOR nvim


#     function fish_greeting
#         echo "$(pfetch)"
#     end
    functions --erase fish_greeting
end
