;;; my-package-config.el --- My config for package.el -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'package)
(setq package-archives
      '(("gnu"          . "https://elpa.gnu.org/packages/")
	("org"          . "https://orgmode.org/elpa/")
	("melpa"        . "https://melpa.org/packages/")
	("melpa-stable" . "https://stable.melpa.org/packages/"))
      package-archive-priorities
      '(("melpa-stable" . 5)
	("elpa"         . 15)
	("org"          . 10)
	("melpa"        . 20)))
(setq package-enable-at-startup nil)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3") ; Workaround until 26.3+
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package)
  (setq use-package-always-ensure t))

(provide 'my-package-config)
;;; my-package-config.el ends here
