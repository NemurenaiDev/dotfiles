DOTFILES_PATH=~/Hyprland

eval "$(thefuck --alias)"


lfcd() {
		rm "/tmp/lf-shellcd-lastdir" "/tmp/lf-shellcd-changecwd" 2>/dev/null
    lf -last-dir-path "/tmp/lf-shellcd-lastdir" -command "source '$HOME/.config/lf/lfrc'" "$@"
    if [ -e "/tmp/lf-shellcd-changecwd" ] && \
				dir="$(cat "/tmp/lf-shellcd-lastdir")" 2>/dev/null; then
				cd "$dir"
    fi
}


alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias vim='nvim'
alias vi='nvim'

alias l='lsd'
alias ll='lsd -lh'
alias lll='lsd -lAh'

alias c='clear'

alias lf='lfcd'
alias brc='nano ~/Hyprland/bashrc'
alias ncdu='ncdu --exclude ".sshfs"'


alias dots-push='git -C "$DOTFILES_PATH" add . && git -C "$DOTFILES_PATH" commit -m update && git -C "$DOTFILES_PATH" push origin master'
alias dots-pull='git -C "$DOTFILES_PATH" pull origin master'

alias dc='docker-compose'

