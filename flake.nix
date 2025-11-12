{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs@{ flake-parts, self, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages.x = pkgs.callPackage ./uboot.nix {};
        packages.a133-image = self.nixosConfigurations.a133.config.system.build.image.overrideAttrs {
          preInstall = ''
            dd if=${pkgs.callPackage ./uboot.nix {}}/u-boot-sunxi-with-spl.bin of=${self.nixosConfigurations.a133.config.image.repart.imageFileBasename}.raw bs=128k seek=1 conv=notrunc
          '';
        };
      };
      flake = {
        nixosConfigurations.a133 = inputs.nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            "${nixpkgs}/nixos/modules/profiles/minimal.nix"
            ./a133.nix
            ./configuration.nix
            ./repart.nix
          ];
        };
      };
    };
}
