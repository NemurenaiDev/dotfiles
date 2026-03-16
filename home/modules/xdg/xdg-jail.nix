{
  config,
  host,
  pkgs,
  lib,
  ...
}:

let
  homedir = config.home.homeDirectory;

  jail-soft = ".local/xdg-jail/soft";
  jail-bwrap = ".local/xdg-jail/bwrap";

  enjail-soft =
    pkg: bin:
    (pkgs.symlinkJoin {
      name = "${pkg.name}-enjailed-${host.username}";
      paths = [ pkg ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/${bin} \
          --run "
            cd ${homedir}/${jail-soft}
            export HOME=${homedir}/${jail-soft}
            exec $out/bin/.${bin}-wrapped \"\$@\"
          "
      '';
    });

  enjail-bwrap =
    pkg: bin:
    (pkgs.symlinkJoin {
      name = "${pkg.name}-enjailed-${host.username}";
      paths = [ pkg ];
      buildInputs = [
        pkgs.makeWrapper
        pkgs.bubblewrap
      ];
      postBuild = ''
        wrapProgram $out/bin/${bin} \
          --prefix PATH : ${pkgs.bubblewrap}/bin \
          --run "
            exec ${pkgs.bubblewrap}/bin/bwrap \
              --bind / / \
              \
              --dev /dev \
              --proc /proc \
              \
              --bind ${homedir}/${jail-bwrap} ${homedir} \
              --bind ${homedir} ${homedir}/HOME \
              --bind ${homedir}/.cache ${homedir}/.cache \
              --bind ${homedir}/.config ${homedir}/.config \
              --bind ${homedir}/.local ${homedir}/.local \
              --bind-try ${homedir}/Desktop ${homedir}/Desktop \
              --bind-try ${homedir}/Downloads ${homedir}/Downloads \
              --bind-try ${homedir}/Pictures ${homedir}/Pictures \
              --bind-try ${homedir}/Projects ${homedir}/Projects \
              \
              --die-with-parent \
              \
              $out/bin/.${bin}-wrapped \"\$@\"
          "
      '';
    });
in
{
  home.activation."link-xdg-jail-to-home" = lib.hm.dag.entryAnywhere ''
    ${pkgs.coreutils}/bin/mkdir -p ${homedir}/${jail-bwrap}
    ${pkgs.coreutils}/bin/mkdir -p ${homedir}/${jail-soft}

    ${pkgs.coreutils}/bin/ln -sfn "${homedir}/.config" "${homedir}/${jail-soft}/.config"
    ${pkgs.coreutils}/bin/ln -sfn "${homedir}/.local" "${homedir}/${jail-soft}/.local"
    ${pkgs.coreutils}/bin/ln -sfn "${homedir}/.cache" "${homedir}/${jail-soft}/.cache"
  '';

  home.activation."mv-to-xdg-jail" = lib.hm.dag.entryAfter [ "link-xdg-jail-to-home" ] ''
    mv-to-jail() {
      if [ -e "$1" ]; then
        if [ ! -e "$2" ]; then
          ${pkgs.coreutils}/bin/mv "$1" "$2"
        else
          ${pkgs.coreutils}/bin/mv "$1" "${homedir}/ALREADY-IN-JAIL-$(date +%s)--$(basename "$1")"
        fi
      fi
    }

    mv-to-jail "${homedir}/.pki" "${homedir}/${jail-soft}/.pki"
    mv-to-jail "${homedir}/.vscode" "${homedir}/${jail-soft}/.vscode"
    mv-to-jail "${homedir}/.cursor" "${homedir}/${jail-soft}/.cursor"
    mv-to-jail "${homedir}/.antigravity" "${homedir}/${jail-soft}/.antigravity"

    mv-to-jail "${homedir}/.steam" "${homedir}/${jail-soft}/.steam"
    mv-to-jail "${homedir}/.steampid" "${homedir}/${jail-soft}/.steampid"
    mv-to-jail "${homedir}/.steampath" "${homedir}/${jail-soft}/.steampath"

    mv-to-jail "${homedir}/.anydesk" "${homedir}/${jail-bwrap}/.anydesk"
  '';

  home.packages = [
    (enjail-soft pkgs.steam "steam")
    (enjail-soft pkgs.steam-run "steam-run")

    (enjail-soft pkgs.vivaldi "vivaldi")
    (enjail-soft pkgs.ungoogled-chromium "chromium")

    (enjail-soft pkgs.vscode-fhs "code")
    (enjail-soft pkgs.code-cursor-fhs "cursor")
    (enjail-soft pkgs.antigravity-fhs "antigravity")

    (enjail-bwrap pkgs.anydesk "anydesk")
  ];
}
