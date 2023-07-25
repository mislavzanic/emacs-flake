{config, lib, pkgs, inputs, ...}:
with lib;
with lib.my; let
  cfg = config.modules.editor.emacs;
  cfgType = config.type;
in {
  options.modules.editor.emacs = with types; {
    enable = mkBoolOpt false;
    enableServer = mkBoolOpt false;
    path = mkOpt str (builtins.toString ../emacs);
    hm = mkBoolOpt false;
  };

  config = mkIf cfg.enable (mkMerge [
    {
      nixpkgs.overlays = [inputs.emacs-overlay.overlay];

      modules.${cfgType} = {
        packages = with pkgs; [
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

        fonts = with pkgs; [
          emacs-all-the-icons-fonts
          jetbrains-mono
          nerdfonts
          cantarell-fonts
        ];
      };

      services.emacs = {
        enable = cfg.enableServer;
        package = customEmacs;
      };

      home.configFile = {
        "emacs" = {
          source = builtins.toString ../emacs;
          recursive = true;
        };
      };
    }
  ]);
}
