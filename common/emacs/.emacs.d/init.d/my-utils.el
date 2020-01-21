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

(defun my-open-emacs-config-files ()
  "Choose and open Emacs config files."
  (interactive)
  (helm-find-files-1 (expand-file-name "init.d/" user-emacs-directory)))

(defun my-open-org-files ()
  "Choose and open my Org-mode notes."
  (interactive)
  (projectile-switch-project-by-name "~/Notes/"))

(defun my-open-dotfiles ()
  "Choose and open one of my config files."
  (interactive)
  (projectile-switch-project-by-name "~/dotfiles"))

(defun my-open-tmp-dir ()
  "Choose and open a file in ~/tmp."
  (interactive)
  (helm-find-files-1 "~/tmp/"))

(defun my-reload-emacs-config-file ()
  "Reload my Emacs config file."
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory)))

(defun my-evil-exchange-line-above ()
  "Exchange current line with the line above."
  (interactive)
  (if (> (line-number-at-pos) 1)
    (save-excursion
      (forward-line -1)
      (call-interactively #'evil-delete-whole-line)
      (call-interactively #'evil-paste-after)
	  (setq kill-ring (cdr kill-ring)))))

;; TODO: Handle edge cases
(defun my-evil-exchange-line-below ()
  "Exchange current line with the line below."
  (interactive)
  (save-excursion
	(if (= 0 (forward-line 1))
		(progn
		  (call-interactively #'evil-delete-whole-line)
		  (forward-line -1)
		  (call-interactively #'evil-paste-before)
		  (setq kill-ring (cdr kill-ring))))))

(defun my-kill-other-buffers ()
  "Kill all buffers except the current one."
  (interactive)
  (if (y-or-n-p-with-timeout "Kill other buffers? " 3 nil)
	  (let ((buffers-to-kill (delq (current-buffer) (buffer-list))))
		(mapc #'kill-buffer buffers-to-kill)
		(message "Killed %d other buffers" (seq-length buffers-to-kill)))))

(defvar my-fonts '("Fira Code-12" "Iosevka-13" "Source Code Pro-12"))
(defun my-select-font ()
  "Select the font to use."
  (interactive)
  (set-face-font 'default
   (ido-completing-read "Change font to: " my-fonts nil t)))

;; TODO: Change hunspell dict
(defvar my-dictionaries '("/usr/share/dict/american-english" "/usr/share/dict/british-english"))
(defun my-select-dictionary ()
  "Select the dictionary to use for spelling help."
  (interactive)
  (let* ((prev-dict ispell-complete-word-dict)
		 (dict (ido-completing-read "Change dictionary to: " my-dictionaries nil t prev-dict)))
	(customize-set-variable 'ispell-complete-word-dict dict)
	(customize-set-variable 'ispell-alternate-dictionary dict)))

(provide 'my-utils)
;;; my-utils.el ends here
