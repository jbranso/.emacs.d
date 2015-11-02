(use-package evil
  :ensure t
  ;;If you diminish undo-tree mode, then you diminish evil-mode
  ;; I see the evil thing in the mode line on an org buffer, BUT not in an emacs lisp buffer
  ;;  :diminish undo-tree-mode
  :config (evil-mode 1))

(use-package evil-surround
  :ensure t
  :config (global-evil-surround-mode 1))

;;Do not move the cursor back when exiting insert mode.
(setq evil-move-cursor-back nil)
;; This macro allows me to insert a space with the spacebar.
(fset 'viper-space "\C-z \C-z")

;; Make evil-insert-mode allow emacs keybindings
(setcdr evil-insert-state-map nil)

(setq evil-dvorak-funky-h-and-t 1)
(setq evil-dvorak-use-for-web-mode 1)

(use-package evil-dvorak
  :ensure t
  :config (global-evil-dvorak-mode 1)
  :diminish evil-dvorak-mode)

(local-unset-key (kbd "TAB"))

(define-key evil-emacs-state-map (kbd "s-z") #'evil-normal-state)


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
;; I'll have to try out each one at a time and see which one works, if one does work
;;(evil-set-initial-state 'ggtags-navigation-mode 'normal)
;;(evil-set-initial-state 'ggtags-tags-mode 'normal)
;; setting this to emacs makes opening up any new buffer set the evil state to emacs
(evil-set-initial-state 'ggtags-global-mode 'emacs)

(provide 'init-evil)
;; ;;; evil-changes.el ends here
