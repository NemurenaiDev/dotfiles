{
  programs.kitty = {
    enable = true;
    shellIntegration.mode = null;
    shellIntegration.enableZshIntegration = false;
    shellIntegration.enableBashIntegration = false;
    shellIntegration.enableFishIntegration = false;

    extraConfig = ''
      shell zsh
      font_family JetBrainsMono Nerd Font Mono
      confirm_os_window_close 0
      bold_font auto
      italic_font auto
      bold_italic_font auto
      font_size 12
      cursor_shape block
      repaint_delay 5
      input_delay 1
      sync_to_monitor yes
      enable_audio_bell no
      enabled_layouts splits
      window_padding_width 10
      tab_bar_style separator

      background_opacity 0.4
      dynamic_background_opacity no
      scrollback_lines 10000

      term xterm-256color

      clear_all_shortcuts yes

      map page_up scroll_page_up
      map page_down scroll_page_down
      map ctrl_page_up scroll_home
      map ctrl_page_down scroll_end

      map ctrl+shift+minus change_font_size all -2.0
      map ctrl+shift+equal change_font_size all +2.0

      map ctrl+c copy_or_interrupt
      map ctrl+v paste_from_buffer clipboard

      background #000000
    '';
  };
}
