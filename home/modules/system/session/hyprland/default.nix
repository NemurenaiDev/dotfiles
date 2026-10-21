{
  monitors,
  config,
  pkgs,
  lib,
  ...
}:

{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.configType = "lua";
  wayland.windowManager.hyprland.systemd.enable = false;

  xdg.dataFile."hyprland.stubs.lua".text = ''
    ${lib.readFile "${pkgs.hyprland}/share/hypr/stubs/hl.meta.lua"}

    ---@class Monitors
    ---@field primary string
    ---@field secondaryOrFallback string

    ---@class Nix
    ---@field binPath Path
    ---@field monitors Monitors

    ---@type Nix
    nix = nil


    ---@param str string
    ---@param patterns string[]
    ---@return boolean
    function matches(str, patterns) end
  '';

  wayland.windowManager.hyprland.extraConfig = ''
    nix = {
      binPath = "${config.xdg.dataHome}/bin",

      monitors = {
        primary = "${monitors.primary}",
        secondaryOrFallback = "${monitors.secondary or monitors.primary}",
      },
    }


    function matches(str, patterns)
        for _, pattern in ipairs(patterns) do
            if str:match(pattern) then
                return true
            end
        end

        return false
    end



    ${builtins.readFile ./config.lua}

    ${builtins.readFile ./startup.lua}

    ${builtins.readFile ./others.lua}
    ${builtins.readFile ./wrules.lua}
    ${builtins.readFile ./keybinds.lua}
  '';
}
