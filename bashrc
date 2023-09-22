DOTFILES_PATH=~/Hyprland

eval "$(starship init bash)"

lfcd() {
	rm "/tmp/lf-shellcd-lastdir" "/tmp/lf-shellcd-changecwd" 2>/dev/null
    lf -last-dir-path "/tmp/lf-shellcd-lastdir" -command "source '$HOME/.config/lf/lfrc'" "$@"
    if [ -e "/tmp/lf-shellcd-changecwd" ] && \
			dir="$(cat "/tmp/lf-shellcd-lastdir")" 2>/dev/null; then
			cd "$dir"
    fi
}
alias lf='lfcd'


alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'

alias vim='nvim'
alias vi='nvim'

alias l='lsd'
alias ll='lsd -lh'
alias lll='lsd -lAh'

alias c='clear'

alias dc='docker-compose'

alias dots-pull='git -C "$DOTFILES_PATH" pull origin master'
#alias dots-push='git -C "$DOTFILES_PATH" add . && git -C "$DOTFILES_PATH" commit -m update && git -C "$DOTFILES_PATH" push origin master'
dots-push() {
    local commit_message="${1:-minor}"
    git -C "$DOTFILES_PATH" add .
    git -C "$DOTFILES_PATH" commit -m "$commit_message"
    git -C "$DOTFILES_PATH" push origin master
}

export VISUAL=nvim
export EDITOR=nvim
