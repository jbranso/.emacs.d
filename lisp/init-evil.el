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

(defun my-evil-dvorak-normal-state ()
    "These are the non-standard customizations, that I've done to my evil-dvorak.
    These are my various changes that I initially had in evil-dvorak, but I'm removing them to help out the spacemacs devs."
    (interactive)
    ;;normal mode customizations

    ;; the default evil-mode does NOT play well with visual line mode!  Until that is figured out, I'm going to use the
    ;; emacs keys for moving up and down a line.
    ;; "t" 'evil-previous-line
    ;; "h" 'evil-next-line
    (define-key evil-normal-state-map "t" 'previous-line)
    (define-key evil-normal-state-map  "h" 'next-line)
    (define-key evil-normal-state-map  "n" 'evil-backward-char)
    (define-key evil-normal-state-map  "s" 'evil-forward-char)
    (define-key evil-normal-state-map  (kbd "ESC") 'nil)
    (define-key evil-normal-state-map  (kbd "C-s") 'evil-substitute)
    (define-key evil-normal-state-map  (kbd "C-c r") 'evil-record-macro)
    (define-key evil-normal-state-map  "," 'undo-tree-undo)
    (define-key evil-normal-state-map  "/" 'helm-swoop)
    (define-key evil-normal-state-map  (kbd "<backspace>") 'avy-goto-char)
    ;; (kbd "<return>") 'newline-and-indent
    ;; usually
    ;; RET means newline, BUT RET in org-mode should mean to org-indent.
    ;; now if you press RET on an org link, you follow it!  cool eh?
    (define-key evil-normal-state-map  (kbd "<return>") #'(lambda ()
                                                            "Usually do newline and indent, but in org buffers, do org-indent"
                                                            (interactive)
                                                            (if (equal 'org-mode major-mode)
                                                                (org-return)
                                                              (newline-and-indent))))
    (define-key evil-normal-state-map  "Q" 'anzu-query-replace-regexp)
    (define-key evil-normal-state-map  "I" 'evil-append)
    (define-key evil-normal-state-map  "$" 'ispell-word)
    ;; (kbd "a") 'evil-first-non-blank
    (define-key evil-normal-state-map  (kbd "a") 'move-beginning-of-line)
    (define-key evil-normal-state-map  (kbd "A") 'evil-insert-line)
    ;; (kbd "u") 'evil-end-of-line
    (define-key evil-normal-state-map  (kbd "u") 'move-end-of-line)
    (define-key evil-normal-state-map  (kbd "U") 'evil-append-line)
    ;;(define-key evil-normal-state-map  (kbd "q") '(lambda ()
    ;; "q saves the current buffer, then kills it.  I should add a checking mechanism... If the buffer name starts and ends with *, then do not save the buffer"
      ;;                                              (interactive)
        ;;                                            (save-buffer)
          ;;                                          (let (kill-buffer-query-functions) (kill-buffer))))
    (define-key evil-normal-state-map  (kbd "l") 'recenter-top-bottom)
    ;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
    ;;at least so the documentation claimed
    (define-key evil-normal-state-map  (kbd "C-d") 'delete-char)
    (define-key evil-normal-state-map  (kbd "<") 'beginning-of-buffer)
    (define-key evil-normal-state-map  (kbd ">") 'end-of-buffer)
    (define-key evil-normal-state-map  (kbd "SPC") 'viper-space)
    (define-key evil-normal-state-map  (kbd "C-a") 'mark-whole-buffer)

    ;;Miscellaneous
    (define-key evil-normal-state-map  (kbd "TAB") #'indent-for-tab-command)
    (define-key evil-normal-state-map  (kbd "s-z") #'evil-emacs-state)

    ;;moving point from top
    (define-key evil-normal-state-map  (kbd "C-w t") #'windmove-up)
    (define-key evil-normal-state-map  (kbd "C-w h") #'windmove-down)
    (define-key evil-normal-state-map  (kbd "C-w n") #'windmove-left)
    (define-key evil-normal-state-map  (kbd "C-w s") #'windmove-right)
    ;; this breaks the regular use of the vim letter "b", which move back by one word.
    ;; (kbd "b") #'(lambda ()
    ;;               "Switch to the previous buffer"
    ;;               (interactive)
    ;;               (switch-to-buffer nil))

    (define-key evil-normal-state-map (kbd "C-t") 'evil-open-above)
    (define-key evil-normal-state-map (kbd "C-h") 'evil-open-below)
    (define-key evil-normal-state-map (kbd "J") 'join-line)
    (define-key evil-normal-state-map (kbd "j") #'(lambda ()
                                                    (interactive)
                                                    "join this line at the end of the line below"
                                                    (join-line 1)
                                                    ))
)

  (add-hook 'evil-normal-state-entry-hook 'my-evil-dvorak-normal-state)

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
