(require 'ispell)

(use-package flycheck
  :defer t
  :config
  (add-hook 'after-init-hook #'(lambda ()
                                 (global-flycheck-mode 1)))

  ;; show flycheck errors in a popup
  (with-eval-after-load 'flycheck
    (flycheck-pos-tip-mode))

  ;; (eval-after-load 'flycheck
  ;;   '(flycheck-package-setup))
  )
(use-package flycheck-pos-tip :ensure t :defer t)

;; Override default flycheck triggers

;; (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
;;       flycheck-idle-change-delay 0.8)

;; (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list))

(provide 'init-flycheck)
;;; init-flycheck ends here
