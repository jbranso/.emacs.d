(require 'helm-config)
;; I've installed helm-ag, which might be cool.

(setq
 ;;don't let helm guess what you want to search for on helm swoop... It is normally wrong.
 helm-swoop-pre-input-function #'(lambda () (interactive))
 ;; tell helm to use recentf-list to look for files instead of file-name-history
 helm-ff-file-name-history-use-recentf t
 ;; let helm show 500 files in helm-find-files
 helm-ff-history-max-length 500
 ;; I've set helm's prefix key in init-editing utils
 ;; don't let helm index weird output files from converting .tex files to pdf for example
 helm-ff-skip-boring-files t
 ;;make helm use the full frame. not needed.
 ;;helm-full-frame t
 ;; enable fuzzy mating in M-x
 helm-M-x-fuzzy-match t
 ;;the more of these sources that I have, the slower helm will be
 helm-for-files-preferred-list '(helm-source-buffers-list
                                 helm-source-recentf
                                 helm-source-bookmarks
                                 ;;helm-source-file-cache
                                 helm-source-files-in-current-dir
                                 ;;helm-source-locate
                                 ;;helm-source-projectile-files-in-all-projects-list
                                 ;;helm-source-findutils
                                 ;;helm-source-files-in-all-dired
                                 ))

(helm-mode 1)

;; how do I get this to work?
;; (define-key helm-find-files-map (kbd "s-h") 'helm-next-line)

(provide 'init-helm)
