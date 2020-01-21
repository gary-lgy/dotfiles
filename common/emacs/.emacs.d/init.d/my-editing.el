;;; my-editing.el --- My packages for editing files -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'my-package-config)

;; Display tabs as 4 spaces
(setq-default tab-width 4)

;; Use visual lines
(global-visual-line-mode 1)
(delight 'visual-line-mode nil "simple")

;; display “lambda” as “λ”
(global-prettify-symbols-mode 1)

(use-package electric
  :config
  (electric-indent-mode 1))

;; Visualize white space
(use-package whitespace
  :delight global-whitespace-mode
  :custom
  (whitespace-style '(face tabs tab-mark empty trailing))
  (whitespace-display-mappings
   '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
  :init
  (custom-set-faces
   '(whitespace-tab ((t (:foreground "#636363")))))
  :config
  (global-whitespace-mode 1))

(use-package display-line-numbers
  :custom
  (display-line-numbers-type 'relative)
  :config
  (define-globalized-minor-mode my-globalized-display-line-numbers-mode display-line-numbers-mode
	(lambda ()
	  (unless (derived-mode-p 'doc-view-mode 'pdf-view-mode)
		(display-line-numbers--turn-on))))
  (my-globalized-display-line-numbers-mode 1))

(use-package undo-tree
  :delight
  :init
  (setq undo-tree-auto-save-history t
		undo-tree-history-directory-alist
		`(("." . ,(expand-file-name "undo" user-emacs-directory)))))

(use-package flyspell
  :delight
  :hook (text-mode . flyspell-mode)
  :init
  (defun my-save-word ()
	"Saves the word at point to the personal dictionary."
  (interactive)
  (let ((current-location (point))
         (word (flyspell-get-word)))
    (when (and (consp word)
			   (y-or-n-p (concat "Add \"" (car word) "\" to personal dictionary? ")))
      (flyspell-do-correct 'save nil
						   (car word)
						   current-location
						   (cadr word)
						   (caddr word)
						   current-location))))
  :general
  ('(normal motion)
   "z g" #'my-save-word)
  :custom
  (ispell-program-name "hunspell")
  (ispell-complete-word-dict (file-truename "/usr/share/dict/british")))

(use-package ripgrep
  :custom
  (ripgrep-arguments '("--hidden" "--follow")))

(use-package fic-mode
  :delight
  :custom
  (fic-foreground-color "Dark Orange")
  (fic-background-color nil)
  :load-path "external"
  :hook (prog-mode text-mode))

(use-package smartparens
  :delight
  :custom
  (sp-highlight-pair-overlay nil)
  :config
  (require 'smartparens-config)
  (sp-local-pair '(c-mode c++-mode java-mode go-mode js-mode jsx-mode swift-mode)
				 "{" nil
				 :post-handlers '(:add ("||\n[i]" "RET")))
  (sp-local-pair '(js-mode jsx-mode python-mode swift-mode)
				 "[" nil
				 :post-handlers '(:add ("||\n[i]" "RET")))
  (sp-local-pair 'swift-mode
				 "\\(" ")")
  (smartparens-global-mode 1))

(use-package highlight-parentheses
  :delight
  :hook (prog-mode . highlight-parentheses-mode))

(use-package editorconfig
  :config
  (editorconfig-mode 1))

(use-package dtrt-indent
  :config
  (dtrt-indent-mode 1))

(use-package yasnippet
  :delight yas-minor-mode
  :config
  (yas-global-mode 1)
  (use-package yasnippet-snippets))

(provide 'my-editing)
;;; my-editing.el ends here
