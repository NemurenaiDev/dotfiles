{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    completionInit = ''
      [[ $PERF == 1 ]] && zmodload zsh/datetime
      [[ $PERF == 1 ]] && start=$EPOCHREALTIME
      [[ $PERF == 1 ]] && zmodload zsh/zprof


      # WARNING: "compinit -d" may be a security risk when your system is multi-user with untrusted users
      autoload -U compinit && compinit -d ~/.cache/zcompdump -C
    '';

    initContent = ''
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

      update-history() {
        builtin fc -AI
      }

      list-dir() {
        lsd --literal --icon always --color always --group-dirs first --date "+%x %T" "$@"
      }

      use() {
        if [ -z "$1" ]; then
          echo "Usage: use <package>"
          return 1
        fi

        nix shell "nixpkgs#$1"
      }


      if who am i | grep tty1; then
          clear && uwsm -v && exec sh -c "uwsm start default || uwsm start select" &>/dev/null
      fi

      if [ ! "$HYPRLAND_INSTANCE_SIGNATURE" ]; then;
          if [ "$(ps -a | grep -e Hyprland)" ]; then
              if [ -f /tmp/HyprlandInstanceSignature ]; then
                export HYPRLAND_INSTANCE_SIGNATURE="$(cat /tmp/HyprlandInstanceSignature)"
              fi
          fi
      fi


      autoload -Uz select-word-style

      select-word-style bash

      autoload -Uz add-zsh-hook

      add-zsh-hook chpwd list-dir
      add-zsh-hook precmd update-history

      HISTSIZE="2500"
      SAVEHIST="2500"

      setopt INC_APPEND_HISTORY
      setopt SHARE_HISTORY
      setopt HIST_EXPIRE_DUPS_FIRST
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_REDUCE_BLANKS
      setopt HIST_VERIFY

      zstyle ":completion:*" completer _extensions _complete #_approximate
      zstyle ":completion:*" menu select
      zstyle ":completion:*:*:*:*:descriptions" format "%F{green}-- %d --%f"
      zstyle ":completion:*" group-name ""
      zstyle ":completion:*:*:-command-:*:*" group-order alias builtins functions commands
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


      alias reload="source ~/.zshrc"

      alias kitty="kitty --single-instance"

      alias l="list-dir"
      alias ls="list-dir"
      alias ll="list-dir -lh"
      alias lll="list-dir -lAh"
      alias watch="CLICOLOR_FORCE=1 watch -c"

      alias rm="trash -v"
      alias hist="history 0 | fzf | sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//' | wl-copy -n"
      alias ncdu="ncdu --exclude Remote --exclude /proc --exclude /run --exclude /mnt --exclude /home/yabai/Library"

      alias os="nh os"
      alias oss="sudo -v && nh os switch"
      alias hm="nh home"
      alias hms="nh home switch"
      alias sw="sudo -v && nh os switch && nh home switch"
      alias swu="sudo -v && nh os switch -u && nh home switch"

      alias ff="fastfetch"
      alias wlcp="wl-copy -n"

      alias g="git"
      alias gst="git status"
      alias ga="git add"
      alias gaa="git add ."
      alias gc="git commit -m"
      alias gp="git push"
      alias gpo="git push origin"


      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"
      eval "$(starship init zsh)"


      [[ $PERF == 1 ]] && zprof
      [[ $PERF == 1 ]] && end=$EPOCHREALTIME
      [[ $PERF == 1 ]] && echo "ENTIRE .zshrc LOADED IN: $(echo "$end - $start" | bc)s"
    '';
  };
}
