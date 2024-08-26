{
  description = "Rust development template";

  inputs = {
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    ...
  }:
    utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = import nixpkgs {inherit system;};
        toolchain = pkgs.rustPlatform;
      in {
        packages.nu-plugin-apt = toolchain.buildRustPackage {
          pname = "nu-plugin-apt";
          version = "0.1.0";

          src = ./.;

          cargoLock.lockFile = ./Cargo.lock;

          cargoBuildFlags = ["--package nu_plugin_apt"];
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            (with toolchain; [
              cargo
              rustc
              rustLibSrc
            ])
            clippy
            rustfmt
            pkg-config
          ];

          # Specify the rust-src path (many editors rely on this)
          RUST_SRC_PATH = "${toolchain.rustLibSrc}";
        };
      }
    )
    // {
      overlays.default = this: pkgs: {
        nu-plugin-apt = self.packages."${pkgs.system}".nu-plugin-apt;
      };
    };
}
