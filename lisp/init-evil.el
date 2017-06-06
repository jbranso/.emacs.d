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

(use-package evil-lion :ensure t :config (evil-lion-mode))

;; glip= on this paragraph makes it
;; snthtnsh = asnteuhaeontuh
;; satnehnth = ansteuhnstaehu
;; santeh = aseunthesnu

;; snthtnsh  = asnteuhaeontuh
;; satnehnth = ansteuhnstaehu
;; santeh    = aseunthesnu

;;Do not move the cursor back when exiting insert mode.
(setq evil-move-cursor-back nil)
;; This macro allows me to insert a space with the spacebar.
(fset 'viper-space "\C-z \C-z")

;; Make evil-insert-mode allow emacs keybindings
(setcdr evil-insert-state-map nil)

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

  (define-key evil-normal-state-map "\e" 'emacs-prefix-key)

  ;; bind evil-jump-out-args
  (define-key evil-normal-state-map "K" 'evil-jump-out-args))

(defun evil-dvorak-turn-on-web-mode-keys ()
  "This turns on the evil-dvorak web-mode keyboard shortcuts."
  (interactive)
  (define-key evil-normal-state-map (kbd "Hta") 'web-mode-tag-attributes-sort)
  (define-key evil-normal-state-map (kbd "Htb") 'web-mode-tag-beginning)
  (define-key evil-normal-state-map (kbd "Hte") 'web-mode-tag-end)
  (define-key evil-normal-state-map (kbd "Htm") 'web-mode-tag-match)
  (define-key evil-normal-state-map (kbd "Htn") 'web-mode-tag-next)
  (define-key evil-normal-state-map (kbd "Htp") 'web-mode-tag-previous)
  (define-key evil-normal-state-map (kbd "Hts") 'web-mode-tag-select)
  (define-key evil-normal-state-map (kbd "Hek") 'web-mode-element-kill)
  (define-key evil-normal-state-map (kbd "Hev") 'web-mode-element-vanish)
  (define-key evil-normal-state-map (kbd "Hea") 'web-mode-element-content-select)
  (define-key evil-normal-state-map (kbd "Hec") 'web-mode-element-clone)
  (define-key evil-normal-state-map (kbd "Heb") 'web-mode-element-beginning)
  (define-key evil-normal-state-map (kbd "Hed") 'web-mode-element-child)
  (define-key evil-normal-state-map (kbd "Hee") 'web-mode-element-end)
  (define-key evil-normal-state-map (kbd "Hef") 'web-mode-element-children-fold-or-unfold)
  (define-key evil-normal-state-map (kbd "Hei") 'web-mode-element-insert)
  (define-key evil-normal-state-map (kbd "Hem") 'web-mode-element-mute-blanks)
  (define-key evil-normal-state-map (kbd "Hen") 'web-mode-element-next)
  (define-key evil-normal-state-map (kbd "Hep") 'web-mode-element-previous)
  (define-key evil-normal-state-map (kbd "Her") 'web-mode-element-rename)
  (define-key evil-normal-state-map (kbd "Hes") 'web-mode-element-select)
  (define-key evil-normal-state-map (kbd "He;") 'web-mode-comment-or-uncomment)
  (define-key evil-normal-state-map (kbd "Het") 'web-mode-element-transpose)
  (define-key evil-normal-state-map (kbd "Heu") 'web-mode-element-parent)
  (define-key evil-normal-state-map (kbd "Hew") 'web-mode-element-wrap)
  (define-key evil-normal-state-map (kbd "Hab") 'web-mode-attribute-beginning)
  (define-key evil-normal-state-map (kbd "Hae") 'web-mode-attribute-end)
  (define-key evil-normal-state-map (kbd "Hai") 'web-mode-attribute-insert)
  (define-key evil-normal-state-map (kbd "Hak") 'web-mode-attribute-kill)
  (define-key evil-normal-state-map (kbd "Han") 'web-mode-attribute-next)
  (define-key evil-normal-state-map (kbd "Has") 'web-mode-attribute-select)
  (define-key evil-normal-state-map (kbd "Hat") 'web-mode-attribute-transpose))

(defun my-evil-dvorak-customizations ()
  "These are the non-standard customizations, that I've done to my evil-dvorak.
  These are my various changes that I initially had in evil-dvorak, but I'm removing them to help out the spacemacs devs."
  (interactive)
  ;;normal mode customizations
  (evil-define-key 'normal evil-dvorak-mode-map
    ;; the default evil-mode does NOT play well with visual line mode!  Until that is figured out, I'm going to use the
    ;; emacs keys for moving up and down a line.
    ;; "t" 'evil-previous-line
    ;; "h" 'evil-next-line
    "t" 'previous-line
    "h" 'next-line
    "n" 'evil-backward-char
    "s" 'evil-forward-char
    (kbd "ESC") 'nil
    (kbd "C-s") 'evil-substitute
    (kbd "C-c r") 'evil-record-macro
    "," 'undo-tree-undo
    "/" 'helm-swoop
    (kbd "<backspace>") 'avy-goto-char
    ;; (kbd "<return>") 'newline-and-indent
    ;; usually
    ;; RET means newline, BUT RET in org-mode should mean to org-indent.
    ;; now if you press RET on an org link, you follow it!  cool eh?
    (kbd "<return>") #'(lambda ()
                         "Usually do newline and indent, but in org buffers, do org-indent"
                         (interactive)
                         (if (equal 'org-mode major-mode)
                             (org-return)
                           (newline-and-indent)))
    "Q" 'anzu-query-replace-regexp
    "I" 'evil-append
    "$" 'ispell-word
    ;; (kbd "a") 'evil-first-non-blank
    (kbd "a") 'move-beginning-of-line
    (kbd "A") 'evil-insert-line
    ;; (kbd "u") 'evil-end-of-line
    (kbd "u") 'move-end-of-line
    (kbd "U") 'evil-append-line
    (kbd "q") '(lambda ()
                 "q saves the current buffer, then kills it.  I should add a checking mechanism... If the buffer name starts and ends with *, then do not save the buffer"
                 (interactive)
                 (save-buffer)
                 (let (kill-buffer-query-functions) (kill-buffer)))
    (kbd "l") 'recenter-top-bottom
    ;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
    ;;at least so the documentation claimed
    (kbd "C-d") 'delete-char
    (kbd "<") 'beginning-of-buffer
    (kbd ">") 'end-of-buffer
    (kbd "SPC") 'viper-space
    (kbd "C-a") 'mark-whole-buffer

    ;;Miscellaneous
    (kbd "TAB") #'indent-for-tab-command
    (kbd "s-z") #'evil-emacs-state

    ;;moving point from top
    (kbd "C-w t") #'windmove-up
    (kbd "C-w h") #'windmove-down
    (kbd "C-w n") #'windmove-left
    (kbd "C-w s") #'windmove-right
    ;; this breaks the regular use of the vim letter "b", which move back by one word.
    ;; (kbd "b") #'(lambda ()
    ;;               "Switch to the previous buffer"
    ;;               (interactive)
    ;;               (switch-to-buffer nil))
    )

  ;;insert mode customizations
  (evil-define-key 'insert evil-dvorak-mode-map
    (kbd "C-d") 'delete-char
    (kbd "C-z") 'evil-normal-state
    ;; (kbd "ESC") 'evil-normal-state
    (kbd "C-c r") 'evil-record-macro)

  (evil-define-key 'visual evil-dvorak-mode-map
    "h" 'evil-next-line
    "t" 'evil-previous-line
    "n" 'evil-backward-char
    "s" 'evil-forward-char

    ;; I had used this before, but now that I am learning evil, I'm not going to use those.h
    ;; "o" 'evil-backward-word-begin
    "e" 'evil-forward-word-begin
    ;; "O" 'evil-backward-WORD-end
    ;; "E" 'evil-forward-WORD-end
    ))

(use-package evil-dvorak
  :ensure t
  :config
  (global-evil-dvorak-mode 1)
  (add-hook 'web-mode-hook 'evil-dvorak-turn-on-web-mode-keys)
  (my-evil-dvorak-customizations)
  :diminish evil-dvorak-mode)

(local-unset-key (kbd "TAB"))

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
