{ self, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.hello-nu = self.nuenv.buildDerivation pkgs {
        name = "hello-nu";
        version = "0.1.0";
        packages = [ pkgs.hello ];
        plugins = [ pkgs.nushell-plugin-formats ];
        builder = builtins.toFile "builder.nu" ''
          print ("[a]\nb=c"| from ini )

          print $env.out
          print $env.MESSAGE
          print $env.PATH

          mkdir $"($env.out)/share"
          hello --greeting $env.MESSAGE | save $"($env.out)/share/hello.txt"
        '';
        env.MESSAGE = "Hello from Nix + Nu";
      };
    };
}
