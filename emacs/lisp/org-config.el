;;; org-config.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Mislav Zanic
;;
;; Author: Mislav Zanic <mislavzanic3@gmail.com>
;; Maintainer: Mislav Zanic <mislavzanic3@gmail.com>
;; Created: March 23, 2023
;; Modified: March 23, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/mzanic/org-config
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(use-package org
  :init
  (setq org-todo-keywords
    '((sequence "TODO(t)" "SOMEDAY(s)" "IN-PROGRESS(i)" "HOLD(h)" "|" "DONE(d)")
      (sequence "TO-READ(r)" "READING(R)"                         "|" "HAVE-READ(D)")
      (sequence "PROJ(p)"                                         "|" "COMPLETED(c)")))

  :bind (("C-c a" . org-agenda))
  :config
  (add-hook 'org-mode-hook 'org-indent-mode)

  (setq org-directory "~/.local/notes/")
  (setq org-agenda-files '("~/.local/notes/org-roam/agenda.org"))
  (setq org-default-notes-file (expand-file-name "notes.org" org-directory))

  (setq org-agenda-start-with-log-mode t)
  (setq org-hide-emphasis-markers t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t))

(use-package org-agenda
  :ensure nil
  :custom
  (org-agenda-tags-column 77)
  (org-agenda-custom-commands
   `(("A" "Weekly Work Agenda"
      ((tags-todo "work"
	((org-agenda-skip-function '(org-agenda-skip-if nil '(timestamps)))
	 (org-agenda-skip-function `(org-agenda-skip-entry-if
		'notregexp ,(format "\\[#%s\\]" (char-to-string org-priority-highest))))
	 (org-agenda-block-separator nil)
	 (org-agenda-overriding-header "Important tasks without a deadline\n")))
       (todo "HOLD"
	((org-agenda-skip-function `(org-agenda-skip-entry-if
		'regexp ,(format "\\[#%s\\]" (char-to-string org-priority-highest))))
	 (org-agenda-block-separator nil)
	 (org-agenda-overriding-header "\nTasks on hold\n")))
       (agenda ""
	((org-agenda-span 1)
         (org-deadline-warning-days 0)
         (org-agenda-block-separator nil)
         (org-scheduled-past-days 0)
         (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
         (org-agenda-format-date "%A %-e %B %Y")
         (org-agenda-overriding-header "\nToday's agenda\n"))))))))

(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . evil-org-mode)
  :init
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org-bullets
  :after org
  :ensure t
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "●" "○" "◆" "●" "○" "◆")))

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.4))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.3))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))

(use-package org-journal
  :after org
  :ensure t
  :bind (("C-c j j" . org-journal-new-entry)
	 ("C-c j f" . org-journal-open-current-journal-file))
  :custom
  (org-journal-dir "~/.local/notes/work/journal/")
  (org-journal-file-type 'weekly)
  (org-journal-time-format "")
  (org-journal-time-prefix "- "))

(use-package org-present
  :ensure t
  :preface
  (defun mz/start-presentation ()
    (hide-mode-line-mode 1)
    (org-present-big)
    (company-mode -1)
    (rainbow-delimiters-mode -1)
    (setq olivetti-body-width 88))
  (defun mz/stop-presentation ()
    (hide-mode-line-mode -1)
    (org-present-small)
    (company-mode 1)
    (rainbow-delimiters-mode 1)
    (olivetti-mode -1))
  :hook
  (org-present-mode      . mz/start-presentation)
  (org-present-mode-quit . mz/stop-presentation))


(provide 'org-config)
;;; org-config.el ends here
