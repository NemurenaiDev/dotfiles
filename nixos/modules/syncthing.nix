{
  lib,
  hosts,
  host,
  ...
}:

let
  otherHosts = lib.filter (h: h.hostname != host.hostname) hosts;
  userOtherHosts = lib.filter (h: h.username == host.username) otherHosts;

  # otherDeviceNames = lib.map (host: host.hostname) otherHosts;
  userOtherDeviceNames = lib.map (host: host.hostname) userOtherHosts;

  otherDevices = lib.listToAttrs (
    lib.map (host: {
      name = host.hostname;
      value = {
        id = host.deviceId;
      };
    }) otherHosts
  );

  basefolder = {
    fsWatcherEnabled = true;
    fsWatcherDelayS = 1;
    fsWatcherTimeoutS = 0;
  };
in
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;

    user = host.username;
    dataDir = "/home/${host.username}/.cache/syncthing";
    extraFlags = [ "--no-browser" ];

    settings = {
      # fix the infinite crash loop issue: https://github.com/syncthing/syncthing/issues/10611
      options.listenAddresses = [ "tcp://:22000" ];

      devices = otherDevices;
      folders = {

        ".ssh" = basefolder // {
          path = "/home/${host.username}/.ssh";
          devices = userOtherDeviceNames;
        };

        ".config" = basefolder // {
          path = "/home/${host.username}/.config";
          devices = userOtherDeviceNames;
          ignorePatterns = [
            "!haruna"

            "!onlyoffice"

            "!deluge/ui.conf"
            "!deluge/core.conf"
            "!deluge/gtk3ui.conf"
            "!deluge/plugins"

            "!mimeapps.list"

            "*"
          ];
        };

        "Projects" = basefolder // {
          path = "/home/${host.username}/Projects";
          devices = userOtherDeviceNames;
          ignorePatterns = [
            # Garbage
            "logs/"
            "Logs/"
            "*.log"
            "*.tmp"
            "*.bak"

            # Builds
            "out/"
            "dist/"
            "build/"
            "target/"
            "bin/"
            "go.sum"
            "*.out"
            "*.exe"
            "*.dll"
            "*.so"
            "*.a"
            "*.o"

            # Javascript / Typescript
            "node_modules/"
            ".next/"
            ".nuxt/"
            ".yarn/"
            ".cache/"
            ".turbo/"
            ".parcel-cache/"

            # Python
            "__pycache__/"
            "*.pyc"
            ".venv/"
            "venv/"

            # Go
            "pkg/"
            "vendor/"
          ];
        };

      };
    };
  };
}
