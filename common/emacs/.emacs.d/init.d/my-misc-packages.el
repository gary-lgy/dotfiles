;;; my-misc-packages --- My standalone packages -*- lexical-binding: t -*-

;;; Commentary:
;; Packages that do not form their own group (e.g. evil, company)

;;; Code:

(require 'my-package-config)

(use-package paradox
  :config
  (paradox-enable))

(use-package smooth-scroll
  :functions
  smooth-scroll-mode
  :delight
  :init
  (setq smooth-scroll/vscroll-step-size 4)
  :config
  (smooth-scroll-mode 1))

(use-package restart-emacs
  :custom
  (restart-emacs-restore-frames t))

(use-package eyebrowse
  :custom
  (eyebrowse-new-workspace t)
  (eyebrowse-wrap-around t)
  :config
  (eyebrowse-mode 1))

(use-package winner
  :config
  (winner-mode 1))

(use-package dired
  :ensure nil
  :custom
  (dired-listing-switches "-alh"))

(use-package eldoc
  :delight
  :config
  (eldoc-mode 1))

(use-package imenu
  :custom
  (imenu-auto-rescan t))

(use-package saveplace
  :config
  (save-place-mode 1))

(use-package autorevert
  :demand t
  :hook (dired-mode . auto-revert-mode)
  :custom
  (auto-revert-verbose nil)
  :config
  (global-auto-revert-mode 1))

(use-package desktop
  :init
  (setq desktop-dirname user-emacs-directory)
  :config
  (desktop-save-mode 1))

(use-package savehist
  :custom
  (savehist-save-minibuffer-history t)
  (savehist-additional-variables
   '(evil-ex-search-history
	 search-ring
	 regexp-search-ring
	 kill-ring
	 compile-history
	 log-edit-comment-ring))
  (savehist-file (expand-file-name "savehist" user-emacs-directory))
  :config
  (savehist-mode 1))

(provide 'my-misc-packages)
;;; my-misc-packages ends here
