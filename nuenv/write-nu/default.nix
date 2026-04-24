{ self, ... }:
{
  flake.nuenv.writeNu =
    pkgs:
    {
      name,
      version,
      script,
      env ? { },
      libraries ? [ ],
      packages ? [ ],
      plugins ? [ ],
    }:
    self.nuenv.buildNuPackage pkgs {
      inherit
        name
        version
        env
        libraries
        packages
        plugins
        ;

      scripts = {
        ${name} = "main.nu";
      };

      src = builtins.toFile "main.nu" script;
    };
}
