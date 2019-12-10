;;; init.el --- My config file -*- lexical-binding: t -*-

;;; Commentary:
;; This file only provides a skeleton and loads files from init.d

;;; Code:

;;; Move the annoying Custom crap into its own file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load-file custom-file)

;; Load other init files
(add-to-list 'load-path (expand-file-name "init.d" user-emacs-directory))

(require 'my-misc-config)
(require 'my-package-config)
(require 'my-misc-packages)
(require 'my-editing)
(require 'my-appearance)
(require 'my-helm)
(require 'my-company)
(require 'my-flycheck)
(require 'my-evil)
(require 'my-lsp)
(require 'my-project)
(require 'my-keys)

(require 'my-elisp)
(require 'my-org)
(require 'my-documents)
(require 'my-go)

(provide 'init)
;;; init.el ends here
