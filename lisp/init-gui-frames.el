;;----------------------------------------------------------------------------
;; Window size and features
;;----------------------------------------------------------------------------

;;; Code:
;; don't show the tool bar.  It's a waste of space
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; http://endlessparentheses.com/beacon-never-lose-your-cursor-again.html?source=rss
;; whenever you jump a line down or jump a line up, beacon flashes a little but.  pretty cool.
(beacon-mode 1)
(setq beacon-push-mark 35)
(setq beacon-color "#666600")

;; make it easy to switch to various windows inside one emacs frames using windmove
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

;; scroll one line at a time (less "jumpy" than defaults)
;; this lets you scroll the emacs buffer rather smoothly
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; this is SOOO useful!
;;Use the desktop library to save the state of Emacs from one session to another. Once you save the Emacs desktop—the buffers,
;;their file names, major modes, buffer positions, and so on—then subsequent Emacs sessions reload the saved desktop. By default,
;;the desktop also tries to save the frame and window configuration. To disable this, set desktop-restore-frames to nil. (See that
;;variable’s documentation for some related options that you can customize to fine-tune this behavior.)
;;(desktop-save-mode 1)

;; http://whattheemacsd.com/init.el-03.html
;; save the position that point was in during the last emacs session
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))
;; I found this hydra here
;; http://ericjmritz.name/2015/10/14/some-personal-hydras-for-gnu-emacs/
(defhydra hydra-desktop (:color blue)
  "desktop"
  ("c" desktop-clear "clear")
  ("s" desktop-save "save")
  ("r" desktop-revert "revert")
  ("d" desktop-change-dir "dir"))

(provide 'init-gui-frames)
