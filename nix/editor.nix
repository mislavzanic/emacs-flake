{config, lib, pkgs, inputs, ...}:
with lib;
with lib.my; let
  cfg = config.modules.editor.emacs;
in {
  options.modules.editor.emacs = with types; {
    enable = mkBoolOpt false;
    enableServer = mkBoolOpt false;
    path = mkOpt str (builtins.toString ../emacs);
    hm = mkBoolOpt false;
  };

  config = let
    customEmacs = with pkgs; 
      ((emacsPackagesFor emacs).emacsWithPackages (epkgs: with epkgs; [
        vterm
        use-package
        auto-compile
        emacsql-sqlite
        org-roam
      ]));
    packages = with pkgs; [
      customEmacs

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
  in mkIf cfg.enable (mkMerge [
    {
      nixpkgs.overlays = [inputs.emacs-overlay.overlay];

      fonts.fonts = with pkgs; [
        emacs-all-the-icons-fonts
        jetbrains-mono
        nerdfonts
        cantarell-fonts
      ];

      services.emacs = {
        enable = cfg.enableServer;
        package = customEmacs;
      };
    }
    (mkIf cfg.hm {
      home.packages = packages;
    })
    (mkIf (cfg.hm != true) {
      user.packages = packages;
    })
  ]);
}
