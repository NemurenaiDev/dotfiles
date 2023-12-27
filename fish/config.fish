if status is-interactive
    set -xg DOTFILES_PATH ~/Hyprland
    set -xg VARIABLES_PATH ~/Hyprland/scripts/variables
    set -xg VISUAL nvim
    set -xg EDITOR nvim

    source "$DOTFILES_PATH/fish/setenv.fish"

    if test (tty) = '/dev/tty1'
        if not pgrep -x 'Hyprland' >/dev/null
            Hyprland
        end
    end


    starship init fish | source

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


    alias gr 'cd /'
    alias gm 'cd /mnt'
    alias ge 'cd /etc'
    alias go 'cd /opt'
    alias gu 'cd /usr'

    alias gh 'cd ~'
    alias gc 'cd ~/.config'
    alias gd 'cd ~/Downloads'
    alias gp 'cd ~/Projects'


    alias ff 'wl-copy (fd --type f --follow -E node_modules -E vendor -E /proc -E /run -E /srv -E /sys -E /lib -E /lib64 -E /sbin -E /bin -E /mnt | fzf -e)'
    alias gg 'cd (fd --type d --follow -E node_modules -E vendor -E /proc -E /run -E /srv -E /sys -E /lib -E /lib64 -E /sbin -E /bin -E /mnt | fzf -e)'
    alias ggg 'cd (cat $VARIABLES_PATH/histcd | fzf -e)'
    alias g "cdoriginal '$(cat $VARIABLES_PATH/lastcd)'"

    functions -c cd cdoriginal
    function cd
        cdoriginal $argv
        echo "$(pwd)" > "$VARIABLES_PATH/lastcd"
        echo "$(pwd)" >> "$VARIABLES_PATH/histcd"
    end

    functions --erase fish_greeting
end
