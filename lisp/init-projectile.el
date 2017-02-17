(use-package projectile
  :diminish projectile-mode
  :config
  (use-package helm-projectile
    :ensure t)
  (eval-after-load 'projectile-mode 'helm-projectile-on)
  :ensure t)

;;(use-package helm-projectile-all :ensure t)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
;;(helm-projectile-on)


;;indexing files is slow.  You want to cache stuff.
;;(setq projectile-enable-caching t)

(provide 'init-projectile)
