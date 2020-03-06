;;; my-org.el --- My config for org-mode -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:
(require 'my-package-config)

;; For export to HTML
(use-package htmlize)

(use-package org
  :ensure org-plus-contrib
  :pin org
  :custom
  (org-export-backends '(ascii beamer html icalendar latex md odt))
  (org-modules '(org-tempo))
  ;; Hide markers
  (org-hide-emphasis-markers nil)
  (org-hide-leading-stars t)
  (org-export-with-toc nil)
  ;; Sub and superscripts
  (org-use-sub-superscripts '{})
  (org-pretty-entities-include-sub-superscripts t)
  (org-export-with-sub-superscripts t)
  ;; Nice options for working with notes
  (org-startup-align-all-tables t)
  (org-startup-indented t)
  (org-startup-with-inline-images t)
  (org-startup-with-latex-preview t)
  (org-pretty-entities t)
  (org-image-actual-width nil)
  ;; Org attach
  (org-attach-use-inheritance t)
  ;; Todo
  (org-todo-keywords '((sequence "TODO" "LATER" "|" "DONE")))
  (org-todo-keyword-faces '(("TODO" . org-todo) ("LATER" . org-warning)))
  (org-enforce-todo-dependencies t)
  (org-clock-persist 'history)
  ;; Org-babel
  (org-confirm-babel-evaluate nil)
  (org-src-fontify-natively t)
  (org-src-tab-acts-natively t)
  (org-babel-load-languages '((emacs-lisp . t)
							  (lisp       . t)
							  (shell      . t)
							  (python     . t)
							  (ruby       . t)
							  (java       . t)
							  (C          . t)
							  (js         . t)
							  (latex      . t)
							  (css        . t)
							  (org        . t)
							  (calc       . t)
							  (dot        . t)
							  (plantuml   . t)))
  ;; Editing
  (org-special-ctrl-a/e t)
  :general
  ('(normal visual motion) org-mode-map
   "RET"     #'org-open-at-point
   "SPC m m" #'org-ctrl-c-ctrl-c
   "SPC m 8" #'org-ctrl-c-star
   "SPC m -" #'org-ctrl-c-minus
   "SPC m ," #'org-edit-special
   "SPC m s" #'org-schedule
   "SPC m t" #'org-todo
   "SPC m a" #'org-archive-subtree-default
   "SPC m e" #'org-export-dispatch
   "SPC m i" #'org-toggle-inline-images
   "SPC m l" #'org-latex-preview
   "SPC m T" #'org-table-create-or-convert-from-region
   "SPC m p" #'org-set-property
   "SPC m f" #'org-refile)
  :config
  (delight 'org-indent-mode nil "org-indent")
  (org-clock-persistence-insinuate)
  (require 'ox-extra)
  (ox-extras-activate '(latex-header-blocks ignore-headlines)))

(use-package evil-org
  :delight
  :after (evil org)
  :hook (org-mode . evil-org-mode)
  :custom
  (evil-org-use-additional-insert t)
  (evil-org-retain-visual-state-on-shift t)
  :config
  (evil-org-set-key-theme '(navigation insert return textobjects additional))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org-bullets
  :after org
  :custom
  (org-bullets-bullet-list '("✿" "✸" "◉" "○"))
  :hook (org-mode . org-bullets-mode))

(use-package org-download
  :after org
  :custom
  (org-download-method 'attach)
  :general
  ('(normal visual motion) org-mode-map
   "SPC m S" #'org-download-screenshot
   "SPC m I" #'org-download-image)
  :hook
  (org-mode . org-download-enable)
  :config
  (if (eq system-type 'darwin)
	  (customize-set-value 'org-download-screenshot-method "screencapture -i %s")
	(customize-set-value 'org-download-screenshot-method "xclip -selection clipboard -t image/png -o > %s")))

(use-package org-pomodoro
  :after org
  :custom
  (org-pomodoro-clock-break nil)
  (org-pomodoro-manual-break t))

(provide 'my-org)
;;; my-org.el ends here
