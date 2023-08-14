;;; dired-config.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Mislav Zanic
;;
;; Author: Mislav Zanic <mislavzanic3@gmail.com>
;; Maintainer: Mislav Zanic <mislavzanic3@gmail.com>
;; Created: March 23, 2023
;; Modified: March 23, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/mzanic/dired-config
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(use-package dired
  :ensure nil
  :hook (dired-mode . diredfl-mode)
  :bind (("C-c C-j" . dired-jump))
  :config
  (evil-define-key 'normal dired-mode-map
    (kbd "h") 'dired-up-directory
    (kbd "l") 'dired-find-file ; use dired-find-file instead of dired-open.
    (kbd "m") 'dired-mark
    (kbd "t") 'dired-toggle-marks
    (kbd "u") 'dired-unmark
    (kbd "C") 'dired-do-copy
    (kbd "D") 'dired-do-delete
    (kbd "J") 'dired-goto-file
    (kbd "M") 'dired-chmod
    (kbd "O") 'dired-chown
    (kbd "P") 'dired-do-print
    (kbd "R") 'dired-rename
    (kbd "T") 'dired-do-touch
    (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
    (kbd "+") 'dired-create-directory
    (kbd "N") 'dired-create-directory
    (kbd "n") 'find-file
    (kbd "-") 'dired-up-directory
    (kbd "% l") 'dired-downcase)
  (add-hook 'dired-mode-hook 'auto-revert-mode)
  (setq dired-listing-switches "-aBhl  --group-directories-first")
  (use-package dired-narrow)
  (use-package diredfl)                 ; More colorful output
  (use-package dired-x                  ; Cool Extra functionality
    :ensure nil))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :config
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv")
                                ("pdf" . "zathura"))))

(provide 'dired-conf)
;;; dired-config.el ends here
