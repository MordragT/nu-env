{
  buildNuPackage,
  imagemagick,
  ffmpeg,
}:
buildNuPackage {
  name = "all-to";
  version = "0.1.0";
  src = ./src;

  scripts = {
    all-to = "main.nu";
  };

  packages = [
    imagemagick
    ffmpeg
  ];
}
