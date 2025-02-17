{
  buildNuPackage,
  openconnect,
  wireguard-tools,
  nushellPlugins,
}:
buildNuPackage {
  name = "vpnctl";
  version = "0.1.1";
  src = ./src;

  scripts = {
    vpnctl = "main.nu";
  };

  plugins = [nushellPlugins.formats];

  packages = [
    openconnect
    wireguard-tools
  ];
}
