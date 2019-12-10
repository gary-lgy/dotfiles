;;; my-package-config.el --- My config for package.el -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'package)

(setq package-archives
	  '(("gnu"   . "https://elpa.gnu.org/packages/")
		("org"   . "https://orgmode.org/elpa/")
		("melpa" . "https://melpa.org/packages/"))
	  package-archive-priorities
	  '(("gnu"   . 15)
		("org"   . 10)
		("melpa" . 20))
	  package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package)
  (setq use-package-always-ensure t))

;; For defining keys with the :general keyword
(use-package general
  :functions (mmap nmap iemap imap itomap otomap)
  :config
  (general-evil-setup t))

(provide 'my-package-config)
;;; my-package-config.el ends here
