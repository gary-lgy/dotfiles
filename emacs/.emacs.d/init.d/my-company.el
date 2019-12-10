;;; my-company.el --- My config for compnay -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'my-package-config)
(require 'my-editing)

(use-package company
  :delight
  :functions
  my-company-add-backends
  :custom
  (company-idle-delay 0.1)
  (company-show-numbers t)
  (company-minimum-prefix-length 2)
  (company-selection-wrap-around t)
  (company-dabbrev-downcase nil)
  (company-dabbrev-code-everywhere t)
  (company-backends
   '((company-capf company-yasnippet company-files company-keywords company-gtags company-etags company-dabbrev)))
  :demand t
  :general
  ('(insert emacs)
   "M-c" #'company-complete)
  (company-active-map
	"M-y" #'company-complete-selection
	"RET" nil
	"<return>" nil)
  :config
  (defun my-company-add-backends (&rest backends)
	"Add BACKENDS into `company-backends'."
	(make-local-variable 'company-backends)
	(setq company-backends (copy-tree company-backends))
	(setf (car company-backends)
		  (append backends (car company-backends))))
  (add-hook 'text-mode-hook
			(lambda ()
			  (my-company-add-backends #'company-ispell)))
  (add-hook 'prog-mode-hook
			(lambda ()
			  (my-company-add-backends #'company-dabbrev-code)))
  (global-company-mode 1))

(use-package company-statistics
  :after company
  :config
  (company-statistics-mode 1))

(provide 'my-company)
;;; my-company.el ends here
