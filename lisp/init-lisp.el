;; ----------------------------------------------------------------------------
;; Automatic byte compilation
;; ----------------------------------------------------------------------------
(use-package auto-compile
  :ensure t)
(auto-compile-on-save-mode 1)
(auto-compile-on-load-mode 1)

;; ----------------------------------------------------------------------------
;; Load .el if newer than corresponding .elc
;; ----------------------------------------------------------------------------
(setq load-prefer-newer t)

;; ----------------------------------------------------------------------------
;; Enable desired features for all lisp modes
;; ----------------------------------------------------------------------------
;; show different parenthesis in different colors.  For example, the lambda's parenthesis, within a function will have a
;; color than the function's parenthesis.
(use-package rainbow-delimiters
  :ensure t)
(add-hook 'emacs-lisp-mode-hook '(lambda ()
                                   (rainbow-delimiters-mode 1)
                                   (flycheck-mode 1)
                                   ))

;; automatically indent the text after certain commands are pressed!
(when (fboundp 'aggressive-indent-mode)
  (aggressive-indent-mode))

;; show documentation of the current elisp function in the minibuffer as you write it.
;; whoever made this mode is amazing!

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(use-package paredit
  :ensure t
  :init
  (defun paredit-barf-all-the-way-backward ()
    (interactive)
    (paredit-split-sexp)
    (paredit-backward-down)
    (paredit-splice-sexp))
  (defun paredit-barf-all-the-way-forward ()
    (interactive)
    (paredit-split-sexp)
    (paredit-forward-down)
    (paredit-splice-sexp)
    (if (eolp) (delete-horizontal-space)))
  (defun paredit-slurp-all-the-way-backward ()
    (interactive)
    (catch 'done
      (while (not (bobp))
        (save-excursion
          (paredit-backward-up)
          (if (eq (char-before) ?\()
              (throw 'done t)))
        (paredit-backward-slurp-sexp))))
  (defun paredit-slurp-all-the-way-forward ()
    (interactive)
    (catch 'done
      (while (not (eobp))
        (save-excursion
          (paredit-forward-up)
          (if (eq (char-after) ?\))
              (throw 'done t)))
        (paredit-forward-slurp-sexp)))))


(defun turn-on-paredit ()
  (autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)
  (define-key emacs-lisp-mode-map (kbd "C-c 0") 'paredit-forward-slurp-sexp)
  (define-key emacs-lisp-mode-map (kbd "C-c 9") 'paredit-backward-slurp-sexp)
  (define-key emacs-lisp-mode-map (kbd "C-c ]") 'paredit-forward-barf-sexp)
  (define-key emacs-lisp-mode-map (kbd "C-c [") 'paredit-backward-barf-sexp)

  (define-key emacs-lisp-mode-map (kbd "C-c )") 'paredit-slurp-all-the-way-forward)
  (define-key emacs-lisp-mode-map (kbd "C-c }") 'paredit-barf-all-the-way-forward)
  (define-key emacs-lisp-mode-map (kbd "C-c (") 'paredit-slurp-all-the-way-backward)
  (define-key emacs-lisp-mode-map (kbd "C-c {") 'paredit-barf-all-the-way-backward)
  (evil-define-key 'normal evil-dvorak-mode-map (kbd "k") 'paredit-kill)
  (paredit-mode +1))

(dolist (hook '(prog-mode-hook
                text-mode-hook))
  (add-hook hook (lambda ()
                   (evil-define-key 'normal evil-dvorak-mode-map  "k" 'kill-line))))

(add-hook 'emacs-lisp-mode-hook 'turn-on-paredit)


(provide 'init-lisp)
