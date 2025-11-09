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
in
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;

    user = host.username;
    dataDir = "/home/${host.username}/.cache/syncthing";
    extraFlags = [ "--no-browser" ];

    settings = {
      devices = otherDevices;
      folders = {

        ".ssh" = {
          path = "/home/${host.username}/.ssh";
          devices = userOtherDeviceNames;
        };

        "Projects" = {
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

            # Unity
            "PackageCache/"
            "Library/"

            # Go
            "pkg/"
            "vendor/"
          ];
        };

      };
    };
  };
}
