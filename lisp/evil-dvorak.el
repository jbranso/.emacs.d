;;  evil-dvorak-mode allows you to use evil with appropriate dvorak bindings.

;; I already use C-k for kill-line. I should make k be kill-line,
;; and make K be kill to the beginning of line,
;; then unset C-k

;; Also it should be possible for me to make a yl for yank line command!

(define-minor-mode evil-dvorak-mode
  "Evil dvorak mode allows you to use evil using the dvorak keyboard layout.  Contributions are welcome."
  :lighter "ED"
  :keymap (make-sparse-keymap))

(evil-define-key 'normal evil-dvorak-mode-map "k" 'kill-line)
;;(evil-define-key 'normal evil-dvorak-mode-map "$" 'ispell-word)
;; (evil-define-key 'insert evil-dvorak-mode (kbd "C-z") 'evil-normal-state)
;; (evil-define-key 'motion evil-dvorak-mode "n" 'evil-backward-char)
;; (evil-define-key 'motion evil-dvorak-mode "s" 'evil-forward-char)
;; (evil-define-key 'motion evil-dvorak-mode "s" 'evil-forward-char)
;; (evil-define-key 'motion evil-dvorak-mode "t" 'evil-previous-line)
;; (evil-define-key 'motion evil-dvorak-mode "h" 'evil-next-line)
;; (evil-define-key 'motion evil-dvorak-mode "u" 'evil-end-of-line)
;; (evil-define-key 'motion evil-dvorak-mode "a" 'evil-first-non-blank)
;; (evil-define-key 'motion evil-dvorak-mode "o" 'evil-backward-word-begin)
;; (evil-define-key 'motion evil-dvorak-mode "e" 'evil-forward-word-begin)
;; ;; I would like to use these, but they do not work well with golden-ratio-mode
;; ;;(evil-define-key 'motion (kbd "C-w h") 'evil-window-down)
;; ;;(evil-define-key 'motion (kbd "C-w t") 'evil-window-up)
;; ;;(evil-define-key 'motion (kbd "C-w n") 'evil-window-left)
;; ;;(evil-define-key 'motion (kbd "C-w s") 'evil-window-right)
;; (evil-define-key 'motion evil-dvorak-mode (kbd "C-w h") 'windmove-down)
;; (evil-define-key 'motion evil-dvorak-mode (kbd "C-w t") 'windmove-up)
;; (evil-define-key 'motion evil-dvorak-mode (kbd "C-w n") 'windmove-left)
;; (evil-define-key 'motion evil-dvorak-mode (kbd "C-w s") 'windmove-right)

;; (evil-define-key 'operator evil-dvorak-mode "s" 'evil-forward-char)
;; (evil-define-key 'operator evil-dvorak-mode "n" 'evil-backward-char)
;; (evil-define-key 'operator evil-dvorak-mode "t" 'evil-previous-line)
;; (evil-define-key 'operator evil-dvorak-mode "h" 'evil-next-line)
;; ;;(evil-define-key 'operator "u" 'evil-end-of-line)
;; ;;(evil-define-key 'operator "a" 'evil-first-non-blank)
;; (evil-define-key 'operator evil-dvorak-mode "o" 'evil-backward-word-begin)
;; (evil-define-key 'operator evil-dvorak-mode "e" 'evil-forward-word-begin)
;; (evil-define-key 'operator evil-dvorak-mode "O" 'evil-backward-WORD-end)
;; (evil-define-key 'operator evil-dvorak-mode "E" 'evil-forward-WORD-end)
;; (evil-define-key 'operator evil-dvorak-mode (kbd "<backspace>") 'ace-jump-char-mode)

;; (evil-define-key 'visual evil-dvorak-mode "s" 'evil-forward-char)
;; (evil-define-key 'visual evil-dvorak-mode "n" 'evil-backward-char)
;; (evil-define-key 'visual evil-dvorak-mode "t" 'evil-previous-line)
;; (evil-define-key 'visual evil-dvorak-mode "h" 'evil-next-line)
;; ;;I what to be able to use vaw (visual around word)
;; ;;(evil-define-key 'visual "u" 'evil-end-of-line)
;; ;;(evil-define-key 'visual "a" 'evil-first-non-blank)
;; (evil-define-key 'visual evil-dvorak-mode "o" 'evil-backward-word-begin)
;; (evil-define-key 'visual evil-dvorak-mode "e" 'evil-forward-word-begin)
;; (evil-define-key 'visual evil-dvorak-mode "O" 'evil-backward-WORD-end)
;; (evil-define-key 'visual evil-dvorak-mode "E" 'evil-forward-WORD-end)
;; (evil-define-key 'visual evil-dvorak-mode (kbd "<backspace>") 'ace-jump-char-mode)
;; (evil-define-key 'visual evil-dvorak-mode (kbd ";") 'comment-dwim)

;; (evil-define-key 'replace evil-dvorak-mode (kbd "C-s") 'evil-substitute)
;; (evil-define-key 'replace evil-dvorak-mode "s" 'evil-forward-char)
;; (evil-define-key 'replace evil-dvorak-mode "n" 'evil-backward-char)
;; (evil-define-key 'replace evil-dvorak-mode "t" 'evil-previous-line)
;; (evil-define-key 'replace evil-dvorak-mode "h" 'evil-next-line)
;; ;; if a === 'evil-first-non-blank, then caw (change around word), won't work.
;; ;;(evil-define-key 'replace "u" 'evil-end-of-line)
;; ;;(evil-define-key 'replace "a" 'evil-first-non-blank)
;; (evil-define-key 'replace evil-dvorak-mode "o" 'evil-backward-word-begin)
;; (evil-define-key 'replace evil-dvorak-mode "e" 'evil-forward-word-begin)
;; (evil-define-key 'replace evil-dvorak-mode "O" 'evil-backward-WORD-end)
;; (evil-define-key 'replace evil-dvorak-mode "E" 'evil-forward-WORD-end)
;; ;; this is sooo cool!!!!
;; (evil-define-key 'replace evil-dvorak-mode (kbd "<backspace>") 'ace-jump-char-mode)


;; (evil-define-key 'normal evil-dvorak-mode (kbd "I") 'evil-append)
;; (evil-define-key 'normal evil-dvorak-mode "$" 'ispell-word)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "C-s") 'evil-substitute)
;; (evil-define-key 'normal evil-dvorak-mode "s" 'evil-forward-char)
;; (evil-define-key 'normal evil-dvorak-mode "n" 'evil-backward-char)
;; (evil-define-key 'normal evil-dvorak-mode "t" 'evil-previous-line)
;; (evil-define-key 'normal evil-dvorak-mode "h" 'evil-next-line)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "C-l") 'recenter-top-bottom)
;; (evil-define-key 'normal evil-dvorak-mode "l" 'recenter-top-bottom)
;; (evil-define-key 'normal evil-dvorak-mode "o" 'evil-backward-word-begin)
;; (evil-define-key 'normal evil-dvorak-mode "e" 'evil-forward-word-begin)
;; (evil-define-key 'normal evil-dvorak-mode "O" 'evil-backward-WORD-end)
;; (evil-define-key 'normal evil-dvorak-mode "E" 'evil-forward-WORD-end)
;; (evil-define-key 'normal evil-dvorak-mode "j" 'evil-join)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "C-h") 'evil-open-below)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "C-t") 'evil-open-above)
;; (evil-define-key 'normal evil-dvorak-mode (kbd ";") 'comment-dwim)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "C-c r") 'evil-record-macro)
;; ;; These bindings have been put into init-editing-utils.el, which is where all of my
;; ;; C-c . bindings are.
;; ;; (evil-define-key 'normal (kbd "C-c h") 'help)
;; ;; (evil-define-key 'normal (kbd "C-c d") 'dired-jump)
;; ;; (evil-define-key 'normal (kbd "C-c g") 'magit-status)
;; ;; (evil-define-key 'normal (kbd "C-c b") 'eval-buffer)
;; ;; (evil-define-key 'normal (kbd "C-c l") 'eval-last-sexp)
;; ;; (evil-define-key 'normal (kbd "C-c e") 'helm-M-x)
;; ;; (evil-define-key 'normal (kbd "C-c m") 'helm-mini)

;; ;; I would like to use these, but they do not work well with golden-ratio-mode
;; ;;(evil-define-key 'normal (kbd "C-w h") 'evil-window-down)
;; ;;(evil-define-key 'normal (kbd "C-w t") 'evil-window-up)
;; ;;(evil-define-key 'normal (kbd "C-w n") 'evil-window-left)
;; ;;(evil-define-key 'normal (kbd "C-w s") 'evil-window-right)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "C-w h") 'windmove-down)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "C-w t") 'windmove-up)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "C-w n") 'windmove-left)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "C-w s") 'windmove-right)
;; (evil-define-key 'normal evil-dvorak-mode "," 'undo-tree-undo)
;; (evil-define-key 'normal evil-dvorak-mode "/" 'helm-swoop)
;; (evil-define-key 'normal evil-dvorak-mode "'" 'evil-goto-mark)
;; (evil-define-key 'normal evil-dvorak-mode "Q" 'query-replace)
;; (evil-define-key 'normal evil-dvorak-mode
;;   (kbd "q") '(lambda ()
;;                (interactive)
;;                (save-buffer)
;;                (let (kill-buffer-query-functions) (kill-buffer))))
;; (evil-define-key 'normal evil-dvorak-mode (kbd "<backspace>") 'ace-jump-char-mode)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "l") 'recenter-top-bottom)
;; ;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
;; (evil-define-key 'normal evil-dvorak-mode (kbd "<return>") 'newline)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "SPC") 'viper-space)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "C-a") 'mark-whole-buffer)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "a") 'evil-first-non-blank)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "A") 'evil-insert-line)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "u") 'evil-end-of-line)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "U") 'evil-append-line)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "C-d") 'delete-char)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "<") 'beginning-of-buffer)
;; (evil-define-key 'normal evil-dvorak-mode (kbd ">") 'end-of-buffer)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "l") 'recenter-top-bottom)
;; ;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
;; (evil-define-key 'normal evil-dvorak-mode (kbd "<return>") 'newline)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "SPC") 'viper-space)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "C-a") 'mark-whole-buffer)
;; (evil-define-key 'insert evil-dvorak-mode (kbd "C-i") 'info-display-manual)
;; (evil-define-key 'normal evil-dvorak-mode (kbd "C-d") 'delete-char)

;; ;; this should prevent making the escape key moving the cursor backwards but...
;; ;; (evil-define-key viper-insert-global-user-map
;; ;;   (kbd "ESC") '(lambda()
;; ;;               (viper-intercept-ESC-key)
;; ;;               (forward-char)))
;; (evil-define-key 'insert evil-dvorak-mode (kbd "C-d") 'delete-char)
;; (evil-define-key 'insert evil-dvorak-mode (kbd "<backspace>") 'delete-backward-char)
;; (evil-define-key 'insert evil-dvorak-mode (kbd "<return>") 'newline-and-indent)
;; (evil-define-key 'insert evil-dvorak-mode (kbd "C-h") 'next-line)
;; (evil-define-key 'insert evil-dvorak-mode (kbd "C-t") 'previous-line)
;; (evil-define-key 'insert evil-dvorak-mode (kbd "C-n") 'backward-char)
;; (evil-define-key 'insert evil-dvorak-mode (kbd "C-s") 'forward-char)
;; (evil-define-key 'insert evil-dvorak-mode (kbd "C-i") 'info-display-manual)
;; (evil-define-key 'insert evil-dvorak-mode (kbd "C-z") 'evil-normal-state)

;; ;; these bindings have been placed into init-editing-utils.el, which is where
;; ;; most of my global key-bindings are.
;; ;; (evil-define-key 'emacs (kbd "C-c h") 'help)
;; ;; (evil-define-key 'emacs (kbd "C-c d") 'dired-jump)
;; ;; (evil-define-key 'emacs (kbd "C-c g") 'magit-status)
;; ;; (evil-define-key 'emacs (kbd "C-c b") 'eval-buffer)
;; ;; (evil-define-key 'emacs (kbd "C-c l") 'eval-last-sexp)
;; ;; (evil-define-key 'emacs (kbd "C-c r") 'evil-record-macro)
;; ;; (evil-define-key 'emacs (kbd "C-c b") 'eval-buffer)
;; ;; (evil-define-key 'emacs (kbd "M") (kbd "ESC"))
;; ;; I would like to use these, but they do not work well with golden-ratio-mode
;; ;;(evil-define-key 'emacs (kbd "C-w h") 'evil-window-down)
;; ;;(evil-define-key 'emacs (kbd "C-w t") 'evil-window-up)
;; ;;(evil-define-key 'emacs (kbd "C-w n") 'evil-window-left)
;; (define-key evil-emacs-state-map (kbd "C-w h") 'windmove-down)
;; (define-key evil-emacs-state-map (kbd "C-w t") 'windmove-up)
;; (define-key evil-emacs-state-map (kbd "C-w n") 'windmove-left)
;; (define-key evil-emacs-state-map (kbd "C-w s") 'windmove-right)


;; ;; Set the default state for various buffers
;; (evil-set-initial-state 'dired-mode 'emacs)
;; (evil-set-initial-state 'snake-mode 'emacs)
;; (evil-set-initial-state 'eshell-mode 'emacs)
;; (evil-set-initial-state 'term-mode 'emacs)
;; ;;This next one is working or not?
;; (evil-set-initial-state 'git-mode 'emacs)

(provide 'evil-dvorak)
