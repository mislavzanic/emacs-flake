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
    myEmacs = with pkgs;
      ((emacsPackagesFor emacs-unstable).emacsWithPackages (epkgs: with epkgs; [
          use-package
          auto-compile

          ripgrep

          vterm
          emacsql-sqlite
          org-roam

          vertico
          orderless
          marginalia
          consult
          consult-projectile

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

          jinx

          which-key
          general
          org
          evil-org
          org-bullets
          org-journal
          org-present
          
          direnv
          company
          corfu
          rainbow-delimiters
          company-box
          haskell-mode
          hindent
          go-mode
          nix-mode
          python-mode
          yaml-mode
          terraform-mode
          json-mode
          markdown-mode

          modus-themes
          fontaine
          minions
          nyan-mode
          dashboard

          dired-narrow
          diredfl
          gcmh
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
