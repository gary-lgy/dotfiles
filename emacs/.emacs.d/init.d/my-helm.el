;;; my-helm.el --- My helm config -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'my-package-config)

(use-package helm
  :delight
  :bind (("M-x"     . helm-M-x)
		 ("M-y"     . helm-show-kill-ring)
		 ("C-x C-f" . helm-find-files)
		 ("C-x C-b" . helm-mini)
		 ("C-x b"   . helm-mini))
  :demand t
  :custom
  (helm-recentf-fuzzy-match t)
  (helm-buffers-fuzzy-matching t)
  (helm-locate-fuzzy-match t)
  (helm-M-x-fuzzy-match t)
  (helm-semantic-fuzzy-match t)
  (helm-imenu-fuzzy-match t)
  (helm-apropos-fuzzy-match t)
  (helm-lisp-fuzzy-completion t)
  (helm-session-fuzzy-match t)
  (helm-etags-fuzzy-match t)
  (helm-mode-fuzzy-match t)
  (helm-completion-in-region-fuzzy-match t)
  (helm-ff-DEL-up-one-level-maybe t)
  :config
  (helm-mode 1))

(use-package helm-flx
  :after helm
  :custom
  (helm-flx-for-helm-find-files t)
  (helm-flx-for-helm-locate t)
  :config
  (helm-flx-mode 1))

(use-package ido
  :custom
  (ido-case-fold t)
  (ido-enable-flex-matching t))

(provide 'my-helm)
;;; my-helm.el ends here
