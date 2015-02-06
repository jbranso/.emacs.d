(require-package 'diff-hl)
(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
(add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)
;; do the same thing in dired mode!
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

(provide 'init-vc)
