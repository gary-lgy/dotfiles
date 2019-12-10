;;; my-misc-config --- My miscellaneous config -*- lexical-binding: t -*-

;;; Commentary:
;; Config that are not large enough to have their own modules

;;; Code:

;; Confirm kill Emacs
(setq confirm-kill-emacs (lambda (prompt) (y-or-n-p-with-timeout prompt 3 nil)))

;; Focus help window
(setq help-window-select t)

;; Scroll
(setq scroll-conservatively 101
      scroll-margin 20)

;; Turn off useless stuff
(setq inhibit-startup-screen t)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Backup
(setq version-control t
      kept-new-versions 10
      kept-old-versions 0
      delete-old-versions t
      backup-by-copying t
      vc-make-backup-files t
      backup-directory-alist `(("." . ,(expand-file-name "backups" user-emacs-directory))))

(provide 'my-misc-config)
;;; my-misc-config.el ends here
