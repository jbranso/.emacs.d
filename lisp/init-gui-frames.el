;;----------------------------------------------------------------------------
;; Window size and features
;;----------------------------------------------------------------------------
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(use-package golden-ratio
  :ensure t
  :diminish golden-ratio-mode)
(golden-ratio-mode 1)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

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
