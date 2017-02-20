(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(add-hook 'evil-mode-hook '( lambda ()
                             (define-key evil-emacs-state-map (kbd "C-w h") 'windmove-down)
                             (define-key evil-emacs-state-map (kbd "C-w t") 'windmove-up)
                             (define-key evil-emacs-state-map (kbd "C-w n") 'windmove-left)
                             (define-key evil-emacs-state-map (kbd "C-w s") 'windmove-right)
                             (define-key evil-normal-state-map (kbd "C-w h") 'windmove-down)
                             (define-key evil-normal-state-map (kbd "C-w t") 'windmove-up)
                             (define-key evil-normal-state-map (kbd "C-w n") 'windmove-left)
                             (define-key evil-normal-state-map (kbd "C-w s") 'windmove-right)))

;; (add-hook 'debugger-mode-hook '( lambda ()
;;                                  (define-key debugger-mode-map (kbd "C-w h") 'windmove-down)
;;                                  (define-key debugger-mode-map (kbd "C-w t") 'windmove-up)
;;                                  (define-key debugger-mode-map (kbd "C-w n") 'windmove-left)
;;                                  (define-key debugger-mode-map (kbd "C-w s") 'windmove-right)))
;; (add-hook 'help-mode-map ( lambda ()
;;                            (define-key help-mode-map (kbd "C-w h") 'windmove-down)
;;                            (define-key help-mode-map (kbd "C-w t") 'windmove-up)
;;                            (define-key help-mode-map (kbd "C-w n") 'windmove-left)
;;                            (define-key help-mode-map (kbd "C-w s") 'windmove-right)))

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))
(add-hook 'after-init-hook 'save-place-mode)

(when (display-graphic-p)
  (global-hl-line-mode 1))

;;cr red
;;cg green
;;x like this
(defface font-lock-comment-strike
  '((t (:strike-through t)))
  "For strike-through comments")

(defface font-lock-comment-important
  '((t (:foreground "#00ff00")))
  "For important")

(defface font-lock-comment-todo
  '((t (:foreground "#ff0000")))
  "For todo comments")

(defun add-custom-keyw()
  "adds a few special keywords"
  (font-lock-add-keywords
   nil
   '(("\\s<+x[[:space:]]*\\(.*?\\)[[:space:]]*\\s>" 1 'font-lock-comment-strike prepend)
     ("\\s<+cr[[:space:]]*\\(.*?\\)[[:space:]]*\\s>" 1 'font-lock-comment-todo prepend)
     ("\\s<+cg[[:space:]]*\\(.*?\\)[[:space:]]*\\s>" 1 'font-lock-comment-important prepend))))

  (add-hook 'prog-mode-hook #'add-custom-keyw)

(provide 'init-gui-frames)
