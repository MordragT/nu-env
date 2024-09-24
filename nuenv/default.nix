{
  nushell,
  sys,
  # writeTextFile,
}: {
  # TODO no packages but just inherit the pkgs which can then be used like $env.hello ?
  mkDerivation = {
    name, # The name of the derivation
    packages ? [], # Packages provided to the realisation process
    system ? sys, # The build system
    build ? "", # The build script itself
    outputs ? ["out"], # Outputs to provide
    env-config ? ./env-config.nu,
    plugins ? [],
    ... # Catch user-supplied env vars
  } @ attrs: let
    # Gather arbitrary user-supplied environment variables
    reserved-attrs = [
      "name"
      "packages"
      "system"
      "build"
      "outputs"
      "env-config"
      "plugins"
      "__nu_nushell"
      "__nu_builder"
      "__nu_packages"
      "__nu_build"
      "__nu_env_config"
      "__nu_extra_attrs"
      "__nu_plugins"
    ];

    extra-attrs = removeAttrs attrs reserved-attrs;
  in
    derivation {
      # Core derivation info
      inherit name system outputs;

      # Build logic
      builder = "${nushell}/bin/nu"; # Use Nushell instead of Bash
      args = [./bootstrap.nu]; # Run a bootstrap script that then runs the builder

      # When this is set, Nix writes the environment to a JSON file at
      # $NIX_BUILD_TOP/.attrs.json. Because Nushell can handle JSON natively, this approach
      # is generally cleaner than parsing environment variables as strings.
      __structuredAttrs = true;

      # Attributes passed to the environment (prefaced with __nu_ to avoid naming collisions)
      __nu_nushell = "${nushell}/bin/nu";
      __nu_builder = ./builder.nu;
      __nu_packages = packages;
      __nu_build = build;
      __nu_env_config = env-config;
      __nu_plugins = plugins;
      __nu_extra_attrs = extra-attrs;
    };

  # # An analogue to writeScriptBin but for Nushell rather than Bash scripts.
  # mkNushellScript = {
  #   name,
  #   script,
  #   bin ? name,
  # }: let
  #   nu = "${nushell}/bin/nu";
  # in
  #   writeTextFile {
  #     inherit name;
  #     destination = "/bin/${bin}";
  #     text = ''
  #       #!${nu}

  #       ${script}
  #     '';
  #     executable = true;
  #   };
}
