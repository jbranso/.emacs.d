(use-package projectile
  :diminish projectile-mode
  :ensure t)

(use-package helm-projectile
  :ensure t)
;;(use-package helm-projectile-all :ensure t)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)


;;indexing files is slow.  You want to cache stuff.
;;(setq projectile-enable-caching t)

(provide 'init-projectile)
