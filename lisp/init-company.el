(use-package company :ensure t
  :config
  (setq company-idle-delay .2)
  (define-key company-active-map "\C-n" #'company-select-next)
  (define-key company-active-map "\C-p" #'company-select-previous))

(add-hook 'after-init-hook 'global-company-mode)

(dolist (hook '(prog-mode-hook
                text-mode-hook
                org-mode-hook))
  (add-hook hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   '((company-dabbrev-code company-yasnippet))))))

(provide 'init-company)
