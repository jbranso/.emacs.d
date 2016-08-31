(cond ((string-equal system-type "darwin"))
      (setq flyspell-program "hunspell"))
(require 'ispell)

(use-package flycheck-pos-tip :ensure t :defer t)

(use-package flycheck-status-emoji :ensure t)

(use-package flycheck-color-mode-line :ensure t)

(use-package flycheck
  :defer t
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-flycheck-mode)

  (eval-after-load "flycheck"
    '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
  (with-eval-after-load 'flycheck
    (flycheck-pos-tip-mode))
  (with-eval-after-load 'flycheck
    (flycheck-status-emoji-mode)))


(provide 'init-flycheck)
