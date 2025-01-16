{ buildUBoot, fetchFromGitHub, armTrustedFirmwareAllwinner }:
buildUBoot {
  version = "master";
  src = fetchFromGitHub {
    owner = "u-boot";
    repo = "u-boot";
    rev = "caa740df9cae5ddc74b18b88a4fea43e27b2fdf6";
    hash = "sha256-+72ZzGtNrS1vOOsBOlujB9gYQ7HZFxywYEBH70QSUD0=";
  };
  patches = [];
  defconfig = "liontron-h-a133l_defconfig";
  BL31 = "${armTrustedFirmwareAllwinner}/bl31.bin";
  filesToInstall = [ "u-boot-sunxi-with-spl.bin" ];
}
