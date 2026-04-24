{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default =
        let
          toolchain = pkgs.rustPlatform;
        in
        pkgs.mkShell {
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
    };
}
