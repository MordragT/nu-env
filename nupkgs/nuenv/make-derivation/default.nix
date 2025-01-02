pkgs: {
  name, # The name of the derivation
  version,
  builder, # Builder script
  system ? pkgs.system, # The build system
  outputs ? ["out"], # Outputs to provide
  packages ? [], # Packages provided to the realisation process
  plugins ? [], # nushell plugins
  libraries ? [], # nushell libraries
  env ? {}, # user-supplied env vars
}: let
  nushell = "${pkgs.nushell}/bin/nu";
in
  derivation {
    # Core derivation info
    inherit system outputs;

    name = "${name}-${version}";

    # Build logic
    builder = nushell; # Use Nushell instead of Bash
    args = [./bootstrap.nu]; # Run a bootstrap script that then runs the builder

    # When this is set, Nix writes the environment to a JSON file at
    # $NIX_BUILD_TOP/.attrs.json. Because Nushell can handle JSON natively, this approach
    # is generally cleaner than parsing environment variables as strings.
    __structuredAttrs = true;

    # Attributes passed to the environment (prefaced with __nu_ to avoid naming collisions)
    __nu_builder = builder;
    __nu_packages = packages;
    __nu_plugins = plugins;
    __nu_libraries = libraries;
    __nu_nushell = nushell;
    __nu_config = ./config.nu;
    __nu_env_config = ./env.nu;
    __nu_plugin_config = "plugin.msgpackz";
    __nu_env = env;
  }
