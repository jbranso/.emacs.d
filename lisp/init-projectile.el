(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

;;indexing files is slow.  You want to cache stuff.
;;(setq projectile-enable-caching t)

(provide 'init-projectile)
