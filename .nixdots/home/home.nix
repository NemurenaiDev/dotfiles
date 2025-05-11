{
  config,
  pkgs,
  host,
  ...
}:

let
  sessionVariables = {
    KEYBOARD = "at-translated-set-2-keyboard";

    HYPRCURSOR_THEME = "catppuccin-mocha-dark-cursors";
    HYPRCURSOR_SIZE = "18";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_DRM_NO_ATOMIC = "1";
  };
in
{
  home.stateVersion = host.stateVersion;
  home.sessionVariables = sessionVariables;
  home.username = host.username;
  home.homeDirectory = "/home/${host.username}";

  imports = [ ./modules ];

  gtk.enable = true;

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "maroon";
    gtk.enable = true;
  };

  #   xdg.configFile = {
  #     "Kvantum/kvantum.kvconfig".text = ''
  #       [General]
  #       theme=catppuccin-mocha-maroon
  #     '';

  #     # "Kvantum/Catppuccin-Mocha-Maroon".source =
  #     #   "${pkgs.catppuccin-kvantum}/share/Kvantum/Catppuccin-Mocha-Maroon";
  #   };

}
