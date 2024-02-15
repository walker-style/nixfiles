{
  lib,
  config,
  ...
}: {
  imports = [
    ./intel
    ./gpu/intel
  ];


  hardware = {
    nvidia = {
      modesetting.enable = lib.mkDefault true;
      powerManagement.enable = lib.mkDefault true;
      #
      prime = {
        intelBusId = "PCI:00:02:0";
        nvidiaBusId = "PCI:01:00:0";
      };
    };
  };

  # Cooling management
  services.thermald.enable = lib.mkDefault true;

    # √(2560² + 1600²) px / 16 in ≃ 189 dpi
  services.xserver.dpi = 120;

  }
