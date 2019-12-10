;;; my-documents.el --- Configurations for editing and viewing documents -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'my-package-config)

(use-package markdown-mode
  :delight "Md"
  :mode (("\\.\\(md\\|markdown\\)\\'" . markdown-mode)
		 ("\\(README\\|CONTRIBUTING\\|CONTRIBUTORS\\)\\.md\\'" . gfm-mode)))

(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :magic ("%PDF" . pdf-view-mode)
  :config
  ;; Required to overwrite the keys bound by evil-collection
  (add-hook
   'pdf-view-mode-hook
   (lambda ()
	 (nmap pdf-view-mode-map
	   "f" #'pdf-links-action-perform
	   "F" #'pdf-links-isearch-link
	   "O" #'pdf-occur
	   "J" #'pdf-view-next-page-command
	   "K" #'pdf-view-previous-page-command)))
  (pdf-loader-install))

(use-package tex
  :ensure auctex
  :defines preview-default-preamble
  :defer t
  :init
  (setq TeX-auto-save t
		TeX-parse-self t
		TeX-PDF-mode t)
  (setq-default TeX-master nil)
  :config
  (use-package preview
	:ensure nil
	:custom
	(preview-default-preamble
	 (append
	  preview-default-preamble
	  '("\\PreviewEnvironment{enumerate}" "\\PreviewEnvironment{description}" "\\PreviewEnvironment{itemize}"))))
  (use-package auctex-latexmk
	:custom
	(auctex-latexmk-inherit-TeX-PDF-mode t)
	:config
	(auctex-latexmk-setup))
  (use-package reftex
	:hook (LaTeX-mode . turn-on-reftex)
	:custom
	(reftex-plug-into-AUCTeX t)))

(provide 'my-documents)
;;; my-documents.el ends here
