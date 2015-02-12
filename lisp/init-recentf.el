(recentf-mode 1)
(setq recentf-max-saved-items 1000
      recentf-exclude '("/tmp/"
                        ;; in case I ever want to exclude shh files, I can add this next line.
                        ;;  "/ssh:"
                        ))

(provide 'init-recentf)
