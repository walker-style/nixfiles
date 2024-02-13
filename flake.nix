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
    in {

      nixosConfigurations = {
        nixos-walker = lib.nixosSystem {
        inherit system;
        modules = [ ./configuration.nix ];
          
        };
      };

      homeConfigurations = {
        jonathan = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };
    }


