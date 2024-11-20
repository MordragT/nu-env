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
      src
      scripts
      env
      dependencies
      packages
      plugins
      ;
  };
}
