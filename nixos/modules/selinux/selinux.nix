{ pkgs, lib, ... }:

#
# https://github.com/SELinuxProject/refpolicy
# https://github.com/NixOS/nixpkgs/pull/396177
#
# temporary labeling solution
# sudo unshare --mount --propagation private bash -c "mount -o remount,rw /nix/store && restorecon -RFv /"
#

let
  selinuxCfg = {
    mode = "permissive"; # "enforcing", "permissive", or "disabled"
    type = "refpolicy";
    policyVersion = null;
    policy = import ./policy/package.nix { inherit pkgs lib; };
  };
in
{
  systemd.package = pkgs.systemd.override { withSelinux = true; };

  environment = {
    systemPackages = with pkgs; [
      setools
      libselinux
      policycoreutils
    ];

    etc."selinux/refpolicy".source = "${selinuxCfg.policy}/etc/selinux/refpolicy";

    etc."selinux/current".text = "${selinuxCfg.policy}";

    etc."selinux/config".text = ''
      SELINUX=${selinuxCfg.mode}
      SELINUXTYPE=${selinuxCfg.type}
    '';

    etc."selinux/semanage.conf".text = ''
      ${lib.optionalString (selinuxCfg.policyVersion != null) ''
        policy-version = ${toString selinuxCfg.policyVersion}
      ''}

      compiler-directory = ${pkgs.policycoreutils}/libexec/selinux/hll

      [load_policy]
      path = ${lib.getExe' pkgs.policycoreutils "load_policy"}
      [end]

      [setfiles]
      path = ${lib.getExe' pkgs.policycoreutils "setfiles"}
      args = -q -c $@ $<
      [end]

      [sefcontext_compile]
      path = ${lib.getExe' pkgs.libselinux "sefcontext_compile"}
      args = -r $@
      [end]
    '';
  };

  system.activationScripts.selinux = {
    deps = [ "usrbinenv" "etc" ];
    text = ''
      exec >&2

      if ! ${pkgs.gnugrep}/bin/grep -qw selinux /sys/kernel/security/lsm; then
        echo ""
        echo "SELinux not found in /sys/kernel/security/lsm"
        echo "You might want 'nixos-rebuild boot' instead of 'nixos-rebuild switch'"
        echo ""
      fi

      ${lib.getExe' pkgs.policycoreutils "load_policy"}

      ${lib.getExe' pkgs.policycoreutils "restorecon"} /etc
      ${lib.getExe' pkgs.policycoreutils "restorecon"} /usr
      ${lib.getExe' pkgs.policycoreutils "restorecon"} /bin
    '';
  };
}
