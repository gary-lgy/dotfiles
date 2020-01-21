;;; my-swift.el --- My swift configurations -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package swift-mode
  :init
  (defun my-swiftlint-autocorrect-current-file ()
	"Invoke swiftlint"
	(interactive)
	(shell-command (concat "swiftlint autocorrect " (buffer-file-name)))
	(revert-buffer nil t))
  (defun my-swift-run-current-file ()
	"Run current file with swift"
	(interactive)
	(when (y-or-n-p-with-timeout "Run this file? " 3 nil)
	  (shell-command (concat "swift " (buffer-file-name)))))
  :general
  ('(normal visual motion) swift-mode-map
   "SPC m f"   #'my-swiftlint-autocorrect-current-file
   "SPC m RET" #'my-swift-run-current-file))

(use-package flycheck-swiftlint
  :after (swift-mode flycheck)
  :config
  (flycheck-swiftlint-setup))

(use-package flycheck-swift
  :after (swift-mode flycheck flycheck-swiftlint)
  :config
  (flycheck-swift-setup)
  (flycheck-add-next-checker 'swift 'swiftlint))

(provide 'my-swift)
;;; my-swift.el ends here
