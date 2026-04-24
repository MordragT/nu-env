{ lib, ... }:
{
  options.flake.nuenv = lib.mkOption {
    description = "Custom flake output for nuenv";
    type = lib.types.attrs;
  };

  imports = [
    ./build-derivation
    ./build-nu-package
    ./write-nu
  ];
}
