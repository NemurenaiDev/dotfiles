{ config, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      export VISUAL="nano"
      export EDITOR="nano"
      export PATH="$PATH:$(yarn global bin)"
      export NODE_PATH="${config.home.homeDirectory}/.npm-packages/lib/node_modules"

      who am i | grep tty1 && uwsm check may-start && uwsm start default


      if [ ! "$HYPRLAND_INSTANCE_SIGNATURE" ]; then;
          if [ "$(ps -a | grep -e Hyprland)" ]; then
              if [ -f /tmp/HyprlandInstanceSignature ]; then
                export HYPRLAND_INSTANCE_SIGNATURE="$(cat /tmp/HyprlandInstanceSignature)"
              fi
          fi
      fi


      toggle-sudo() {
          if [[ $BUFFER == sudo\ * ]]; then
              BUFFER="''${BUFFER#sudo }"
          else
              BUFFER="sudo $BUFFER"
          fi
          zle end-of-line
      }
      zle -N toggle-sudo

      get-terminal-name() {
          ps -o comm= -p "$(($(ps -o ppid= -p "$(($(ps -o sid= -p "$$")))")))"
      }

      lastcd() {
          cd "$@" && lsd --literal --icon always --color always --group-dirs first
          echo "$(pwd)" > ${config.home.homeDirectory}/.cache/lastcd
      }

      ssh() {
          if [[ "$(get-terminal-name)" == "kitty" ]]; then
              kitten ssh "$@"
          else
              /bin/ssh "$@"
          fi
      }


      autoload -U select-word-style
      select-word-style bash
      setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_ignore_dups hist_save_no_dups

      zstyle ":completion:*" menu select
      zstyle ":completion:*" use-cache on
      zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
      zstyle ":completion:*" list-colors "''${(s.:.)LS_COLORS}"

      bindkey "^f" autosuggest-accept
      bindkey "^[s" toggle-sudo

      bindkey "^[[A" history-search-backward
      bindkey "^[[B" history-search-forward

      bindkey "^[[3;5~" kill-word
      bindkey "^H" backward-kill-word
      bindkey "^[[3~" delete-char

      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;5C" forward-word
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line

      bindkey "^Z" undo
      bindkey "^Y" redo


      alias vi="nano" vim="nano" nvim="nano"

      alias kitty="kitty --single-instance"

      alias l="lsd --literal --icon always --color always --group-dirs first --date +%x\ %T"
      alias ls="lsd --literal --icon always --color always --group-dirs first --date +%x\ %T"
      alias ll="lsd --literal --icon always --color always --group-dirs first --date +%x\ %T -lh"
      alias lll="lsd --literal --icon always --color always --group-dirs first --date +%x\ %T -lAh"
      alias watch="CLICOLOR_FORCE=1 watch -c"

      alias cd="lastcd"
      alias rm="trash -v"
      alias ff="fastfetch"
      alias wlcp="wl-copy"
      alias hist="history 0 | fzf | tr -d "\n" | wl-copy"
      alias ncdu="ncdu --exclude Remote --exclude /proc --exclude /run --exclude /mnt --exclude /home/yabai/Library"

      alias g="git"
      alias gst="git status"
      alias ga="git add"
      alias gaa="git add ."
      alias gc="git commit -m"
      alias gp="git push"
      alias gpo="git push origin"


      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"
      eval "$(oh-my-posh init zsh --config ${config.home.homeDirectory}/.config/ohmyposh.toml)"
    '';
  };
}
