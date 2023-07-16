;;; early-init.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Mislav Zanic
;;
;; Author: Mislav Zanic <mislavzanic3@gmail.com>
;; Maintainer: Mislav Zanic <mislavzanic3@gmail.com>
;; Created: March 22, 2023
;; Modified: March 22, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/mzanic/early-init
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;      This is a copy-paste of Tony Zormans early-init.el.
;;      Link: https://gitlab.com/slotThe/dotfiles/-/blob/master/emacs/.config/emacs/early-init.el
;;
;;; Code:

(defvar file-name-handler-alist-old file-name-handler-alist)
(setq file-name-handler-alist   nil
      message-log-max           16384
      gc-cons-threshold         402653184
      gc-cons-percentage        0.6)
(add-hook 'after-init-hook
          (lambda ()
            (setq file-name-handler-alist file-name-handler-alist-old
                  gc-cons-threshold 16777216
                  gc-cons-percentage 0.1)
            (garbage-collect))
          t)

;; Always recompile libraries if needed.  This being in early init is in
;; line with `auto-compile's manual.
(let* ((dir "~/.config/emacs/elpa/")
       (packages (directory-files dir))
       (get-pkg (lambda (pkg)
                  (seq-find (lambda (p) (string-prefix-p pkg p))
                            packages))))
  (dolist (pkg (list (funcall get-pkg "compat")
                     (funcall get-pkg "packed")))
    (add-to-list 'load-path (concat dir pkg))))

(setq load-prefer-newer t)

(require 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

(setq frame-inhibit-implied-resize t)

(menu-bar-mode   -1)
(scroll-bar-mode -1)
(tool-bar-mode   -1)

;;; early-init.el ends here
