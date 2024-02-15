{ config, pkgs, ... }:

{
  imports = [
    ./x11.nix
  ];

  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    
    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
      ];
    };
  };
}
