{
  config,
  ...
}: {
  imports = [
    ./gpu/intel
    ./gpu/nvidia
    ./opengl
  ];

  hardware = {
    nvidia = {
      prime = {
        intelBusId = "PCI:00:02:0";
        nvidiaBusId = "PCI:01:00:0";
      };
    };
  };

  # Cooling management
  services.thermald.enable = true;

    # √(2560² + 1600²) px / 16 in ≃ 189 dpi
  services.xserver.dpi = 120;

  }
