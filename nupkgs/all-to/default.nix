{ self, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.all-to = self.nuenv.buildNuPackage pkgs {
        name = "all-to";
        version = "0.1.0";
        src = ./src;

        scripts = {
          all-to = "main.nu";
        };

        packages = with pkgs; [
          imagemagick
          ffmpeg
        ];
      };
    };
}
