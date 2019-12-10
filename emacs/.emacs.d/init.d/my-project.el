;;; my-project.el --- My configurations for working with projects -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'my-package-config)

(use-package vc
  :custom
  (vc-follow-symlinks t))

(use-package magit
  :config
  (use-package evil-magit
	:after evil))

(use-package git-gutter
  :delight
  :custom
  (git-gutter:ask-p nil)
  (git-gutter:modified-sign " ")
  (git-gutter:added-sign " ")
  (git-gutter:deleted-sign " ")
  (git-gutter:update-interval 2)
  ;; TODO: live update does not work: https://github.com/syohex/emacs-git-gutter/pull/166
  :config
  (set-face-attribute 'git-gutter:modified nil :inverse-video t)
  (set-face-attribute 'git-gutter:added nil :inverse-video t)
  (set-face-attribute 'git-gutter:deleted nil :inverse-video t)
  (add-to-list 'git-gutter:update-hooks 'focus-in-hook)
  (add-to-list 'git-gutter:update-commands 'other-window)
  (global-git-gutter-mode))

(use-package projectile
  :delight
  :custom
  (projectile-completion-system 'helm)
  :config
  (projectile-mode t))

;; TODO: refer to these for helm-projectile
;; https://github.com/syl20bnr/spacemacs/blob/master/layers/%2Bcompletion/helm/packages.el
(use-package helm-projectile
  :after (helm projectile))

(provide 'my-project)
;;; my-project.el ends here
