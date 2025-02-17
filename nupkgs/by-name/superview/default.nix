{
  buildNuPackage,
  ffmpeg,
}:
buildNuPackage {
  name = "superview";
  version = "0.1.0";
  src = ./src;

  scripts = {
    superview = "main.nu";
  };

  packages = [
    ffmpeg
  ];
}
