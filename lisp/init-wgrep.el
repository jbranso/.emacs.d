;; this lets you use an emacs grep command to look for something,
;; then in that grep buffer, you are can freely modify the text.
;; you can also use this in ag-mode. COOL!

;; You can edit the text in the *grep* buffer after typing C-c C-p.
;; After that the changed text is highlighted.
;; The following keybindings are defined:

;; C-c C-e : Apply the changes to file buffers.
;; C-c C-u : All changes are unmarked and ignored.
;; C-c C-d : Mark as delete to current line (including newline).
;; C-c C-r : Remove the changes in the region (these changes are not
;;           applied to the files. Of course, the remaining
;;           changes can still be applied to the files.)
;; C-c C-p : Toggle read-only area.
;; C-c C-k : Discard all changes and exit.
;; C-x C-q : Exit wgrep mode.

;; * To save all buffers that wgrep has changed, run
;;
;;   M-x wgrep-save-all-buffers

;; * To save buffer automatically when `wgrep-finish-edit'.
;;
;; (setq wgrep-auto-save-buffer t)

;; * You can change the default key binding to switch to wgrep.
;;
;; (setq wgrep-enable-key "r")

;; * To apply all changes wheather or not buffer is read-only.
;;
;; (setq wgrep-change-readonly-file t)

(use-package wgrep :ensure t)
;; make wgrep save all the files you changes on exit
(setq wgrep-auto-save-buffer t)


(autoload 'wgrep-ag-setup "wgrep-ag")
(add-hook 'ag-mode-hook 'wgrep-ag-setup)

(provide 'init-wgrep)
