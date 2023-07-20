{config, lib, pkgs, inputs, ...}:
with lib;
with lib.my; let
  cfg = config.editor.emacs;
in {
  options.editor.emacs = {
    enable = mkBoolOpt false;
    enableServer = mkBoolOpt false;
    homeCfg = mkBoolOpt true;
  };

  config = mkIf cfg.enable (mkMerge [
    {
      nixpkgs.overlays = [inputs.emacs-overlay.overlay];

      environment.systemPackages = with pkgs; [
        ((emacsPackagesFor emacs).emacsWithPackages (epkgs: with epkgs; [
          vterm
          use-package
          auto-compile
          emacsql-sqlite
          org-roam
        ]))

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

      fonts.fonts = with pkgs; [
        emacs-all-the-icons-fonts
        jetbrains-mono
        nerdfonts
        cantarell-fonts
      ];

      services.emacs.enable = cfg.enableServer;
    }
    (mkIf cfg.homeCfg {
      home.configFile = {
        "emacs" = {
          source = builtins.toString ../emacs;
          recursive = true;
        };
      };
    })
  ]);
}
