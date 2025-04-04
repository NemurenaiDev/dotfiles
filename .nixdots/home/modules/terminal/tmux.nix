{
  programs.tmux = {
    enable = true;
    newSession = true;

    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -g mouse off

      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      set -g prefix M-Space


      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'tmux-plugins/tmux-resurrect'
      set -g @plugin 'tmux-plugins/tmux-yank'
      
      set -g @catppuccin_flavour 'mocha'
      set -g @plugin 'dreamsofcode-io/catppuccin-tmux'

      run '~/.tmux/plugins/tpm/tpm'


      bind M-Space send-prefix

      bind -n F2 command-prompt "rename-window %%"
      bind -n S-F2 command-prompt "rename-session %%"

      bind -n C-h send-keys C-w

      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      bind -n M-S-Left resize-pane -L 5
      bind -n M-S-Right resize-pane -R 5
      bind -n M-S-Up resize-pane -U 2
      bind -n M-S-Down resize-pane -D 2

      bind -n M-q kill-pane

      bind -n M-Q switch-client -p
      bind -n M-E switch-client -n

      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      bind -n M-[ split-window -v -c "#{pane_current_path}"
      bind -n M-] split-window -h -c "#{pane_current_path}"
    '';
  };
}
