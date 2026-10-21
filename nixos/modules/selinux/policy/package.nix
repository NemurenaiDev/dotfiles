{ pkgs, lib, ... }:

pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "refpolicy-nixos";
  version = "20260616";

  src = pkgs.fetchFromGitHub {
    owner = "SELinuxProject";
    repo = "refpolicy";
    tag = "RELEASE_2_${finalAttrs.version}";
    hash = "sha256-A7bC/44Swt1pe9qAubrOIVEJpsXeCkJUaftLHqq3EmM=";
  };

  nativeBuildInputs = [
    pkgs.python3
    pkgs.getopt
    pkgs.gnum4
    pkgs.bash
  ];

  configurePhase = ''
    runHook preConfigure


    ${pkgs.coreutils-full}/bin/cp -r ${./modules}/. policy/modules/custom


    echo "/usr/bin/Hyprland -- gen_context(system_u:object_r:wm_exec_t,s0)" >> policy/modules/apps/wm.fc
    echo "/usr/bin/\.Hyprland-wrapped -- gen_context(system_u:object_r:wm_exec_t,s0)" >> policy/modules/apps/wm.fc

    echo "/usr/libexec/dconf-service -- gen_context(system_u:object_r:gconfd_exec_t,s0)" >> policy/modules/apps/gnome.fc

    echo "HOME_DIR/\.cache/syncthing/.config(/.*)?  gen_context(system_u:object_r:syncthing_xdg_config_t,s0)" >> policy/modules/apps/syncthing.fc


    substituteInPlace policy/modules/kernel/corecommands.fc --replace-fail "/usr/lib/systemd/systemd.*" "/usr/lib/systemd/systemd.+"

    substituteInPlace policy/modules/**/*.fc \
      --replace-quiet "/usr/bin/" "/nix/store/[^/]+/(bin|sbin)/" \
      --replace-quiet "/usr/sbin/" "/nix/store/[^/]+/(sbin|bin)/" \
      --replace-quiet "/usr/lib/" "/nix/store/[^/]+/(lib|libexec)/" \
      --replace-quiet "/usr/libexec/" "/nix/store/[^/]+/(libexec|lib)/" \
      --replace-quiet "/usr/" "/nix/store/[^/]+/" \
      --replace-quiet "/etc" "/(etc|etc/static)"


    make conf ''${makeFlags[@]}


    # for m in $(grep -A1 '^# Layer: apps' policy/modules.conf | grep '^# Module: ' | sed 's/^# Module: //'); do
    #     sed -i "s/^$m = module/$m = off/" policy/modules.conf
    # done

    # substituteInPlace policy/modules.conf \
    #   --replace-fail "loadkeys = off" "loadkeys = module"


    runHook postConfigure
  '';

  makeFlags = [
    "SHELL=${pkgs.bash}/bin/bash"

    "CHECKPOLICY=${lib.getExe pkgs.checkpolicy}"
    "CHECKMODULE=${lib.getExe' pkgs.checkpolicy "checkmodule"}"

    "SEMODULE=${lib.getExe' pkgs.policycoreutils "semodule"}"
    "SEMOD_PKG=${lib.getExe' pkgs.semodule-utils "semodule_package"}"
    "SEMOD_LNK=${lib.getExe' pkgs.semodule-utils "semodule_link"}"
    "SEMOD_EXP=${lib.getExe' pkgs.semodule-utils "semodule_expand"}"

    "DESTDIR=${placeholder "out"}"
    "prefix=${placeholder "out"}"
    "DISTRO=nixos"
    "SYSTEMD=y"
    "UBAC=y"

    "MONOLITHIC=y"
    "SETFILES=${pkgs.policycoreutils}/bin/setfiles"
  ];

  installTargets = "all install install-headers";

  postInstall = ''
    ${pkgs.coreutils-full}/bin/cp policy/modules.conf $out/share/selinux/modules.conf
  '';

  meta = {
    description = "SELinux Reference Policy with experimental NixOS support (WIP)";
    homepage = "http://userspace.selinuxproject.org";
    platforms = lib.platforms.linux;
    license = lib.licenses.gpl2Only;
    maintainers = [ ];
  };
})
