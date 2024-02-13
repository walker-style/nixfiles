{

  description = "Manage NixOs and Home Manager";

  inputs = {

          nixpkgs.url = "nixpkgs/nixos-unstable";
          home-manager.url = "github:nix-community/home-manager/master";
          home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = { self, nixpkgs, home-manager, ... }:

    let 
      systemSettings = {
        profile = "developer";
      	system = "x86_64-linux";
      };
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
      lib = nixpkgs.lib;
    in {

      nixosConfigurations = {
        nixos-walker = lib.nixosSystem {
        system = systemSettings.system;
        modules = [ (./. + "/profiles"+("/"+systemSettings.profile)+"/configuration.nix") ];
          
        };
      };

      homeConfigurations = {
        jonathan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ (./. + "/profiles"+("/"+systemSettings.profile)+"/home.nix") ];
        };
      };
    };
    }


