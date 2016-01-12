;;; Commentary:
;; This shows you in the fringes of the buffer (this is the left column on the left side of your buffer)
;; whick text in a buffer has not yet been committed.
(use-package diff-hl
  :ensure t)
(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)

(provide 'init-vc)
;;; init-vc ends here
