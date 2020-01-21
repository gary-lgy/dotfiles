;;; my-evil.el ---  My config for evil -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'my-package-config)

(use-package evil
  :defines
  evil-want-Y-yank-to-eol
  :functions
  evil-select-search-module
  evil-set-initial-state
  :after undo-tree
  :custom
  (evil-want-integration t)
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  (evil-want-fine-undo t)
  (evil-want-Y-yank-to-eol t)
  (evil-move-beyond-eol nil)
  (evil-shift-width 2)
  (evil-split-window-below t)
  (evil-vsplit-window-right t)
  (evil-respect-visual-line-mode t)
  :config
  (evil-mode 1)
  (evil-select-search-module 'evil-search-module 'evil-search)
  (evil-set-initial-state 'term-mode 'emacs)
  (evil-set-initial-state 'undo-tree-visualizer-mode 'emacs))

(use-package evil-collection
  :after evil
  :custom
  (evil-collection-company-use-tng nil)
  (evil-collection-setup-minibuffer t)
  :config
  (delq 'outline evil-collection-mode-list)
  (delq 'go-mode evil-collection-mode-list)
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :delight
  :after evil
  :config
  (evil-commentary-mode 1))

(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode 1))

(use-package evil-textobj-column
  :after evil
  :general
  (general-itomap
	"c" #'evil-textobj-column-word
	"C" #'evil-textobj-column-WORD))

(use-package evil-args
  :after evil
  :general
  (general-itomap "a" #'evil-inner-arg)
  (general-otomap "a" #'evil-outer-arg)
  :config
  (add-hook 'emacs-lisp-mode-hook
			(lambda ()
			  (set (make-local-variable 'evil-args-delimiters) '(" " "\t")))))

(use-package evil-visualstar
  :after evil
  :config
  (global-evil-visualstar-mode 1))

(use-package evil-exchange
  :after evil
  :config
  (evil-exchange-cx-install))

(use-package evil-textobj-entire
  :after evil
  :general
  (general-itomap "e" #'evil-entire-entire-buffer)
  (general-otomap "e" #'evil-entire-entire-buffer))

(use-package evil-lion
  :after evil
  :config
  (evil-lion-mode 1))

(use-package avy)

(provide 'my-evil)
;;; my-evil.el ends here
