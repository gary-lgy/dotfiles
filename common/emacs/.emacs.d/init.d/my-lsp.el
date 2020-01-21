;;; my-lsp.el --- Configuration for lsp-mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'my-package-config)
(require 'my-company)

(use-package lsp-mode
  :hook (prog-mode . lsp-deferred)
  :hook (yaml-mode . lsp-deferred)
  :commands (lsp lsp-deferred)
  :custom
  (lsp-auto-configure nil)
  (lsp-auto-guess-root t)
  (lsp-prefer-flymake nil)
  :config
  (require 'lsp-clients) ; might not be needed
  (defun my-lsp-use-peek-maybe (no-peek with-peek)
	(lambda (arg)
	  "Use `NO-PEEK' or `WITH-PEEK' if given prefix ARG"
	  (interactive "P")
	  (if (and (featurep 'lsp-ui-peek) arg)
		  (call-interactively with-peek)
		(call-interactively no-peek))))
  (defun my-lsp-mode-setup-keys ()
	(general-def 'normal 'local
	  "g d" (my-lsp-use-peek-maybe #'lsp-find-definition #'lsp-ui-peek-find-definitions)
	  "g h" (my-lsp-use-peek-maybe #'lsp-find-references #'lsp-ui-peek-find-references)
	  "g a" #'lsp-execute-code-action
	  "g o" #'lsp-organize-imports
	  "g i" (my-lsp-use-peek-maybe #'lsp-goto-implementation #'lsp-ui-peek-find-implementation)
	  "g t" #'lsp-goto-type-definition
	  "g r" #'lsp-rename
	  "M-k" #'lsp-ui-doc-glance))
  (add-hook 'lsp-mode-hook #'my-lsp-mode-setup-keys))

(use-package lsp-ui
  :after lsp-mode
  :custom
  (lsp-ui-doc-enable nil)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-flycheck-enable t)
  :hook (lsp-mode . lsp-ui-mode))

(use-package company-lsp
  :after (lsp-mode company)
  :hook
  (lsp-mode . (lambda ()
				(progn (my-company-add-backends #'company-lsp)
					   (setf (car company-backends)
							 (remove 'company-capf (car company-backends)))))))

(provide 'my-lsp)
;;; my-lsp.el ends here
