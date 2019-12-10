;;; my-elisp.el --- My Emacs Lisp configurations -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

(require 'my-package-config)

(use-package elisp-mode
  :ensure nil
  :delight (emacs-lisp-mode ("Elisp" (lexical-binding ":Lex" ":Dyn")) :major)
  :general
  ('(insert emacs) '(emacs-lisp-mode-map lisp-interaction-mode-map)
   "#" #'my-insert-sharp-quote)
  ('normal '(emacs-lisp-mode-map lisp-interaction-mode-map)
		   "RET" #'eval-last-sexp)
  ('motion '(emacs-lisp-mode-map lisp-interaction-mode-map)
		   "[]" #'sp-beginning-of-sexp
		   "][" #'sp-end-of-sexp
		   "]]" #'sp-next-sexp
		   "[[" #'sp-previous-sexp
		   "]}" #'sp-forward-slurp-sexp
		   "]{" #'sp-forward-barf-sexp
		   "[}" #'sp-backward-slurp-sexp
		   "[{" #'sp-backward-barf-sexp
		   "))" #'sp-down-sexp
		   ")(" #'sp-up-sexp
		   "()" #'sp-backward-down-sexp
		   "((" #'sp-backward-up-sexp)
  :config
  (defun my-insert-sharp-quote ()
	"Insert #' unless in a string or comment."
	(interactive)
	(call-interactively #'self-insert-command)
	(let ((ppss (syntax-ppss)))
	  (unless (or (elt ppss 3)
				  (elt ppss 4)
				  (eq (char-after) ?'))
		(insert "'")))))

(provide 'my-elisp)
;;; my-elisp.el ends here
