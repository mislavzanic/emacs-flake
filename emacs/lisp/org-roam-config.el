;;; org-roam-config.el: -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Mislav Zanic
;;
;; Author: Mislav Zanic <mislavzanic3@gmail.com>
;; Maintainer: Mislav Zanic <mislavzanic3@gmail.com>
;; Created: March 23, 2023
;; Modified: March 23, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/mzanic/org-roam-config
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:

(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))

(defun efs/org-roam-capture-inbox ()
  (interactive)
  (org-roam-capture- :node (org-roam-node-create)
                    :templates '(("i" "inbox" plain "* %?"
                                 :if-new (file+head "inbox.org" "#+title: Inbox\n")))))

(defun mz/org-roam-capture-task ()
  (interactive)
  (org-roam-capture- :node (org-roam-node-create)
                    :templates '(("t" "todo entry" plain "* %?"
                                 :if-new (file+head "agenda.org" "#+title: Agenda\n")))))

(global-set-key (kbd "C-c n b") #'efs/org-roam-capture-inbox)

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/.local/notes/org-roam")
  (org-roam-complete-everywhere t)
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n l" . org-roam-buffer-toggle)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n I" . org-roam-node-insert-immediate)
	 ("C-c n b" . #'efs/org-roam-capture-inbox)
	 ("C-c n t" . #'mz/org-roam-capture-task)
         ;; :map org-roam-map
         ;; ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))

  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)

  :config
  (require 'org-roam-dailies) ;; Ensure the keymap is available
  (org-roam-db-autosync-mode)

  (defun efs/org-roam-filter-by-tag (tag-name)
    (lambda (node)
      (member tag-name (org-roam-node-tags node))))

  (setq org-roam-capture-templates
        '(("m" "main" plain
           "%?"
           :if-new (file+head "main/${slug}.org"
                              "#+title: ${title}\n")
           :immediate-finish t
           :unnarrowed t)
          ("n" "notes" plain "%?"
           :if-new
           (file+head "notes/${title}.org" "#+title: ${title}\n#+filetags: :notes:\n#+startup: entitiespretty\n")
           :immediate-finish t
           :unnarrowed t)
          ("w" "work notes" plain "%?"
           :if-new
           (file+head "work_notes/${title}.org" "#+title: ${title}\n#+filetags: :work:\n")
           :immediate-finish t
           :unnarrowed t)))

  (cl-defmethod org-roam-node-type ((node org-roam-node))
    "Return the TYPE of NODE."
    (condition-case nil
        (file-name-nondirectory
         (directory-file-name
          (file-name-directory
           (file-relative-name (org-roam-node-file node) org-roam-directory))))
      (error "")))

  (setq org-roam-node-display-template
        (concat "${title:*} " (propertize "${tags:50}" 'face 'org-tag)))

  (setq org-roam-dailies-directory "journal/"))


(provide 'org-roam-config)
;;; org-roam-config.el ends here
