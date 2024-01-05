if status is-interactive
    set -xg DOTFILES_PATH ~/dotfiles
    set -xg VARIABLES_PATH ~/dotfiles/.variables

    source "$DOTFILES_PATH/[terminal]/fish/setenv.fish"

    if test "$AUTORUN_HYPRLAND" = "true"
        if test (tty) = '/dev/tty1'
            if not pgrep -x 'Hyprland' >/dev/null
                Hyprland
            end
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
    alias ggg 'cd (cat $VARIABLES_PATH/histcd | sort | uniq | fzf -e)'
    alias g 'cd-original "$(cat $VARIABLES_PATH/lastcd)"'

    functions -c cd cd-original
    function cd
        cd-original $argv
        echo "$(pwd)" > "$VARIABLES_PATH/lastcd"
        echo "$(pwd)" >> "$VARIABLES_PATH/histcd"
    end

    function pc
        switch $argv[1]
            case "i"
                pikaur -S --nodiff --noedit $argv[2..-1]
            case "install"
                pikaur -S --nodiff --noedit $argv[2..-1]
            case "remove"
                pikaur -Rns $argv[2..-1]
            case "update"
                sudo pikaur -Syu --nodiff --noedit
            case "search"
                pikaur -Ss $argv[2..-1]
            case "list"
                pikaur -Q | grep "$(string join '\|' $argv[2..-1])"
            case "info"
                pikaur -Qi $argv[2..-1]
            case "clear"
                pikaur -Scc
            case "*"
                echo "Usage: pc [ i | install | remove | update | search | list | info | clear] [packages...]"
        end
    end

    functions --erase fish_greeting
end