{ self, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.comma = self.nuenv.writeNu pkgs {
        name = "comma";
        version = "0.1.0";
        script = ''
          def main [...pkgs: string] {
              let pkgs = $pkgs
                  | each { |pkg| "nixpkgs#" + $pkg }
              nix shell ...$pkgs
          }
        '';
      };
    };
}
