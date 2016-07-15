(use-package auto-compile
  :ensure t)
(auto-compile-on-save-mode 1)
(auto-compile-on-load-mode 1)

(setq load-prefer-newer t)

(use-package rainbow-delimiters
  :ensure t)

(use-package paredit
  :ensure t
  :defer t
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

(defun elisp/turn-on-paredit ()
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

(defun scheme/turn-on-paredit ()
  (autoload 'enable-paredit-mode "paredit"
    "Turn on pseudo-structural editing of Lisp code."
    t)
  (define-key scheme-mode-map (kbd "C-c 0") 'paredit-forward-slurp-sexp)
  (define-key scheme-mode-map (kbd "C-c 9") 'paredit-backward-slurp-sexp)
  (define-key scheme-mode-map (kbd "C-c ]") 'paredit-forward-barf-sexp)
  (define-key scheme-mode-map (kbd "C-c [") 'paredit-backward-barf-sexp)

  (define-key scheme-mode-map (kbd "C-c )") 'paredit-slurp-all-the-way-forward)
  (define-key scheme-mode-map (kbd "C-c }") 'paredit-barf-all-the-way-forward)
  (define-key scheme-mode-map (kbd "C-c (") 'paredit-slurp-all-the-way-backward)
  (define-key scheme-mode-map (kbd "C-c {") 'paredit-barf-all-the-way-backward)
  (evil-define-key 'normal evil-dvorak-mode-map (kbd "k") 'paredit-kill)
  (paredit-mode +1))

(add-hook 'scheme-mode-hook '(lambda ()
                               (rainbow-delimiters-mode 1)
                               ;; You want to enable evil-paredit mode for evil, because it's SOOO helpful.
                               (evil-paredit-mode 1)
                               (scheme/turn-on-paredit)
                               ;; make >= look like ≥
                               (push '(">=" . ?≥) prettify-symbols-alist)
                               (push '("<=" . ?≤) prettify-symbols-alist)
                               (eldoc-mode)))

(use-package aggressive-indent :ensure t)
(aggressive-indent-mode)

(use-package easy-escape :ensure t
  :config (add-hook 'emacs-lisp-mode-hook #'easy-escape-minor-mode)
  :diminish easy-escape-minor-mode)

(use-package geiser :ensure t
  :config
  (setq geiser-active-implementations '(guile)))

(defface font-lock-elisp-boolean
'((t (:foreground "#00ff00")))
"For important")

(font-lock-add-keywords
'emacs-lisp-mode
'(("\\s<+cg[[:space:]]*\\(.*?\\)[[:space:]]*\\s>" 1 'font-lock-boolean prepend)))
