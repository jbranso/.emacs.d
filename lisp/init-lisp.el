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

(add-hook 'emacs-lisp-mode-hook '(lambda ()
                                   (rainbow-delimiters-mode 1)
                                   ;; You want to enable evil-paredit mode for evil, because it's SOOO helpful.
                                   (evil-paredit-mode 1)
                                   (elisp/turn-on-paredit)
                                   ;; make >= look like ≥
                                   (push '(">=" . ?≥) prettify-symbols-alist)
                                   (push '("<=" . ?≤) prettify-symbols-alist)
                                   (push '("float-pi" . ?π) prettify-symbols-alist)
                                   (push '("float-pi" . ?e) prettify-symbols-alist)
                                   (eldoc-mode)))

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

(defun getBufferStringFromWordAtPoint ()
  "This function gets the buffer string from the word at point"
  (interactive)
  (print
   (buffer-substring (progn
                       (backward-word)
                       (point))
                     (progn
                       (forward-word)
                       (point)))))

(defface font-lock-green-color
  '((t (:foreground "#00ff00")))
  "For boolean values")

(defun highlightBoolsElisp ()
  "This highlights the boolean values in elisp."
  (interactive)
  (font-lock-add-keywords nil
                          '(("\\<t\\>" 1 'font-lock-green-color prepend)
                            ("\\<nil\\>" 1 'font-lock-green-color prepend))))



  ;;(add-hook 'emacs-lisp-mode-hook #'highlightBoolsElisp)

(provide 'init-lisp)

(defun my/reeval-defun-at-point ()
  "This reevaluates the defun at point."
  (interactive)
  (let (current-pos-of-point)
    (setq current-pos-of-point (point))
    (search-backward-regexp "^(defun")
    (evil-jump-item)
    (eval-last-sexp)
    (goto-char current-pos-of-point)))

(define-key emacs-lisp-mode-map (kbd "C-x e") #'my/reeval-defun-at-point)

(defun my/dumb-defun ()
  (interactive)
  (print (+ 5 2)))

(provide 'init-lisp)
