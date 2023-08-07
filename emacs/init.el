;;; init.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Mislav Zanic
;;
;; Author: Mislav Zanic <mislavzanic3@gmail.com>
;; Maintainer: Mislav Zanic <mislavzanic3@gmail.com>
;; Created: March 22, 2023
;; Modified: March 22, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/mzanic/init
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(add-to-list 'load-path (concat user-emacs-directory "lisp/"))
(setq custom-file (make-temp-file "emacs-custom.el_"))

(set-language-environment "UTF-8")
(setq default-input-method nil)         ; This gets set by the above—dont'.

(setq vc-follow-symlinks t)   ; Always follow symlinks without prompting.
      ;; default-directory  "~/")   ; Default directory for current buffer.

;;;; Packages

;; Set up package repositories.
(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") 'append)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") 'append)

(setq package-native-compile t
      native-comp-async-report-warnings-errors nil)

(require 'use-package)
(setq use-package-always-ensure t
      use-package-always-defer  t)

(use-package gcmh                       ; 28mar2022
  :demand t
  :config (gcmh-mode)
  :custom (gcmh-high-cons-threshold (* 100 1024 1024)))

;; (global-set-key (kbd "ESC") 'minibuffer-keyboard-quit)
(require 'sensible-defaults)

(require 'theming)
(require 'modeline)
(require 'keybindings)

(require 'evil-conf)
(require 'completion)
(require 'dired-conf)
(require 'global-packages)

(require 'programming)
(require 'org-config)
(require 'org-roam-config)

;;; init.el ends here
