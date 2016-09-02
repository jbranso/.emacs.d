
(require 'ispell)

(use-package flycheck :defer t :ensure t)

(add-hook 'after-init-hook #'global-flycheck-mode)

(use-package flycheck-pos-tip :ensure t)
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

(use-package flycheck-color-mode-line :ensure t)
(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(use-package flycheck-status-emoji :ensure t)

(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-status-emoji-mode))

(provide 'init-flycheck)
;;; init-flycheck ends here
