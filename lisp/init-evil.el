(require 'evil)
(evil-mode 1)

(require 'evil-surround)
(global-evil-surround-mode 1)
;;I don't know why this is not working.
;;(add-hook 'evil-mode-hook 'turn-on-surround-mode)

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

;; Make evil-insert-mode allow emacs keybindings
(setcdr evil-insert-state-map nil)

;; I have no idea why this is not working. It should be!
;; this a file that will hopefully soon become and emacs package.
(setq evil-dvorak-funky-h-and-t 1)
(setq evil-dvorak-use-for-web-mode 1)
(require 'evil-dvorak)
(global-evil-dvorak-mode 1)

;; (define-key evil-normal-state-map (kbd "Hta") 'web-mode-tag-attributes-sort)
;; (evil-set-initial-state 'snake-mode 'emacs)
(loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
                              (nrepl-mode . insert)
                              (pylookup-mode . emacs)
                              (comint-mode . normal)
                              (shell-mode . insert)
                              (git-commit-mode . insert)
                              (git-rebase-mode . emacs)
                              (git-timemachine-mode . emacs)
                              (term-mode . emacs)
                              (help-mode . emacs)
                              (helm-grep-mode . emacs)
                              (grep-mode . emacs)
                              (bc-menu-mode . emacs)
                              (magit-branch-manager-mode . emacs)
                              (rdictcc-buffer-mode . emacs)
                              (dired-mode . emacs)
                              (wdired-mode . normal))
      do (evil-set-initial-state mode state))

(provide 'init-evil)
;; ;;; evil-changes.el ends here
