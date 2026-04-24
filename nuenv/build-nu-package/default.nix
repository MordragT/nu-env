{ self, ... }:
{
  flake.nuenv.buildNuPackage =
    pkgs:
    {
      name,
      version,
      src,
      scripts ? [ ],
      env ? { },
      libraries ? [ ],
      packages ? [ ],
      plugins ? [ ],
    }:
    self.nuenv.buildDerivation pkgs {
      inherit
        name
        version
        ;

      builder = ./builder.nu;
      packages = [
        pkgs.uutils-coreutils-noprefix
      ];

      env = {
        inherit
          name
          version
          src
          scripts
          env
          libraries
          packages
          plugins
          ;
      };
    };
}
