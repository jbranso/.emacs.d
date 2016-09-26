(use-package projectile :ensure t
  :config (setq projectile-enable-caching t))

(use-package helm-projectile
  :ensure t)
(use-package helm-projectile-all
  :ensure t)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)


(provide 'init-projectile)
