;; apparently the bash binary will do on the fly bash syntax checking as you type.
;; that is super cool!
(add-hook 'sh-mode-hook (lambda () (flycheck-mode 1)))

(provide 'init-bash)
