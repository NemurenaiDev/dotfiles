{ host, lib, ... }:

{
  # tailscale serve --bg --set-path /metrics/node 127.0.0.1:9101/metrics
  services.prometheus.exporters.node.enable = true;
  services.prometheus.exporters.node.port = 9101;

  # tailscale serve --bg --set-path /metrics/gpu 127.0.0.1:9109/metrics
  services.prometheus.exporters.nvidia-gpu.enable = host.gpuVendor == "nvidia";
  services.prometheus.exporters.nvidia-gpu.port = 9109;

  virtualisation.oci-containers.containers =
    lib.optionalAttrs (host.gpuVendor == "amd") {
      amd-gpu-exporter = {
        image = "docker.io/rocm/device-metrics-exporter:v1.5.1";
        ports = [ "9109:5000" ];
        volumes = [
          "/sys/class/drm:/sys/class/drm:ro"
          "/sys/bus/pci:/sys/bus/pci:ro"
        ];
        extraOptions = [
          "--device=/dev/dri"
          "--device=/dev/kfd"
        ];
      };
    }
    // lib.optionalAttrs (host.gpuVendor == "intel") {
      intel-gpu-exporter = {
        image = "docker.io/andrewgolikov55/intel-gpu-exporter:latest";
        ports = [ "9109:9100" ];
        extraOptions = [
          "--pid=host"
          "--privileged"
          "--device=/dev/dri:/dev/dri"
        ];
      };
    };
}
