;;; my-misc-packages --- My standalone packages -*- lexical-binding: t -*-

;;; Commentary:
;; Packages that do not form their own group (e.g. evil, company)

;;; Code:

(require 'my-package-config)

(use-package smooth-scroll
  :functions
  smooth-scroll-mode
  :delight
  :init
  (setq smooth-scroll/vscroll-step-size 4)
  :config
  (smooth-scroll-mode))

(use-package restart-emacs
  :custom
  (restart-emacs-restore-frames t))

(use-package magit)

(use-package projectile
  :delight '(:eval (format "Proj[%s]" (projectile-project-name)))
  :config
  (projectile-mode t))

(provide 'my-misc-packages)
;;; my-misc-packages ends here
