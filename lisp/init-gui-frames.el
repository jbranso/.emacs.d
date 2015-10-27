;;----------------------------------------------------------------------------
;; Window size and features
;;----------------------------------------------------------------------------

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(use-package golden-ratio
  :ensure t
  :diminish golden-ratio-mode)
(golden-ratio-mode 1)
;; http://endlessparentheses.com/beacon-never-lose-your-cursor-again.html?source=rss
;; whenever you jump a line down or jump a line up, beacon flashes a little but.  pretty cool.
(beacon-mode 1)
(setq beacon-push-mark 35)
(setq beacon-color "#666600")

;; scroll one line at a time (less "jumpy" than defaults)
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
;; I found this hydra here
;; http://ericjmritz.name/2015/10/14/some-personal-hydras-for-gnu-emacs/
(defhydra hydra-desktop (:color blue)
  "desktop"
  ("c" desktop-clear "clear")
  ("s" desktop-save "save")
  ("r" desktop-revert "revert")
  ("d" desktop-change-dir "dir"))
;; this is not working at all.
;; (require 'hydra)
;; (setq hydra-is-helpful t)
;; (local-unset-key "C-w" )
;; (defhydra window-navigate (global-map "C-w")
;;   "window navigate"
;;   ("h" windmove-down)
;;   ("t" windmove-up)
;;   ("n" windmove-left)
;;   ("s" windmove-right))

(provide 'init-gui-frames)
