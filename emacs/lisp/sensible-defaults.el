;;; sensible-defaults.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Mislav Zanic
;;
;; Author: Mislav Zanic <mislavzanic3@gmail.com>
;; Maintainer: Mislav Zanic <mislavzanic3@gmail.com>
;; Created: March 23, 2023
;; Modified: March 23, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/mzanic/sensible-defaults
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(use-package emacs
  :ensure nil
  :custom (column-number-mode t)        ; for the modeline
  :bind (("C-c C-y" . yank-from-kill-ring))
  :config
  (setq-default cursor-type 'hbar)
  (setq kill-do-not-save-duplicates t) ; Don't save duplicates to kill ring

  (setq use-short-answers     t)    ; Why would you ever want to type a full yes?
  (setq y-or-n-p-use-read-key t)    ; read-key instead of minibuffer (more flexible)
  (setq visible-bell t)             ; Visual bell instead of audio bell.
  (advice-add 'display-line-numbers-mode :after
    (lambda (_)
      (when display-line-numbers-mode
        (setq display-line-numbers 'visual
          display-line-numbers-current-absolute t)))))

(provide 'sensible-defaults)
;;; sensible-defaults.el ends here
