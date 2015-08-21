(recentf-mode 1)
(setq recentf-max-saved-items 2000
      recentf-exclude '("/tmp/"
			"^.*autoloads.*$"
            "^.*TAGS.*$"
            "^.*COMMIT.*$"
            "^.*pacnew.*$"
                        ;; in case I ever want to exclude shh files, I can add this next line.
                        ;;  "/ssh:"
            ))

(add-to-list 'recentf-keep "^.*php$//")
(recentf-auto-cleanup)

(provide 'init-recentf)
