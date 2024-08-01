{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    lobster.url = "github:justchokingaround/lobster";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
        url = "github:hyprwm/hyprland-plugins";
        inputs.hyprland.follows = "hyprland"; # IMPORTANT
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
	modules = [ ./configuration.nix ];
      };
    };
    homeConfigurations = {
      justalternate = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
	modules = [
	  ./home.nix
	];
        extraSpecialArgs = {
          inherit inputs;
	};
      };
    };
  };
}
