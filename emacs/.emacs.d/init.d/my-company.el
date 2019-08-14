;;; my-company.el --- My config for compnay -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'my-package-config)

(defun company-ispell-setup ()
  "Setup company-ispell in text modes"
  (make-local-variable 'company-backends)
  (add-to-list 'company-backends 'company-ispell)
  (setq company-ispell-dictionary (file-truename "/usr/share/dict/british")))

(use-package company
  :defines
  company-dabbrev-downcase
  company-dabbrev-code-everywhere
  company-dabbrev-other-buffers
  company-dabbrev-code-other-buffers
  :delight
  :init
  (setq
   company-idle-delay 0.1
   company-show-numbers t
   company-minimum-prefix-length 2
   company-selection-wrap-around t
   company-dabbrev-downcase nil
   company-dabbrev-code-everywhere t
   company-dabbrev-other-buffers 'all
   company-dabbrev-code-other-buffers 'all)
  (add-hook 'text-mode-hook #'company-ispell-setup)
  :config
  (global-company-mode t))

(use-package company-statistics
  :after company
  :config
  (company-statistics-mode))

(provide 'my-company)
;;; my-company.el ends here
