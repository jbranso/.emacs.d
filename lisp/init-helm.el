(require 'helm-config)

(setq
 ;;don't let helm guess what you want to search for on helm swoop... It is normally wrong.
 helm-swoop-pre-input-function '(lambda () (interactive))
 )

(helm-mode 1)

(provide 'init-helm)
