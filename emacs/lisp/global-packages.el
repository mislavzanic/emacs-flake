;;; global-packages.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Mislav Zanic
;;
;; Author: Mislav Zanic <mislavzanic3@gmail.com>
;; Maintainer: Mislav Zanic <mislavzanic3@gmail.com>
;; Created: March 23, 2023
;; Modified: March 23, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/mzanic/global-packages
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(blink-cursor-mode 0)
(setq scroll-conservatively most-positive-fixnum)
(setq echo-keystrokes 0.01)
;;; `global-subword-mode'
;; Treat camelCase and PascalCase words like kebab-case and snake_case
;; with regards to word operations.
(global-subword-mode)

;; (use-package minibuffer                   ; minibuffer history
;;   :ensure nil
;;   :hook (minibuffer-mode . savehist-mode)
;;   :custom (history-delete-duplicates t))

(global-hl-line-mode)

(use-package xclip
  :demand t
  :config (xclip-mode))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

(use-package beframe
  :general
  (mzanic/leader-keys
   "bb" '(beframe-switch-buffer :wk "switch buffer"))
  :config
  (beframe-mode t))
(global-set-key (kbd "C-x b") #'beframe-switch-buffer)

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap ("C-c p" . projectile-command-map)
  :init
  (setq projectile-switch-project-action #'projectile-dired))

(use-package magit
  :ensure t
  :bind (("C-c g" . magit))
  :general
  (mzanic/leader-keys
   "g" '(:ignore t :wk "magit")
   "gg" '(magit :wk "magit")
   "gb" '(magit-branch :wk "magit branch"))
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package olivetti
  :ensure t
  :hook (org-mode . olivetti-mode)
  :custom (olivetti-body-width 0.8))

(use-package auto-package-update
  :ensure t
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-pacakge-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-time "09:00"))

(use-package hide-mode-line :ensure t)

;; (use-package keycast
;;   :ensure t
;;   :init (keycast-mode))

(provide 'global-packages)
;;; global-packages.el ends here
