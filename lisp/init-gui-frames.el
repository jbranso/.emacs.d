(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(defun my/toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(with-eval-after-load 'evil
  (define-key evil-emacs-state-map (kbd "C-w h") 'windmove-down)
  (define-key evil-emacs-state-map (kbd "C-w t") 'windmove-up)
  (define-key evil-emacs-state-map (kbd "C-w n") 'windmove-left)
  (define-key evil-emacs-state-map (kbd "C-w s") 'windmove-right)
  (define-key evil-emacs-state-map (kbd "C-w C-t") 'my/toggle-window-split)

  (define-key evil-window-map (kbd "C-t") 'my/toggle-window-split)
  (define-key evil-emacs-state-map (kbd "C-w C-t") 'my/toggle-window-split)

  (evil-define-key 'emacs evil-normal-state-map (kbd "C-w h") 'windmove-down)
  (evil-define-key 'emacs evil-normal-state-map (kbd "C-w t") 'windmove-up)
  (evil-define-key 'emacs evil-normal-state-map (kbd "C-w n") 'windmove-left)
  (evil-define-key 'emacs evil-normal-state-map (kbd "C-w s") 'windmove-ri)
  (evil-define-key 'emacs evil-normal-state-map (kbd "C-w C-t") 'my/toggle-window-split)

  ;;I don't think this would ever really be useful
  (evil-define-key 'normal help-mode-map (kbd "C-w h") 'windmove-down)
  (evil-define-key 'normal help-mode-map (kbd "C-w t") 'windmove-up)
  (evil-define-key 'normal help-mode-map (kbd "C-w n") 'windmove-left)
  (evil-define-key 'normal help-mode-map (kbd "C-w s") 'windmove-right)
  (evil-define-key 'normal help-mode-map (kbd "C-w C-t") 'my/toggle-window-split)

  (evil-define-key 'emacs  help-mode-map (kbd "C-w h") 'windmove-down)
  (evil-define-key 'emacs  help-mode-map (kbd "C-w t") 'windmove-up)
  (evil-define-key 'emacs  help-mode-map (kbd "C-w n") 'windmove-left)
  (evil-define-key 'emacs  help-mode-map (kbd "C-w s") 'windmove-right)
  (evil-define-key 'emacs  help-mode-map (kbd "C-w C-t") 'my/toggle-window-split)

  (evil-define-key 'normal debugger-mode-map (kbd "C-w h") 'windmove-down)
  (evil-define-key 'normal debugger-mode-map (kbd "C-w t") 'windmove-up)
  (evil-define-key 'normal debugger-mode-map (kbd "C-w n") 'windmove-left)
  (evil-define-key 'normal debugger-mode-map (kbd "C-w s") 'windmove-right)
  (evil-define-key 'normal debugger-mode-map (kbd "C-w C-t") 'my/toggle-window-split)

  (evil-define-key 'emacs  debugger-mode-map (kbd "C-w h") 'windmove-down)
  (evil-define-key 'emacs  debugger-mode-map (kbd "C-w t") 'windmove-up)
  (evil-define-key 'emacs  debugger-mode-map (kbd "C-w n") 'windmove-left)
  (evil-define-key 'emacs  debugger-mode-map (kbd "C-w s") 'windmove-right)
  (evil-define-key 'emacs  debugger-mode-map (kbd "C-w C-t") 'my/toggle-window-split)

  (evil-define-key 'emacs  erc-mode-map (kbd "C-w h") 'windmove-down)
  (evil-define-key 'emacs  erc-mode-map (kbd "C-w t") 'windmove-up)
  (evil-define-key 'emacs  erc-mode-map (kbd "C-w n") 'windmove-left)
  (evil-define-key 'emacs  erc-mode-map (kbd "C-w s") 'windmove-right)
  (evil-define-key 'emacs  erc-mode-map (kbd "C-w C-t") 'my/toggle-window-split)

  (evil-define-key 'emacs  gnus-article-mode-map (kbd "C-w h") 'windmove-down)
  (evil-define-key 'emacs  gnus-article-mode-map (kbd "C-w t") 'windmove-up)
  (evil-define-key 'emacs  gnus-article-mode-map (kbd "C-w n") 'windmove-left)
  (evil-define-key 'emacs  gnus-article-mode-map (kbd "C-w s") 'windmove-right)
  (evil-define-key 'emacs  gnus-article-mode-map (kbd "C-w C-t") 'my/toggle-window-split)
  )

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))
(save-place-mode)

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

(defun add-custom-keyw ()
  "adds a few special keywords"
  (font-lock-add-keywords
   nil
   '(("\\s<+x[[:space:]]*\\(.*?\\)[[:space:]]*\\s>" 1 'font-lock-comment-strike prepend)
     ("\\s<+cr[[:space:]]*\\(.*?\\)[[:space:]]*\\s>" 1 'font-lock-comment-todo prepend)
     ("\\s<+cg[[:space:]]*\\(.*?\\)[[:space:]]*\\s>" 1 'font-lock-comment-important prepend))))

    (add-hook 'prog-mode-hook #'add-custom-keyw)

(provide 'init-gui-frames)
