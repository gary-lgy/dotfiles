;;; my-flycheck.el --- My flycheck config -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'my-package-config)

(use-package flycheck
  :delight
  :custom
  (flycheck-emacs-lisp-load-path 'inherit)
  :config
  (global-flycheck-mode 1)
  (add-hook 'go-mode-hook
			(lambda ()
			  (flycheck-add-next-checker 'lsp-ui 'go-gofmt))))

(provide 'my-flycheck)
;;; my-flycheck.el ends here
