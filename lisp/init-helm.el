(require 'helm-config)

(setq
 ;;don't let helm guess what you want to search for on helm swoop... It is normally wrong.
 helm-swoop-pre-input-function '(lambda () (interactive))
 ;; tell helm to use recentf-list to look for files instead of file-name-history
 helm-ff-file-name-history-use-recentf t
 ;; let helm show 1000 files in helm-find-files
 helm-ff-history-max-length 1000
 ;; this is not working... helm key in enabled in the global map...
 helm-command-prefix (kbd "C-c C-h")
 )

(helm-mode 1)

(provide 'init-helm)
