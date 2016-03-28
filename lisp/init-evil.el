(use-package evil
  :ensure t
  ;;If you diminish undo-tree mode, then you diminish evil-mode
  ;; I see the evil thing in the mode line on an org buffer, BUT not in an emacs lisp buffer
  :diminish undo-tree-mode
  :config (evil-mode 1))

;; TODO evil-surround is broken!
;; I can't do the basic examples found here: https://github.com/timcharper/evil-surround
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1)
  ;; for all programming modes and text modes, make * and / a surround pair
  ;; but this is not working
  ;;  * hello *  with point on hello "ds*" and "cs*'" does not work
  (dolist (hook '(prog-mode-hook
                  text-mode-hook))
    (add-hook hook (lambda ()
                     (push '(?* . ("*" . "*")) evil-surround-pairs-alist)
                     (push '(?/ . ("/" . "/")) evil-surround-pairs-alist)))))

;;Do not move the cursor back when exiting insert mode.
(setq evil-move-cursor-back nil)
;; This macro allows me to insert a space with the spacebar.
(fset 'viper-space "\C-z \C-z")

;; Make evil-insert-mode allow emacs keybindings
(setcdr evil-insert-state-map nil)

(setq evil-dvorak-funky-h-and-t 1)
(setq evil-dvorak-use-for-web-mode 1)

;; use % to go traverse code in most languages
;; https://github.com/redguardtoo/evil-matchit
;; da% deletes all of the stuff between matches
;; va% selects all of it too
;; this breaks webmode
;; (use-package evil-matchit
;;   :ensure t
;;   :config (global-evil-matchit-mode 1))

;; https://github.com/Dewdrops/evil-extra-operator/blob/master/evil-extra-operator.el
;; This code here has GOOD code that explains how to make extra evil operators.  ie "g." makes it so you can
;; translate text to english via google translate.  VERY cool!
;; (require 'evil-extra-operator)
;; (global-evil-extra-operator-mode 1)

;; https://github.com/wcsmith/evil-args
;; For example, cia transforms:

;; function(ar|g1, arg2, arg3)
;; function(|, arg2, arg3)

;; daa transforms:

;; function(ar|g1, arg2, arg3)
;; function(|arg2, arg3)
(use-package evil-args
  :ensure t
  :config
  ;; bind evil-args text objects
  (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
  (define-key evil-outer-text-objects-map "a" 'evil-outer-arg)

  ;; bind evil-forward/backward-args
  (define-key evil-normal-state-map "S" 'evil-forward-arg)
  (define-key evil-normal-state-map "N" 'evil-backward-arg)
  (define-key evil-motion-state-map "S" 'evil-forward-arg)
  (define-key evil-motion-state-map "N" 'evil-backward-arg)

  ;; bind evil-jump-out-args
  (define-key evil-normal-state-map "K" 'evil-jump-out-args))

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

(provide 'init-evil)
;; ;;; evil-changes.el ends here
