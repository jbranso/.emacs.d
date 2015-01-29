;;  evil-dvorak-mode allows you to use evil with appropriate dvorak bindings.

;; I already use C-k for kill-line. I should make k be kill-line,
;; and make K be kill to the beginning of line,
;; then unset C-k

;; Also it should be possible for me to make a yl for yank line command!

(require 'evil)

(define-minor-mode evil-dvorak-mode
  "Evil dvorak mode allows you to use evil using the dvorak keyboard layout.  Contributions are welcome."
  :lighter "ED"
  :keymap (make-sparse-keymap))

(defun turn-on-evil-dvorak-mode ()
  "Enable evil-dvorak-mode in the current buffer."
  (evil-dvorak-mode 1))

(define-globalized-minor-mode global-evil-dvorak-mode
  evil-dvorak-mode turn-on-evil-dvorak-mode
  "Global minor mode to emulate surround.vim.")

(evil-define-key 'normal evil-dvorak-mode-map "k" 'kill-line)
;;(evil-define-key 'normal evil-dvorak-mode-map "$" 'ispell-word)
(evil-define-key 'insert evil-dvorak-mode-map (kbd "C-z") 'evil-normal-state)
(evil-define-key 'insert evil-dvorak-mode-map (kbd "ESC") 'evil-normal-state)
(evil-define-key 'motion evil-dvorak-mode-map "n" 'evil-backward-char)
(evil-define-key 'motion evil-dvorak-mode-map "s" 'evil-forward-char)
(evil-define-key 'motion evil-dvorak-mode-map "s" 'evil-forward-char)
(evil-define-key 'motion evil-dvorak-mode-map "t" 'evil-previous-line)
(evil-define-key 'motion evil-dvorak-mode-map "h" 'evil-next-line)
(evil-define-key 'motion evil-dvorak-mode-map "u" 'evil-end-of-line)
(evil-define-key 'motion evil-dvorak-mode-map "a" 'evil-first-non-blank)
(evil-define-key 'motion evil-dvorak-mode-map "o" 'evil-backward-word-begin)
(evil-define-key 'motion evil-dvorak-mode-map "e" 'evil-forward-word-begin)

(evil-define-key 'operator evil-dvorak-mode-map "s" 'evil-forward-char)
(evil-define-key 'operator evil-dvorak-mode-map "n" 'evil-backward-char)
(evil-define-key 'operator evil-dvorak-mode-map "t" 'evil-previous-line)
(evil-define-key 'operator evil-dvorak-mode-map "h" 'evil-next-line)
;;(evil-define-key 'operator "u" 'evil-end-of-line)
;;(evil-define-key 'operator "a" 'evil-first-non-blank)
(evil-define-key 'operator evil-dvorak-mode-map "o" 'evil-backward-word-begin)
(evil-define-key 'operator evil-dvorak-mode-map "e" 'evil-forward-word-begin)
(evil-define-key 'operator evil-dvorak-mode-map "O" 'evil-backward-WORD-end)
(evil-define-key 'operator evil-dvorak-mode-map "E" 'evil-forward-WORD-end)
(evil-define-key 'operator evil-dvorak-mode-map (kbd "<backspace>") 'ace-jump-char-mode)

(evil-define-key 'visual evil-dvorak-mode-map "s" 'evil-forward-char)
(evil-define-key 'visual evil-dvorak-mode-map "n" 'evil-backward-char)
(evil-define-key 'visual evil-dvorak-mode-map "t" 'evil-previous-line)
(evil-define-key 'visual evil-dvorak-mode-map "h" 'evil-next-line)
;;I what to be able to use vaw (visual around word)
;;(evil-define-key 'visual "u" 'evil-end-of-line)
;;(evil-define-key 'visual "a" 'evil-first-non-blank)
(evil-define-key 'visual evil-dvorak-mode-map "o" 'evil-backward-word-begin)
(evil-define-key 'visual evil-dvorak-mode-map "e" 'evil-forward-word-begin)
(evil-define-key 'visual evil-dvorak-mode-map "O" 'evil-backward-WORD-end)
(evil-define-key 'visual evil-dvorak-mode-map "E" 'evil-forward-WORD-end)
(evil-define-key 'visual evil-dvorak-mode-map (kbd "<backspace>") 'ace-jump-char-mode)
(evil-define-key 'visual evil-dvorak-mode-map (kbd ";") 'comment-dwim)

(evil-define-key 'replace evil-dvorak-mode-map (kbd "C-s") 'evil-substitute)
(evil-define-key 'replace evil-dvorak-mode-map "s" 'evil-forward-char)
(evil-define-key 'replace evil-dvorak-mode-map "n" 'evil-backward-char)
(evil-define-key 'replace evil-dvorak-mode-map "t" 'evil-previous-line)
(evil-define-key 'replace evil-dvorak-mode-map "h" 'evil-next-line)
;; if a === 'evil-first-non-blank, then caw (change around word), won't work.
;;(evil-define-key 'replace "u" 'evil-end-of-line)
;;(evil-define-key 'replace "a" 'evil-first-non-blank)
(evil-define-key 'replace evil-dvorak-mode-map "o" 'evil-backward-word-begin)
(evil-define-key 'replace evil-dvorak-mode-map "e" 'evil-forward-word-begin)
(evil-define-key 'replace evil-dvorak-mode-map "O" 'evil-backward-WORD-end)
(evil-define-key 'replace evil-dvorak-mode-map "E" 'evil-forward-WORD-end)
;; this is sooo cool!!!!
(evil-define-key 'replace evil-dvorak-mode-map (kbd "<backspace>") 'ace-jump-char-mode)


(evil-define-key 'normal evil-dvorak-mode-map (kbd "I") 'evil-append)
(evil-define-key 'normal evil-dvorak-mode-map "$" 'ispell-word)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "C-s") 'evil-substitute)
(evil-define-key 'normal evil-dvorak-mode-map "s" 'evil-forward-char)
(evil-define-key 'normal evil-dvorak-mode-map "n" 'evil-backward-char)
(evil-define-key 'normal evil-dvorak-mode-map "t" 'evil-previous-line)
(evil-define-key 'normal evil-dvorak-mode-map "h" 'evil-next-line)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "C-l") 'recenter-top-bottom)
(evil-define-key 'normal evil-dvorak-mode-map "l" 'recenter-top-bottom)
(evil-define-key 'normal evil-dvorak-mode-map "o" 'evil-backward-word-begin)
(evil-define-key 'normal evil-dvorak-mode-map "e" 'evil-forward-word-begin)
(evil-define-key 'normal evil-dvorak-mode-map "O" 'evil-backward-WORD-end)
(evil-define-key 'normal evil-dvorak-mode-map "E" 'evil-forward-WORD-end)
(evil-define-key 'normal evil-dvorak-mode-map "j" 'evil-join)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "C-h") 'evil-open-below)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "C-t") 'evil-open-above)
(evil-define-key 'normal evil-dvorak-mode-map (kbd ";") 'comment-dwim)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "C-c r") 'evil-record-macro)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "C-w h") 'windmove-down)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "C-w t") 'windmove-up)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "C-w n") 'windmove-left)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "C-w s") 'windmove-right)
(evil-define-key 'normal evil-dvorak-mode-map "," 'undo-tree-undo)
(evil-define-key 'normal evil-dvorak-mode-map "/" 'helm-swoop)
(evil-define-key 'normal evil-dvorak-mode-map "'" 'evil-goto-mark)
(evil-define-key 'normal evil-dvorak-mode-map "Q" 'query-replace)
(evil-define-key 'normal evil-dvorak-mode-map
  (kbd "q") '(lambda ()
               (interactive)
               (save-buffer)
               (let (kill-buffer-query-functions) (kill-buffer))))
(evil-define-key 'normal evil-dvorak-mode-map (kbd "<backspace>") 'ace-jump-char-mode)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "l") 'recenter-top-bottom)
;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
(evil-define-key 'normal evil-dvorak-mode-map (kbd "<return>") 'newline)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "SPC") 'viper-space)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "C-a") 'mark-whole-buffer)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "a") 'evil-first-non-blank)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "A") 'evil-insert-line)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "u") 'evil-end-of-line)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "U") 'evil-append-line)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "C-d") 'delete-char)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "<") 'beginning-of-buffer)
(evil-define-key 'normal evil-dvorak-mode-map (kbd ">") 'end-of-buffer)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "l") 'recenter-top-bottom)
;;there is no need to set return to newline-and-indent, because electric-indent-mode is now on by default.
(evil-define-key 'normal evil-dvorak-mode-map (kbd "<return>") 'newline)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "SPC") 'viper-space)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "C-a") 'mark-whole-buffer)
(evil-define-key 'insert evil-dvorak-mode-map (kbd "C-i") 'info-display-manual)
(evil-define-key 'normal evil-dvorak-mode-map (kbd "C-d") 'delete-char)

;; this should prevent making the escape key moving the cursor backwards but...
;; (evil-define-key viper-insert-global-user-map
;;   (kbd "ESC") '(lambda()
;;               (viper-intercept-ESC-key)
;;               (forward-char)))
(evil-define-key 'insert evil-dvorak-mode-map (kbd "C-d") 'delete-char)
(evil-define-key 'insert evil-dvorak-mode-map (kbd "<backspace>") 'delete-backward-char)
(evil-define-key 'insert evil-dvorak-mode-map (kbd "<return>") 'newline-and-indent)
(evil-define-key 'insert evil-dvorak-mode-map (kbd "C-h") 'next-line)
(evil-define-key 'insert evil-dvorak-mode-map (kbd "C-t") 'previous-line)
(evil-define-key 'insert evil-dvorak-mode-map (kbd "C-n") 'backward-char)
(evil-define-key 'insert evil-dvorak-mode-map (kbd "C-s") 'forward-char)
(evil-define-key 'insert evil-dvorak-mode-map (kbd "C-i") 'info-display-manual)
(evil-define-key 'insert evil-dvorak-mode-map (kbd "C-z") 'evil-normal-state)

;; these bindings have been placed into init-editing-utils.el, which is where
;; most of my global key-bindings are.
;; (evil-define-key 'emacs (kbd "C-c h") 'help)
;; (evil-define-key 'emacs (kbd "C-c d") 'dired-jump)
;; (evil-define-key 'emacs (kbd "C-c g") 'magit-status)
;; (evil-define-key 'emacs (kbd "C-c b") 'eval-buffer)
;; (evil-define-key 'emacs (kbd "C-c l") 'eval-last-sexp)
;; (evil-define-key 'emacs (kbd "C-c r") 'evil-record-macro)
;; (evil-define-key 'emacs (kbd "C-c b") 'eval-buffer)
;; (evil-define-key 'emacs (kbd "M") (kbd "ESC"))
;; I would like to use these, but they do not work well with golden-ratio-mode
;;(evil-define-key 'emacs (kbd "C-w h") 'evil-window-down)
;;(evil-define-key 'emacs (kbd "C-w t") 'evil-window-up)
;;(evil-define-key 'emacs (kbd "C-w n") 'evil-window-left)
(define-key evil-emacs-state-map (kbd "C-w h") 'windmove-down)
(define-key evil-emacs-state-map (kbd "C-w t") 'windmove-up)
(define-key evil-emacs-state-map (kbd "C-w n") 'windmove-left)
(define-key evil-emacs-state-map (kbd "C-w s") 'windmove-right)


;; Set the default state for various buffers
(evil-set-initial-state 'dired-mode 'emacs)
(evil-set-initial-state 'snake-mode 'emacs)
(evil-set-initial-state 'eshell-mode 'emacs)
(evil-set-initial-state 'term-mode 'emacs)
;;This next one is working or not?
(evil-set-initial-state 'git-mode 'emacs)

(provide 'evil-dvorak)
