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
;; (define-key evil-normal-state-map (kbd "Htb") 'web-mode-tag-beginning)
;; (define-key evil-normal-state-map (kbd "Hte") 'web-mode-tag-end)
;; (define-key evil-normal-state-map (kbd "Htm") 'web-mode-tag-match)
;; (define-key evil-normal-state-map (kbd "Htn") 'web-mode-tag-next)
;; (define-key evil-normal-state-map (kbd "Htp") 'web-mode-tag-previous)
;; (define-key evil-normal-state-map (kbd "Hts") 'web-mode-tag-select)

;; (define-key evil-normal-state-map (kbd "Hek") 'web-mode-element-kill)
;; (define-key evil-normal-state-map (kbd "Hev") 'web-mode-element-vanish)
;; (define-key evil-normal-state-map (kbd "Hea") 'web-mode-element-content-select)
;; (define-key evil-normal-state-map (kbd "Hec") 'web-mode-element-clone)
;; (define-key evil-normal-state-map (kbd "Heb") 'web-mode-element-beginning)
;; (define-key evil-normal-state-map (kbd "Hed") 'web-mode-element-child)
;; (define-key evil-normal-state-map (kbd "Hee") 'web-mode-element-end)
;; (define-key evil-normal-state-map (kbd "Hef") 'web-mode-element-children-fold-or-unfold)
;; (define-key evil-normal-state-map (kbd "Hei") 'web-mode-element-insert)
;; (define-key evil-normal-state-map (kbd "Hem") 'web-mode-element-mute-blanks)
;; (define-key evil-normal-state-map (kbd "Hen") 'web-mode-element-next)
;; (define-key evil-normal-state-map (kbd "Hep") 'web-mode-element-previous)
;; (define-key evil-normal-state-map (kbd "Her") 'web-mode-element-rename)
;; (define-key evil-normal-state-map (kbd "Hes") 'web-mode-element-select)
;; (define-key evil-normal-state-map (kbd "Het") 'web-mode-element-transpose)
;; (define-key evil-normal-state-map (kbd "Heu") 'web-mode-element-parent)
;; (define-key evil-normal-state-map (kbd "Hew") 'web-mode-element-wrap)

;; (define-key evil-normal-state-map (kbd "Hab") 'web-mode-attribute-beginning)
;; (define-key evil-normal-state-map (kbd "Hae") 'web-mode-attribute-end)
;; (define-key evil-normal-state-map (kbd "Hai") 'web-mode-attribute-insert)
;; (define-key evil-normal-state-map (kbd "Hak") 'web-mode-attribute-kill)
;; (define-key evil-normal-state-map (kbd "Han") 'web-mode-attribute-next)
;; (define-key evil-normal-state-map (kbd "Has") 'web-mode-attribute-select)
;; (define-key evil-normal-state-map (kbd "Hat") 'web-mode-attribute-transpose)

;; ;;(define-key evil-emacs-state-map (kbd "C-w h") 'evil-window-down)
;; (define-key evil-replace-state-map
;; (define-key evil-visual-state-map
;; (define-key evil-operator-state-map
;; ;; Set the default state for various buffers
;; (evil-set-initial-state 'dired-mode 'emacs)
;; (evil-set-initial-state 'snake-mode 'emacs)
;; (evil-set-initial-state 'eshell-mode 'emacs)
;; (evil-set-initial-state 'term-mode 'emacs)
;; ;;This next one is working or not?
;; (evil-set-initial-state 'git-mode 'emacs)

(provide 'init-evil)
;; ;;; evil-changes.el ends here
