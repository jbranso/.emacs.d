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

(evil-define-key 'normal web-mode-map (kbd "Hta") 'web-mode-tag-attributes-sort)
(evil-define-key 'normal web-mode-map (kbd "Htb") 'web-mode-tag-beginning)
(evil-define-key 'normal web-mode-map (kbd "Hte") 'web-mode-tag-end)
(evil-define-key 'normal web-mode-map (kbd "Htm") 'web-mode-tag-match)
(evil-define-key 'normal web-mode-map (kbd "Htn") 'web-mode-tag-next)
(evil-define-key 'normal web-mode-map (kbd "Htp") 'web-mode-tag-previous)
(evil-define-key 'normal web-mode-map (kbd "Hts") 'web-mode-tag-select)
(evil-define-key 'normal web-mode-map (kbd "Hek") 'web-mode-element-kill)
(evil-define-key 'normal web-mode-map (kbd "Hev") 'web-mode-element-vanish)
(evil-define-key 'normal web-mode-map (kbd "Hea") 'web-mode-element-content-select)
(evil-define-key 'normal web-mode-map (kbd "Hec") 'web-mode-element-clone)
(evil-define-key 'normal web-mode-map (kbd "Heb") 'web-mode-element-beginning)
(evil-define-key 'normal web-mode-map (kbd "Hed") 'web-mode-element-child)
(evil-define-key 'normal web-mode-map (kbd "Hee") 'web-mode-element-end)
(evil-define-key 'normal web-mode-map (kbd "Hef") 'web-mode-element-children-fold-or-unfold)
(evil-define-key 'normal web-mode-map (kbd "Hei") 'web-mode-element-insert)
(evil-define-key 'normal web-mode-map (kbd "Hem") 'web-mode-element-mute-blanks)
(evil-define-key 'normal web-mode-map (kbd "Hen") 'web-mode-element-next)
(evil-define-key 'normal web-mode-map (kbd "Hep") 'web-mode-element-previous)
(evil-define-key 'normal web-mode-map (kbd "Her") 'web-mode-element-rename)
(evil-define-key 'normal web-mode-map (kbd "Hes") 'web-mode-element-select)
(evil-define-key 'normal web-mode-map (kbd "He;") 'web-mode-comment-or-uncomment)
(evil-define-key 'normal web-mode-map (kbd "Het") 'web-mode-element-transpose)
(evil-define-key 'normal web-mode-map (kbd "Heu") 'web-mode-element-parent)
(evil-define-key 'normal web-mode-map (kbd "Hew") 'web-mode-element-wrap)

(evil-define-key 'normal web-mode-map (kbd "Hfl") 'purdue-view-this-file-locally)
(evil-define-key 'normal web-mode-map (kbd "Hfd") 'purdue-view-this-file-in-dev-server)

(evil-define-key 'normal web-mode-map (kbd "Hab") 'web-mode-attribute-beginning)
(evil-define-key 'normal web-mode-map (kbd "Hae") 'web-mode-attribute-end)
(evil-define-key 'normal web-mode-map (kbd "Hai") 'web-mode-attribute-insert)
(evil-define-key 'normal web-mode-map (kbd "Hak") 'web-mode-attribute-kill)
(evil-define-key 'normal web-mode-map (kbd "Han") 'web-mode-attribute-next)
(evil-define-key 'normal web-mode-map (kbd "Has") 'web-mode-attribute-select)
(evil-define-key 'normal web-mode-map (kbd "Hat") 'web-mode-attribute-transpose)

(fset 'create\ mailto\ link
       (lambda (&optional arg) "Keyboard macro."
         (interactive "p")
         (kmacro-exec-ring-item
          (quote ([121 105 87 118 105 87 83 60 97 62 72 97 105 104 114 101 102 return 109 97 105 108 116 111 58 25 return] 0 "%d")) arg)))


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
   ;; I'm getting a weird error.  maybe this will help
   ;;(define-key evil-normal-state-map  (kbd "ESC") 'nil)
   ;;(define-key evil-normal-state-map  (kbd "C-s") 'evil-substitute)
   (define-key evil-normal-state-map  (kbd "C-c r") 'evil-record-macro)
   (define-key evil-normal-state-map  "," 'undo-tree-undo)
   ;; I'm trying to replace this with "C-c /"
   ;;(define-key evil-normal-state-map  "/" 'helm-swoop)
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
   ;; I'm trying to get used to normal vim commands
   ;;(define-key evil-normal-state-map  "I" 'evil-append)
   ;; I'm trying to get used to normal vim commands
   ;;(define-key evil-normal-state-map  "$" 'ispell-word)
   ;; (kbd "a") 'evil-first-non-blank
   ;; I'm trying to get used to more default vim behavior
   ;;(define-key evil-normal-state-map  (kbd "a") 'move-beginning-of-line)
   ;;(define-key evil-normal-state-map  (kbd "A") 'evil-insert-line)
   ;; (kbd "u") 'evil-end-of-line

   ;; I'm trying to get used to default vim behavior
   ;; (define-key evil-normal-state-map  (kbd "u") 'move-end-of-line)
   ;; (define-key evil-normal-state-map  (kbd "U") 'evil-append-line)
   ;;(define-key evil-normal-state-map  (kbd "q") '(lambda ()
   ;; "q saves the current buffer, then kills it.  I should add a checking mechanism... If the buffer name starts and ends with *, then do not save the buffer"
   ;;                                              (interactive)
   ;;                                            (save-buffer)
   ;;                                          (let (kill-buffer-query-functions) (kill-buffer))))
   ;; I'm trying to get used to normal vim behavior
   ;;(define-key evil-normal-state-map  (kbd "l") 'recenter-top-bottom)
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

  ;; (define-key evil-normal-state-map (kbd "C-t") 'evil-open-above)
 ;;  (define-key evil-normal-state-map (kbd "C-h") 'evil-open-below)
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
  (define-key evil-insert-state-map  (kbd "C-c r") 'evil-record-macro)
  (define-key evil-insert-state-map  (kbd "C-s") 'evil-forward-char)
  (define-key evil-insert-state-map  (kbd "C-h") 'evil-backward-char))
(add-hook 'evil-insert-state-entry-hook 'my-evil-dvorak-insert-state)

(define-key evil-emacs-state-map  (kbd "C-w t") #'windmove-up)
(define-key evil-emacs-state-map  (kbd "C-w h") #'windmove-down)
(define-key evil-emacs-state-map  (kbd "C-w n") #'windmove-left)
(define-key evil-emacs-state-map  (kbd "C-w s") #'windmove-right)

(provide 'init-evil)
;;; evil-changes.el ends here
