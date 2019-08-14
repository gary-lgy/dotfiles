;;; my-appearance.el --- My Emacs appearance configurations -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'my-package-config)

(use-package delight
  :config
  (delight '((eldoc-mode nil "eldoc")
			 (visual-line-mode nil "simple")
			 (markdown-mode "Md" :major)
			 (global-whitespace-mode nil "whitespace")
			 (emacs-lisp-mode ("Elisp" (lexical-binding ":Lex" ":Dyn")) :major))
		   (defadvice powerline-major-mode (around delight-powerline-major-mode activate)
			 "Ensure that powerline's major mode names are delighted."
			 (let ((inhibit-mode-name-delight nil))
			   ad-do-it))))

(use-package doom-themes
  :init
  (setq doom-themes-enable-bold t
		doom-themes-enable-italic t)
  :config
  (doom-themes-org-config)
  (load-theme 'doom-one t))

;; TODO: consider doom-modeline
(use-package telephone-line
  :init
  (setq telephone-line-primary-left-separator    'telephone-line-cubed-right
		telephone-line-secondary-left-separator  'telephone-line-cubed-hollow-right
		telephone-line-primary-right-separator   'telephone-line-cubed-left
		telephone-line-secondary-right-separator 'telephone-line-cubed-left
		telephone-line-height 24
		telephone-line-evil-use-short-tag t)
  :config
  (telephone-line-mode t))

(provide 'my-appearance)
;;; my-appearance.el ends here
