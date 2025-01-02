{rustPlatform}:
rustPlatform.buildRustPackage {
  pname = "nu-plugin-apt";
  version = "0.1.0";
  src = ../../.;

  cargoLock.lockFile = ../../Cargo.lock;
  cargoBuildFlags = ["--package nu_plugin_apt"];
}
