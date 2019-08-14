;;; my-misc-config --- My miscellaneous config -*- lexical-binding t -*-

;;; Commentary:
;; Config that are not large enough to have their own modules

;;; Code:

;; Display tabs as 4 spaces
(setq-default tab-width 4)

;; Minimize lag
(setq auto-window-vscroll nil)

;; Window and buffer settings
(substitute-key-definition #'kill-buffer #'kill-buffer-and-window global-map)
(setq help-window-select t)

;; Electric modes
(electric-indent-mode t)

;; Save point place across sessions
(save-place-mode t)

;; Visualize Whitespace
(require 'whitespace)
(setq whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
 '(whitespace-tab ((t (:foreground "#636363")))))
(setq whitespace-display-mappings
      '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
(global-whitespace-mode)

;; Line numbers
(defvar display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

;; Visual line mode
(global-visual-line-mode t)

;; Font
(set-face-font 'default "Fira Code-12")
;; (set-face-font 'default "Iosevka-13")
;; (set-face-font 'default "Source Code Pro-12")

;; Spell check
(setq ispell-program-name "hunspell")
(add-hook 'text-mode-hook #'flyspell-mode)
(add-hook 'prog-mode-hook #'flyspell-prog-mode)
(setq ispell-complete-word-dict (file-truename "/usr/share/dict/british"))

;; Scroll
(setq scroll-conservatively 101
      scroll-margin 20)

;; ElDoc
(eldoc-mode t)

;; which-function
(which-function-mode t)

;; Turn off useless stuff
(setq inhibit-startup-screen t)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Save the damn history
(setq savehist-save-minibuffer-history t
	  savehist-additional-variables
	  '(evil-ex-search-history
		search-ring
		regexp-search-ring
		kill-ring
		compile-history
		log-edit-comment-ring)
	  savehist-file (expand-file-name "savehist" user-emacs-directory))
(savehist-mode t)

;; Backup
(setq version-control t
      kept-new-versions 10
      kept-old-versions 0
      delete-old-versions t
      backup-by-copying t
      vc-make-backup-files t
      backup-directory-alist `(("." . ,(expand-file-name "backups" user-emacs-directory))))

(provide 'my-misc-config)
;;; my-misc-config.el ends here
