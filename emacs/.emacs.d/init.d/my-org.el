;;; my-org.el --- My config for org-mode -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'my-package-config)
(require 'ox-md)

;; Use table.el
(require 'table)
(add-hook 'text-mode-hook 'table-recognize)

;; Use RET to follow links
(setq org-return-follows-link t)
(add-hook 'evil-after-load-hook
		  (lambda ()
			(evil-define-key 'normal org-mode-map (kbd "RET") #'org-return)))

;; Hide markers
(setq org-hide-emphasis-markers t
	  org-hide-leading-stars t
	  org-export-with-toc nil)

(use-package htmlize)

(use-package org-bullets
  :hook (org-mode . (lambda () (org-bullets-mode 1))))

(provide 'my-org)
;;; my-org.el ends here
