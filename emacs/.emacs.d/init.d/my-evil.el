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
  :init
  (setq evil-want-integration nil
		evil-want-keybinding nil
		evil-want-C-u-scroll t
		evil-want-fine-undo t
		evil-want-Y-yank-to-eol t
		evil-move-beyond-eol nil
		evil-shift-width 2
		evil-split-window-below t
		evil-vsplit-window-right t)
  :after undo-tree
  :config
  (evil-mode t)
  (evil-select-search-module 'evil-search-module 'evil-search)
  (evil-set-initial-state 'deadgrep-mode 'emacs)
  (evil-set-initial-state 'term-mode 'emacs)
  (evil-set-initial-state 'undo-tree-visualizer-mode 'emacs))

(use-package evil-collection
  :after evil
  :custom
  (evil-collection-company-use-tng t)
  :config
  (evil-collection-init))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode t))

(use-package evil-commentary
  :delight
  :after evil
  :config
  (evil-commentary-mode t))

(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode t))

(use-package evil-textobj-column
  :after evil)

(use-package evil-args
  :after evil
  :config
  (add-hook 'emacs-lisp-mode-hook
			(lambda ()
			  (set (make-local-variable 'evil-args-delimiters) '(" " "\t")))))

(use-package evil-visualstar
  :after evil
  :config
  (global-evil-visualstar-mode t))

(use-package evil-exchange
  :after evil
  :config
  (evil-exchange-cx-install))

(use-package evil-textobj-entire
  :after evil)

(use-package evil-lion
  :after evil
  :config
  (evil-lion-mode t))

(provide 'my-evil)
;;; my-evil.el ends here
