;;; theming.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Mislav Zanic
;;
;; Author: Mislav Zanic <mislavzanic3@gmail.com>
;; Maintainer: Mislav Zanic <mislavzanic3@gmail.com>
;; Created: March 22, 2023
;; Modified: March 22, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/mzanic/theming
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(use-package modus-themes
  :ensure t
  :init
  (modus-themes-select 'modus-vivendi)
  (setq modus-themes-vivendi-color-overrides '((bg-alt . "#000000")))
  :custom
  (modus-themes-common-palette-overrides
      '((bg-mode-line-active bg-blue-subtle)
        (fg-mode-line-active fg-main)
        (border-mode-line-active bg-blue-intense)))
  (modus-themes-bold-constructs t)
  (modus-themes-italic-constructs t)
  (modus-themes-variable-pitch-ui t)    ; variable pitch mode line etc.
  (modus-themes-mixed-fonts t))

(use-package fontaine
  :ensure t
  :init (fontaine-set-preset 'default)
  :custom
  (fontaine-presets
   '((default :default-height 100)
     (t :default-family "monospace"
        :fixed-pitch-family "monospace"
        :variable-pitch-family "monospace"))))

(setq modus-themes-common-palette-overrides
      '((bg-mode-line-active bg-blue-subtle)
        (fg-mode-line-active fg-main)
        (border-mode-line-active blue-intense)))

;; (use-package doom-modeline
;;   :ensure t
;;   :init (doom-modeline-mode t))

(use-package minions
  :ensure t
  :config (minions-mode))

(use-package nyan-mode
  :ensure t
  :init (nyan-mode t))

(use-package dashboard
  :init (dashboard-setup-startup-hook)
  :config
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))
        dashboard-startup-banner "~/.config/emacs/logo.png"
        dashboard-center-content t))

(provide 'theming)
;;; theming.el ends here
