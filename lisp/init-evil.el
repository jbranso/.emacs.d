(use-package evil
  :ensure t
  ;;If you diminish undo-tree mode, then you diminish evil-mode
  ;; I see the evil thing in the mode line on an org buffer, BUT not in an emacs lisp buffer
  :diminish undo-tree-mode
  :config (evil-mode 1))

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

(setq evil-move-cursor-back nil)

(fset 'viper-space "\C-z \C-z")

(setcdr evil-insert-state-map nil)

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

(add-hook 'web-mode-hook 'evil-dvorak-turn-on-web-mode-keys)

(defun my-evil-dvorak-visual-state ()
  "These are the non-standard customizations, that I've done to my evil-dvorak.
  These are my various changes that I initially had in evil-dvorak, but I'm removing them to help out the spacemacs devs."
  (interactive)
  ;;visual state map
  (define-key evil-visual-state-map "h" 'evil-next-line)
  (define-key evil-visual-state-map  "t" 'evil-previous-line)
  (define-key evil-visual-state-map  "n" 'evil-backward-char)
  (define-key evil-visual-state-map  "s" 'evil-forward-char)

  ;; I had used this before, but now that I am learning evil, I'm not going to use those.h
  ;; "o" 'evil-backward-word-begin

  ;; "O" 'evil-backward-WORD-end
  ;; "E" 'evil-forward-WORD-end

  (define-key evil-visual-state-map  "e" 'evil-forward-word-begin))
(add-hook 'evil-visual-state-entry-hook 'my-evil-dvorak-visual-state)

(defun my-evil-dvorak-insert-state ()
  "These are the non-standard customizations, that I've done to my evil-dvorak.
  These are my various changes that I initially had in evil-dvorak, but I'm removing them to help out the spacemacs devs."
  (interactive)
  ;;insert mode customizations
  (define-key evil-insert-state-map (kbd "C-d") 'delete-char)
  (define-key evil-insert-state-map (kbd "C-z") 'evil-normal-state)
  ;; (kbd "ESC") 'evil-normal-state
  (define-key evil-insert-state-map  (kbd "C-c r") 'evil-record-macro))
(add-hook 'evil-insert-state-entry-hook 'my-evil-dvorak-insert-state)

(provide 'init-evil)
;;; evil-changes.el ends here
