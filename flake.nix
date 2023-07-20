{
  description = "My emacs config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nix-utils = {
      url = "github:mislavzanic/nix-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    emacs-overlay,
    nix-utils,
    ...
  }: let
    inherit (lib.my) mapModules;
    inherit (nix-utils) mkPkgs;

    pkgs = mkPkgs {
      system = "x86_64-linux";
      pkgs = nixpkgs;
      overlays = [];
    };

    lib = nixpkgs.lib.extend (nix-utils.mkLib {inherit inputs pkgs;});
  in {
    modules = mapModules ./nix import;
  };
}
