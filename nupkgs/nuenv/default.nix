self: pkgs: let
  callPackage = pkgs.lib.callPackageWith (pkgs // self);
in {
  makeDerivation = import ./make-derivation pkgs;
  buildNuPackage = callPackage ./build-nu-package {};
}
