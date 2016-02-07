(use-package avy
  :ensure t
  :config
  (setq
   avybackground t
   avy-highlight-first t)
  ;; https://github.com/abo-abo/avy
  (setq  avy-keys (number-sequence ?e ?t )))

(provide 'init-avy)
