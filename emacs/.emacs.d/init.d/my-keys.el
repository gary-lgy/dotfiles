;;; my-keys.el --- My key bindings -*- lexical-binding: t -*-

;;; Commentary:
;; TODO: Use unimpaired bindings from
;; https://github.com/syl20bnr/spacemacs/blob/master/layers/%2Bspacemacs/spacemacs-evil/local/evil-unimpaired/evil-unimpaired.el

;;; Code:

(require 'my-package-config)
(require 'my-misc-packages)
(require 'winner)
(require 'my-evil)
(require 'my-helm)
(require 'my-utils)
(require 'my-flycheck)
(require 'my-project)
(require 'my-org)
(require 'my-editing)
(require 'my-documents)
(require 'my-company)
(require 'my-lsp)

(use-package which-key
  :delight
  :config
  (which-key-mode 1))

;;; Leader bindings

;; Generic leader
(general-create-definer my-leader
  :prefix "SPC"
  :prefix-command 'my-leader-prefix-command
  :prefix-map     'my-leader-prefix-map
  :states         '(normal visual motion)
  :keymaps        'override)
(my-leader
  "SPC" #'helm-M-x
  "j"   #'save-buffer
  "k"   #'delete-window
  "TAB" #'evil-switch-to-windows-last-buffer)

;; Emacs/eyebrowse leader
(general-create-definer my-emacs-eyebrowse-leader
  :prefix "SPC e"
  :prefix-command 'my-emacs-eyebrowse-leader-prefix-command
  :prefix-map 'my-emacs-eyebrowse-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-emacs-eyebrowse-leader
  "r"   #'restart-emacs
  "q"   #'save-buffers-kill-terminal
  "R"   #'my-reload-emacs-config-file
  "h"   #'eyebrowse-prev-window-config
  "l"   #'eyebrowse-next-window-config
  "e"   #'eyebrowse-last-window-config
  "d"   #'eyebrowse-close-window-config
  "t"   #'eyebrowse-rename-window-config
  "SPC" #'eyebrowse-switch-to-window-config
  "0"   #'eyebrowse-switch-to-window-config-0
  "1"   #'eyebrowse-switch-to-window-config-1
  "2"   #'eyebrowse-switch-to-window-config-2
  "3"   #'eyebrowse-switch-to-window-config-3
  "4"   #'eyebrowse-switch-to-window-config-4
  "5"   #'eyebrowse-switch-to-window-config-5
  "6"   #'eyebrowse-switch-to-window-config-6
  "7"   #'eyebrowse-switch-to-window-config-7
  "8"   #'eyebrowse-switch-to-window-config-8
  "9"   #'eyebrowse-switch-to-window-config-9)

;; Buffer leader
(general-create-definer my-buffer-leader
  :prefix "SPC b"
  :prefix-command 'my-buffer-leader-prefix-command
  :prefix-map 'my-buffer-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-buffer-leader
  "b" #'helm-mini
  "d" #'kill-this-buffer
  "k" #'kill-buffer-and-window
  "s" (lambda () (interactive) (switch-to-buffer "*scratch*"))
  "m" (lambda () (interactive) (switch-to-buffer "*Messages*"))
  "O" #'my-kill-other-buffers)

;; Window leader
(general-create-definer my-window-leader
  :prefix "SPC w"
  :prefix-command 'my-window-leader-prefix-command
  :prefix-map 'my-window-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-window-leader
  "j"   #'evil-window-down
  "k"   #'evil-window-up
  "h"   #'evil-window-left
  "l"   #'evil-window-right
  "s"   #'split-window-right
  "v"   #'split-window-below
  "w"   #'other-window
  "d"   #'delete-window
  "o"   #'delete-other-windows
  "r"   #'evil-window-rotate-downwards
  "R"   #'evil-window-rotate-upwards
  "="   #'evil-window-increase-height
  "-"   #'evil-window-decrease-height
  "."   #'evil-window-increase-width
  ","   #'evil-window-decrease-width
  "+"   #'balance-windows
  "W"   #'window-configuration-to-register
  "g"   #'jump-to-register
  "u"   #'winner-undo
  "C-r" #'winner-redo)

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
  "F" #'helm-find)

;; Project leader
(general-create-definer my-project-leader
  :prefix "SPC p"
  :prefix-command 'my-project-leader-prefix-command
  :prefix-map 'my-project-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-project-leader
  "p"   #'helm-projectile-switch-project
  "f"   #'helm-projectile-find-file
  "d"   #'projectile-dired
  "r"   #'helm-projectile-recentf
  "s"   #'projectile-run-eshell
  "K"   #'projectile-kill-buffers
  "g"   #'projectile-ripgrep
  "SPC" #'projectile-commander
  "t"   #'projectile-toggle-between-implementation-and-test)

;; Search leader
(general-create-definer my-search-leader
  :prefix "SPC s"
  :prefix-command 'my-search-leader-prefix-command
  :prefix-map 'my-search-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-search-leader
  "r" #'ripgrep-regexp
  "n" #'evil-ex-nohighlight
  "o" #'helm-occur)

;; vc leader
(general-create-definer my-vc-leader
  :prefix "SPC g"
  :prefix-command 'my-vc-leader-prefix-command
  :prefic-map 'my-vc-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-vc-leader
 "t" #'git-gutter
 "v" #'git-gutter:popup-hunk
 "s" #'git-gutter:stage-hunk
 "r" #'git-gutter:revert-hunk
 "g" #'magit)

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
  "p" #'describe-package
  "c" #'customize-group)

;; Org leader
(general-create-definer my-org-leader
  :prefix "SPC o"
  :prefix-command 'my-org-leader-prefix-command
  :prefix-map 'my-org-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-org-leader
  "a" #'org-agenda
  "p" #'org-pomodoro
  "o" #'my-open-org-files
  "c" #'org-capture
  "l" #'org-store-link)

;; Miscellaneous leader
(general-create-definer my-misc-leader
  :prefix "SPC ,"
  :prefix-command 'my-misc-leader-prefix-command
  :prefix-map 'my-misc-leader-prefix-map
  :states '(normal visual motion)
  :keymaps 'override)
(my-misc-leader
  "s" #'shell-command
  "f" #'my-select-font
  "D" #'my-select-dictionary
  "," #'evil-avy-goto-line
  "." #'evil-avy-goto-word-1
  "e" #'my-open-emacs-config-files
  "d" #'my-open-dotfiles
  "t" #'my-open-tmp-dir)

;;; Other bindings

;; Resizing window
(general-def
  "S-C-h" #'shrink-window-horizontally
  "S-C-l" #'enlarge-window-horizontally
  "S-C-j" #'shrink-window
  "S-C-k" #'enlarge-window)

(general-unbind 'normal
  "J"
  "K")

(mmap
  "J"   #'evil-forward-paragraph
  "K"   #'evil-backward-paragraph
  "H"   #'evil-first-non-blank
  "L"   #'evil-end-of-line
  "gm"  #'evilmi-jump-items
  "[d"  #'flycheck-previous-error
  "]d"  #'flycheck-next-error
  "g:"  #'eval-expression
  "]a"  #'evil-forward-arg
  "[a"  #'evil-backward-arg
  "[b"  #'previous-buffer
  "]b"  #'next-buffer
  "]h"  #'git-gutter:next-hunk
  "[h"  #'git-gutter:previous-hunk
  "C-j" #'evil-scroll-line-down
  "C-k" #'evil-scroll-line-up)

(nmap
  "gJ"    #'evil-join
  "] SPC" #'my-insert-line-below
  "[ SPC" #'my-insert-line-above
  "[e"    #'my-evil-exchange-line-above
  "]e"    #'my-evil-exchange-line-below
  "M-u"   #'universal-argument)

(iemap
  "C-a" #'evil-first-non-blank
  "C-e" #'end-of-line
  "C-j" #'next-line
  "C-k" #'previous-line
  "M-u" #'universal-argument)

;; press `jk' in insert mode to simulate `ESC'
(imap
  "j" (general-key-dispatch 'self-insert-command
		:timeout 0.25
		"k" 'evil-normal-state)
  "k" (general-key-dispatch 'self-insert-command
		:timeout 0.25
		"j" 'evil-normal-state))

(provide 'my-keys)
;;; my-keys.el ends here
