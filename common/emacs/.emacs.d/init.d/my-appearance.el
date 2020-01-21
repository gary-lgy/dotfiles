;;; my-appearance.el --- My Emacs appearance configurations -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'my-package-config)

(set-face-font 'default "Fira Code-12")
;; (set-face-font 'default "Iosevka-13")
;; (set-face-font 'default "Source Code Pro-12")

(use-package page-break-lines
  :delight
  :config
  (global-page-break-lines-mode 1))

(use-package all-the-icons
  :config
  ;; Install fonts if they are not installed already
  (when (and (not (file-exists-p "~/.local/share/fonts/all-the-icons.ttf"))
			 (eq system-type 'gnu/linux))
	(all-the-icons-install-fonts)))

(use-package doom-themes
  :init
  (setq doom-themes-enable-bold t
		doom-themes-enable-italic t)
  :config
  (load-theme 'doom-vibrant t)
  (doom-themes-visual-bell-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package minions
  :config
  (minions-mode 1))

(use-package doom-modeline
  :custom
  (doom-modeline-project-detection 'projectile)
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-indent-info nil)
  (doom-modeline-checker-simple-format nil)
  (doom-modeline-persp-name nil)
  (doom-modeline-mu4e nil)
  (doom-modeline-irc nil)
  (column-number-indicator-zero-based nil)
  :hook (after-init . doom-modeline-mode)
  :hook (doom-modeline-mode . column-number-mode))

(provide 'my-appearance)
;;; my-appearance.el ends here
