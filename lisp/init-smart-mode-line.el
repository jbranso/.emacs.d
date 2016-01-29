;;; package --- Summary
;;; Commentary:
;;; Code:

;; powerline evil has 1 contributor.  It's pretty much crap
;;(require 'powerline-evil)

;; powerline is by the guy that maintains melpa, but it doesn't seem to work
;;(use-package powerline :ensure t)

;;(display-time-mode t)

;; don't delete-package (powerline).  smart-mode-line-powerline-theme depends on it
(use-package smart-mode-line-powerline-theme :ensure t)
;; smart mode line apparently is more active and works w/ just about anything
(use-package smart-mode-line :ensure t
  :init
  (setq sml/theme 'powerline)
  (sml/setup))


;;(setq powerline-evil-tag 'verbose)

(provide 'init-smart-mode-line)
;;; init-smart-mode-line ends here
