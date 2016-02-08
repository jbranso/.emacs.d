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
                                   ;; You want to enable evil-paredit mode for evil, because it's SOOO helpful.
                                   (evil-paredit-mode 1)
                                   (turn-on-paredit)
                                   ;; make >= look like ≥
                                   (push '(">=" . ?≥) prettify-symbols-alist)
                                   (push '("<=" . ?≤) prettify-symbols-alist)
                                   (eldoc-mode)))

;; automatically indent the text after certain commands are pressed!
(when (fboundp 'aggressive-indent-mode)
  (aggressive-indent-mode))

;; emacs regexp are cumbersome
;; "\b" in most regexp engines means word end
;; but when one is programming in emacs-lisp you have to write "\\b"
;; easy escape is light prettify-mode and changes \\ --> one highlighted \
(use-package easy-escape :ensure t
  :config (add-hook 'emacs-lisp-mode-hook #'easy-escape-minor-mode)
  :diminish easy-escape-minor-mode)

;; show documentation of the current elisp function in the minibuffer as you write it.
;; whoever made this mode is amazing!

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



;; I don't use the motion commands in there at all, because it's just easier to use the evil motion
(defhydra hydra-paredit (:color pink :hint nil)
  "
 ^Barfing/Slurping^           ^Splice^
^^^^^^^^^^^^^^^^^^------------------------------------------------
_0_: slurp forward           _S._: splice sexp
_9_: slurp backward          _Ss_: splice forward
_]_: barf forward            _Sn_: splice backward
_[_: barf backward           _\^_: raise sexp
_\)_: slurp all forward
_\(_: slurp all backward
_\}_: barf all forward
_\{_: barf all backward
"
  ;; Barfing/Slurping
  ("0" paredit-forward-slurp-sexp)
  ("9" paredit-backward-slurp-sexp)
  ("]" paredit-forward-barf-sexp)
  ("[" paredit-backward-barf-sexp)
  (")" paredit-slurp-all-the-way-forward)
  ("(" paredit-slurp-all-the-way-backward)
  ("}" paredit-barf-all-the-way-forward)
  ("{" paredit-barf-all-the-way-backward)

  ;; Splice
  ("S." paredit-splice-sexp)
  ("Ss" paredit-splice-killing-forward)
  ("Sn" paredit-splice-killing-backward)
  ("^"  paredit-raise-sexp)
  ("\\" paredit-split-sexp)
  ("j" paredit-join-sexp)
  (";" paredit-semicolan)

  ("g" nil "leave"))

;; I want to set this hydra to a keybinding.  So I don't have to remember all of the keybindings
(define-key emacs-lisp-mode-map (kbd "C-c C-p") 'hydra-paredit/body)


;; what is this here for?
(dolist (hook '(prog-mode-hook
                text-mode-hook))
  (add-hook hook (lambda ()
                   (evil-define-key 'normal evil-dvorak-mode-map  "k" 'kill-line))))


(provide 'init-lisp)
