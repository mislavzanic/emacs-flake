{
  description = "My emacs config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    
    utils-flake.url = "github:mislavzanic/utils-flake";
  };

  outputs = inputs @ {
    nixpkgs,
    emacs-overlay,
    utils-flake,
    ...
  }: let
    inherit (lib.my) mapModules;
    inherit (utils-flake) mkPkgs;

    pkgs = mkPkgs {
      system = "x86_64-linux";
      pkgs = nixpkgs;
      overlays = [];
    };

    lib = nixpkgs.lib.extend (utils-flake.mkLib {inherit inputs pkgs;});
  in {
    modules = mapModules ./nix import;

    emacsFiles = {
      "emacs" = {
        source = builtins.toString ./emacs;
        recursive = true;
      };
    };
  };
}
