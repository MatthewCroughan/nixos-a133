{ buildUBoot, fetchFromGitHub, armTrustedFirmwareAllwinner }:
buildUBoot {
  version = "master";
  src = fetchFromGitHub {
    owner = "u-boot";
    repo = "u-boot";
    rev = "4f70106beafe30df8b0528a3d8b2543cd48fe241";
    hash = "sha256-q0XDtxdBqpO3Ih9Oy1dmusp7SBZvEflj/W51Fey16Dc=";
  };
  patches = [];
  prePatch = ''
    substituteInPlace configs/liontron-h-a133l_defconfig --replace-fail 'CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-a133-liontron-h-a133l"' 'CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-a100-allwinner-perf1"'
  '';
  defconfig = "liontron-h-a133l_defconfig";
  BL31 = "${armTrustedFirmwareAllwinner}/bl31.bin";
  filesToInstall = [ "u-boot-sunxi-with-spl.bin" ];
}
