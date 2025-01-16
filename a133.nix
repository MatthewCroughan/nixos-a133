{ pkgs, lib, ... }:
{
  hardware.deviceTree.name = "allwinner/sun50i-a133-liontron-h-a133l.dtb";
  hardware.deviceTree.enable = true;
  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = lib.recursiveUpdate (lib.systems.elaborate "aarch64-linux") {
    linux-kernel.target = "vmlinuz.efi";
    linux-kernel.installTarget = "zinstall";
  };
  boot.loader = {
    systemd-boot.enable = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
