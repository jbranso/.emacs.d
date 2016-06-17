(setq-default grep-highlight-matches t
              grep-scroll-output t)

;; ag is the silver searcher.  It lets you search for stuff crazy fast
(when (executable-find "ag")
  (use-package ag
    :defer t
    :ensure t)
  (use-package wgrep-ag
    :defer t
    :ensure t)
  (setq-default ag-highlight-search t))

(provide 'init-grep)
