;;; my-keys.el --- My key bindings -*- lexical-binding: t -*-

;;; Commentary:
;; TODO: Use unimpaired bindings from
;; https://github.com/syl20bnr/spacemacs/blob/master/layers/%2Bspacemacs/spacemacs-evil/local/evil-unimpaired/evil-unimpaired.el

;;; Code:

(require 'my-package-config)
(require 'my-evil)
(require 'my-utils)
(require 'my-flycheck)
(require 'org)

(use-package general
  :config
  (general-evil-setup t))

(use-package which-key
  :delight
  :config
  (which-key-mode))

;;; Leader bindings

;; Generic leader
(general-create-definer my-leader
  :prefix "SPC"
  :prefix-command 'my-leader-prefix-command
  :prefix-map 'my-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-leader
  "SPC" #'helm-M-x
  "j"   #'save-buffer
  "k"   #'delete-window
  "TAB" #'evil-switch-to-windows-last-buffer)

;; Emacs leader
(general-create-definer my-emacs-leader
  :prefix "SPC e"
  :prefix-command 'my-emacs-leader-prefix-command
  :prefix-map 'my-emacs-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-emacs-leader
  "r"   #'restart-emacs
  "q"   #'save-buffers-kill-terminal)

;; Buffer leader
(general-create-definer my-buffer-leader
  :prefix "SPC b"
  :prefix-command 'my-buffer-leader-prefix-command
  :prefix-map 'my-buffer-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-buffer-leader
  "b" #'helm-mini
  "k" #'kill-buffer-and-window
  "s" (lambda () (interactive) (switch-to-buffer "*scratch*"))
  "m" (lambda () (interactive) (switch-to-buffer "*Messages*")))

;; Window leader
(general-create-definer my-window-leader
  :prefix "SPC w"
  :prefix-command 'my-window-leader-prefix-command
  :prefix-map 'my-window-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-window-leader
  "j"       #'evil-window-down
  "k"       #'evil-window-up
  "h"       #'evil-window-left
  "l"       #'evil-window-right
  "s"       #'split-window-right
  "v"       #'split-window-below
  "w"       #'other-window
  "k"       #'delete-window
  "o"       #'delete-other-windows)

;; File leader
(general-create-definer my-file-leader
  :prefix "SPC f"
  :prefix-command 'my-file-leader-prefix-command
  :prefix-map 'my-file-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-file-leader
  "d" #'dired
  "s" #'save-buffer
  "r" #'helm-recentf
  "f" #'helm-find-files
  "F" #'helm-find
  "e" #'my-open-emacs-config-files
  "o" #'my-open-org-files
  "R" #'my-reload-emacs-config-file)

;; Project leader
(general-create-definer my-project-leader
  :prefix "SPC p"
  :prefix-command 'my-project-leader-prefix-command
  :prefix-map 'my-project-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-project-leader
  "p" #'helm-projectile-switch-project
  "f" #'helm-projectile-find-file
  "d" #'projectile-dired
  "r" #'projectile-recentf
  "t" #'projectile-run-term
  "s" #'projectile-run-shell
  "K" #'projectile-kill-buffers)

;; Search leader
(general-create-definer my-search-leader
  :prefix "SPC s"
  :prefix-command 'my-search-leader-prefix-command
  :prefix-map 'my-search-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-search-leader
  "d" #'deadgrep
  "n" #'evil-ex-nohighlight
  "o" #'helm-occur)

;; Help leader
(general-create-definer my-help-leader
  :prefix "SPC h"
  :prefix-command 'my-help-leader-prefix-command
  :prefix-map 'my-help-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-help-leader
  "k" #'describe-key
  "f" #'describe-function
  "v" #'describe-variable
  "b" #'describe-bindings
  "p" #'describe-package)

;;; Other bindings

;; Resizing window
(general-def
  "S-C-h" #'shrink-window-horizontally
  "S-C-l" #'enlarge-window-horizontally
  "S-C-j" #'shrink-window
  "S-C-k" #'enlarge-window)

;; Use visual line operators
(general-swap-key nil 'motion
  "j" "gj"
  "k" "gk"
  "$" "g$"
  "^" "g^")

(general-unbind 'normal
  "J"
  "K")

(mmap
  "J"   #'evil-forward-paragraph
  "K"   #'evil-backward-paragraph
  "H"   #'evil-first-non-blank-of-visual-line
  "L"   #'evil-end-of-visual-line
  "gm"  #'evilmi-jump-items
  "[d"  #'flycheck-previous-error
  "]d"  #'flycheck-next-error
  "M-k" #'evil-lookup
  "g:"  #'eval-expression
  "]a"  #'evil-forward-arg
  "[a"  #'evil-backward-arg
  "[b"  #'previous-buffer
  "]b"  #'next-buffer)

(nmap
  "gJ"          #'evil-join
  "] SPC"       #'my-insert-line-below
  "[ SPC"       #'my-insert-line-above
  "[e"          #'my-evil-exchange-line-above
  "]e"          #'my-evil-exchange-line-below)

(iemap
  "C-a" #'evil-first-non-blank
  "C-e" #'end-of-line
  "C-n" #'next-line
  "C-j" #'next-line
  "C-p" #'previous-line
  "C-k" #'previous-line)

;; press `jk' in insert mode to simulate `ESC'
(imap
  "j" (general-key-dispatch 'self-insert-command
		:timeout 0.25
		"k" 'evil-normal-state)
  "k" (general-key-dispatch 'self-insert-command
		:timeout 0.25
		"j" 'evil-normal-state))

(itomap
  "c" #'evil-textobj-column-word
  "C" #'evil-textobj-column-WORD
  "a" #'evil-inner-arg
  evil-textobj-entire-key #'evil-entire-entire-buffer)

(otomap
  "a"  #'evil-outer-arg
  evil-textobj-entire-key #'evil-entire-entire-buffer)

;;; Bindings to specific maps

;; ELisp
(mmap emacs-lisp-mode-map
  "<RET>" #'eval-last-sexp
  "[]"    #'sp-beginning-of-sexp
  "]["    #'sp-end-of-sexp
  "]]"    #'sp-next-sexp
  "[["    #'sp-previous-sexp
  "]}"    #'sp-forward-slurp-sexp
  "]{"    #'sp-forward-barf-sexp
  "[}"    #'sp-backward-slurp-sexp
  "[{"    #'sp-backward-barf-sexp
  "))"    #'sp-down-sexp
  ")("    #'sp-up-sexp
  "()"    #'sp-backward-down-sexp
  "(("    #'sp-backward-up-sexp)

(iemap
  :keymaps '(emacs-lisp-mode-map lisp-interaction-mode-map)
  "#" #'my-insert-sharp-quote)

;; Org mode
(nmap org-mode-map
  "gm" #'org-ctrl-c-ctrl-c)

;; Helm
(general-def helm-map
  "C-h C-h" #'helm-execute-persistent-action
  "C-j"   #'helm-next-line
  "C-k"   #'helm-previous-line)

;; Company
(general-def
  "M-c" #'company-complete)

(general-def company-active-map
  "RET" #'company-complete-selection)

(provide 'my-keys)
;;; my-keys.el ends here
