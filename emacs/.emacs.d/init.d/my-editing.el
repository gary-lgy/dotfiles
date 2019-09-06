;;; my-editing.el --- My packages for editing files -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'my-package-config)

(use-package undo-tree
  :delight
  :init
  (setq undo-tree-auto-save-history t
		undo-tree-history-directory-alist `(("." . ,(expand-file-name
													 "undo"
													 user-emacs-directory)))))

(use-package ripgrep
  :custom
  (ripgrep-arguments '("--hidden" "--follow")))

(use-package fic-mode
  :custom
  (fic-foreground-color "Dark Orange")
  (fic-background-color nil)
  :load-path "external"
  :hook (prog-mode text-mode))

(use-package smartparens
  :delight
  :custom
  (sp-highlight-wrap-overlay nil)
  (sp-highlight-pair-overlay nil)
  (sp-autodelete-pair nil)
  :hook (prog-mode . smartparens-mode)
  :config
  (require 'smartparens-config))

(use-package highlight-parentheses
  :delight
  :hook (prog-mode . highlight-parentheses-mode))

(use-package editorconfig
  :config
  (editorconfig-mode t))

(use-package dtrt-indent
  :config
  (dtrt-indent-mode t))

(use-package markdown-mode
  :mode "\\.\(md\|markdown\)\\'")

(provide 'my-editing)
;;; my-editing.el ends here
