{
  config,
  host,
  pkgs,
  lib,
  ...
}:

let
  homedir = config.home.homeDirectory;

  jail = ".local/xdg-jail";
  jail-soft = ".local/xdg-jail/.softjail";

  enjail =
    pkg: bin:
    (pkgs.symlinkJoin {
      name = "${pkg.name}-enjailed-${host.username}";
      paths = [ pkg ];
      buildInputs = [
        pkgs.makeWrapper
        pkgs.bubblewrap
      ];
      postBuild = ''
        # resolve $hidden the same way wrapProgram does
        # https://github.com/NixOS/nixpkgs/blob/bd53ac106738b7bc47f89d56b5ddbff4bd4af4bf/pkgs/build-support/setup-hooks/make-wrapper.sh#L229-L232

        hidden="$out/bin/.${bin}-wrapped"
        while [ -e "$hidden" ]; do
          hidden="''${hidden}_"
        done

        wrapProgram $out/bin/${bin} \
          --prefix PATH : ${pkgs.bubblewrap}/bin \
          --run "
            exec ${pkgs.bubblewrap}/bin/bwrap \
              --bind / / \
              \
              --dev-bind /dev /dev \
              --proc /proc \
              \
              --bind ${homedir}/${jail} ${homedir} \
              --bind ${homedir}/.cache ${homedir}/.cache \
              --bind ${homedir}/.config ${homedir}/.config \
              --bind ${homedir}/.local ${homedir}/.local \
              \
              --bind-try ${homedir} ${homedir}/Original \
              --bind-try ${homedir}/Desktop ${homedir}/Desktop \
              --bind-try ${homedir}/Downloads ${homedir}/Downloads \
              --bind-try ${homedir}/Movies ${homedir}/Movies \
              --bind-try ${homedir}/Pictures ${homedir}/Pictures \
              --bind-try ${homedir}/Projects ${homedir}/Projects \
              --bind-try ${homedir}/Services ${homedir}/Services \
              \
              --die-with-parent \
              \
              \"$hidden\" \"\$@\"
          "
      '';
    });

  enjail-soft =
    pkg: bin:
    (pkgs.symlinkJoin {
      name = "${pkg.name}-enjailed-${host.username}";
      paths = [ pkg ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = "wrapProgram $out/bin/${bin} --run 'export HOME=${homedir}/${jail-soft} && cd \$HOME'";
    });
in
{
  home.activation."link-xdg-jail-to-home" = lib.hm.dag.entryAnywhere ''
    ${pkgs.coreutils}/bin/mkdir -p ${homedir}/${jail}
    ${pkgs.coreutils}/bin/mkdir -p ${homedir}/${jail-soft}

    ${pkgs.coreutils}/bin/ln -sfn ${homedir}/.config ${homedir}/${jail-soft}/.config
    ${pkgs.coreutils}/bin/ln -sfn ${homedir}/.local ${homedir}/${jail-soft}/.local
    ${pkgs.coreutils}/bin/ln -sfn ${homedir}/.cache ${homedir}/${jail-soft}/.cache

    ${pkgs.coreutils}/bin/ln -sfn ${homedir}/*/ ${homedir}/${jail-soft}/
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

    mv-to-jail "${homedir}/.pki" "${homedir}/${jail}/.pki"

    mv-to-jail "${homedir}/.anydesk" "${homedir}/${jail}/.anydesk"

    mv-to-jail "${homedir}/.vscode" "${homedir}/${jail}/.vscode"
    mv-to-jail "${homedir}/.cursor" "${homedir}/${jail}/.cursor"
    mv-to-jail "${homedir}/.antigravity" "${homedir}/${jail}/.antigravity"

    mv-to-jail "${homedir}/.steam" "${homedir}/${jail-soft}/.steam"
    mv-to-jail "${homedir}/.steampid" "${homedir}/${jail-soft}/.steampid"
    mv-to-jail "${homedir}/.steampath" "${homedir}/${jail-soft}/.steampath"
  '';

  home.packages = [
    (enjail-soft pkgs.steam "steam")
    (enjail-soft pkgs.steam-run "steam-run")

    (enjail pkgs.anydesk "anydesk")

    (enjail pkgs.spotify "spotify")

    (enjail pkgs.vivaldi "vivaldi")
    (enjail pkgs.ungoogled-chromium "chromium")

    (enjail pkgs.vscode-fhs "code")
    (enjail pkgs.code-cursor-fhs "cursor")
    (enjail pkgs.antigravity-fhs "antigravity")

    (enjail (pkgs.symlinkJoin {
      name = "${pkgs.postman}-gsettings-schemas-fixed";
      paths = [ pkgs.postman ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = "wrapProgram $out/bin/postman --set GSETTINGS_SCHEMA_DIR ${pkgs.gtk3}/share/gsettings-schemas/gtk+3-${pkgs.gtk3.version}/glib-2.0/schemas";
    }) "postman")
    (enjail pkgs.insomnia "insomnia")
  ];
}
