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
  :config (add-hook 'emacs-lisp-mode-hook #'easy-escape-minor-mode))

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



(defhydra hydra-paredit (:color pink :hint nil)
  "
^Moving^              ^Barfing/Slurping^           ^Splice^
^^^^^^-------------------------------------------------------------------
_s_: forward          _0_: slurp forward           _S._: splice sexp
_n_: backward         _9_: slurp backward          _Ss_: splice forward
_t_: up               _]_: barf forward            _Sn_: splice backward
_h_: down             _[_: barf backward           _\^_:  split sexp
                      _\)_: slurp all forward
                      _\(_: slurp all backward
                      _\}_: barf all forward
                      _\{_: barf all backward

"
  ;; Moving
  ("s" paredit-forward)                ; Up
  ("n" paredit-backward)               ; Up
  ("t" paredit-forward-down)                ; Up
  ("h" paredit-backward-up)                ; Up

  ;; Barfing/Slurping
  ("0" paredit-forward-slurp-sexp)          ; Show (expand) everything
  ("9" paredit-backward-slurp-sexp)          ; Show (expand) everything
  ("]" paredit-forward-barf-sexp)          ; Show (expand) everything
  ("[" paredit-backward-barf-sexp)          ; Show (expand) everything
  (")" paredit-slurp-all-the-way-forward)          ; Show (expand) everything
  ("(" paredit-slurp-all-the-way-backward)          ; Show (expand) everything
  ("}" paredit-barf-all-the-way-forward)          ; Show (expand) everything
  ("{" paredit-barf-all-the-way-backward)          ; Show (expand) everything

  ("S." paredit-splice-sexp)    ; Hide everything but the top-level headings
  ("Ss" paredit-splice-killing-forward)    ; Hide everything but the top-level headings
  ("Sn" paredit-splice-killing-backward)    ; Hide everything but the top-level headings
  ("^"  paredit-split-sexp)    ; Hide everything but the top-level headings
  ("j" paredit-join-sexp)    ; Hide everything but the top-level headings

  ("g" nil "leave"))


;; I want to set this hydra to a keybinding.  So I don't have to remember all of the keybindings
(define-key emacs-lisp-mode-map (kbd "C-c C-p") 'hydra-paredit/body)
;; a ton of other modes try to set C-c C-b to a keybinding.  I am overriding them.


;; what is this here for?
(dolist (hook '(prog-mode-hook
                text-mode-hook))
  (add-hook hook (lambda ()
                   (evil-define-key 'normal evil-dvorak-mode-map  "k" 'kill-line))))


(provide 'init-lisp)
