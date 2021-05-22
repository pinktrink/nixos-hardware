{ lib, pkgs, ... }: let
  pkgs1909 = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-19.09.tar.gz") {};
in {
  hardware.opengl.package = pkgs.buildEnv {
    name = "mesa-driver+txc-${pkgs.mesa.version}";
    paths = [
      pkgs1909.mesa.drivers
      pkgs1909.libtxc_dxtn
    ];
  };

  services.xserver.drivers = [ rec {
    display = true;
    name = "intel";
    driverName = name;
    modules = [ pkgs1909.xorg.xf8gvideointel ];
  } ];
}
