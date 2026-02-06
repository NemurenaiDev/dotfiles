{ config, ... }:

{
  xdg.configFile."gtk-3.0/bookmarks".force = true;
  xdg.configFile."gtk-3.0/bookmarks".text = ''
    file:/// /
    file://${config.home.homeDirectory} Home
    file://${config.home.homeDirectory}/Downloads Downloads
    file://${config.home.homeDirectory}/Pictures Pictures
    file://${config.home.homeDirectory}/Projects Projects
    
    trash:/// Trash

    sftp://cyberia${config.home.homeDirectory} sftp://cyberia
    sftp://homelab${config.home.homeDirectory} sftp://homelab
    sftp://x14p${config.home.homeDirectory} sftp://x14p
  '';

  dconf.settings = {
    "org/gnome/eog/ui" = {
      statusbar = true;
    };

    "org/nemo/compact-view" = {
      all-columns-have-same-width = false;
      default-zoom-level = "standard";
    };

    "org/nemo/icon-view" = {
      default-zoom-level = "standard";
      labels-beside-icons = false;
    };

    "org/nemo/list-view" = {
      default-column-order = [
        "name"
        "size"
        "type"
        "date_modified"
        "date_created_with_time"
        "date_accessed"
        "date_created"
        "detailed_type"
        "group"
        "where"
        "mime_type"
        "date_modified_with_time"
        "octal_permissions"
        "owner"
        "permissions"
      ];
      default-visible-columns = [ "name" ];
      default-zoom-level = "small";
    };

    "org/nemo/plugins" = {
      disabled-actions = [
        "change-background.nemo_action"
        "set-as-background.nemo_action"
      ];
    };

    "org/nemo/preferences" = {
      date-format = "iso";
      default-folder-viewer = "list-view";
      detect-content = false;
      disable-menu-warning = true;
      ignore-view-metadata = true;
      last-server-connect-method = 0;
      show-compact-view-icon-toolbar = false;
      show-edit-icon-toolbar = false;
      show-full-path-titles = true;
      show-hidden-files = false;
      show-icon-view-icon-toolbar = false;
      show-list-view-icon-toolbar = false;
      start-with-dual-pane = false;
      thumbnail-limit = 10485760;
      tooltips-in-icon-view = true;
      tooltips-in-list-view = true;
      tooltips-on-desktop = true;
      tooltips-show-access-date = false;
      tooltips-show-birth-date = false;
      tooltips-show-file-type = false;
      tooltips-show-mod-date = false;
      tooltips-show-path = true;
    };

    "org/nemo/preferences/menu-config" = {
      background-menu-open-as-root = false;
      background-menu-open-in-terminal = false;
      background-menu-paste = false;
      background-menu-show-hidden-files = false;
      selection-menu-copy = false;
      selection-menu-cut = false;
      selection-menu-favorite = false;
      selection-menu-make-link = true;
      selection-menu-move-to-trash = false;
      selection-menu-open = false;
      selection-menu-open-as-root = false;
      selection-menu-open-in-new-tab = false;
      selection-menu-open-in-new-window = false;
      selection-menu-open-in-terminal = false;
      selection-menu-paste = false;
      selection-menu-pin = false;
      selection-menu-rename = false;
    };

    "org/nemo/sidebar-panels/tree" = {
      show-only-directories = true;
    };

    "org/nemo/window-state" = {
      maximized = true;
      my-computer-expanded = false;
      network-expanded = false;
      side-pane-view = "places";
      sidebar-bookmark-breakpoint = 0;
      sidebar-width = 181;
      start-with-menu-bar = true;
      start-with-sidebar = true;
      start-with-status-bar = false;
    };
  };
}
