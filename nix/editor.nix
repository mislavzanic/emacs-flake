{config, lib, pkgs, inputs, ...}:
with lib;
with lib.my; let
  cfg = config.modules.editor.emacs;
in {
  options.modules.editor.emacs = {
    enable = mkBoolOpt false;
    enableServer = mkBoolOpt false;
    path = mkOpt str (builtins.toString ../emacs);
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
  in mkIf cfg.enable {
    nixpkgs.overlays = [inputs.emacs-overlay.overlay];

    environment.systemPackages = with pkgs; [
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
  };
}
