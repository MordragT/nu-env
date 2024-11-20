pkgs: let
  nuenv = import ../nuenv nuenv pkgs;
  callPackage = pkgs.lib.callPackageWith (pkgs // nuenv);
in
  nuenv
  // {
    all-to = callPackage ./all-to {};
    hello = callPackage ./hello {};
    nu-plugin-apt = callPackage ./nu-plugin-apt {};
  }
