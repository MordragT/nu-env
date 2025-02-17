{
  makeDerivation,
  nushellPlugins,
  hello,
}:
makeDerivation {
  name = "hello-nu";
  version = "0.1.0";
  packages = [hello];
  plugins = [nushellPlugins.formats];
  builder = builtins.toFile "builder.nu" ''
    print ("[a]\nb=c"| from ini )

    print $env.out
    print $env.MESSAGE
    print $env.PATH

    mkdir $"($env.out)/share"
    hello --greeting $env.MESSAGE | save $"($env.out)/share/hello.txt"
  '';
  env.MESSAGE = "Hello from Nix + Nu";
}
