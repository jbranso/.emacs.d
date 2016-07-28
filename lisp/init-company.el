(use-package company :ensure t
  :config
  (setq company-idle-delay .2)
  (define-key company-mode-map "\C-n" #'company-select-next)
  (define-key company-mode-map "\C-p" #'company-select-previous))

(add-hook 'after-init-hook 'global-company-mode)

(provide 'init-company)
