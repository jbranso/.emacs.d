(setq-default grep-highlight-matches t
              grep-scroll-output t)

;; ag is the silver searcher.  It lets you search for stuff crazy fast
(when (executable-find "ag")
  (use-package ag
    :ensure t)
  (use-package wgrep-ag
    :ensure t)
  (setq-default ag-highlight-search t))

(provide 'init-grep)
