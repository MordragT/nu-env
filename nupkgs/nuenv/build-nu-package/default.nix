{
  makeDerivation,
  uutils-coreutils-noprefix,
}: {
  name,
  version,
  src,
  scripts ? [],
  env ? {},
  dependencies ? [],
  packages ? [],
  plugins ? [],
}:
makeDerivation {
  inherit
    name
    version
    ;

  builder = ./builder.nu;
  packages = [
    uutils-coreutils-noprefix
  ];

  env = {
    inherit
      name
      version
      src
      scripts
      env
      dependencies
      packages
      plugins
      ;
  };
}
