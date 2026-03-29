{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    dotDir = "${config.xdg.configHome}/zsh";

    completionInit = ''
      [[ $PERF == 1 ]] && zmodload zsh/datetime
      [[ $PERF == 1 ]] && start=$EPOCHREALTIME
      [[ $PERF == 1 ]] && zmodload zsh/zprof


      if [ "$(tty)" = "/dev/tty1" ]; then
        exec sh -c '
          ${pkgs.jp2a}/bin/jp2a --term-fit --term-zoom --term-center "${config.xdg.dataHome}/assets/wallpapers/frieren-sleeps-for-ascii.png"

          exec uwsm start -e -N Hyprland -D Hyprland ${pkgs.hyprland}/bin/start-hyprland > /dev/null 2>&1
        '
      fi


      if [ ! -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then;
          if [ -f /tmp/HYPRLAND_INSTANCE_SIGNATURE ]; then
            export HYPRLAND_INSTANCE_SIGNATURE="$(cat /tmp/HYPRLAND_INSTANCE_SIGNATURE)"
          fi
      fi


      autoload -U compinit && compinit
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

      get-terminal-name() {
        ps -o comm= -p "$(($(ps -o ppid= -p "$(($(ps -o sid= -p "$$")))")))"
      }

      update-history() {
        builtin fc -AI
      }

      list-dir() {
        lsd --almost-all --literal --icon always --color always --group-dirs first --date "+%x %T" "$@"
      }

      use() {
        if [ -z "$1" ]; then
          echo "Usage: use <package> [args...]"
          return 1
        fi

        USEPKGS="$USEPKGS $1" nix shell --impure "nixpkgs#$1" "''${@:2}"
      }

      dev() {
        nix develop
      }

      gs() {
        local server
        server=$(grep -E '^Host ' ~/.ssh/config | awk '$2 != "*" {print $2}' | fzf --height=10 --min-height=2 --layout=reverse --preview-window=border-left --preview "sed -n '/^Host {}$/,/^Host /p' ~/.ssh/config | head -n -1")
        if [[ -n $server ]]; then
          ssh $server
        fi
      }

      at() {
        local session

        session=$(
          FZF_DEFAULT_COMMAND="zellij list-sessions" \
            fzf \
              --ansi --height=10 --min-height=2 --layout=reverse \
              --header="Press Enter to attach or Del to kill session" \
              --bind 'del:execute-silent(zellij delete-session --force "$(echo {} | sed "s/ \[.*//")")+reload(eval $FZF_DEFAULT_COMMAND)'
        )

        if [[ -n "$session" ]]; then
          zellij attach "$(printf "%s\n" "$session" | sed "s/ \[.*//")"
        fi
      }

      zs() {
        zellij attach --create "$(sed "s|$HOME/||g; s|/| > |g" <<< "$PWD")"
      }

      fzf-history-widget() {
        local selected
        selected="$(history 0 | tac | fzf --ansi --height=10 --min-height=2 --query="$LBUFFER")" || return
        LBUFFER="$(echo "$selected" | sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//')"
        zle reset-prompt
      }

      edit-command-line-editor() {
        VISUAL=$EDITOR zle edit-command-line
      }



      autoload -Uz select-word-style
      autoload -Uz edit-command-line
      autoload -Uz add-zsh-hook

      select-word-style bash

      zle -N toggle-sudo
      zle -N fzf-history-widget
      zle -N edit-command-line
      zle -N edit-command-line-editor

      add-zsh-hook chpwd list-dir
      add-zsh-hook precmd update-history



      HISTSIZE="5000"
      SAVEHIST="5000"


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


      bindkey "^[s" toggle-sudo
      bindkey "^f" autosuggest-accept
      bindkey "^r" fzf-history-widget
      bindkey '^e' edit-command-line-editor

      bindkey "^[[3~" delete-char
      bindkey "^[[3;5~" kill-word
      bindkey "^H" backward-kill-word

      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;5C" forward-word
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line

      bindkey "^Z" undo
      bindkey "^Y" redo



      alias reload="source $ZDOTDIR/.zshrc"

      alias kitty="kitty --single-instance"

      alias l="list-dir --hyperlink auto"
      alias ls="list-dir --hyperlink auto"
      alias ll="list-dir --hyperlink auto -Ah"
      alias lll="list-dir --hyperlink auto -lAh"

      alias rm="trash -v"
      alias hist="history 0 | tac | fzf | sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//' | wl-copy -n"
      alias ncdu="ncdu --exclude Remote --exclude /proc --exclude /run --exclude /mnt --exclude /home/yabai/Library"

      alias vimv="vimv"
      alias rename="vimv"

      alias sw="sudo -v && nh os switch && nh home switch"
      alias swu="sudo -v && nh os switch -u && nh home switch"
      alias hms="nh home switch"

      alias ff="fastfetch"
      alias wlcp="wl-copy -n"

      alias dc="docker compose"

      alias g="git"
      alias gst="git status"
      alias ga="git add"
      alias gaa="git add ."
      alias gc="git commit -m"
      alias gp="git push"
      alias gpo="git push origin"



      eval "$(zoxide init --cmd cd zsh)"
      eval "$(starship init zsh)"



      if [ -n "$USEPKGS" ]; then
        USEPKG_PATHS=("''${(@s/:/)PATH}")
        USEPKG_CURR="''${USEPKG_PATHS[1]}"

        if [ "$USEPKG_CURR" != "$USEPKG_PREV" ]; then
          export USEPKG_PREV="$USEPKG_CURR"
          
          list-dir --tree --hyperlink auto --blocks size,name "$USEPKG_CURR"
        fi
      fi



      [[ $PERF == 1 ]] && zprof
      [[ $PERF == 1 ]] && end=$EPOCHREALTIME
      [[ $PERF == 1 ]] && echo "ENTIRE .zshrc LOADED IN: $(echo "$end - $start" | bc)s"
    '';
  };
}
