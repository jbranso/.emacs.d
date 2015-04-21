(require 'evil)
(evil-mode 1)

(require 'evil-surround)
(global-evil-surround-mode 1)
;;I don't know why this is not working.
;;(add-hook 'evil-mode-hook 'turn-on-surround-mode)

(require 'powerline)
(require 'powerline-evil)
(powerline-evil-vim-theme)

;;Do not move the cursor back when exiting insert mode.
(setq evil-move-cursor-back nil)
;; This macro allows me to insert a space with the spacebar.
(fset 'viper-space "\C-z \C-z")
;; this macro will turn a WORD into a proper html link
(fset 'makeHref
      (lambda (&optional arg)
        "Keyboard macro."
        (interactive "p")
        (kmacro-exec-ring-item
         (quote ("EBEyES<a href=\">" 0 "%d")) arg)))


;; This macro will insert an org link.
(fset 'org-link
   [?i ?\[ ?\[ ?\C-x ?Q return ?\] ?\] backspace ?\[ ?\C-x ?Q return ?\] ?\]])

(fset 'org-link
      [?i ?\[ ?\[ ?\C-x ?Q return ?\] ?\] backspace ?\[ ?\C-x ?Q return ?\] ?\]])


;; (defun org-link ()

;;   )



;; Make evil-insert-mode allow emacs keybindings
(setcdr evil-insert-state-map nil)

;; I have no idea why this is not working. It should be!
;; this a file that will hopefully soon become and emacs package.
(setq evil-dvorak-funky-h-and-t 1)
(setq evil-dvorak-use-for-web-mode 1)

(require 'evil-dvorak)
(global-evil-dvorak-mode 1)

(local-unset-key (kbd "TAB"))
(define-key evil-normal-state-map (kbd "TAB") 'indent-for-tab-command)
(define-key evil-normal-state-map (kbd "s-z") 'evil-emacs-state)
(define-key evil-normal-state-map (kbd "s-l") 'org-link)
(define-key evil-insert-state-map (kbd "s-z") 'evil-normal-state)
(define-key evil-normal-state-map (kbd "C-w h") 'windmove-down)
(define-key evil-normal-state-map (kbd "C-w t") 'windmove-up)
;;(define-key evil-normal-state-map (kbd "Q") 'anzu-query-replace-regexp)
;; This for when I use visual line mode mode. Now visual line mode should work for basic
;; key movements
;; This is not working.
(define-key evil-normal-state-map (kbd "h") 'next-line)
(define-key evil-normal-state-map (kbd "t") 'previous-line)
(define-key evil-normal-state-map (kbd "n") 'backward-char)
(define-key evil-normal-state-map (kbd "l") 'forward-char)
;;(define-key evil-normal-state-map (kbd "<return>") 'newline-and-indent)
;;(define-key evil-insert-state-map (kbd "<return>") 'newline-and-indent)

(define-key evil-emacs-state-map (kbd "s-z") 'evil-normal-state)

;; Ask on IRC about this
;; I'm trying to make emacs treat the letter after O in the alphabet as ESC
;; (add-hook evil-normal-state-entry-hook 'lambda ()
;;           (interactive)
;;           (keyboard-translate ?M 27 )
;;           (define-key evil-normal-state-map (kbd "ESC") 'emacs-prefix-key))

;; (add-hook evil-normal-state-exit-hook 'lambda ()
;;           (interactive)
;;           (keyboard-translate <ESC> ?M))


;; set this key to be the projectile prefix.
;;(define-key evil-normal-state-map (kbd "C-c p") 'web-mode-tag-attributes-sort)
(evil-set-initial-state 'snake-mode 'emacs)
(evil-set-initial-state 'comint-mode 'normal)
(evil-set-initial-state 'eshell-mode 'emacs)
(evil-set-initial-state 'shell-mode 'emacs)
(evil-set-initial-state 'git-commit-mode 'emacs)
(evil-set-initial-state 'git-rebase-mode 'emacs)
(evil-set-initial-state 'git-timemachine-mode 'emacs)
(evil-set-initial-state 'term-mode 'emacs)
(evil-set-initial-state 'help-mode 'emacs)
(evil-set-initial-state 'helm-grep-mode 'emacs)
(evil-set-initial-state 'grep-mode 'emacs)
(evil-set-initial-state 'bc-menu-mode 'emacs)
(evil-set-initial-state 'magit-branch-manager-mode 'emacs)
(evil-set-initial-state 'rdictcc-buffer-mode 'emacs)
(evil-set-initial-state 'dired-mode 'emacs)
(evil-set-initial-state 'wdired-mode 'normal)
(evil-set-initial-state 'git-timemachine-mode 'emacs)

(provide 'init-evil)
;; ;;; evil-changes.el ends here
