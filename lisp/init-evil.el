(use-package evil
  :ensure t
  :diminish undo-tree-mode
  :config (evil-mode 1))

(use-package evil-surround
  :ensure t
  :config (global-evil-surround-mode 1))
;; I can add more surround pairs by doing this
;; (add-hook 'c++-mode-hook (lambda ()
;;                            (push '(?< . ("< " . " >")) surround-pairs-alist)))
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


;; (defun org-link ()

;;   )

;; Make evil-insert-mode allow emacs keybindings
(setcdr evil-insert-state-map nil)

;; I have no idea why this is not working. It should be!
;; this a file that will hopefully soon become and emacs package.
(setq evil-dvorak-funky-h-and-t 1)
(setq evil-dvorak-use-for-web-mode 1)

;;(require 'evil-dvorak)
(use-package evil-dvorak
  :ensure t
  :config (global-evil-dvorak-mode 1))


(local-unset-key (kbd "TAB"))
;; (define-key evil-normal-state-map (kbd "C-w h") #'windmove-down)
;; (define-key evil-normal-state-map (kbd "C-w t") #'windmove-up)

(define-key evil-emacs-state-map (kbd "s-z") #'evil-normal-state)

;; make it easy to switch to various windows inside one emacs frame
(define-key evil-emacs-state-map (kbd "C-w h") 'windmove-down)
(define-key evil-emacs-state-map (kbd "C-w t") 'windmove-up)
(define-key evil-emacs-state-map (kbd "C-w n") 'windmove-left)
(define-key evil-emacs-state-map (kbd "C-w s") 'windmove-right)
(define-key evil-normal-state-map (kbd "C-w h") 'windmove-down)
(define-key evil-normal-state-map (kbd "C-w t") 'windmove-up)
(define-key evil-normal-state-map (kbd "C-w n") 'windmove-left)
(define-key evil-normal-state-map (kbd "C-w s") 'windmove-right)

;; M just moves the key to the center of the screen. Just a waste. Let's bind it to use emms!
(define-key evil-normal-state-map (kbd "M i") #'(lambda ()
                                                  (interactive)
                                                  (emms-librefm-stream "librefm://globaltags/Classical")))
(define-key evil-normal-state-map (kbd "M p") 'emms-previous)
(define-key evil-normal-state-map (kbd "M n") 'emms-next)
(define-key evil-normal-state-map (kbd "M P") 'emms-pause)
(define-key evil-normal-state-map (kbd "M s") 'emms-show)
(define-key evil-normal-state-map (kbd "M k") 'emms-stop)


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
(evil-set-initial-state 'sx-compose-mode 'emacs)
(evil-set-initial-state 'sx-question-mode 'emacs)
(evil-set-initial-state 'sx-question-list-mode 'emacs)
(evil-set-initial-state 'erc-mode 'emacs)
(evil-set-initial-state 'paradox-menu-mode 'emacs)
(evil-set-initial-state 'woman-mode 'emacs)
;; I think one of the two below this made evil mode open up a new buffer and set 'emacs state on
;;(evil-set-initial-state 'ggtags-mode 'emacs)
;;(evil-set-initial-state 'ggtags-global-mode 'emacs)
(evil-set-initial-state 'ggtags-navigation-mode 'emacs)


(provide 'init-evil)
;; ;;; evil-changes.el ends here
