DOTFILES_PATH=~/Hyprland

lfcd() {
        LF_SHELLCD_TEMPDIR="$(mktemp -d -t lf-shellcd-XXXXXX)"
        export LF_SHELLCD_TEMPDIR
        lf -last-dir-path "$LF_SHELLCD_TEMPDIR/lastdir" -command "source '$HOME/.config/lf/lfrc'" "$@"
        if [ -e "$LF_SHELLCD_TEMPDIR/changecwd" ] && \
                dir="$(cat "$LF_SHELLCD_TEMPDIR/lastdir")" 2>/dev/null; then
                cd "$dir"
        fi
        rm -rf "$LF_SHELLCD_TEMPDIR"
        unset LF_SHELLCD_TEMPDIR    
}


alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias vim='nvim'
alias vi='nvim'

alias l='lsd'
alias ll='lsd -lh'
alias lll='lsd -lAh'

alias lf='lfcd'
alias brc='nano ~/.bashrc'
alias ncdu='ncdu --exclude ~/.sshfs'

alias git-push='git add * && git commit -m update && git push origin master'
alias git-pull='git pull origin master'

alias dots-push='git -C "$DOTFILES_PATH" add . && git -C "$DOTFILES_PATH" commit -m update && git -C "$DOTFILES_PATH" push origin master'
alias dots-pull='git -C "$DOTFILES_PATH" pull origin master'
