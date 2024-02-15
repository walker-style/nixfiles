{ lib, config, pkgs, ... }:

{


  boot.initrd.kernelModules = ["nvidia"];
  boot.extraModulePackages = [
    #config.boot.kernelPackages.lenovo-legion-module 
    config.boot.kernelPackages.nvidia_x11
  ];

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];


  hardware = {
    nvidia = {
      modesetting.enable = lib.mkDefault true;
      powerManagement.enable = lib.mkDefault true;
      
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  }
