{
  programs.btop = {
    enable = true;

    extraConfig = ''
      color_theme = "catppuccin_mocha"
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

      disks_filter = "exclude=/nix/store"
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
}
