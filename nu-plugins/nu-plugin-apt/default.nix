{rustPlatform}:
rustPlatform.buildRustPackage {
  pname = "nu-plugin-apt";
  version = "0.1.0";
  src = ../.;

  cargoLock.lockFile = ../Cargo.lock;
  # Locked necessary: https://github.com/nushell/nushell/issues/17510
  cargoBuildFlags = ["--package nu_plugin_apt" "--locked"];
}
