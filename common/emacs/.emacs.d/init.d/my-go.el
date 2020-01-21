;;; my-go.el --- My Golang configurations -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'my-package-config)

(use-package go-mode
  :mode ("\\.go\\'" . go-mode)
  :mode ("go\\.mod\\'" . go-dot-mod-mode)
  :commands (go-mode go-dot-mod-mode)
  :custom
  (gofmt-command "goimports")
  :general
  ('normal go-mode-map
		   "SPC m SPC" #'gofmt
		   "SPC m RET" #'my-go-run-current-file
		   "SPC m I"   #'go-import-add
		   "SPC m f"   #'go-goto-function
		   "SPC m n"   #'go-goto-function-name
		   "SPC m a"   #'go-goto-arguments
		   "SPC m d"   #'go-goto-docstring
		   "SPC m r"   #'go-goto-return-values
		   "SPC m i"   #'go-goto-imports
		   "SPC m ."   #'go-goto-method-receiver)
  :config
  (defun my-go-run-current-file ()
	"Run the current file with `go run FILENAME'."
	(interactive)
	(when (y-or-n-p-with-timeout "Run this file? " 3 nil)
	  (shell-command (concat "go run " (buffer-file-name))))))

(provide 'my-go)
;;; my-go.el ends here
