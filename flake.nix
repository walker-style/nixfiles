{

  description = "Manage NixOs and Home Manager";

  inputs = {

          nixpkgs.url = "nixpkgs/nixos-unstable";
          home-manager.url = "github:nix-community/home-manager/master";
          home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = { self, nixpkgs, home-manager, ... }:

    let 
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      systemSettings = {
        profile = "developer";
      };
    in {

      nixosConfigurations = {
        nixos-walker = lib.nixosSystem {
        inherit system;
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


