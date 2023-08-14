{config, lib, pkgs, inputs, ...}:
with lib;
with lib.my; let
  cfg = config.modules.editor.emacs;
  configDir = ../emacs;
  cfgType = config.type;
in {
  options.modules.editor.emacs = with types; {
    enable = mkBoolOpt false;
    enableServer = mkBoolOpt false;
    path = mkOpt str (builtins.toString configDir);
  };

  config = mkIf cfg.enable (let
    myEmacs = with pkgs; (pkgs.emacsWithPackagesFromUsePackage {
      config = ../emacs;
      package = emacs-unstable;
      # defaultInitFile = true;
      alwaysEnsure = true;
    });
    # myEmacs = with pkgs;
    #   ((emacsPackagesFor emacs-unstable).emacsWithPackages (epkgs: with epkgs; [
    #       vterm
    #       use-package
    #       auto-compile
    #       emacsql-sqlite
    #       org-roam
    #   ]));
  in {
    nixpkgs.overlays = [inputs.emacs-overlay.overlay];

    core = {
      packages = with pkgs; [
        myEmacs
        binutils
        gnutls
        fd
        ripgrep
        jq
        imagemagick
        sqlite
        xdotool
        xorg.xwininfo
      ];

      fonts = with pkgs; [
        emacs-all-the-icons-fonts
        jetbrains-mono
        nerdfonts
        cantarell-fonts
      ];
    };

    services.emacs = {
      enable = cfg.enableServer;
      package = myEmacs;
    };

    home.configFile = {
      "emacs" = {
        source = cfg.path;
        recursive = true;
      };
    };
  });
}
