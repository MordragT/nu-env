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
        nuenv = import ./nuenv {
          inherit (pkgs) nushell;
          sys = system;
        };
        toolchain = pkgs.rustPlatform;
      in {
        packages.nu-plugin-apt = toolchain.buildRustPackage {
          pname = "nu-plugin-apt";
          version = "0.1.0";

          src = ./.;

          cargoLock.lockFile = ./Cargo.lock;

          cargoBuildFlags = ["--package nu_plugin_apt"];
        };

        packages.hello = nuenv.mkDerivation {
          name = "hello-nix-nushell";
          packages = [pkgs.hello];
          build = ''
            print $env.out
            print $env.MESSAGE

            mkdir $"($env.out)/share"
            hello --greeting $env.MESSAGE | save $"($env.out)/share/hello.txt"
          '';
          MESSAGE = "Hello from Nix + Nu";
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
