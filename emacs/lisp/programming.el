;;; programming.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Mislav Zanic
;;
;; Author: Mislav Zanic <mislavzanic3@gmail.com>
;; Maintainer: Mislav Zanic <mislavzanic3@gmail.com>
;; Created: March 23, 2023
;; Modified: March 23, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/mzanic/programming
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(use-package direnv
  :ensure t
  :init
  (direnv-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package electric
  :init
  (electric-pair-mode +1)) ;; automatically insert closing parens 
;;  (setq electric-pair-preserve-balance nil)) ;; more annoying than useful

(use-package eglot
  :init (setq completion-category-overrides '((eglot (styles orderless))))
  :config
  (advice-add 'eglot :before #'direnv-update-environment))

(use-package corfu
  :ensure t
  :init (global-corfu-mode)
  :hook
  (prog-mode . corfu-mode)
  (eshell-mode . corfu-mode)
  :bind (:map corfu-map
	      ("RET" . corfu-insert)
	      ("TAB" . corfu-next)
	      ([tab] . corfu-next)
	      ("S-TAB" . corfu-previous)
	      ([backtab] . corfu-previous))
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-separator ?\s)
  (completion-styles '(orderless-fast))
  (corfu-auto-delay 0.0))

(use-package haskell-mode
  :ensure t
  :hook (haskell-mode . eglot-ensure)
  :custom
  (haskell-interactive-popup-errors nil)
  (haskell-indentation-where-pre-offset  1)
  (haskell-indentation-where-post-offset 1)
  (haskell-process-auto-import-loaded-modules t))

(use-package hindent
  :ensure t
  :hook ((haskell-mode) . hindent-mode)
  :custom
  (hindent-process-path "fourmolu")
  (hindent-extra-args '("-o" "-XBangPatterns"
                        "-o" "-XTypeApplications"
                        "--indentation" "2")))

(use-package go-mode
  :ensure t
  :hook (go-mode . eglot-ensure))

(use-package nix-mode
  :ensure t
  :hook (nix-mode . eglot-ensure))

(use-package python-mode
  :ensure t
  :hook (python-mode . eglot-ensure))

(use-package yaml-mode
  :ensure t)

(use-package terraform-mode
  :ensure t)

(use-package json-mode)

(use-package markdown-mode
  :ensure t)

(provide 'programming)
;;; programming.el ends here
