;;; evil.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Mislav Zanic
;;
;; Author: Mislav Zanic <mislavzanic3@gmail.com>
;; Maintainer: Mislav Zanic <mislavzanic3@gmail.com>
;; Created: March 23, 2023
;; Modified: March 23, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/mzanic/evil
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(defun efs/evil-hook ()
  dolist (mode '(git-rebase-mode
                 eshell-mode
                 term-mode))
  (add-to-list 'evil-emacs-state-modes mode))

(use-package evil
  :demand t
  :general
  (mzanic/leader-keys
    "w" '(:keymap evil-window-map :wk "window"))
  :init
  (setq evil-want-C-u-scroll t) ;; allow scroll up with 'C-u'
  (setq evil-want-C-d-scroll t) ;; allow scroll down with 'C-d'

  (setq evil-want-integration t) ;; necessary for evil collection
  (setq evil-want-keybinding nil)

  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)

  :config
  (evil-mode))

(use-package evil-collection
  :after evil
  :init (evil-collection-init))

(use-package evil-commentary
  :after evil
  :init
  (evil-commentary-mode)) ;; globally enable evil-commentary

;; (use-package evil-goggles
;;   :init
;;   (evil-goggles-mode)
;;   (evil-goggles-use-diff-faces))

(provide 'evil-conf)
;;; evil-conf.el ends here
