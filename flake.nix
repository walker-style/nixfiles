{

  description = "Manage NixOs and Home Manager";

  inputs = {

          nixpkgs.url = "nixpkgs/nixos-unstable";
          home-manager.url = "github:nix-community/home-manager/master";
          home-manager.inputs.nixpkgs.follows = "nixpkgs";

          stylix.url = "github:danth/stylix";
 
    };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:

    let 
      systemSettings = {
        profile = "developer";
      	system = "x86_64-linux";
      };
      userSettings = rec {
        username = "jonathan"; # username
        name = "Jonathan Walker"; # name/identifier
        email = "w@lker.dev"; # email (used for certain configurations)
        dotfilesDir = "~/.dotfiles"; # absolute path of the local repo
        theme = "solarized-dark"; # selcted theme from my themes directory (./themes/)
        wm = "i3"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
        # window manager type (hyprland or x11) translator
        wmType = if (wm == "hyprland") then "wayland" else "x11";
        #browser = "qutebrowser"; # Default browser; must select one from ./user/app/browser/
        #defaultRoamDir = "Personal.p"; # Default org roam directory relative to ~/Org
        term = "alacritty"; # Default terminal command;
        font = "Intel One Mono"; # Selected font
        fontPkg = pkgs.intel-one-mono; # Font package
        editor = "nvim"; # Default editor;
        # editor spawning translator
        # generates a command that can be used to spawn editor inside a gui
        # EDITOR and TERM session variables must be set in home.nix or other module
        # I set the session variable SPAWNEDITOR to this in my home.nix for convenience
        spawnEditor = if (editor == "emacsclient") then "emacsclient -c -a 'emacs'"
                      else (if ((editor == "vim") || (editor == "nvim") || (editor == "nano")) then "exec " + term + " -e " + editor else editor);
      };
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
      lib = nixpkgs.lib;
    in {

      nixosConfigurations = {
        nixos-walker = lib.nixosSystem {
        system = systemSettings.system;
        modules = [ (./. + "/profiles"+("/"+systemSettings.profile)+"/configuration.nix") ];
          inherit (inputs) stylix;
          specialArgs = {
            # pass config variables from above
            inherit systemSettings;
            inherit userSettings;
          };
          
        };
      };

      homeConfigurations = {
        jonathan = home-manager.lib.homeManagerConfiguration {
          modules = [ (./. + "/profiles"+("/"+systemSettings.profile)+"/home.nix") ];
          inherit pkgs;
          inherit (inputs) stylix;
          extraSpecialArgs = {
            # pass config variables from above
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };
    };
    }


