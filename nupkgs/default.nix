pkgs: let
  nuenv = import ./nuenv nuenv pkgs;
  callPackage = pkgs.lib.callPackageWith (pkgs // nuenv);
in {
  inherit nuenv;
  all-to = callPackage ./by-name/all-to {};
  hello-nu = callPackage ./by-name/hello-nu {};
  superview = callPackage ./by-name/superview {};
  vpnctl = callPackage ./by-name/vpnctl {};
  nu-plugin-apt = callPackage ../nu-plugins/nu-plugin-apt {};
}
