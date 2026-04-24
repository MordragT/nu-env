{ self, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.superview = self.nuenv.buildNuPackage pkgs {
        name = "superview";
        version = "0.1.0";
        src = ./src;

        scripts = {
          superview = "main.nu";
        };

        packages = [
          pkgs.ffmpeg
        ];
      };
    };
}
