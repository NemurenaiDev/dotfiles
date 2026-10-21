{ config, pkgs, ... }:

let
  pam-selinux = pkgs.linux-pam.overrideAttrs (old: {
    buildInputs = old.buildInputs ++ [
      pkgs.libselinux
    ];

    mesonFlags = old.mesonFlags ++ [
      (pkgs.lib.mesonEnable "selinux" true)
    ];

    patches = [
      (pkgs.writeText "pam.patch" ''
        diff --git a/modules/module-meson.build b/modules/module-meson.build
        index a5d24ba6..8fcee2cd 100644
        --- a/modules/module-meson.build
        +++ b/modules/module-meson.build
        @@ -73,7 +73,7 @@ if module == 'pam_sepermit'
             subdir_done()
           endif
           pam_module_deps += [libselinux]
        -  sepermit_lockdir = localstatedir / 'run' / 'sepermit'
        +  sepermit_lockdir = '/run/sepermit'
           pam_module_c_args += ['-DSEPERMIT_LOCKDIR="@0@"'.format(sepermit_lockdir)]
         endif
         if module == 'pam_setquota'
        @@ -397,10 +397,6 @@ if module == 'pam_sepermit'
             install_dir: vendor_sconfigdir,
             install_tag: 'config',
           )
        -  install_emptydir(
        -    sepermit_lockdir,
        -    install_tag: 'config',
        -  )
         endif
         if module == 'pam_time'
           install_data(
      '')
    ];

    postInstall = (old.postInstall or "") + ''
      if [ ! -e "$out/lib/security/pam_selinux.so" ]; then
        echo "ERROR: pam_selinux.so was not built/installed" >&2
        exit 1
      fi
    '';
  });
in
{
  security.lsm = [ "selinux" ];

  security.pam = {
    package = pam-selinux;

    services = {
      systemd-user.rules.session.selinux = {
        order = config.security.pam.services.systemd-user.rules.session.loginuid.order + 10;
        control = "required";
        modulePath = "${pam-selinux}/lib/security/pam_selinux.so";
      };

      login.rules.session.selinux = {
        order = config.security.pam.services.login.rules.session.loginuid.order + 10;
        control = "required";
        modulePath = "${pam-selinux}/lib/security/pam_selinux.so";
      };

      sshd.rules.session.selinux = {
        order = config.security.pam.services.sshd.rules.session.loginuid.order + 10;
        control = "required";
        modulePath = "${pam-selinux}/lib/security/pam_selinux.so";
      };
    };
  };

  systemd.tmpfiles.rules = [ "d /run/sepermit 0755 root root -" ];
}
