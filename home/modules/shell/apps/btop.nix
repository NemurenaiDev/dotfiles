{ config, ... }:

{
  programs.btop = {
    enable = true;

    extraConfig = ''
      color_theme = "${config.home.homeDirectory}/.config/btop/catppuccin.mocha.theme"
      log_level = "WARNING"
      theme_background = False
      truecolor = True
      force_tty = False
      vim_keys = False
      rounded_corners = True
      update_ms = 1000

      graph_symbol = "braille"
      graph_symbol_cpu = "default"
      graph_symbol_gpu = "default"
      graph_symbol_mem = "default"
      graph_symbol_net = "default"
      graph_symbol_proc = "default"

      shown_boxes = "cpu mem net proc"
      presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty"

      proc_sorting = "cpu lazy"
      proc_reversed = False
      proc_tree = False
      proc_colors = True
      proc_gradient = True
      proc_per_core = False
      proc_mem_bytes = True
      proc_cpu_graphs = True
      proc_info_smaps = False
      proc_left = False
      proc_filter_kernel = False
      proc_aggregate = False

      cpu_graph_upper = "Auto"
      cpu_graph_lower = "Auto"
      cpu_invert_lower = False
      cpu_single_graph = False
      cpu_bottom = False
      cpu_sensor = "Auto"
      cpu_core_map = ""

      check_temp = True
      show_uptime = True
      show_coretemp = True
      temp_scale = "celsius"
      base_10_sizes = False
      show_cpu_freq = True
      clock_format = "%X"
      background_update = True
      custom_cpu_name = ""

      show_gpu_info = "Auto"
      gpu_mirror_graph = True
      custom_gpu_name0 = ""
      custom_gpu_name1 = ""
      custom_gpu_name2 = ""
      custom_gpu_name3 = ""
      custom_gpu_name4 = ""
      custom_gpu_name5 = ""

      disks_filter = ""
      mem_graphs = False
      mem_below_net = False
      zfs_arc_cached = True
      show_swap = True
      swap_disk = False
      show_disks = True
      only_physical = True
      use_fstab = False
      zfs_hide_datasets = False
      disk_free_priv = False
      nvml_measure_pcie_speeds = True

      show_io_stat = False
      io_mode = False
      io_graph_combined = False
      io_graph_speeds = ""

      net_download = 100
      net_upload = 100
      net_auto = True
      net_sync = True
      net_iface = ""

      show_battery = True
      selected_battery = "Auto"
      show_battery_watts = True
    '';
  };

  home.file.".config/btop/catppuccin.mocha.theme".force = true;
  home.file.".config/btop/catppuccin.mocha.theme".text = ''
    theme[main_bg]="#1E1E2E"
    theme[main_fg]="#CDD6F4"
    theme[title]="#CDD6F4"
    theme[hi_fg]="#89B4FA"
    theme[selected_bg]="#45475A"
    theme[selected_fg]="#89B4FA"
    theme[inactive_fg]="#7F849C"
    theme[graph_text]="#F5E0DC"
    theme[meter_bg]="#45475A"
    theme[proc_misc]="#F5E0DC"

    theme[cpu_box]="#cba6f7" #Mauve
    theme[mem_box]="#a6e3a1" #Green
    theme[net_box]="#eba0ac" #Maroon
    theme[proc_box]="#89b4fa" #Blue

    theme[div_line]="#6C7086"

    theme[temp_start]="#a6e3a1"
    theme[temp_mid]="#f9e2af"
    theme[temp_end]="#f38ba8"

    theme[cpu_start]="#94e2d5"
    theme[cpu_mid]="#74c7ec"
    theme[cpu_end]="#b4befe"

    theme[free_start]="#cba6f7"
    theme[free_mid]="#b4befe"
    theme[free_end]="#89b4fa"

    theme[cached_start]="#74c7ec"
    theme[cached_mid]="#89b4fa"
    theme[cached_end]="#b4befe"

    theme[available_start]="#fab387"
    theme[available_mid]="#eba0ac"
    theme[available_end]="#f38ba8"

    theme[used_start]="#a6e3a1"
    theme[used_mid]="#94e2d5"
    theme[used_end]="#89dceb"

    theme[download_start]="#fab387"
    theme[download_mid]="#eba0ac"
    theme[download_end]="#f38ba8"

    theme[upload_start]="#a6e3a1"
    theme[upload_mid]="#94e2d5"
    theme[upload_end]="#89dceb"

    theme[process_start]="#74C7EC"
    theme[process_mid]="#89DCEB"
    theme[process_end]="#cba6f7"
  '';
}
