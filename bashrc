DOTFILES_PATH=~/Hyprland

eval "$(starship init bash)"


alias lf='cd $(~/.config/hypr/scripts/lfcd.sh)'


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
alias dc-start='dc down && dc build && dc up -d && clear && dc up'

alias dots-pull='git -C "$DOTFILES_PATH" pull origin master'
dots-push() {
    local commit_message="${1:-minor}"
    git -C "$DOTFILES_PATH" add .
    git -C "$DOTFILES_PATH" commit -m "$commit_message"
    git -C "$DOTFILES_PATH" push origin master
}

export VISUAL=nvim
export EDITOR=nvim

