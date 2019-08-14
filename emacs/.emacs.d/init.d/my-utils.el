;;; my-utils.el --- My utility functions -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:
(require 'evil)
(require 'helm)

(defun my-insert-line-above ()
  "Insert a line above."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (newline)))

(defun my-insert-line-below ()
  "Insert a line below."
  (interactive)
  (save-excursion
    (end-of-line)
    (newline)))

(defun my-insert-sharp-quote ()
  "Insert #' unless in a string or comment."
  (interactive)
  (call-interactively #'self-insert-command)
  (let ((ppss (syntax-ppss)))
    (unless (or (elt ppss 3)
              (elt ppss 4)
              (eq (char-after) ?'))
      (insert "'"))))

(defun my-open-emacs-config-files ()
  "Choose and open Emacs config files with helm-find-files."
  (interactive)
  (helm-find-files-1 (expand-file-name "init.d/" user-emacs-directory)))

(defun my-open-org-files ()
  "Choose and open my Org-mode notes with helm-find-files."
  (interactive)
  (helm-find-files-1 "~/Notes/"))

(defun my-reload-emacs-config-file ()
  "Reload my Emacs config file."
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory)))

;; TODO: Handle edge cases
(defun my-evil-exchange-line-above ()
  "Exchange current line with the line above."
  (interactive)
  (if (> (line-number-at-pos) 1)
    (save-excursion
      (forward-line -1)
      (call-interactively #'evil-delete-whole-line)
      (call-interactively #'evil-paste-after))))

(defun my-evil-exchange-line-below ()
  "Exchange current line with the line below."
  (interactive)
  (save-excursion
    (forward-line 1)
    (call-interactively #'evil-delete-whole-line)
    (forward-line -1)
    (call-interactively #'evil-paste-before)))

(provide 'my-utils)
;;; my-utils.el ends here
