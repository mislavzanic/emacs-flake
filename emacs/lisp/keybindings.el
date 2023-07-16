;;; easy-keys.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Mislav Zanic
;;
;; Author: Mislav Zanic <mislavzanic3@gmail.com>
;; Maintainer: Mislav Zanic <mislavzanic3@gmail.com>
;; Created: March 23, 2023
;; Modified: March 23, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/mzanic/easy-keys
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.01))

(use-package general
  :config
  (general-evil-setup))

(general-create-definer mzanic/leader-keys
  :keymaps '(normal insert visual emacs)
  :prefix "SPC"
  :global-prefix "C-SPC")

(mzanic/leader-keys
  "f" '(:ignore t :wk "file")
  "ff" '(find-file :wk "find file")
  "fg" '(consult-ripgrep :wk "ripgrep"))

(mzanic/leader-keys
  "b" '(:ignore t :wk "buffer")
  "bk" '(kill-this-buffer :wk "kill this buffer"))

(mzanic/leader-keys
  "d" '(:ignore t :wk "dired")
  "dd" 'dired)

(provide 'keybindings)
;;; easy-keys.el ends here
