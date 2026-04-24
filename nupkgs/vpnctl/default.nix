{ self, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.vpnctl = self.nuenv.buildNuPackage pkgs {
        name = "vpnctl";
        version = "0.1.1";
        src = ./src;

        scripts = {
          vpnctl = "main.nu";
        };

        plugins = [ pkgs.nushell-plugin-formats ];

        packages = with pkgs; [
          openconnect
          wireguard-tools
        ];
      };
    };
}
