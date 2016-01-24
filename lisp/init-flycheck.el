(require 'ispell)

(use-package flycheck)

(add-hook 'after-init-hook #'global-flycheck-mode)

;; show flycheck errors in a popup
(use-package flycheck-pos-tip
  :ensure t
  :defer t)

(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode)

  ;; Override default flycheck triggers

;; (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
;;       flycheck-idle-change-delay 0.8)

;; (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list))

(provide 'init-flycheck)
;;; init-flycheck ends here
