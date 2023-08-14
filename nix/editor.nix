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
      config = "${configDir}/init.el";
      package = emacs-unstable;
      alwaysEnsure = true;
      extraEmacsPackages = epkgs: [epkgs.auto-compile];
    });
    myEmacs = with pkgs;
      ((emacsPackagesFor emacs-unstable).emacsWithPackages (epkgs: with epkgs; [
          use-package
          auto-compile

          vterm
          emacsql-sqlite
          org-roam

          vertico
          savehist
          orderless
          marginalia
          consult

          dired
          all-the-icons-dired
          dired-open

          evil
          evil-collection
          evil-commentary

          xclip
          helpful
          beframe
          projectile
          magit
          olivetti
          hide-mode-line

          which-key
          general
          org
          org-agenda
          evil-org
          org-bullets
          org-journal
          org-present
          
          direnv
          company
          rainbow-delimiters
          electric
          lsp-mode
          lsp-ui
          company
          company-box
          haskell-mode
          lsp-haskell
          hindent
          go-mode
          nix-mode
          python-mode
          yaml-mode
          terraform-mode
          json-mode
          markdown-mode
      ]));
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
